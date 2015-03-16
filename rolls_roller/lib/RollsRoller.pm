package RollsRoller;
use Mojo::Base 'Mojolicious';
$ENV{MOJO_CONFIG} = 'script/app.conf';
# This method will run once at server start
sub startup {
  my $self = shift;
  my $cfg = $self->plugin('Config');
  # Router
  my $r = $self->routes;
  # app
  $self->secrets([$cfg->{secret}]);
  # Normal route to controller
  $r->get('/')->to('index#welcome');
  
  $r->post('/')->to('index#diller');
  
  $r->get('/calculator')->to('calculator#welcome');
  
}

1;
