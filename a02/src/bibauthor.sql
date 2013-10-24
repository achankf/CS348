connect to cs348

with  \
	getyears_by_author(pubid,year) as ( \
		select p.pubid, \
			case \
				when b.year is not null then b.year \
				when j.year is not null then j.year \
				when pro.year is not null then pro.year \
			end as year \
		from publication p \
		inner join wrote w on p.pubid = w.pubid \
		inner join author a on w.aid = a.aid \
		left join book b on p.pubid = b.pubid \
		left join journal j on p.pubid = j.pubid \
		left join proceedings pro on p.pubid = pro.pubid \
		where a.name = 'Author_18' \
) \
select p.pubid \
from publication p, wrote w, author a, getyears_by_author gba \
where p.pubid = w.pubid \
	and w.aid = a.aid \
	and p.pubid = gba.pubid \
	and w.aorder = 1 \
order by a.name, gba.year



connect reset
