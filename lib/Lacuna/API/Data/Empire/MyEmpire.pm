package Lacuna::API::Data::Empire::MyEmpire;

use Moose;
use Carp;
use Lacuna::API::Data::Bits::DateTime;
use Lacuna::API::Data::Body::MyBody;

# This defines your own Empire and all the attributes and methods that go with it
# mostly, this is obtained by a call to /empire get_status

with 'Lacuna::API::Data::Role::Attributes';

# Attributes based on the hash returned by the call
my $attributes = {
    id                      => 'Int',
    rpc_count               => 'Int',
    is_isolationist         => 'Int',
    name                    => 'Str',
    status_message          => 'Str',
    home_planet_id          => 'Int',
    has_new_messages        => 'Int',
    latest_message_id       => 'Int',
    essentia                => 'Num',
    planets                 => \'ArrayRef[Lacuna::API::Data::Body::MyBody]',
    tech_level              => 'Int',
    self_destruct_active    => 'Int',
    self_destruct_date      => \'Lacuna::API::Data::Bits::DateTime',
    alignment               => 'Str',
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
