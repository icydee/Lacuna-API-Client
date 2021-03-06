package Lacuna::API::Client::Map;

use Moose;
use Carp;

use Lacuna::API::Client::Map::StarMap;

# This defines the calls to the '/map' API

with 'Lacuna::API::Client::Role::Call';

has '_path'      => (
        is          => 'ro',
        default     => '/map',
        );

sub get_star_map {
    my ($self, $args) = @_;

    return Lacuna::API::Client::Map::StarMap->new($args);
}

sub check_star_for_incoming_probe {
    my ($self, $star_id) = @_;

    my $result = $self->call('check_star_for_incoming_probe', {
        star_id     => $star_id,
    });

    if ($result->{result}{incoming_probe}) {
        return Lacuna::API::Client::Bits::DateTime->new_from_raw($result->{result}{incoming_probe});
    }
    return;
}

# Get the status of a star
#
sub get_star {
    my ($self, $star_id) = @_;

    return Lacuna::API::Client::Map::Star->new({ id => $star_id });
}

# Find a star based on it's first few characters
#
sub find_star {
    my ($self, $star_name) = @_;

    my $result = $self->call('find_star', {
        name        => $star_name,
    });
    
    my @stars;
    foreach my $raw (@{$result->{result}{stars}}) {
        my $star = Lacuna::API::Client::Map::Star->new({
            id          => $raw->{id},
            name        => $raw->{name},
            x           => $raw->{x},
            y           => $raw->{y},
            color       => $raw->{color},
        });
        push @stars,$star;
    }
    return \@stars;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

=cut

=head1 NAME

Lacuna::API::Client::Map;

=head1 SYNOPSIS

  

=head1 DESCRIPTION

Client library call to the Lacuna Expanse /map API

=cut

