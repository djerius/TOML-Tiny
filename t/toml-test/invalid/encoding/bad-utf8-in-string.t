# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
# The following line contains an invalid UTF-8 sequence.
bad = "�"

  |, strict => 1);
}), 'strict_mode dies on encoding/bad-utf8-in-string';

done_testing;