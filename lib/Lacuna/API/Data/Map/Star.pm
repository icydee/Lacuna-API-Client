package Lacuna::API::Data::Map::Star;

use Moose;
use Carp;
use Lacuna::API::Data::Bits::DateTime;

# This defines a single star

with 'Lacuna::API::Data::Role::Attributes';

# Attributes based on the hash returned by the call
my $attributes = {
    id                      => 'Int',
    name                    => 'Str',
    color                   => 'Str',
    x                       => 'Int',
    y                       => 'Int',
    zone                    => 'Str',
    bodies                  => \'ArrayRef[Lacuna::API::Data::Body::PublicBody]',
    station                 => \'Lacuna::API::Data::Body::PublicBody',
};

has '_attributes' => (
    is          => 'ro',
    default     => sub {$attributes},
    init_arg    => undef,
);

create_attributes(__PACKAGE__, $attributes);

no Moose;
__PACKAGE__->meta->make_immutable;

