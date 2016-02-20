package Lacuna::API::App::EmpireMisc::CreateAndFound;

use Moose;
use MooseX::App::Command;
use namespace::autoclean;
use Data::Dumper;
use String::Random;

extends 'Lacuna::API::App::EmpireMisc';

sub run {
    my ($self) = @_;

    print "Fetching a captcha\n";

    my $captcha = $self->client->empire->fetch_captcha;

    print "CAPTCHA:/nguid=[".$captcha->guid."]/nurl =[".$captcha->url."]\nPlease provide the solution: ";
    my $captcha_solution = <STDIN>;
    chomp $captcha_solution;

    my $string_random   = String::Random->new;
    my $empire_name     = $string_random->randpattern("CcccccccccCccccccccc");
    my $email_address   = $string_random->randpattern("Cccccccccccc").'@example.com';

    my $result = $self->client->empire->create({
        name                => $empire_name,
        password            => 'secret',
        password1           => 'secret',
        captcha_guid        => $captcha->guid,
        captcha_solution    => $captcha_solution,
        email               => $email_address,
    });
    my $empire_id = $result->{empire_id};

    print "New empire created with ID=$empire_id\n";
    print "API KEY ".$self->client->empire->api_key."\n";
    $result = $self->client->empire->found({
        empire_id           => $empire_id,
        api_key             => $self->client->empire->api_key, 
    });


}

__PACKAGE__->meta->make_immutable;



