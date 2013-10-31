connect to cs348

with  \
	getyears_by_author(pubid,year) as ( \
		select p.pubid, b.year \
		from publication p \
		inner join wrote w on p.pubid = w.pubid \
		inner join author a on w.aid = a.aid \
		inner join book b on p.pubid = b.pubid \
		where a.name = 'Author_2' \
), \
	getarticles_appearsin(pubid,year) as ( \
		select art.appearsin, \
			case \
				when b.year is not null then b.year \
				when j.year is not null then j.year \
				when pro.year is not null then pro.year \
			end as year \
		from article art \
			inner join wrote wr on art.pubid = wr.pubid \
			inner join author a on wr.aid = a.aid \
			left join book b on art.appearsin = b.pubid \
			left join journal j on art.appearsin = j.pubid \
			left join proceedings pro on art.appearsin = pro.pubid \
		where a.name = 'Author_2' \
), \
	getarticles(pubid,year) as ( \
		select art.pubid, \
			case \
				when b.year is not null then b.year \
				when j.year is not null then j.year \
				when pro.year is not null then pro.year \
			end as year \
		from article art \
			inner join wrote wr on art.pubid = wr.pubid \
			inner join author a on wr.aid = a.aid \
			left join book b on art.appearsin = b.pubid \
			left join journal j on art.appearsin = j.pubid \
			left join proceedings pro on art.appearsin = pro.pubid \
		where a.name = 'Author_2' \
) \
select gba.pubid, a.name, gba.year \
from getyears_by_author gba, wrote w, author a \
where gba.pubid = w.pubid \
	and w.aid = a.aid \
	and w.aorder = 1 \
	and gba.year is not null \
union \
select ga.pubid, a.name, ga.year \
from getarticles_appearsin ga \
left join wrote w on ga.pubid = w.pubid \
left join author a on w.aid = a.aid \
where w.aorder is null or w.aorder = 1 \
union \
select ga.pubid, a.name, ga.year \
from getarticles ga \
left join wrote w on ga.pubid = w.pubid \
left join author a on w.aid = a.aid \
where w.aorder is null or w.aorder = 1 \
order by name, year

select distinct p.title, \
	case \
		when b.year is not null then 'book' \
		when j.year is not null then 'journal' \
		when pro.year is not null then 'proceedings' \
	end as pub_type \
from publication p \
	left join book b on p.pubid = b.pubid \
	left join journal j on p.pubid = j.pubid \
	left join proceedings pro on p.pubid = pro.pubid \
where p.pubid = '556' \

select coalesce(a.name,'') as name \
from wrote w, author a \
where w.aid = a.aid \
	and w.pubid = '556' \
order by w.aorder

select pubid \
from article a \
where a.appearsin = '556'

select appearsin, count(pubid) \
from article \
group by appearsin

connect reset
