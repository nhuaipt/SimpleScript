#! /usr/bin/perl
use Digest::SHA1;
use File::Find;
print "Path name: ";
    $mypath = <>;
chomp($mypath);
#`chmod +x $mypath`;
my @id;
my @id_arr;
my @log;
my $logname;
my $oldhash;
my $write;
find sub{
    push @folders,"$File::Find::name" if(-d $File::Find::name);
},$mypath;
for my $i (@folders){
    print "$i \n";
    my @dirc = glob("$i/*.*");
foreach $path (@dirc) {
   #print "path: $path\n";
	my $filenames = (split'/', $path)[-1];
	#print "file: $filenames\n";
	my $file_id = `ls -i $path`;
	@id = split(' ', $file_id);
	#print "$id[0]\n";

	open (my $fh, '<', $path) or die "Can't open '$path': $!";
	binmode ($fh);
	my $epoch_timestamp = (stat($fh))[9];
	my $timestamp       = localtime($epoch_timestamp);
	$hash = Digest::SHA1->new->addfile($fh)->hexdigest;
	#print "$hash .' '. $timestamp\n";
	close $fh;
	my $isnew = 0;
	my $filename = shift || "/home/locnqt/Desktop/lab2/output.log";
	if (open(my $fh1, '<', $filename)) {
		while (my $row = <$fh1>) {
			chomp $row;
			@log = split(',', $row);
			#push(@log,split(',', $row));
			if($id[0] eq $log[3]){
				$logname = $log[0];
				$oldhash = $log[1];
				$isnew = 1;
				#print "Line $l: $row end\n";
				`perl -n -i -e "print unless /^$row/" $filename`;
				#push(@id_arr,$id[0]);
				#print "$logname  $oldhash  $isnew";
				last;
			}
		}
	}
	close $fh1;
	if($isnew!=0){
		if(($hash eq $oldhash) && ($filenames eq $logname)){
			print "File $filenames not changed\n";
		}
		elsif (($hash ne $oldhash) && ($filenames eq $logname)){
			print "File $filenames Content changed at '$log[2]'\n";
		}
		elsif (($hash eq $oldhash) &&($filenames ne $logname)){
			print "File $logname changed name to $filenames at '$log[2]'\n";
		}
		else {
			printf "File $logname changed name to $filenames and Content changed at '$log[2]'\n";
		}
	} else{
		print "Add new file $filenames to log\n";
	}
	$write = $write.$filenames. ',' .$hash. ',' .$timestamp. ',' .$id[0]. "\n";
}
}
my $file = shift || "/home/locnqt/Desktop/lab2/output.log";
if (open(my $fh3, '<', $file)) {
	while (my $row = <$fh3>) {
		chomp $row;
		#print "Line $l: $row end\n";
		if(!$row eq ''){
			@log1 = split(',', $row);
			print "File $log1[0] was deleted.\n";
		}
	}
}
close $fh1;
my $filelog = shift || "/home/locnqt/Desktop/lab2/output.log";
open(my $fh2, '>', $filelog) or die "Could not open file '$filelog' $!";
say $fh2 $write;
close $fh2;
