package Lacuna::API::Data::Body::MyBody;

use Moose;
use Carp;

# This defines data about a body (including your own colonies) as obtained
# by the call to /body get_status

with 'Lacuna::API::Data::Role::Attributes';

# Attributes based on the hash returned by the call
my $attributes = {
    id                      => 'Int',
    name                    => 'Str',
    x                       => 'Int',
    y                       => 'Int',
    type                    => 'Str',
    population              => 'Int',
    empire                  => \'Lacuna::API::Data::Empire::Status',
    ore_capacity            => 'Int',
    num_incoming_ally       => 'Int',
    num_incoming_foreign    => 'Int',
    num_incoming_own        => 'Int',
    water_stored            => 'Int',
    waste_stored            => 'Int',
    energy_stored           => 'Int',
    food_stored             => 'Int',
    ore_stored              => 'Int',
    water_capacity          => 'Int',
    waste_capacity          => 'Int',
    energy_capacity         => 'Int',
    food_capacity           => 'Int',
    ore_capacity            => 'Int',
    water_hour              => 'Int',
    waste_hour              => 'Int',
    energy_hour             => 'Int',
    food_hour               => 'Int',
    ore_hour                => 'Int',
    happiness               => 'Int',
    building_count          => 'Int',
    needs_surface_refresh   => 'Int',
    zone                    => 'Str',
    size                    => 'Int',
    orbit                   => 'Int',
    happiness_hour          => 'Int',
    surface_version         => 'Int',
    plots_available         => 'Int',
    water                   => 'Int',
    image                   => 'Str',
    ore                     => \'Lacuna::API::Data::Bits::Ores',
    star                    => \'Lacuna::API::Data::Map::Star',
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
