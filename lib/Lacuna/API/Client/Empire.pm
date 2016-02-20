package Lacuna::API::Client::Empire;

use Moose;
use Carp;
use Lacuna::API::Data::Empire::MyEmpire;
use Lacuna::API::Data::Empire::PublicProfile;
use Lacuna::API::Data::Empire::MyProfile;

# This object is responsible for all the calls to the path /empire


with 'Lacuna::API::Client::Role::Call';

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
has 'api_key' => (
    is          => 'rw',
    isa         => 'Str',
    default     => '33779e58-4b56-4fcb-9994-66c10749c57b',
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

sub is_name_available {
    my ($self, $args) = @_;
    local $@;

    my $result = eval { return $self->call('is_name_available', { name => $args->{name} }) };

    return undef if $@;
    return $result->{result}{available} == 1;
}

# This method is not really required since the code will try
# to auto-login or re-use an existing session
#
sub login {
    my ($self, $args) = @_;

    my $result = $self->call('login', {
        name        => $args->{name},
        password    => $args->{password},
        api_key     => $self->api_key,
    });
    return 1;
}

sub get_invite_friend_url {
    my ($self) = @_;

    my $result = $self->call('get_invite_friend_url', {});
    return $result->{result}{referral_url};;
}


sub logout {
    my ($self) = @_;

    my $result = $self->connection->call('/empire', 'logout', {});
    return 1;
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
