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
  #print Dumper $self->req->content->headers->cookie;
  my $default_printer_config = $self->cookie('printer'); # TODO вынести в конфиг и получить натсройки в \хэш
  # извлечем в хэш данные и обработаем их
  my $printer = _cookie_data_extract($self->req->content->headers->cookie);
  $self->render(text => 'Good: ' . $self->param('email'));
}

## SUBS ##
sub _cookie_data_extract {
  #'sign1=on; light1=on; roll1=on; height1=on; roll2=on; height2=on; sign2=on; printer=regular'
  my $c = shift;
  my %printer;# хэш получаем по имени принтера из БД или конфига (сделать позже)
  chomp($c);
  $c =~ s/\s+//g;
  my @line = (split /;/,$c);
  foreach my $var(@line) {
    next if $var =~ /off$/i; #если выключена - пропускаем
    my ($name,$value) = split(/=/,$var,2);
    if (exists $printer{$name}) {# отбираем только те значения что есть в хэше
        $printer{$name} = $value;
    }
  }
  return \%printer;# возвращаем конфиг принтера сделанного клиентом
}


1;
