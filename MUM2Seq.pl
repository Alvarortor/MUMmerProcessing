#!/usr/bin/perl -w
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO; 

#README
#Takes FASTA input sequence and trims according to mummer.mums coordinates
#Output is formatted so that Excel can read and filter data
#MAKE SURE FASTA FILES TO BE SNIPPED ARE THE SAME
#Ex: If MUMmer used ChrL, you use ChrL here too



#Program START
if ($#ARGV !=2) { #Checks to see if you have all required arguments
print "Usage: perl MUM2Seq.pl <Yourfile.mums> <ReferenceFile> <QueryFile>\n";
exit;
};
my $mumsfile = $ARGV[0];
my $Ref_File = $ARGV[1];
my $Que_File = $ARGV[2];


#How many lines are in mums file
open(MF, '<',$mumsfile) or die "Reference file cannot be opened";
my $countM = 0;
$countM++ while <MF>;
my $Cleancount = $countM-1;
close MF;


my $seqio_obj = Bio::SeqIO->new(-file => $Ref_File, #opening the Reference Fasta File
                             -format => "fasta" );
while (my $seq_obj = $seqio_obj->next_seq ){
	my $seq = $seq_obj->seq;	
#Get Coords
open(FH,'<', $mumsfile) or die $!;

#Stating it the first time
no warnings 'uninitialized';
no warnings 'numeric';
my @number = split(' ', <FH>);
my $S1 = $number[0]-1;
my $LEN = $number[2]+1;

#Produce the substring
my $substring = substr($seq, $S1, $LEN);
my $end = $S1 + $LEN ;


#Save the substring for reference sequences
my $filename = <"RefSeq.txt">;
open(my $fh,'>',$filename) or die "Could not open reference output file.";
my $collabels = "Start\tLEN\tEnd\tSequence\n";
print $fh $collabels;
#print $fh $S1+1,"\t",$LEN,"\t", $end+1,"\t", $substring,"\n";
close $fh;

my $line = 0;
no warnings 'uninitialized';
#loop until all done
$filename = <"RefSeq.txt">;
open($fh, '>>',$filename) or die "Could not update reference file.";
until( $line == $Cleancount)
{
@number = split(' ', <FH>);
my $S1 = $number[0]-1;
$LEN = $number[2];
$line++;
#Produce substring
my $substring = substr($seq, $S1, $LEN);
my $end = $S1 + $LEN;
#Write to file
print $fh $S1+1,"\t",$LEN,"\t", $end+1,"\t", $substring,"\n";
;
}
close $fh;
;
}

#Finishes process
close (FH);
print "Reference Sequences Done!\n";

#Repeats for the Query Sequences!
#opening the Reference Fasta File
$seqio_obj = Bio::SeqIO->new(-file => $Que_File, 
                             -format => "fasta" );
while (my $seq_objQ = $seqio_obj->next_seq ) {
	my $seqQ = $seq_objQ->seq;
	


#Get Coords
no warnings 'uninitialized';
open(FH,'<', $mumsfile) or die $!; #open file


#Stating it the first time
no warnings 'numeric';
my @number = split(' ', <FH>);
;#Find a way to remove first line here
my $S2 = $number[1]-1;
my $LEN = $number[2];

#Produce the substring
my $substringQ = substr($seqQ, $S2, $LEN);
my $endQ = $S2 + $LEN ;

#Save the substring
my $filename = <"QueSeq.txt">;
open(my $fh, '>',$filename) or die "Could not open query output file."; 
my $collabels = "Start\tLEN\tEND\tSequence\n";
print $fh $collabels;
#print $fh $S2+1,"\t",$LEN,"\t", $endQ+1,"\t", $substringQ,"\n";
close $fh;

my $line = 0;
no warnings 'uninitialized';
#loop until all done
$filename = <"QueSeq.txt">;
open($fh, '>>',$filename) or die "Could not update output file.";
until( $line == $Cleancount)
{
@number = split(' ', <FH>);
$S2 = $number[1]-1;
$LEN = $number[2];
$line++;

#Produce substring
no warnings 'uninitialized';
my $substringQ = substr($seqQ, $S2, $LEN);
my $end = $S2 + $LEN;
#Write to file
print $fh $S2+1,"\t",$LEN,"\t", $end+1,"\t", $substringQ,"\n";
;
}
close $fh;
;
}

print "Query Sequences Done!\n";
print "Make sure to perform the proofing program afterwards!\n";
exit 0;

