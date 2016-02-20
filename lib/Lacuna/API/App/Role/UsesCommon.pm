package Lacuna::API::App::Role::UsesCommon;

use Moose::Role;
use MooseX::App::Role;
use Config::Any;
use Lacuna::API::Client;

#--- command line arguments common to all applications

option 'verbose' => (
    is          => 'rw',
    isa         => 'Int',
    default     => 0,
    documentation   => 'Level of verbosity',
);

option 'log_config' => (
    is              => 'rw',
    isa             => 'Str',
    required        => 1,
    documentation   => 'Full path to log4perl config file',
);

option 'client_config' => (
    is              => 'rw',
    isa             => 'Str',
    required        => 1,
    documentation   => 'Full path to client config file',
);

has 'client' => (
    is              => 'rw',
    builder         => '_build_client',
    lazy            => 1,
);


sub _build_client{
    my ($self) = @_;

    my $client = Lacuna::API::Client->new({
        config_file => $self->client_config,
    });
    return $client;
}


sub BUILD {
    my ($self) = @_;

    Log::Log4perl->init($self->log_config);
}

#-- Small class to aid testing
#
package Lacuna::API::App::Role::UsesCommon::Test;
use Moose;
with 'Lacuna::API::App::Role::UsesCommon';
1;
__END__

