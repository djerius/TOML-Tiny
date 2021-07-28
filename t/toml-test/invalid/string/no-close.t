# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
no-ending-quote = "One time, at band camp

  |, strict => 1);
}), 'strict_mode dies on string/no-close';

done_testing;