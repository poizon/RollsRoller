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
  my $param = $self->req->cookies;
  print $param->printer,"\n";
  # извлечем в хэш данные и обработаем их
  #my $printer = _cooke_data_extract($param);  
  $self->render(text => 'Good');
}


## SUBS ##
sub _cookie_data_extract {
  my $c = shift;
  my %data;
  #$data{$c->printer} = 
  1;
}


1;
