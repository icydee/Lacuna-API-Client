package Lacuna::API::Data::Empire::MyEmpire;

use Moose;
use Carp;
use Lacuna::API::Data::Bits::DateTime;
use Lacuna::API::Data::Body::MyBody;

# This defines your own Empire and all the attributes and methods that go with it
# mostly, this is obtained by a call to /empire get_status

with 'Lacuna::API::Data::Role::Attributes';

# Attributes based on the hash returned by the call
my $attributes = {
    id                      => 'Int',
    bodies                  => \'Lacuna::API::Data::Body::Bodies',
    colonies                => 'HashRef[Str]',
    essentia                => 'Num',
    has_new_messages        => 'Int',
    home_planet_id          => 'Int',
    insurrect_value         => 'Int',
    is_isolationist         => 'Int',
    latest_message_id       => 'Int',
    name                    => 'Str',
    next_colony_cost        => 'Int',
    next_colony_srcs        => 'Int',
    next_station_cost       => 'Int',
    planets                 => 'HashRef[Str]',
    rpc_count               => 'Int',
    self_destruct_active    => 'Int',
    self_destruct_date      => \'Lacuna::API::Data::Bits::DateTime',
    stations                => 'HashRef[Str]',
    status_message          => 'Str',
    tech_level              => 'Int',
};

has '_attributes' => (
    is          => 'ro',
    default     => sub {$attributes},
    init_arg    => undef,
);

create_attributes(__PACKAGE__, $attributes);

no Moose;
__PACKAGE__->meta->make_immutable;
1;
