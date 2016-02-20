package Lacuna::API::App::EmpireMisc::IsNameAvailable;

use Moose;
use MooseX::App::Command;
use namespace::autoclean;

extends 'Lacuna::API::App::EmpireMisc';

option 'empire_name' => (
    is              => 'rw',
    isa             => 'Str',
    required        => 1,
    documentation   => 'Empire name to check',
);

sub run {
    my ($self) = @_;

    print "Checking if empire name ".$self->empire_name." is available\n" if $self->verbose;

    my $is_available = $self->client->empire->is_name_available( { name => $self->empire_name } );

    print "Empire Name: '".$self->empire_name."' is ". ($is_available ? '' : "not ") . "available\n";
}

__PACKAGE__->meta->make_immutable;



