CREATE TABLE pds (
    idx INT NOT NULL AUTO_INCREMENT,
    
    -- member 테이블의 PK(idx)를 참조하도록 변경
    memberIdx BIGINT NOT NULL, 
    
    -- 닉네임은 member 테이블과 JOIN하여 가져오므로 중복 저장할 필요 없음
    
    fName VARCHAR(200) NOT NULL,        -- 실제 파일명
    fSName VARCHAR(200) NOT NULL,       -- 서버에 저장되는 파일명
    fSize BIGINT NOT NULL,              -- 파일 크기 (INT 범위를 넘을 수 있으므로 BIGINT 추천)
    part VARCHAR(20) NOT NULL,          -- 파일 분류 (예: '프로그래밍', '디자인')
    title VARCHAR(100) NOT NULL,
    content TEXT,
    openSw CHAR(3) DEFAULT '공개',      -- 공개여부
    hostIp VARCHAR(45) NOT NULL,        -- 접속 IP (IPv6 주소를 고려하여 넉넉하게)
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP, -- 생성일
    downNum INT DEFAULT 0,              -- 다운로드 횟수
    
    PRIMARY KEY (idx),
    
    -- 외래 키 제약조건 수정 (회원 탈퇴 시 게시물도 함께 삭제되도록 CASCADE 설정)
    FOREIGN KEY (memberIdx) REFERENCES member (idx) ON DELETE CASCADE
);
