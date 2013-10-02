#!/usr/bin/perl

use strict; use warnings;

my $prof_id = 0;
my $num_students = 500;
my $student_per_class = 20;
my @days = ("Monday", "Tuesday", "Wednesday", "Thursday", "Friday");

sub gen_course{
	sub print_course_st{
		my $course_id = shift;
		print "insert into course (CNUM, CNAME) values ('$course_id','$course_id Name')\n";
	}
	for (my $i = 100; $i < 500; $i++){
		print_course_st "CS" . $i;
		print_course_st "CO" . $i;
		print_course_st "AA" . $i;
		print_course_st "BB" . $i;
	}
}

sub gen_professor{
	sub print_prof_st{
		my ($course_name, $course_prefix) = @_;
		print "insert into professor (PNUM, PNAME, OFFICE, DEPT) values ($prof_id,'$course_prefix Professor $prof_id','${course_prefix}" . (int(rand(10)) + 4000) . "','$course_name')\n";
		$prof_id++;
	}

	for (my $i = 0; $i < 10; $i++){
		print_prof_st("Computer Science", "CS");
	}
	for (my $i = 0; $i < 10; $i++){
		print_prof_st("Combinatorics and Optimization", "CO");
	}
}

sub gen_student{
	print "insert into student values (0, 'Jones, Fred', 4)\n";

	for (my $i = 1; $i < $num_students; $i++){
		my $year = int(rand(4)) + 1;
		print "insert into student values ($i, 'Student $i', $year)\n";
	}
}

sub gen_class{
	sub print_class_st{
			my ($course_prefix, $course_id, $year, $section) = @_;
			my $prof = int(rand($prof_id));
			print "insert into class (cnum, term, section, pnum) values ('${course_prefix}${course_id}','F$year',$section,$prof)\n";

			my $day = $days[int(rand(5))];
			my $time = sprintf "%02d", int(rand(7)) + 8;
			my $room = 'MC' . (int(rand(100)) + 4000);

			print "insert into schedule(cnum, term, section, day, time, room) values ('${course_prefix}${course_id}','F$year',$section,'$day','${time}:00','$room')\n";
	}

	sub print_enroll_st{
			my ($student_id, $course_prefix, $course_id, $year, $section) = @_;
			print "insert into enrollment (snum, cnum, term, section) values ($student_id,'${course_prefix}${course_id}','F$year',$section)\n";

			return if ($year == 2013);
			my $grade = int(rand(100));
			print "insert into mark(snum, cnum, term, section, grade) values ($student_id,'${course_prefix}${course_id}','F$year',$section,$grade)\n";
	}
	for (my $i = 100; $i < 500; $i++){
		for (my $j = 1; $j < int(rand(4)) + 2; $j++){
			my $year = int(rand(4)) + 2010;

			print_class_st ("CS",$i,$year,$j);

			for (my $k = 0; $k < $student_per_class; $k++){
				my $temp_student = int(rand($num_students));
				print_enroll_st ($temp_student,"CS",$i,$year,$j);
			}
		}
	}
}

print "connect to cs348\n";
gen_course;
gen_professor;
gen_student;
gen_class;
print "commit work\n";
print "connect reset\n";
