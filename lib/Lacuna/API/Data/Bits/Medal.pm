package Lacuna::API::Data::Bits::Medal;

use Moose;
use Carp;

with 'Lacuna::API::Data::Role::Attributes';

my $attributes = {
    id              => 'Int',
    name            => 'Str',
    image           => 'Str',
    date            => \'Lacuna::API::Data::Bits::DateTime',
    public          => 'Int',
    times_earned    => 'Int',
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
