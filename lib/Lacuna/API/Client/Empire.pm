package Lacuna::API::Client::Empire;

use Moose;
use Carp;
use Lacuna::API::Data::Empire::MyEmpire;
use Lacuna::API::Data::Empire::PublicProfile;
use Lacuna::API::Data::Empire::MyProfile;

# This object is responsible for all the calls to the path /empire


with 'Lacuna::API::Client::Role::Call';

has 'id'        => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

has '_path'      => (
    is          => 'ro',
    default     => '/empire',

);
has 'my_empire'    => (
    is          => 'rw',
    isa         => 'Lacuna::API::Data::Empire::MyEmpire',
    lazy        => 1,
    builder     => '_build_my_empire',
);
has 'own_profile' => (
    is          => 'rw',
    isa         => 'Lacuna::API::Data::Empire::MyProfile',
    lazy        => 1,
    builder     => '_build_own_profile',
);

sub _build_my_empire {
    my ($self) = @_;

    my $result          = $self->call('get_status');
    my $my_empire_raw   = $result->{result}{empire};
    return Lacuna::API::Data::Empire::MyEmpire->new_from_raw($my_empire_raw);
}

sub _build_own_profile {
    my ($self) = @_;

    my $result          = $self->call('get_own_profile');
    my $own_profile_raw = $result->{result}{own_profile};
    return Lacuna::API::Data::Empire::MyProfile->new_from_raw($own_profile_raw);
}

sub get_public_profile {
    my ($self, $empire_id) = @_;

    my $result          = $self->call('get_public_profile', $empire_id);
    return Lacuna::API::Data::Empire::PublicProfile->new({
        id   => $empire_id,
    });
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
