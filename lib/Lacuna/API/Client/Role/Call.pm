package Lacuna::API::Client::Role::Call;

use Moose::Role;
use Data::Dumper;

use Lacuna::API::Client::Connection;

has 'connection'        => (is => 'ro', lazy_build => 1);

sub _build_connection {
    return Lacuna::API::Client::Connection->instance;
}

sub call {
    my ($self, $uri, $args) = @_;
    $args->{session_id} = $self->connection->session_id;

    return $self->connection->call($self->_path, $uri, [$args]);
}

1
