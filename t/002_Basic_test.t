use strict;
use warnings;

use FindBin::libs;
use Data::Dumper;

use Test::More tests => 5;
BEGIN { use_ok('Lacuna::API::Client') };

eval { Lacuna::API::Client->new };
like($@, qr/Attribute \(config_file\) is required/, 'Exception without config_file');

my $client = eval { 
    return Lacuna::API::Client->new({
        config_file => "/data/Lacuna-API-Client/etc/client.yml"
    });
};

isa_ok($client, 'Lacuna::API::Client');

my $is_available = not $client->empire->is_name_available( { name => 'icydee' } );

ok( $is_available, 'Empire is not available');

$is_available = $client->empire->is_name_available( { name => 'Z1y3W5x7D6c4B2a' } );

ok($is_available, 'Empire is available');

1;
__END__
