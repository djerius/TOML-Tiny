# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use DateTime;
use DateTime::Format::RFC3339;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $expected1 = {
               'neganswer' => bless( {
                                       'operator' => 'CODE(...)',
                                       '_file' => '(eval 371)',
                                       'name' => '<Custom Code>',
                                       '_lines' => [
                                                     6
                                                   ],
                                       'code' => sub {
                                                     BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                     use strict;
                                                     no feature ':all';
                                                     use feature ':5.16';
                                                     require Math::BigInt;
                                                     'Math::BigInt'->new('-9223372036854775808')->beq($_);
                                                 }
                                     }, 'Test2::Compare::Custom' ),
               'answer' => bless( {
                                    '_lines' => [
                                                  6
                                                ],
                                    'code' => sub {
                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                  use strict;
                                                  no feature ':all';
                                                  use feature ':5.16';
                                                  require Math::BigInt;
                                                  'Math::BigInt'->new('9223372036854775807')->beq($_);
                                              },
                                    'name' => '<Custom Code>',
                                    '_file' => '(eval 370)',
                                    'operator' => 'CODE(...)'
                                  }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q{answer = 9223372036854775807
neganswer = -9223372036854775808
});

is($actual, $expected1, 'long-integer - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ from_toml(to_toml($actual)) }, $actual, 'long-integer - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag 'REPARSED OUTPUT:';
  diag Dumper(from_toml(to_toml($actual)));
};

done_testing;