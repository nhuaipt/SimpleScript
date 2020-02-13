#!/usr/bin/perl
use strict; 
use warnings; 
use File::Copy;

print "Nhap duong dan file : ";
my $file = <>;
chop ($file);
my $new = "copy/$file";
if (-e $file) {
    if(-e $new)
    {
		my @sizem = stat $file;
		my @sizec = stat $new;

		open(FILENEW, $file) or die "Can't read file 'filename' [$!]\n"; 
		open(FILEOLD, $new) or die "Can't read file 'filename' [$!]\n"; 
		my $d1 = <FILENEW>;
		my $d2 = <FILEOLD>;

		if ($d1 ne $d2) {
			my $time = localtime($sizem[9]);
			print "File da bi thay doi vao luc $time";
		}
		else {print "Khong thay doi";}
    }
    else{
    	copy($file,$new) or die "Copy failed: $!";
    	print "Day la lan dau yeu cau kiem tra file \n";
    }
} else {
    print "The file does not exist!\n";
}