show databases;

show tables;

CREATE TABLE member (
    -- 기본 정보
    idx       BIGINT        NOT NULL AUTO_INCREMENT,  -- PK는 int보다 BIGINT가 안전합니다.
    userId      	  VARCHAR(30)   NOT NULL,                 -- 로그인 아이디
    password        VARCHAR(255)  NOT NULL,                 -- 암호화된 비밀번호 (넉넉한 길이)
    nickName        VARCHAR(20)   NOT NULL,
    name            VARCHAR(20)   NOT NULL,
    email           VARCHAR(60)   NOT NULL,
    tel             VARCHAR(15),

    -- 주소 정보 (세분화)
    postCode        VARCHAR(10),                            -- 우편번호
    address1        VARCHAR(100),                           -- 기본 주소
    address2        VARCHAR(100),                           -- 상세 주소

    -- 개인 정보
    gender          CHAR(1),                                -- 'M': 남자, 'F': 여자
    birthday        DATE,                                   -- 생년월일 (시간 정보 제외)

    -- 쇼핑몰 관련 정보
    point           INT           DEFAULT 0,
    level           INT           DEFAULT 3,                -- 회원 등급 (0: 관리자 1: 우수회원, 2: 정회원 3: 준회원)
		todayCnt				INT						DEFAULT 0,
    visitCnt				INT						DEFAULT 0,
    
    -- 상태 및 일시 정보
    isDeleted      BOOLEAN       DEFAULT FALSE,            -- 탈퇴 여부 (true/false)
    deletedAt      DATETIME,                               -- 탈퇴 처리 일시
    createdAt      DATETIME      DEFAULT NOW(),            -- 가입일
    lastLoginAt   DATETIME      DEFAULT NOW(),            -- 마지막 로그인

    PRIMARY KEY (idx),
    UNIQUE (userid),
    UNIQUE (nickname)
);

ALTER TABLE member ADD COLUMN kakaoId BIGINT UNIQUE NULL;




desc member;

drop table member;


select * from member;

