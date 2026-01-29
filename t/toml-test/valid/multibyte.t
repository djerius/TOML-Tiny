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

open my $fh, '<', "./t/toml-test/valid/multibyte.toml" or die $!;
binmode $fh, ':encoding(UTF-8)';
my $toml = do{ local $/; <$fh>; };
close $fh;

my $expected1 = {
               "\x{1d42d}\x{1d41b}\x{1d425}" => {
                                                  "string" => "\x{1d4fc}\x{1d4fd}\x{1d4fb}\x{1d4f2}\x{1d4f7}\x{1d4f0} - #",
                                                  "sub" => {
                                                             "another_test_string" => "\x{a7}\x{e1}\x{20a5}\x{e8} \x{1ad}\x{3bb}\x{ef}\x{f1}\x{3f1}, \x{3b2}\x{fa}\x{1ad} \x{3c9}\x{ef}\x{1ad}\x{3bb} \x{e1} \x{1a8}\x{1ad}\x{159}\x{ef}\x{f1}\x{3f1} #",
                                                             "escapes" => " \x{c2}\x{f1}\x{3b4} \x{3c9}\x{3bb}\x{e8}\x{f1} \"'\x{1a8} \x{e1}\x{159}\x{e8} \x{ef}\x{f1} \x{1ad}\x{3bb}\x{e8} \x{1a8}\x{1ad}\x{159}\x{ef}\x{f1}\x{3f1}, \x{e1}\x{2113}\x{f4}\x{f1}\x{3f1} \x{3c9}\x{ef}\x{1ad}\x{3bb} # \"",
                                                             "\x{3b2}\x{ef}\x{1ad}#" => {
                                                                                          "multi_line_array" => [
                                                                                                                  "]"
                                                                                                                ],
                                                                                          "\x{3c9}\x{3bb}\x{e1}\x{1ad}?" => "\x{dd}\x{f4}\x{fa} \x{3b4}\x{f4}\x{f1}'\x{1ad} \x{1ad}\x{3bb}\x{ef}\x{f1}\x{199} \x{1a8}\x{f4}\x{20a5}\x{e8} \x{fa}\x{1a8}\x{e8}\x{159} \x{3c9}\x{f4}\x{f1}'\x{1ad} \x{3b4}\x{f4} \x{1ad}\x{3bb}\x{e1}\x{1ad}?"
                                                                                        },
                                                             "\x{1d552}\x{1d563}\x{1d563}\x{1d552}\x{1d56a}" => [
                                                                                                                  "] ",
                                                                                                                  " # "
                                                                                                                ],
                                                             "\x{1d552}\x{1d563}\x{1d563}\x{1d552}\x{1d56a}\x{1d7da}" => [
                                                                                                                           "T\x{e8}\x{1a8}\x{1ad} #11 ]\x{1a5}\x{159}\x{f4}\x{1b2}\x{e8}\x{3b4} \x{1ad}\x{3bb}\x{e1}\x{1ad}",
                                                                                                                           "\x{c9}\x{436}\x{1a5}\x{e8}\x{159}\x{ef}\x{20a5}\x{e8}\x{f1}\x{1ad} #9 \x{3c9}\x{e1}\x{1a8} \x{e1} \x{1a8}\x{fa}\x{e7}\x{e7}\x{e8}\x{1a8}\x{1a8}"
                                                                                                                         ]
                                                           }
                                                }
             };


my $actual = from_toml($toml);

is($actual, $expected1, 'multibyte - from_toml') or do{
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

ok(!$error, 'multibyte - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'multibyte - to_toml') or do{
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