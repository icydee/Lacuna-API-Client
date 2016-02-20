package Lacuna::API::Data::Bits::Captcha;

use Moose;
use Carp;

with 'Lacuna::API::Data::Role::Attributes';

my $attributes = {
    guid            => 'Str',
    url             => 'Str',
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
