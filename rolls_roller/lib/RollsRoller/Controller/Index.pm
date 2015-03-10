package RollsRoller::Controller::Index;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

# This action will render a template
sub welcome {
  my $self = shift;
  $self->render('index');
}

# обрабатываем форму с заказом
sub diller {
  my $self = shift;
  #my $c = ;
  #my $cookie = Mojo::Cookie::Request->parse($c);
  #print Dumper $self->req->content->headers->cookie;
  # извлечем в хэш данные и обработаем их
  my $printer = _cooke_data_extract($self->req->content->headers->cookie);  
  $self->render(text => 'Good: ' . $self->param('email'));
}


## SUBS ##
sub _cookie_data_extract {
  #'sign1=on; light1=on; roll1=on; height1=on; roll2=on; height2=on; sign2=on; printer=regular'
  my $c = shift;
  my %data;
  #$data{$c->printer} = 
  1;
}


1;
