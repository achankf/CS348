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
		select distinct c.pnum \
		from class c, mark m \
		where c.cnum = m.cnum \
			and c.cnum = 'CS348' or c.cnum = 'CS234' \
	)

-- Q3
with maxmark(cnum, term, section, grade) as ( \
	select m.cnum, m.term, m.section, max(m.grade) \
	from mark m \
	group by m.cnum, m.term, m.section \
) \
select p.pnum, p.pname, m.cnum, m.term, m.section, m.grade \
from mark m, class c, student s, maxmark m2, professor p \
where m.snum = s.snum \
	and m.cnum = c.cnum and m.term = c.term and m.section = c.section \
	and m2.cnum = m.cnum and  m2.term = m.term and m2.section = m.section \
	and c.pnum = p.pnum \
	and m.grade >= m2.grade \
	and s.sname = 'Fred Smith' 

-- Q4
with min_cs_co_mark(snum, grade) as ( \
	select m.snum, min(m.grade) \
	from mark m \
	where (m.cnum like 'CS%' or m.cnum like 'CO%') \
	group by m.snum \
) \
select s.snum, s.sname, s.year \
from student s, min_cs_co_mark m \
where s.snum = m.snum \
	and s.year = 4 \
	and m.grade >= 90

-- Q5
with teaching(cnum, term, section) as ( \
	select cnum, term, section \
	from schedule sc \
	where (day = 'Monday' and time < '12:00') \
		or (day = 'Friday' and time > '12:00') \
) \
select distinct p.pnum, p.pname, p.office, p.dept \
from professor p, class c, teaching t \
where p.pnum = c.pnum \
	and c.cnum = t.cnum and c.term = t.term and c.section = t.section
