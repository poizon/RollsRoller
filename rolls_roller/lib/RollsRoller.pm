package RollsRoller;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;
  # Documentation browser under "/perldoc"
  #$self->plugin('PODRenderer');
  # Router
  my $r = $self->routes;
  # app
  $self->secrets(['r0llsR0ll3rc0nf1gurator']);
  # Normal route to controller
  $r->get('/')->to('index#welcome');
  
  $r->post('/')->to('index#diller');
  
}

1;
