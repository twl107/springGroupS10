show databases;

show tables;

CREATE TABLE member (
    idx       BIGINT        NOT NULL AUTO_INCREMENT,
    userId      	  VARCHAR(30)   NOT NULL,
    password        VARCHAR(255)  NOT NULL,
    nickName        VARCHAR(20)   NOT NULL,
    name            VARCHAR(20)   NOT NULL,
    email           VARCHAR(60)   NOT NULL,
    tel             VARCHAR(15),

    postCode        VARCHAR(10),
    address1        VARCHAR(100),
    address2        VARCHAR(100),

    gender          CHAR(1),
    birthday        DATE,

    point           INT           DEFAULT 0,
    level           INT           DEFAULT 3,
		todayCnt				INT						DEFAULT 0,
    visitCnt				INT						DEFAULT 0,
    
    isDeleted      BOOLEAN       DEFAULT FALSE,
    deletedAt      DATETIME,
    createdAt      DATETIME      DEFAULT NOW(),
    lastLoginAt   DATETIME      DEFAULT NOW(),

    PRIMARY KEY (idx),
    UNIQUE (userid),
    UNIQUE (nickname)
);

ALTER TABLE member ADD COLUMN kakaoId BIGINT UNIQUE NULL;




desc member;

drop table member;


select * from member;

