package Lacuna::API::Data::Body::MiniStatus;

use Moose;
use Carp;

# This is a mini-status block, as returned in the 'bodies-colonies' section
# of the get_status block
#

with 'Lacuna::API::Data::Role::Attributes';

# Attributes based on the hash returned by the call
my $attributes = {
    id          => 'Int',
    name        => 'Str',
    zone        => 'Str',
    star_id     => 'Int',
    star_name   => 'Str',
    orbit       => 'Int',
    x           => 'Int',
    y           => 'Int',
    empire_name => 'Str',
    empire_id   => 'Int',
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
