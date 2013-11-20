
connect to cs348

drop table product
create table product( \
	manufacturer varchar(100) not null, \
	model_number integer not null, \
	release_date date not null, \
	retail_price double not null, \
	num_stock integer not null, \
	primary key (manufacturer, model_number) \
)

drop table customer 
create table customer( \
	cid integer not null primary key, \
	cname varchar(30) not null, \
	email varchar(60) not null, \
	address varchar(60) not null, \
	domestic_or_foreign char(8) not null \
	check (domestic_or_foreign = 'domestic' or domestic_or_foreign = 'foreign') \
)

drop table purchase_order
create table purchase_order( \
	manufacturer varchar(100) not null, \
	model_number integer not null, \
	cid integer not null references customer(cid), \
	sold_price double not null, \
	-- unique (manufacturer, model_number), \
	primary key (cid, manufacturer, model_number), \
	foreign key (manufacturer, model_number) references product(manufacturer, model_number) \
)

drop table lens
create table lens( \
	manufacturer varchar(100) not null, \
	model_number integer not null, \
	aperture_range double not null, \
	max_focal_length double not null, \
	min_focal_length double not null, \
	primary key (manufacturer, model_number), \
	foreign key (manufacturer, model_number) references product(manufacturer, model_number) \
)

drop table camera
create table camera( \
	manufacturer varchar(100) not null, \
	model_number integer not null, \
	sensor_size double not null, \
	pixel_number integer not null, \
	primary key (manufacturer, model_number), \
	foreign key (manufacturer, model_number) references product(manufacturer, model_number) \
)

create table lens_replaceable_camera( \
	manufacturer varchar(100) not null, \
	model_number integer not null, \
	

insert into customer values (0, 'Alfred', 'a77chan@uwaterloo.ca', 'abc street', 'domestic')
insert into customer values (1, 'Alfred', 'a77chan@uwaterloo.ca', 'dba street', 'dome')
