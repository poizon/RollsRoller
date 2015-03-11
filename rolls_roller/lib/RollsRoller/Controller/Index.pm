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
  # получаем настройки конкретной модели через конфиг
  my $def_roller =  $self->config->{rollers}->{$self->cookie('printer')};
  # извлечем в хэш данные и обработаем их
  my $printer = _cookie_data_extract($def_roller,$self->req->content->headers->cookie);
  my $client = $self->param('client');
  my $email = $self->param('email');
  my $mobile = $self->param('tel');
  # insert into database HERE
  #print Dumper($printer);
  $self->stash(name   => $client,
               printer => $self->cookie('printer'));
  $self->render('finish');
}

## SUBS ##
sub _cookie_data_extract {
  my ($def_printer,$c) = @_;
  chomp($c);
  $c =~ s/\s+//g;
  my @line = (split /;/,$c);
  foreach my $var(@line) {
    next if $var =~ /off$/i; #если выключена - пропускаем
    my ($name,$value) = split(/=/,$var,2);
    if (exists $def_printer->{$name}) {# отбираем только те значения что есть в хэше
        $def_printer->{$name} = $value;
    }
  }
  return $def_printer;# возвращаем конфиг принтера сделанного клиентом
}


1;
