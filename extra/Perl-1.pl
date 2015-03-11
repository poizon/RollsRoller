#!/usr/bin/perl -w
use strict;


#'sign1=on; light1=on; roll1=on; height1=on; roll2=on; height2=on; sign2=on; printer=regular'
  my ($printer,$c) = ('regular','sign_reqular=on; light_reqular=on; roll_reqular=on; height_reqular=on; roll_entry=on; height_entry=on; sign_entry=off;sign_premium=on printer=regular');
  my (%data,@array_on);
  chomp($c);
  $c =~ s/\s+//g;
  my @line = (split /;/,$c);
  foreach my $var(@line) {
    next if $var =~ /off$/i; #если выключена - пропускаем
    print $var,"\n";
    my ($name,$value) = split(/=/,$var,2);
    print "!$name!\n";
    print "!sign_$printer!\n";
    next if $name eq "sign_$printer"; 
    # если это не имя принтера и опция включена - добавляем в массив имя куки
    if ($name =~ /[a-z]+_/g) {
      push(@array_on,$name);
    }
  }
  
  $data{$printer} = @array_on;
  
  print %data;