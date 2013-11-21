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
	primary key (cid, manufacturer, model_number), \
	foreign key (manufacturer, model_number) references product(manufacturer, model_number) \
)

drop table evaluation
create table evaluation( \
	manufacturer varchar(100) not null, \
	model_number integer not null, \
	cid integer not null references customer(cid), \
	score int not null, \
	check (score >= 1 and score <= 5), \
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
	cam_manufacturer varchar(100) not null, \
	cam_model_number integer not null, \
	sensor_size double not null, \
	pixel_number integer not null, \
	primary key (cam_manufacturer, cam_model_number), \
	foreign key (cam_manufacturer, cam_model_number) references product(manufacturer, model_number) \
)

drop table camera_normal_feature
create table camera_normal_feature( \
	cam_manufacturer varchar(100) not null, \
	cam_model_number integer not null, \
	feature_number integer not null, \
	check (feature_number = 2), -- ONLY #2 "FOR NOW" \
	primary key (cam_manufacturer, cam_model_number, feature_number), \
	foreign key (cam_manufacturer, cam_model_number) references camera(manufacturer, model_number) \
) 

drop table camera_distinct_feature
create table camera_distinct_feature( \
	cam_manufacturer varchar(100) not null, \
	cam_model_number integer not null, \
	feature_number integer not null, \
	check (feature_number >= 3 and feature_number <= 5), -- one of {3,4,5} \
	primary key (cam_manufacturer, cam_model_number), -- ONE SUCH FEATURE PER CAMERA \
	foreign key (cam_manufacturer, cam_model_number) references camera(manufacturer, model_number) \
) 

drop table lens_replaceable_camera
create table lens_replaceable_camera( \
	cam_manufacturer varchar(100) not null, \
	cam_model_number integer not null, \
	primary key (cam_manufacturer, cam_model_number), \
	foreign key (cam_manufacturer, cam_model_number) references camera(manufacturer, model_number) \
)

drop table lens_repl_cam_has_lens
create table lens_repl_cam_has_lens( \
	cam_manufacturer varchar(100) not null, \
	cam_model_number integer not null, \
	lens_manufacturer varchar(100) not null, \
	lens_model_number integer not null, \
	primary key (cam_manufacturer, cam_model_number, lens_manufacturer, lens_model_number), \
	foreign key (lens_manufacturer, lens_model_number) references lens(manufacturer, model_number) \
	foreign key (cam_manufacturer, cam_model_number) references lens_replaceable_camera(manufacturer, model_number) \
)

drop table lens_non_replaceable_camera
create table lens_non_replaceable_camera( \
	cam_manufacturer varchar(100) not null, \
	cam_model_number integer not null, \
	lens_manufacturer varchar(100) not null, -- ONLY HAVE ONE LENS \
	lens_model_number integer not null, \
	aperture_range double not null, \
	min_focal_range double not null, \
	max_focal_range double not null, \
	primary key (cam_manufacturer, cam_model_number), \
	foreign key (cam_manufacturer, cam_model_number) references camera(manufacturer, model_number), \
	foreign key (lens_manufacturer, lens_model_number) references lens(manufacturer, model_number) \
)
