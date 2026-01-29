#-------------------------------------------------------------------------------
# Generates perl unit tests from the toml/json files in toml-lang/toml-test
# without having to add special casing to TOML::Tiny to conform to their
# annotated JSON format.
#-------------------------------------------------------------------------------
use strict;
use warnings;
no warnings 'experimental';
use v5.18;

use Data::Dumper;
use JSON::PP;
use File::Copy;
use File::Find;
use File::Spec;

# We want to read unicde as characters from toml-test source files. That makes
# things simpler for us when we parse them and generate perl source in the
# generated test file.
binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

sub slurp{
  open my $fh, '<', $_[0] or die "$_[0]: $!";
  local $/;
  <$fh>;
}

sub spew {
  open my $fh, '>', $_[0] or die $!;
  print $fh $_[1];
}

# Removes type annotations from toml-lang/toml-test JSON files and returns the
# cleaned up data structure to which the associated TOML file should be parsed.
sub deturd_json{
  state $json = JSON::PP->new->utf8(1);
  my $annotated = $json->decode(slurp(shift));
  my $cleanish = deannotate($annotated);

  local $Data::Dumper::Varname  = 'expected';
  local $Data::Dumper::Deparse  = 1;
  local $Data::Dumper::Sortkeys = 1;
  local $Data::Dumper::Useqq    = 1;

  return Dumper($cleanish);
}

# Recursively deannotates and inflates values from toml-test JSON data
# structures into a format more in line with TOML::Tiny's parser outout. For
# integer and float values, a Test2::Tools::Compare validator is generated to
# compare using Math::Big(Int|Float)->beq, since TOML's float and int types are
# 64 bits. Datetimes are converted to a common, normalized string format.
sub deannotate{
  my $data = shift;

  for (ref $data) {
    if ( $_ eq  'HASH') {
      if (exists $data->{type} && exists $data->{value} && keys(%$data) == 2) {
        for ($data->{type}) {
          return $data->{value} eq 'true' ? 1 : 0             if /bool/;
          return [ map{ deannotate($_) } @{$data->{value}} ]  if /array/;

          my $result;

          if (/integer/) {
            my $src = qq{
              use Test2::Tools::Compare qw(validator);
              validator('Math::BigInt->new("$data->{value}")->beq(\$_)' => sub{
                require Math::BigInt;
                my \$got = Math::BigInt->new(\$_);
                Math::BigInt->new("$data->{value}")->beq(\$got);
              });
            };

            $result = eval $src;
            $@ && die $@;
          }

          elsif (/float/) {
            my $src;

            if ($data->{value} eq 'nan') {
              $src = qq{
                use Test2::Tools::Compare qw(validator);
                validator('Math::BigFloat->new(\$_)->is_nan' => sub{
                  require Math::BigFloat;
                  Math::BigFloat->new(\$_)->is_nan;
                });
              };
            }
            elsif ($data->{value} eq 'inf') {
              $src = qq{
                use Test2::Tools::Compare qw(validator);
                validator('Math::BigFloat->new(\$_)->is_inf' => sub{
                  require Math::BigFloat;
                  Math::BigFloat->new(\$_)->is_inf;
                });
              };
            }
            elsif ($data->{value} eq '-inf') {
              $src = qq{
                use Test2::Tools::Compare qw(validator);
                validator('Math::BigFloat->new(\$_)->is_inf' => sub{
                  require Math::BigFloat;
                  Math::BigFloat->new(\$_)->is_inf;
                });
              };
            }
            else {
              $src = qq{
                use Test2::Tools::Compare qw(validator);
                validator('Math::BigFloat->new("$data->{value}")->beq(\$_)' => sub{
                  require Math::BigFloat;
                  my \$got = Math::BigFloat->new(\$_);
                  Math::BigFloat->new("$data->{value}")->beq(\$got);
                });
              };
            }

            $result = eval $src;
            $@ && die $@;
          }


          # force file location to a constant. random changes in files
          # cause the Dumped object to have different 'file'
          # attributes, even though the actual compare code hasn't
          # changed.  This avoids excess VCS churn.
          if ( $result ) {
            $result->set_file( '(eval 000)' );
          }
          else {
              $result = $data->{value};
          }

          return $result;
        }
      }

      my %object;
      $object{$_} = deannotate($data->{$_}) for keys %$data;
      return \%object;
    }

    elsif  ($_ eq 'ARRAY') {
      return [ map{ deannotate($_) } @$data ];
    }

    else {
      return $data;
    }
  }
}

sub fixups {

    # toml-test has lower precision datetime values than TOML::Tiny
    spew( 'toml-test/tests/valid/datetime/milliseconds.json', <<'EOS' );
{
    "utc1":  {"type": "datetime", "value": "1987-07-05T17:45:56.123000000Z"},
    "utc2":  {"type": "datetime", "value": "1987-07-05T17:45:56.600000000Z"},
    "wita1": {"type": "datetime", "value": "1987-07-05T17:45:56.123000000+08:00"},
    "wita2": {"type": "datetime", "value": "1987-07-05T17:45:56.600000000+08:00"}
}
EOS

}


sub find_tests{
  my $src = shift;
  my $spec = shift;

  my @src = File::Spec->splitdir( $src );
  my $type = pop @src;

  my %tests;
  my sub wanted {
    return unless /\.toml$/;

    my $abs = File::Spec->rel2abs( $_ );
    my $rel = File::Spec->abs2rel( $abs, $src );

    my $toml = $rel;
    my $test = substr $rel, 0, -5;
    $tests{$test} = $toml;
  }

  my $list = File::Spec->catfile( @src, "files-toml-$spec" );
  if ( -f $list ) {
      my @files = split( /\n/, slurp( $list ) );
      for ( grep /^$type/, @files ) {
          $_ = File::Spec->catfile( @src, $_ );
          wanted();
      }
  }
  else {
    find {
      no_chdir => 1,
      wanted => \&wanted,
    } => $src;
  }

  return %tests;
}

sub build_pospath_test_files{
  my $src  = shift;
  my $dest = shift;
  my $spec = shift;

  $src = "$src/tests/valid";
  $dest = "$dest/t/toml-test/valid";

  print "Generating positive path tests from $src\n";

  my %TOML = find_tests( $src, $spec );

  for (sort keys %TOML) {
    copy("$src/$TOML{$_}", "$dest/$TOML{$_}");

    my $json = substr( $TOML{$_}, 0, -4 ) . 'json';
    my $data = deturd_json("$src/$json");
    my $test = "$dest/$_.t";

    my ( undef, $path ) = File::Spec->splitpath( $test );
    unless (-f $test) {
      system('mkdir', '-p', $path) == 0 || die $?;
    }

    open my $fh, '>', $test or die $!;

    print $fh qq{# File automatically generated from toml-lang/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

local \$Data::Dumper::Sortkeys = 1;
local \$Data::Dumper::Useqq    = 1;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

open my \$fh, '<', "$dest/$TOML{$_}" or die \$!;
binmode \$fh, ':encoding(UTF-8)';
my \$toml = do{ local \$/; <\$fh>; };
close \$fh;

my $data

my \$actual = from_toml(\$toml);

is(\$actual, \$expected1, '$_ - from_toml') or do{
  diag 'TOML INPUT:';
  diag "\$toml";

  diag '';
  diag 'EXPECTED:';
  diag Dumper(\$expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper(\$actual);
};

my \$regenerated = to_toml \$actual;
my \$reparsed    = eval{ scalar from_toml \$regenerated };
my \$error       = \$@;

ok(!\$error, '$_ - to_toml - no errors')
  or diag \$error;

is(\$reparsed, \$expected1, '$_ - to_toml') or do{
  diag "ERROR: \$error" if \$error;

  diag '';
  diag 'PARSED FROM TEST SOURCE TOML:';
  diag Dumper(\$actual);

  diag '';
  diag 'REGENERATED TOML:';
  diag \$regenerated;

  diag '';
  diag 'REPARSED FROM REGENERATED TOML:';
  diag Dumper(\$reparsed);
};

done_testing;};

    close $fh;
  }
}

sub build_negpath_test_files{
 my $src  = shift;
 my $dest = shift;
 my $spec = shift;

  $src = "$src/tests/invalid";
  $dest = "$dest/t/toml-test/invalid";

  print "Generating negative path tests from $src\n";

  my %TOML = find_tests( $src, $spec );

  for (sort keys %TOML) {
    copy("$src/$TOML{$_}", "$dest/$TOML{$_}");

    my $test = "$dest/$_.t";
    my ( undef, $path ) = File::Spec->splitpath( $test );
    unless (-f $test) {
      system('mkdir', '-p', $path) == 0 || die $?;
    }

    open my $fh, '>', $test or die $!;

    print $fh qq{# File automatically generated from toml-lang/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

open my \$fh, '<', "$dest/$TOML{$_}" or die \$!;
binmode \$fh, ':raw';
my \$toml = do{ local \$/; <\$fh>; };
close \$fh;

ok dies(sub{ scalar from_toml(\$toml, strict => 1) }), 'strict_mode dies on $_';

done_testing;};

    close $fh;
  }
}

my $usage = "usage:$0 \$toml-test-repo-path \$toml-tiny-repo-path \$toml-spec-version\n";
my $toml_test_path = shift @ARGV || die $usage;
my $toml_tiny_path = shift @ARGV || die $usage;
my $toml_spec_version = shift @ARGV || die $usage;

-d $toml_test_path          || die "invalid path to toml-lang/toml-test: $toml_test_path\n";
-d "$toml_test_path/tests"  || die "invalid path to toml-lang/toml-test: $toml_test_path\n";
-d $toml_tiny_path          || die "invalid path to TOML::Tiny repo: $toml_tiny_path\n";
-d "$toml_tiny_path/t"      || die "invalid path to TOML::Tiny repo: $toml_tiny_path\n";

print "Checking out main branch of toml-lang/toml-test and pulling the latest commits\n";

# check out toml-test repo, and make sure we don't have cruft in it
system("cd $toml_test_path && git checkout main && git pull && git restore --staged --worktree . && git clean -f .") == 0 || die $!;

fixups;

-f "$toml_test_path/tests/files-toml-$toml_spec_version" || die "invalid spec version: $toml_spec_version";

my @args = ( $toml_test_path, $toml_tiny_path, $toml_spec_version );
build_pospath_test_files(@args);
build_negpath_test_files(@args);
