# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
array = [
  "Entry 1",
  I don't belong,
  "Entry 2",
]

  |, strict => 1);
}), 'strict_mode dies on array/text-in-array';

done_testing;