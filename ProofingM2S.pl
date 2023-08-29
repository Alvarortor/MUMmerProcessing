#!/usr/bin/perl -w
use strict;
use warnings;

#Getting the arguments ready
#Program is designed to complement MUM2Seq by checking to see if
#S1 and S2 from .mums file match the Starts for the RefSeq.txt and
#QueSeq.txt outputs from MUM2Seq.pl program

if ($#ARGV !=0) { #Checks to see if you have all required arguments
print "Usage: perl ProofingMUM2Seq.pl <Yourfile.mums> <RefSeq.txt> <QueSeq.txt>\n";
exit;
};
my $filename2 = $ARGV[0];
my $filename1 = "RefSeq.txt";
my $filename3 = "QueSeq.txt";



#Preprocessing to get how many lines are in file
open(RF, '<',$filename1) or die "Reference file cannot be opened";
my $count = 0;
$count++ while <RF>;
my $Cleancount = $count-2;
close RF;


#Assign a filehandle to each
open(RF, '<',$filename1) or die "Reference file cannot be opened";
open(MF, '<',$filename2) or die "MUM file cannot be opened";


#Dummy data to remove 1st line
my $dummy = <RF>;
my $dummy2 = <MF>;


#Loop to check each line of reference and mum files
my $counter = 0;
until($counter == $Cleancount ){
	
my @number = split(' ', <RF>);
my @number2 = split(' ', <MF>);
my $S = $number[0];
my $S2 = $number2[0];
$counter++;
if ($S == $S2){
}
	else{
		print "ERROR: $S and $S2 are NOT the same\n" and die;
	}
;
}
print "No errors found between $filename1 and $filename2\n";

close RF;
close MF;

#Repeating above steps so that it loops for some reason?
open(MF, '<',$filename2) or die "MUM file cannot be opened";
open(QF, '<',$filename3) or die "Query file cannot be opened";
$dummy2 = <MF>;
my $dummy3 = <QF>;


#Repeating above process with query and mum file
my $countera = 0;
until($countera == $Cleancount ){
	
my @number = split(' ', <QF>);
my @number3 = split(' ', <MF>);
my $S = $number[0];
my $S3 = $number3[1];
$countera++;
if ($S == $S3){
}
	else{
		print "ERROR: $S and $S3 are NOT the same\n" and die;
	}
;
}

print "No errors found between $filename3 and $filename2\n";
close MF;
close QF;


exit;
