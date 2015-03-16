package RollsRoller::Controller::Calculator;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

# This action will render a template
sub welcome {
  my $self = shift;
  $self->render('calc/index');
}


1;
