package Lacuna::API::Data::Body::PublicBody;

use Moose;
use Carp;

# This defines data about a body that is publically available.

with 'Lacuna::API::Data::Role::Attributes';

# Attributes based on the hash returned by the call
my $attributes = {
    id                      => 'Int',
    name                    => 'Str',
    x                       => 'Int',
    y                       => 'Int',
    type                    => 'Str',
    empire                  => \'Lacuna::API::Data::Empire::Status',
    zone                    => 'Str',
    size                    => 'Int',
    orbit                   => 'Int',
    image                   => 'Str',
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
