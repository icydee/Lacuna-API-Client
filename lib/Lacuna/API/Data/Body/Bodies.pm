package Lacuna::API::Data::Body::Bodies;

use Moose;
use Carp;

# This defines the 'bodies' structure returned from empires status.

with 'Lacuna::API::Data::Role::Attributes';

# Attributes based on the hash returned by the call
my $attributes = {
    colonies        => \'ArrayRef[Lacuna::API::Data::Body::MiniStatus]',
    mystations      => \'ArrayRef[Lacuna::API::Data::Body::MiniStatus]',
    ourstations     => \'ArrayRef[Lacuna::API::Data::Body::MiniStatus]',
    babies          => \'HashRef[Lacuna::API::Data::Body::Baby]',
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
