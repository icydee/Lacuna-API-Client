package Lacuna::API::App::Misc::Login;

use Moose;
use MooseX::App::Command;
use Data::Dumper;
use namespace::autoclean;

extends 'Lacuna::API::App::Misc';

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

    my $response = $self->client->login({
        name        => $self->empire_name,
        password    => $self->password,
    });

    # If we get here then we know we have logged in
    # (an error would raise an exception)
    #
    print Dumper($response);
    print "Successful login. session = ".$response->{result}{session_id}."\n";

}

__PACKAGE__->meta->make_immutable;



