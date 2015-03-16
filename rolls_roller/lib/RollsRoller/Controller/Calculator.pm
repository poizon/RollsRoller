package RollsRoller::Controller::Calculator;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

# This action will render a template
sub welcome {
  my $self = shift;
  $self->render('calc/index');
}

sub startcalc {
  my $self = shift;
  $self->render('calc/step1');
}

1;
