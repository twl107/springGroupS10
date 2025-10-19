create table notice(
	idx int not null auto_increment,
	
	memberIdx bigint not null,
	
	title varchar(100) not null,
	content text not null,
	viewCnt int default 0,
	wDate datetime default current_timestamp,
	
	primary key (idx),
	
	foreign key (memberIdx) references member (idx) on delete cascade
);