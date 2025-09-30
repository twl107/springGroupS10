show databases;

create table product (
	product_id		bigint	not null auto_increment primary key,
	category_id 	bigint	not null,
	name					varchar(100) not null,
	price					int	not null,
	stock					int default 0,
	description		text,
	thumbnail			varchar(255),
	created_at		datetime	default now(),
	
	foreign key (category_id) references category(category_id)
);


