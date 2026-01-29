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

open my $fh, '<', "./t/toml-test/valid/spec-1.0.0/float-0.toml" or die $!;
binmode $fh, ':encoding(UTF-8)';
my $toml = do{ local $/; <$fh>; };
close $fh;

my $expected1 = {
               "flt1" => bless( {
                                  "_file" => "(eval 000)",
                                  "_lines" => [
                                                7
                                              ],
                                  "code" => sub {
                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x41\x50\x51\x00\x00\x15\x55\x55"}
                                                use strict;
                                                no feature ':all';
                                                use feature ':5.16';
                                                require Math::BigFloat;
                                                my $got = 'Math::BigFloat'->new($_);
                                                'Math::BigFloat'->new('1')->beq($got);
                                            },
                                  "name" => "Math::BigFloat->new(\"1\")->beq(\$_)",
                                  "operator" => "CODE(...)",
                                  "stringify_got" => 0
                                }, 'Test2::Compare::Custom' ),
               "flt2" => bless( {
                                  "_file" => "(eval 000)",
                                  "_lines" => [
                                                7
                                              ],
                                  "code" => sub {
                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x41\x50\x51\x00\x00\x15\x55\x55"}
                                                use strict;
                                                no feature ':all';
                                                use feature ':5.16';
                                                require Math::BigFloat;
                                                my $got = 'Math::BigFloat'->new($_);
                                                'Math::BigFloat'->new('3.1415')->beq($got);
                                            },
                                  "name" => "Math::BigFloat->new(\"3.1415\")->beq(\$_)",
                                  "operator" => "CODE(...)",
                                  "stringify_got" => 0
                                }, 'Test2::Compare::Custom' ),
               "flt3" => bless( {
                                  "_file" => "(eval 000)",
                                  "_lines" => [
                                                7
                                              ],
                                  "code" => sub {
                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x41\x50\x51\x00\x00\x15\x55\x55"}
                                                use strict;
                                                no feature ':all';
                                                use feature ':5.16';
                                                require Math::BigFloat;
                                                my $got = 'Math::BigFloat'->new($_);
                                                'Math::BigFloat'->new('-0.01')->beq($got);
                                            },
                                  "name" => "Math::BigFloat->new(\"-0.01\")->beq(\$_)",
                                  "operator" => "CODE(...)",
                                  "stringify_got" => 0
                                }, 'Test2::Compare::Custom' ),
               "flt4" => bless( {
                                  "_file" => "(eval 000)",
                                  "_lines" => [
                                                7
                                              ],
                                  "code" => sub {
                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x41\x50\x51\x00\x00\x15\x55\x55"}
                                                use strict;
                                                no feature ':all';
                                                use feature ':5.16';
                                                require Math::BigFloat;
                                                my $got = 'Math::BigFloat'->new($_);
                                                'Math::BigFloat'->new('5e+22')->beq($got);
                                            },
                                  "name" => "Math::BigFloat->new(\"5e+22\")->beq(\$_)",
                                  "operator" => "CODE(...)",
                                  "stringify_got" => 0
                                }, 'Test2::Compare::Custom' ),
               "flt5" => bless( {
                                  "_file" => "(eval 000)",
                                  "_lines" => [
                                                7
                                              ],
                                  "code" => sub {
                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x41\x50\x51\x00\x00\x15\x55\x55"}
                                                use strict;
                                                no feature ':all';
                                                use feature ':5.16';
                                                require Math::BigFloat;
                                                my $got = 'Math::BigFloat'->new($_);
                                                'Math::BigFloat'->new('1e+06')->beq($got);
                                            },
                                  "name" => "Math::BigFloat->new(\"1e+06\")->beq(\$_)",
                                  "operator" => "CODE(...)",
                                  "stringify_got" => 0
                                }, 'Test2::Compare::Custom' ),
               "flt6" => bless( {
                                  "_file" => "(eval 000)",
                                  "_lines" => [
                                                7
                                              ],
                                  "code" => sub {
                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x41\x50\x51\x00\x00\x15\x55\x55"}
                                                use strict;
                                                no feature ':all';
                                                use feature ':5.16';
                                                require Math::BigFloat;
                                                my $got = 'Math::BigFloat'->new($_);
                                                'Math::BigFloat'->new('-0.02')->beq($got);
                                            },
                                  "name" => "Math::BigFloat->new(\"-0.02\")->beq(\$_)",
                                  "operator" => "CODE(...)",
                                  "stringify_got" => 0
                                }, 'Test2::Compare::Custom' ),
               "flt7" => bless( {
                                  "_file" => "(eval 000)",
                                  "_lines" => [
                                                7
                                              ],
                                  "code" => sub {
                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x41\x50\x51\x00\x00\x15\x55\x55"}
                                                use strict;
                                                no feature ':all';
                                                use feature ':5.16';
                                                require Math::BigFloat;
                                                my $got = 'Math::BigFloat'->new($_);
                                                'Math::BigFloat'->new('6.626e-34')->beq($got);
                                            },
                                  "name" => "Math::BigFloat->new(\"6.626e-34\")->beq(\$_)",
                                  "operator" => "CODE(...)",
                                  "stringify_got" => 0
                                }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml($toml);

is($actual, $expected1, 'spec-1.0.0/float-0 - from_toml') or do{
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

ok(!$error, 'spec-1.0.0/float-0 - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'spec-1.0.0/float-0 - to_toml') or do{
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