package Lacuna::API::Data::Map::StarMap;

use Moose;
use Carp;
use Lacuna::API::Data::Bits::DateTime;

with 'Lacuna::API::Data::Role::Attributes';

has 'left'      => (is => 'rw');
has 'top'       => (is => 'rw');
has 'bottom'    => (is => 'rw');
has 'right'     => (is => 'rw');

# Attributes based on the hash returned by the call
my $attributes = {
    stars       => \'ArrayRef[Lacuna::API::Data::Map::Star]',
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
