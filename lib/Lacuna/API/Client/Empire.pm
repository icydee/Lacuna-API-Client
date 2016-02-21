package Lacuna::API::Client::Empire;

use Moose;
use Carp;
use Lacuna::API::Data::Empire::MyEmpire;
use Lacuna::API::Data::Empire::PublicProfile;
use Lacuna::API::Data::Empire::MyProfile;
use Lacuna::API::Data::Bits::Captcha;
use Data::Dumper;

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

    my $response          = $self->call('get_status');
    my $my_empire_raw   = $response->{result}{empire};
    return Lacuna::API::Data::Empire::MyEmpire->new_from_raw($my_empire_raw);
}

sub _build_own_profile {
    my ($self) = @_;

    my $response          = $self->call('get_own_profile');
    my $own_profile_raw = $response->{result}{own_profile};
    return Lacuna::API::Data::Empire::MyProfile->new_from_raw($own_profile_raw);
}

sub get_public_profile {
    my ($self, $empire_id) = @_;

    my $response          = $self->call('get_public_profile', $empire_id);
    return Lacuna::API::Data::Empire::PublicProfile->new({
        id   => $empire_id,
    });
}

# Returns true if the empire name is available
# 
sub is_name_available {
    my ($self, $args) = @_;
    local $@;

    my $response = eval { return $self->call('is_name_available', { name => $args->{name} }) };

    return undef if $@;
    return $response->{result}{available} == 1;
}

# This method is not really required since the code will try
# to auto-login or re-use an existing session
#
sub login {
    my ($self, $args) = @_;

    my $response = $self->call('login', {
        name        => $args->{name},
        password    => $args->{password},
        api_key     => $self->api_key,
    });
    return 1;
}

# Returns a referral URL
#
sub get_invite_friend_url {
    my ($self) = @_;

    my $response = $self->call('get_invite_friend_url');
    return $response->{result}{referral_url};
}

# Returns true if logged out
#
sub logout {
    my ($self) = @_;

    my $response = $self->call('logout');
    return 1;
}

# Returns a Captcha object
# 
sub fetch_captcha {
    my ($self) = @_;

    my $response = $self->call('fetch_captcha', {});
    return Lacuna::API::Data::Bits::Captcha->new_from_raw($response->{result});
}

# Returns the empire_id if successful
# 
sub create {
    my ($self, $args) = @_;

    my $response = $self->call('create', $args);
    return $response->{result}{empire_id};
}

# Returns true if the empire is founded
#
sub found {
    my ($self, $args) = @_;

    my $response = $self->call('found', $args);
    return 1;
}

# Returns true if the species can be updated
#
sub update_species {
    my ($self, $args) = @_;

    my $response = $self->call('update_species', $args);
    return 1;
}

# Return the empire status
#
sub get_status {
    my ($self, $args) = @_;

    my $response    = $self->call('get_status', $args);

#    foreach my $key (sort keys %{$response->{result}{empire}{bodies}} ) {
#        print "KEY: $key ".Dumper($response->{result}{empire}{bodies}{$key});
#    }

    return Lacuna::API::Data::Empire::MyEmpire->new_from_raw($response->{result}{empire});
}



no Moose;
__PACKAGE__->meta->make_immutable;
1;
