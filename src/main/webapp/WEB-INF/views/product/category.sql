show databases;

CREATE TABLE category (
  category_id   BIGINT        NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 카테고리 고유 ID
  parent_id     BIGINT,                                            -- 상위 카테고리 ID (최상위 카테고리는 NULL)
  name          VARCHAR(50)   NOT NULL,                            -- 카테고리명 (예: 헤드폰, SONY)
  
  -- 상위 카테고리 ID와 카테고리명 조합의 중복을 방지하여 데이터 무결성 확보
  UNIQUE (parent_id, name),
  
  -- 자기 자신을 참조하는 외래 키 설정
  FOREIGN KEY (parent_id) REFERENCES category(category_id)
);
