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
  # извлечем в хэш данные и обработаем их
  my $printer = _cookie_data_extract($self->cookie('printer'),$self->req->content->headers->cookie);
  print Dumper($printer);
  $self->render(text => 'Good: ' . $self->param('email'));
}


## SUBS ##
sub _cookie_data_extract {
  #'sign1=on; light1=on; roll1=on; height1=on; roll2=on; height2=on; sign2=on; printer=regular'
  my ($printer,$c) = @_;
  my (%data,@array_on);
  chomp($c);
  $c =~ s/\s+//g;
  my @line = (split /;/,$c);
  foreach my $var(@line) {
    next if $var =~ /off$/i;
    say $var;
    my ($name,$value) = split(/=/,$var,2);
    # если это не имя принтера и опция включена - добавляем в массив имя куки
    if ($name ne 'printer' and $value eq 'on') {
      push(@array_on,$name);
    }
    
    
  }
  
  $data{$printer} = @array_on;
  return \%data;
}


1;
