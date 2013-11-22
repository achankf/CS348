connect to cs348
drop table product
create table product( \
	model_number integer not null primary key, \
	manufacturer varchar(100) not null, \
	release_date date not null, \
	retail_price double not null, \
	num_stock integer not null \
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
	model_number integer not null references product, \
	cid integer not null references customer(cid), \
	sold_price double not null, \
	score int not null, \
	check (score >= 1 and score <= 5) \
)

drop table lens
create table lens( \
	lens_model_number integer not null primary key references product, \
	aperture_range double not null, \
	max_focal_length double not null, \
	min_focal_length double not null \
)

drop table camera
create table camera( \
	model_number integer not null primary key references product, \
	sensor_size double not null, \
	pixel_number integer not null \
)

drop table camera_normal_feature
create table camera_normal_feature( \
	model_number integer not null primary key references camera, \
	feature_number integer not null, \
	check (feature_number = 2) -- ONLY #2 "FOR NOW" \
) 

drop table camera_distinct_feature
create table camera_distinct_feature( \
	model_number integer not null primary key references camera, \
	feature_number integer not null, \
	check (feature_number >= 3 and feature_number <= 5) -- one of {3,4,5} \
) 

drop table lens_replaceable_camera
create table lens_replaceable_camera( \
	model_number integer not null primary key references camera \
)

drop table lens_repl_cam_has_lens
create table lens_repl_cam_has_lens( \
	cam_model_number integer not null references camera, \
	lens_model_number integer not null references lens, \
	primary key (cam_model_number, lens_model_number) \
)

drop table lens_non_replaceable_camera
create table lens_non_replaceable_camera( \
	cam_model_number integer not null primary key references camera, \
	lens_model_number integer not null references lens, \
	aperture_range double not null, \
	min_focal_range double not null, \
	max_focal_range double not null \
)
