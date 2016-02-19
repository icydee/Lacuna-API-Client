package Lacuna::API::App::Role::UsesCommon;

use Moose::Role;
use MooseX::App::Role;
use Config::Any;

use Lacuna::API::App::SConfig;

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

has '_config' => (
    is              => 'rw',
    builder         => '_build_config',
    lazy            => 1,
);

#--- Builder methods

sub _build_config {
    my ($self) = @_;

    my $config = Config::Any->load_files({
        files           => [$self->config],
        flatten_to_hash => 1,
        use_ext         => 1,
    });
    $config = $config->{$self->config}{internal};

    Lacuna::API::App::SConfig->initialize({
        config => $config,
    });
    return $self->_config_data->{internal};
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

