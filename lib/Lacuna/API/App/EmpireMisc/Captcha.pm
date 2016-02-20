package Lacuna::API::App::EmpireMisc::Captcha;

use Moose;
use MooseX::App::Command;
use namespace::autoclean;
use Data::Dumper;

extends 'Lacuna::API::App::EmpireMisc';

sub run {
    my ($self) = @_;

    print "Fetching a captcha\n";

    my $captcha = $self->client->empire->fetch_captcha({});

    print "CAPTCHA:/nguid=[".$captcha->guid."]/nurl =[".$captcha->url."]\n";
}

__PACKAGE__->meta->make_immutable;



