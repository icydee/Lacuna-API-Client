package Lacuna::API::App::EmpireMisc::Status;

use Moose;
use MooseX::App::Command;
use Data::Dumper;
use namespace::autoclean;

use Lacuna::API::Data::Empire::MyEmpire;


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

    my $empire_status      = $self->client->empire->get_status;
  
    # To demonstrate, display all colony names
    my $colonies = $empire_status->bodies->colonies;
    print "Here are all your colonies\n";
    foreach my $colony (@$colonies) {
        print "    Colony: ".$colony->name."\n";
    }
}

__PACKAGE__->meta->make_immutable;



