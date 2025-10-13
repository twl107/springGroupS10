CREATE TABLE cart (
    idx         INT          NOT NULL AUTO_INCREMENT, -- 장바구니 항목 고유번호 (PK)
    memberIdx   BIGINT       NOT NULL,                -- 회원 고유번호 (FK from member.idx)
    productIdx  INT          NOT NULL,                -- 상품 고유번호 (FK from dbProduct.idx)
    optionIdx   INT,                                  -- 옵션 고유번호 (FK from dbOption.idx), NULL 허용
    quantity    INT          NOT NULL DEFAULT 1,      -- 상품 수량
    addDate     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP, -- 추가된 날짜
    
    PRIMARY KEY (idx),
    
    -- 외래 키(Foreign Key) 제약 조건 설정
    FOREIGN KEY (memberIdx)  REFERENCES member(idx)     ON DELETE CASCADE,
    FOREIGN KEY (productIdx) REFERENCES dbProduct(idx)  ON DELETE CASCADE,
    FOREIGN KEY (optionIdx)  REFERENCES dbOption(idx)   ON DELETE CASCADE,
    
    -- 한 명의 유저가 동일한 상품의 '동일한 옵션'을 여러 번 담는 것을 방지
    UNIQUE (memberIdx, productIdx, optionIdx)
);
