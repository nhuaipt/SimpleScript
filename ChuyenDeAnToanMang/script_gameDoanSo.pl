#!/usr/bin/perl

print "Tro Choi Doan So\n";
print "So nam trong khoang tu 0 den 999\n";

$m = 10;

for(;$m>=0;$m=$m-1/$m){
    print "Nhap so ban doan : \n";
    $so = <>;
    chop($so);
    if($so == $sodung){
        print "Ban da doan dung voi so diem $m";
        last ;
    }
    elsif ($so > $sodung)
    {
        print "So ban nhap lon hon so dung \n";
    }
    else {
        print "So ban nhap nho hon so dung \n";
    }
}


if($m == 0) {print "Ban da het luot doan" ;}
