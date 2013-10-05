#!/usr/bin/perl

sub gen_post{
	print "insert into student values (500,'Fred Smith', 4)\n";
	print "insert into enrollment (snum, cnum, term, section) values (500,'CS365','F2010',1)\n";
	print "insert into enrollment (snum, cnum, term, section) values (500,'CS265','F2011',1)\n";
	print "insert into enrollment (snum, cnum, term, section) values (500,'CS165','F2010',1)\n";
	print "insert into mark(snum, cnum, term, section, grade) values (500,'CS365','F2010',1,100)\n";
	print "insert into mark(snum, cnum, term, section, grade) values (500,'CS265','F2011',1,100)\n";
	print "insert into mark(snum, cnum, term, section, grade) values (500,'CS165','F2010',1,10)\n";

	print "insert into student values (501,'Fred Smith 2', 4)\n";
	print "insert into enrollment (snum, cnum, term, section) values (501,'CS365','F2010',1)\n";
	print "insert into enrollment (snum, cnum, term, section) values (501,'CS265','F2011',1)\n";
	print "insert into enrollment (snum, cnum, term, section) values (501,'CS165','F2010',1)\n";
	print "insert into mark(snum, cnum, term, section, grade) values (501,'CS365','F2010',1,100)\n";
	print "insert into mark(snum, cnum, term, section, grade) values (501,'CS265','F2011',1,100)\n";
	print "insert into mark(snum, cnum, term, section, grade) values (501,'CS165','F2010',1,90)\n";
}

print "connect to cs348\n";
gen_post
print "commit work\n";
print "connect reset\n";
