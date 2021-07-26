# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
# A terminating comma (also called trailing comma) is not permitted after the
# last key/value pair in an inline table
abc = { abc = 123, }

  |, strict_arrays => 1);
}), 'strict_mode dies on inline-table/trailing-comma';

done_testing;