-- Q1

select s.snum, s.sname \ 
from student s,enrollment e, mark m \
where s.snum = e.snum \
	and e.snum = m.snum and e.cnum = m.cnum and e.term = m.term and e.section = m.section \
	and e.cnum = 'CS348' \
	and m.grade >= 90 \
	and s.year = 4

-- Q2
select p.pnum, p.pname \
from professor p \
where p.dept = 'Computer Science' \
	and p.pnum not in ( \
		select pnum \
		from class \
		where cnum = 'CS348' or cnum = 'CS234' \
	)

-- Q3
