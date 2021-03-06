package Lacuna::API::Data::MyProfile;

use Moose;
use Carp;
use Lacuna::API::Data::Bits::DateTime;

with 'Lacuna::API::Data::Role::Attributes';

# Attributes based on the hash returned by the call
my $attributes = {
    id                          => 'Int',
    name                        => 'Str',
    player_name                 => 'Str',
    description                 => 'Str',
    status_message              => 'Str',
    city                        => 'Str',
    country                     => 'Str',
    notes                       => 'Str',
    skype                       => 'Str',
    player_name                 => 'Str',
    email                       => 'Str',
    sitter_password             => 'Str',
    medals                      => \'ArrayRef[Lacuna::API::Data::Bits::Medal]',
    skip_attack_messages        => 'Int',
    skip_excavator_artifact     => 'Int',
    skip_excavator_destroyed    => 'Int',
    skip_excavator_glyph        => 'Int',
    skip_excavator_plan         => 'Int',
    skip_excavator_replace_msg  => 'Int',
    skip_excavator_resources    => 'Int',
    skip_facebook_wall_posts    => 'Int',
    skip_found_nothing          => 'Int',
    skip_happiness_warnings     => 'Int',
    skip_medal_messages         => 'Int',
    skip_pollution_warnings     => 'Int',
    skip_probe_detected         => 'Int',
    skip_resource_warnings      => 'Int',
    skip_spy_recovery           => 'Int',
    skype                       => 'Int',
    dont_replace_excavator      => 'Int',
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
