#!/usr/bin/perl
$cmd = "netstat";
$value = `$cmd`;
#my $value = exec $cmd unless fork;
my $filename = 'REPORT.txt';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh $value;
close $fh;
print "done\n";
#`start $cmd`;


