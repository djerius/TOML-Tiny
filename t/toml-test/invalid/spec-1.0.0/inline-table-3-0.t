# File automatically generated from toml-lang/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

open my $fh, '<', "./t/toml-test/invalid/spec-1.0.0/inline-table-3-0.toml" or die $!;
binmode $fh, ':raw';
my $toml = do{ local $/; <$fh>; };
close $fh;

ok dies(sub{ scalar from_toml($toml, strict => 1) }), 'strict_mode dies on spec-1.0.0/inline-table-3-0';

done_testing;