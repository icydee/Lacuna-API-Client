package Lacuna::API::App::EmpireMisc::Login;

use Moose;
use MooseX::App::Command;
use Data::Dumper;
use namespace::autoclean;

extends 'Lacuna::API::App::EmpireMisc';

option 'empire_name' => (
    is              => 'rw',
    isa             => 'Str',
    required        => 1,
    documentation   => 'Empire name or ID',
);

option 'password' => (
    is              => 'rw',
    isa             => 'Str',
    required        => 1,
    documentation   => 'Empire main or sitter password',
);

sub run {
    my ($self) = @_;

    print "Test login to  ".$self->empire_name."\n" if $self->verbose;

    my $success = $self->client->empire->login({
        name        => $self->empire_name,
        password    => $self->password,
    });

    # If we get here then we know we have logged in
    # (an error would raise an exception)
    #
    print "Successful login.\n";

    my $referral_url = $self->client->empire->get_invite_friend_url({});
    print "GET_INVITE_FRIEND_URL: $referral_url\n";

    $success = $self->client->empire->logout({});

    print "LOGOUT: \n";

}

__PACKAGE__->meta->make_immutable;



