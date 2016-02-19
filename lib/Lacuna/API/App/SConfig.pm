package Lacuna::API::App::SConfig;

use MooseX::Singleton;
use namespace::autoclean;

has config => (
    is          => 'rw',
    isa         => 'HashRef',
    required    => 1,
);

__PACKAGE__->meta->make_immutable;

