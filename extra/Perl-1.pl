#!/usr/bin/perl -w
use strict;

my %printer = (
               mat1  => 'on', 
               sign1 => 'off',
               roll1 => 'off',
               light1 => 'off',
               height1 => 'off'
               );
#'sign1=on; light1=on; roll1=on; height1=on; roll2=on; height2=on; sign2=on; printer=regular'
  my $c = 'sign1=on; light1=off; roll1=off; height1=on; roll2=on; height2=on; sign2=off;sign3=on printer=regular';
  chomp($c);
  $c =~ s/\s+//g;
  my @line = (split /;/,$c);
  foreach my $var(@line) {
    next if $var =~ /off$/i; #если выключена - пропускаем
    
    #print $var,"\n";
    my ($name,$value) = split(/=/,$var,2);
    if (exists $printer{$name}) {
        $printer{$name} = $value;
        #print "$name: $value\n";
    } else {
        #print "$name: $printer{$name}\n";
    }

  }
  
  print %printer;
  