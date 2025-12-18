CREATE TABLE pds (
    idx INT NOT NULL AUTO_INCREMENT,
    
    memberIdx BIGINT NOT NULL, 
    
    fName VARCHAR(200) NOT NULL,
    fSName VARCHAR(200) NOT NULL,
    fSize BIGINT NOT NULL,
    part VARCHAR(20) NOT NULL,
    title VARCHAR(100) NOT NULL,
    content TEXT,
    openSw CHAR(3) DEFAULT '공개',
    hostIp VARCHAR(45) NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    downNum INT DEFAULT 0,
    
    PRIMARY KEY (idx),
    
    FOREIGN KEY (memberIdx) REFERENCES member (idx) ON DELETE CASCADE
);
