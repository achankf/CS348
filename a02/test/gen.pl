#!/usr/bin/perl

use strict; use warnings;

my $num_author = 20;
my $num_pub = 1000;

sub gen_author{
	for (my $i = 0; $i < $num_author; $i++){
		print "insert into author values ($i, 'Author_$i', 'www.author$i.com')\n";
	}
}

sub gen_pub{
	for (my $i = 0; $i < $num_pub; $i++){
		print "insert into publication values ('$i', 'Title_$i')\n";
	}
}

sub gen_wrote{
	my $mod = 0;
	for (my $i = 0; $i < $num_pub; $i++){
		my $num_co = int(rand($num_author / 2)) + 1;
		my $cur_co = $mod;
		for (my $j = 1; $j <= $num_co; $j++){
			print "insert into wrote values ($cur_co, '$i', $j)\n";
			$cur_co = ($cur_co + 2) % $num_author;
		}
		$mod = ($mod + 1) % $num_author;
	}
}

sub gen_subs{
	my $mod = 0;
	my $num_non_article = $num_pub / 4 * 3;
	my $num_article = $num_pub - $num_non_article;
	for (my $i = 0; $i < $num_non_article;){
		my $year = int(rand(10)) + 2000;
		print "insert into proceedings values ('$i', $year)\n";
		$i++;
		$year = int(rand(10)) + 2000;
		my $vol = int(rand(10));
		my $num = int(rand(10));
		print "insert into journal values ('$i', $vol, $num, $year)\n";
		$i++;
		$year = int(rand(10)) + 2000;
		print "insert into book values ('$i', 'Publisher_$i', $year)\n";
		$i++;
	}

	my $cur = $num_non_article;
	for (my $i = 0; $i < $num_article; $i++){
		my $appearin = int(rand($num_non_article));
		my $startpage = int(rand(1000));
		my $endpage = int(rand(1000)) + $startpage;
		print "insert into article values ('$cur','$appearin', $startpage, $endpage)\n";
		$cur++;
	}
}

print "connect to cs348\n";
gen_author;
gen_pub;
gen_wrote;
gen_subs;
print "delete wrote where pubid in (select pubid from proceedings)";
print "delete wrote where pubid in (select pubid from journal)";
print "commit work\n";
print "connect reset\n";
