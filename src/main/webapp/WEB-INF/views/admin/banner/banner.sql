create table banner (
	idx int auto_increment primary key,
	fSName varchar(200) not null,
	linkUrl varchar(200),
	displayOrder int default 0,
	isActive boolean default true,
	createdAt timestamp default current_timestamp
);