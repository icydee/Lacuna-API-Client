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

    my $empire_id = $self->client->empire->create({
        name                => $empire_name,
        password            => 'secret',
        password1           => 'secret',
        captcha_guid        => $captcha->guid,
        captcha_solution    => $captcha_solution,
        email               => $email_address,
    });

    print "New empire created with ID=$empire_id\n";
    
    my $result = $self->client->empire->update_species({
        empire_id               => $empire_id,
        name                    => 'Species Name',
        description             => 'Species Description',
        min_orbit               => 1,
        max_orbit               => 3,
        manufacturing_affinity  => 2,
        deception_affinity      => 2,
        research_affinity       => 2,
        management_affinity     => 5,
        farming_affinity        => 5,
        mining_affinity         => 2,
        science_affinity        => 4,
        environmental_affinity  => 4,
        political_affinity      => 2,
        trade_affinity          => 7,
        growth_affinity         => 7,
    });
    
    
    my $result = $self->client->empire->found({
        empire_id           => $empire_id,
        api_key             => $self->client->empire->api_key, 
    });
    print "Empire $empire_id Founded successfully\n";

}

__PACKAGE__->meta->make_immutable;



