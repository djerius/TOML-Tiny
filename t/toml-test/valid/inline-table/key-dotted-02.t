# File automatically generated from toml-lang/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

local $Data::Dumper::Sortkeys = 1;
local $Data::Dumper::Useqq    = 1;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

open my $fh, '<', "./t/toml-test/valid/inline-table/key-dotted-02.toml" or die $!;
binmode $fh, ':encoding(UTF-8)';
my $toml = do{ local $/; <$fh>; };
close $fh;

my $expected1 = {
               "many" => {
                           "dots" => {
                                       "here" => {
                                                   "dot" => {
                                                              "dot" => {
                                                                         "dot" => {
                                                                                    "a" => {
                                                                                             "b" => {
                                                                                                      "c" => bless( {
                                                                                                                      "_file" => "(eval 000)",
                                                                                                                      "_lines" => [
                                                                                                                                    7
                                                                                                                                  ],
                                                                                                                      "code" => sub {
                                                                                                                                    BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x41\x50\x51\x00\x00\x15\x55\x55"}
                                                                                                                                    use strict;
                                                                                                                                    no feature ':all';
                                                                                                                                    use feature ':5.16';
                                                                                                                                    require Math::BigInt;
                                                                                                                                    my $got = 'Math::BigInt'->new($_);
                                                                                                                                    'Math::BigInt'->new('1')->beq($got);
                                                                                                                                },
                                                                                                                      "name" => "Math::BigInt->new(\"1\")->beq(\$_)",
                                                                                                                      "operator" => "CODE(...)",
                                                                                                                      "stringify_got" => 0
                                                                                                                    }, 'Test2::Compare::Custom' ),
                                                                                                      "d" => bless( {
                                                                                                                      "_file" => "(eval 000)",
                                                                                                                      "_lines" => [
                                                                                                                                    7
                                                                                                                                  ],
                                                                                                                      "code" => sub {
                                                                                                                                    BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x41\x50\x51\x00\x00\x15\x55\x55"}
                                                                                                                                    use strict;
                                                                                                                                    no feature ':all';
                                                                                                                                    use feature ':5.16';
                                                                                                                                    require Math::BigInt;
                                                                                                                                    my $got = 'Math::BigInt'->new($_);
                                                                                                                                    'Math::BigInt'->new('2')->beq($got);
                                                                                                                                },
                                                                                                                      "name" => "Math::BigInt->new(\"2\")->beq(\$_)",
                                                                                                                      "operator" => "CODE(...)",
                                                                                                                      "stringify_got" => 0
                                                                                                                    }, 'Test2::Compare::Custom' )
                                                                                                    }
                                                                                           }
                                                                                  }
                                                                       }
                                                            }
                                                 }
                                     }
                         }
             };


my $actual = from_toml($toml);

is($actual, $expected1, 'inline-table/key-dotted-02 - from_toml') or do{
  diag 'TOML INPUT:';
  diag "$toml";

  diag '';
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'inline-table/key-dotted-02 - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'inline-table/key-dotted-02 - to_toml') or do{
  diag "ERROR: $error" if $error;

  diag '';
  diag 'PARSED FROM TEST SOURCE TOML:';
  diag Dumper($actual);

  diag '';
  diag 'REGENERATED TOML:';
  diag $regenerated;

  diag '';
  diag 'REPARSED FROM REGENERATED TOML:';
  diag Dumper($reparsed);
};

done_testing;