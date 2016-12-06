#!/usr/bin/perl
use strict;
use warnings;

my %seq;
# open dictionary for reading
open (FH,"<", "dictionary.txt") or die ("could not open file");

# iterate through each word in dictionary
while (my $row = <FH>){

      chomp $row;
# create array for each word
      my @word = split ('',$row);

# loop through sequences of 4 characters
      while (scalar(@word) >= 4){
          my $sequence = join "", @word[0..3];
          $seq{$sequence} = [ ] unless exists $seq{$sequence};
          push @{$seq{$sequence}}, $row;
          shift @word;
     }
}
close(FH);

# open sequences and words file for writing
open (SEQ, ">", "sequences.txt") or die ("could not open file");
open (WORDS, ">", "words.txt") or die ("could not open file");

foreach my $key ( sort keys %seq){

# loop and filter once ocurrance
      if(scalar @{$seq{$key}} == 1){
          print $key . " = " . $seq{$key}[0] . "\n";
# print to sequences and words file
          print SEQ "$key\n";
          print WORDS "$seq{$key}[0]\n";
      }
}
close(SEQ);# close files
close(WORDS);
