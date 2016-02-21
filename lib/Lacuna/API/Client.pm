package Lacuna::API::Client;

use Moose;
use Data::Dumper;
use Carp;
use Contextual::Return;
use Config::Any;

use Lacuna::API::Client::Empire;
use Lacuna::API::SConfig;

with 'Lacuna::API::Client::Role::Call';

# This is the base class for the API

# Attributes
has 'config_file'   => (is => 'ro', required => 1);
has 'config'        => (is => 'ro', lazy_build => 1);
has 'uri'           => (is => 'ro', lazy_build => 1);
has 'username'      => (is => 'rw', lazy_build => 1);
has 'password'      => (is => 'rw', lazy_build => 1);
has 'debug_hits'    => (is => 'rw', default => 0);
has 'empire'        => (is => 'ro', lazy_build => 1);
has 'map'           => (is => 'ro', lazy_build => 1);
has 'inbox'         => (is => 'ro', lazy_build => 1);

my $status;

# Do an auto-login and get the initial status
sub BUILD {
    my ($self) = @_;

    Lacuna::API::Client::Connection->initialize({
            uri         => $self->uri,
            username    => $self->username,
            password    => $self->password,
            debug_hits  => $self->debug_hits,
            });
}

# Lazy build of config
#
sub _build_config {
    my ($self) = @_;

    my $config = Config::Any->load_files({
        files           => [$self->config_file],
        flatten_to_hash => 1,
        use_ext         => 1,
    });
    $config = $config->{$self->config_file};

    return $config;
}

# Lazy build of uri
#
sub _build_uri {
    my ($self) = @_;

    return $self->config->{uri};
}

# Lazy build of username
#
sub _build_username {
    my ($self) = @_;

    return $self->config->{username};
}

# Lazy build of password
#
sub _build_password {
    my ($self) = @_;

    return $self->config->{password};
}

# Lazy build of Inbox
#
sub _build_inbox {
    my ($self) = @_;

    my $inbox = Lacuna::API::Client::Inbox->new;

    return $inbox;
}

# Lazy build of My Empire
#
sub _build_empire {
    my ($self) = @_;

    return Lacuna::API::Client::Empire->new;
}

# Lazy build of Map
#
sub _build_map {
    my ($self) = @_;

    my $map = Lacuna::API::Client::Map->new({
        connection => $self->connection,
    });
    return $map;
}

# Generic Find method
#
sub find {
    my ($self, $args) = @_;

    my $things;
    if ($args->{empire}) {
#        print "search for empire [".$args->{empire}."]\n";
        $things = Lacuna::API::Client::Empire->find($args->{empire});
    }

    if ($args->{star}) {
#        print "search for star [".$args->{star}."]\n";
        $things = Lacuna::API::Client::Star->find($args->{star});
    }

    if ($args->{my_colony}) {
#        print "search for my colony [".$args->{my_colony}."]\n";
        $things = $self->empire->find_colony($args->{my_colony});
    }

    return (
        LIST        { @$things;         }
        SCALAR      { $things->[0];    }
    );
}

sub empire_rank {
    my ($self, $args) = @_;

    my $empire_rank = Lacuna::API::Client::EmpireRank->new($args);

    return $empire_rank
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
