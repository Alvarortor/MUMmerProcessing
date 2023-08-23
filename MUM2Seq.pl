#!/usr/bin/perl -w
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO; 

#README
#Takes FASTA input sequence and trims according to mummer.mums coordinates
#Output is formatted so that Excel can read and filter data




#Program START
#Checks to see if you have all required arguments
if ($#ARGV !=2) {
print "Usage: perl MUM2Seq.pl <Yourfile.mums> <ReferenceFile> <QueryFile>\n";
exit;
};
my $mumsfile = $ARGV[0];
my $Ref_File = $ARGV[1];
my $Que_File = $ARGV[2];


#opening the Reference Fasta File
my $seqio_obj = Bio::SeqIO->new(-file => $Ref_File, 
                             -format => "fasta" );
while (my $seq_obj = $seqio_obj->next_seq ) {
	my $seq = $seq_obj->seq;
		
my $count = 0;
#Get Coords
open(FH,'<', $mumsfile) or die $!;

#Stating it the first time
chomp(my @number = split(' ', <FH>));
my $S1 = $number[0]-1;
my $LEN = $number[2]+1;

#Produce the substring
my $substring = substr($seq, $S1, $LEN);
my $end = $S1 + $LEN ;

#Save the substring
my $filename = <"RefSeq">;
open(my $fh, '>',$filename) or die "oops!";
my $collabels = "Start\tLEN\tSequence\n";
print $fh $collabels;
print $fh $S1+1,"\t", $end+1,"\t", $substring,"\n";
close $fh;

#loop until all done
$filename = <"RefSeq">;
open($fh, '>>',$filename) or die "oops!";
until( @number < 1)
{
@number = split(' ', <FH>);
$S1 = $number[0]-1;
$LEN = $number[2];

#Produce substring
my $substring = substr($seq, $S1, $LEN);
my $end = $S1 + $LEN;
my $num = ++$count;
#Write to file
print $fh $S1+1,"\t", $end+1,"\t", $substring,"\n";
;
}
close $fh;
;
}
#Finishes process
close (FH);
print "Hey, just ignore the errors above.\nHavent quite figured out how to remove them yet.\nDon't worry about them, ok?.\n";
print "Reference Sequences Done!\n";

#Repeats for the Query Sequences!
#opening the Reference Fasta File
$seqio_obj = Bio::SeqIO->new(-file => $Que_File, 
                             -format => "fasta" );
while (my $seq_obj = $seqio_obj->next_seq ) {
	my $seq = $seq_obj->seq;
	
my $count = 0;
#Get Coords
open(FH,'<', $mumsfile) or die $!;

#Stating it the first time
chomp(my @number = split(' ', <FH>));
my $S1 = $number[1]-1;
my $LEN = $number[2];

#Produce the substring
my $substring = substr($seq, $S1, $LEN);
my $end = $S1 + $LEN ;

#Save the substring
my $filename = <"QueSeq">;
open(my $fh, '>',$filename) or die "oops!";
#Below line is hidden bc its not needed for proof anymore
my $collabels = "Start\tLEN\tSequence\n";
print $fh $collabels;
print $fh $S1+1,"\t", $end+1,"\t", $substring,"\n";
close $fh;

#loop until all done
$filename = <"QueSeq">;
open($fh, '>>',$filename) or die "oops!";
until( @number < 1)
{
@number = split(' ', <FH>);
$S1 = $number[0]-1;
$LEN = $number[2];

#Produce substring
my $substring = substr($seq, $S1, $LEN);
my $end = $S1 + $LEN;
my $num = ++$count;
#Write to file
print $fh $S1+1,"\t", $end+1,"\t", $substring,"\n";
;
}
close $fh;
;
}


print "Hey, just ignore the errors above.\nStill don't know how to remove them.\nDon't worry about them, ok?.\n";
print "Query Sequences Done!\n";
#Do the rest of the file
exit 0;

