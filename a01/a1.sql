-- Q1

select s.snum, s.sname \ 
from student s,enrollment e, mark m \
where s.snum = e.snum \
	and e.snum = m.snum and e.cnum = m.cnum and e.term = m.term and e.section = m.section \
	and e.cnum = 'CS348' \
	and m.grade >= 90 \
	and s.year = 4

-- Q2
