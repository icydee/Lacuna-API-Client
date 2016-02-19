package Lacuna::API::Client::Map::StarMap;

use Moose;
use Carp;
use Lacuna::API::Client::Bits::DateTime;
use Lacuna::API::Client::Body::Status;

with 'Lacuna::API::Client::Role::Call';
with 'Lacuna::API::Client::Role::Attributes';

has 'left'      => (is => 'rw');
has 'top'       => (is => 'rw');
has 'bottom'    => (is => 'rw');
has 'right'     => (is => 'rw');

# Attributes based on the hash returned by the call
my $attributes = {
    stars       => \'ArrayRef[Lacuna::API::Client::Map::Star]',
};

# private: path to the URL to call
has '_path'  => (
    is          => 'ro',
    default     => '/map',
    init_arg    => undef,
);

has '_attributes' => (
    is          => 'ro',
    default     => sub {$attributes},
    init_arg    => undef,
);

create_attributes(__PACKAGE__, $attributes);

sub update {
    my ($self) = @_;
    my $result = $self->call('get_star_map', {
        left        => $self->left,
        right       => $self->right,
        top         => $self->top,
        bottom      => $self->bottom,
    });
    $self->update_from_raw($result->{result});
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
