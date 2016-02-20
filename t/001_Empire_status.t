use strict;
use warnings;

use Test::More tests => 1;

use FindBin::libs;
use Data::Dumper;
use Lacuna::API::Data::Empire::MyEmpire;

my $hash = {
    id                  => 666,
    rpc_count           => 321,
    is_isolationist     => 0,
    name                => 'My Empire',
    status_message      => 'Hello world',
    home_planet_id      => 123,
    has_new_messages    => 3,
    latest_message_id   => 3333,
    essentia            => 3.5,
    planets             => [
        {
            id          => 234,
            name        => "Earth",
        },
        {   id          => 333,
            name        => "Mars",
        }
    ],
    tech_level          => 20,
    self_destruct_active    => 0,
    self_destruct_date  => '17 03 2013 12:30:45 T',
};

my $empire_status = Lacuna::API::Data::Empire::MyEmpire->new_from_raw($hash);

print STDERR Dumper($empire_status);

ok(1);
1;

