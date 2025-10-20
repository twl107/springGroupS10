show tables;

create table inquiry(
	idx int not null auto_increment,
	userId varchar(20) not null,
	title varchar(100) not null,
	part varchar(20) not null,
	wDate datetime not null default now(),
	orderId varchar(50),
	content text not null,
	fName varchar(100),
	fSName varchar(200),
	reply varchar(10) default '답변대기중',
	primary key (idx),
	foreign key (userId) references member(userId) on update cascade on delete no action
);

desc inquiry;

create table inquiryReply(
	reIdx int not null auto_increment,
	inquiryIdx int not null,
	reWDate datetime not null default now(),
	reContent text not null,
	primary key (reIdx),
	foreign key (inquiryIdx) references inquiry(idx)
);
