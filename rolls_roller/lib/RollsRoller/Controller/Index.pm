package RollsRoller::Controller::Index;
use Mojo::Base 'Mojolicious::Controller';
use DBI;
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
  my $model = $self->cookie('printer');
  $model =~ s/[^a-z]+//g;
  my $def_roller =  $self->config->{rollers}->{$model};
  # извлечем в хэш данные и обработаем их
  my $printer = _cookie_data_extract($def_roller,$self->req->content->headers->cookie);
  my $client = $self->param('client') || 'none';
  my $email = $self->param('email') || 0;
  my $mobile = $self->param('tel') || 0;
  $mobile =~ s/[^0-9]+//g;
  # собираем опции для записи в базу (уже проверенные в функции _cookie_data_extract)
  my $options='';
  foreach my $option(keys %$printer) {
    $options .= $option  . '=' . $printer->{$option} . ';';
  }
  # insert into database HERE
  my $dbh = DBI->connect($self->config->{db}{dsn},$self->config->{db}{user},$self->config->{db}{pass},$self->config->{db}{connect_options}) || die "Cannot connect to database!";
  
  eval {
        $dbh->do(qq{insert into rollorders (client,tel,email,options,model,status) values('$client','$email','$mobile','$options','$model',0)});
  };
  print Dumper($printer);
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
