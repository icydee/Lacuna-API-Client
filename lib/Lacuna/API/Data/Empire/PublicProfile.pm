package Lacuna::API::Data::PublicProfile;

use Moose;
use Carp;
use Lacuna::API::Data::Bits::DateTime;
use Lacuna::API::Data::Body::PublicBody;

with 'Lacuna::API::Data::Role::Attributes';

# Attributes based on the hash returned by the call
my $attributes = {
    id                      => 'Int',
    name                    => 'Str',
    colony_count            => 'Int',
    status_message          => 'Str',
    description             => 'Str',
    city                    => 'Str',
    country                 => 'Str',
    skype                   => 'Str',
    player_name             => 'Str',
    last_login              => \'Lacuna::API::Data::Bits::DateTime',
    date_founded            => \'Lacuna::API::Data::Bits::DateTime',
    species                 => 'Str',
    known_colonies          => \'ArrayRef[Lacuna::API::Data::Body::PublicBody]',
    medals                  => \'ArrayRef[Lacuna::API::Data::Bits::Medal]',
    #alliance
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
