package Lacuna::API::App::Misc;
use MooseX::App qw(Config Color Man Typo);

with
    'Lacuna::API::App::Role::UsesCommon';

1;
__END__

=encoding utf8

=head1 SYNOPSIS

Application for Various small utilities

  # Get a list of all available commands
  
  api-misc help

=cut

