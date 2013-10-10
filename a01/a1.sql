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
with \
	maxmark(cnum, term, section, grade) as ( \
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
with \
	min_cs_co_mark(snum, grade) as ( \
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
with \
	teaching(cnum, term, section) as ( \
		select cnum, term, section \
		from schedule sc \
		where (day = 'Monday' and time < '12:00') \
			or (day = 'Friday' and time > '12:00') \
	) \
select distinct p.pnum, p.pname, p.office, p.dept \
from professor p, class c, teaching t \
where p.pnum = c.pnum \
	and c.cnum = t.cnum and c.term = t.term and c.section = t.section \
order by p.dept, p.pname

-- Q6
with \
	minmark(snum, grade) as ( \
		select m.snum, min(m.grade) \
		from mark m, student s \
		where m.snum = s.snum \
			and s.year = 4 \
			and m.cnum like '%3__' \
		group by m.snum \
	), \
	numerator(num) as ( \
		select count(*) \
		from minmark \
		where grade >= 80 \
	), \
	denominator(num) as ( \
		select count(*) \
		from student \
		where year = 4 \
	) \
select 100.0 * n.num / d.num as percentage \
from numerator n, denominator d

-- Q7
with \
	statistics(cnum, num_enrolled) as ( \
		select e.cnum, count(*) as num_enrolled \
		from enrollment e \
		group by e.cnum \
	), \
	min3(num_enrolled) as ( \
		select distinct num_enrolled \
		from statistics \
		order by num_enrolled \
		limit 3 \
	) \
select s.cnum, s.num_enrolled \
from statistics s, min3 m \
where s.num_enrolled = m.num_enrolled

-- Q8
with  \
	current_class(cnum, term, section) as ( \
		select cnum, term, section \
		from class c \
		except \
		select cnum, term, section \
		from mark \
), \
	class_statistics(cnum, term, section, count) as ( \
		select e.cnum, e.term, e.section, count(*) \
		from enrollment e \
		inner join current_class c \
			on e.cnum = c.cnum and e.term = c.term and e.section = c.section \
		inner join student s \
			on e.snum = s.snum \
		where s.year = 1 or s.year = 2 \
		group by e.cnum, e.term, e.section \
) \
select p.pnum, p.pname, c.cnum, c.term, c.section, s.count \
from class c \
inner join class_statistics s \
	on c.cnum = s.cnum and c.term = s.term and c.section = s.section \
inner join professor p \
	on p.pnum = c.pnum \
where p.dept = 'CS' or p.dept = 'Computer Science' -- just in case \
order by p.pname, p.pnum, c.term, c.section

-- Q9
with \
	max_grades(cnum, term, section, grade) as ( \
		select cnum, term, section, max(grade) \
		from mark \
		group by cnum, term, section \
	) \
select c1.cnum, c1.term, c1.pnum, p1.pname, c1.section, mg1.grade, c2.pnum, p2.pname, c2.section, mg2.grade, p2.dept \
from class c1 \
inner join class c2 \
	on c1.cnum = c2.cnum  and c1.term = c2.term and c1.section <> c2.section \
inner join max_grades mg1 \
	on c1.cnum = mg1.cnum and c1.term = mg1.term and c1.section = mg1.section \
inner join max_grades mg2 \
	on c2.cnum = mg2.cnum and c2.term = mg2.term and c2.section = mg2.section \
inner join professor p1 \
	on c1.pnum = p1.pnum \
inner join professor p2 \
	on c2.pnum = p2.pnum \
where (p1.dept = 'Computer Science' or p1.dept = 'CS') \
	and (p2.dept <> 'Computer Science' and p2.dept <> 'CS') -- note the use of "and" - the subtleties in logic 

-- Q10
with \
	num_dept(num) as ( \
		select count(distinct dept) from professor \
	), \
	prof_per_dept(dept, num) as ( \
		select dept, count(*) \
		from professor \
		group by dept \
	), \
	shared_per_dept(dept, num) as ( \
		select p1.dept, count(distinct p1.pnum) \
		from professor p1, professor p2 \
		where p1.pnum <> p2.pnum and p1.office = p2.office \
		group by p1.dept \
	), \
	shared_majority(num) as ( \
		select count(*) \
		from prof_per_dept ppd, shared_per_dept spd \
		where ppd.dept = spd.dept \
			and spd.num > ppd.num / 2 \
	) \
select 100.0 * numerator.num / denominator.num as percentage \
from shared_majority numerator, num_dept denominator
