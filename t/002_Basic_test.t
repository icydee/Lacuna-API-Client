use strict;
use warnings;

use FindBin::libs;
use Data::Dumper;

use Test::More tests => 5;
BEGIN { use_ok('Lacuna::API::Client') };

eval { Lacuna::API::Client->new };
like($@, qr/Attribute \(uri\) is required/, 'Exception without uri');

my $client = eval { Lacuna::API::Client->new(uri => 'http://spacebotwar.com:8000') };
isa_ok($client, 'Lacuna::API::Client');

my $is_available = not $client->is_name_available( { name => 'icydee' } );

ok( $is_available, 'Empire is not available');

$is_available = $client->is_name_available( { name => 'Z1y3W5x7D6c4B2a' } );

ok($is_available, 'Empire is available');

1;
__END__
