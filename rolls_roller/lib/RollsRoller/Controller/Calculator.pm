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
  if ($self->param('name')) {
  $self->render('calc/step2');
  } elsif($self->param('rollsPerMonth')) {
  $self->render('calc/step3');  
  } else {
  $self->render('calc/step1');  
  }
  
  
}

1;
