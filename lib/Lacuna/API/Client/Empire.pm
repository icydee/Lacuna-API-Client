package Lacuna::API::Client::Empire;

use Moose;
use Carp;
use Lacuna::API::Client::Empire::Status;
use Lacuna::API::Client::Empire::PublicProfile;
use Lacuna::API::Client::Empire::OwnProfile;

# This defines your own Empire and all the attributes and methods that go with it
# mostly, this is obtained by a call to /empire get_status


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
has 'status'    => (
    is          => 'rw',
    isa         => 'Lacuna::API::Client::Empire::Status',
    lazy        => 1,
    builder     => '_build_status',
);
has 'own_profile' => (
    is          => 'rw',
    isa         => 'Lacuna::API::Client::Empire::OwnProfile',
    lazy        => 1,
    builder     => '_build_own_profile',
);


sub _build_status {
    my ($self) = @_;

    my $result = $self->call('get_status');
    my $body = $result->{result}{empire};
    return Lacuna::API::Client::Empire::Status->new_from_raw($body);
    
}

sub _build_own_profile {
    my ($self) = @_;
    my $result = $self->call('get_own_profile');
    my $body = $result->{result}{own_profile};
    return Lacuna::API::Client::Empire::OwnProfile->new_from_raw($body);

}

sub get_public_profile {
    my ($self, $empire_id) = @_;

    return Lacuna::API::Client::Empire::PublicProfile->new({
        id   => $empire_id,
    });
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
