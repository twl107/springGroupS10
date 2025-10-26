
/* 대분류(main) */
create table categoryMain(
  categoryMainCode  char(1)  not null,		/* 대분류코드(A,B,C,...) => 영문 대문자 1자(중복불허) */
  categoryMainName  varchar(20) not null, /* 대분류명(회사명 => 삼성/현대/LG...(중복불허) */
  primary key(categoryMainCode),
  unique key(categoryMainName)
);

/* 중분류(middle) */
create table categoryMiddle(
	categoryMainCode  char(1)  not null,			/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2)  not null,		/* 중분류코드(01,02,03,...) => 문자형 숫자 2자(중복불허) */
  categoryMiddleName  varchar(20) not null, /* 중분류명(제품분류명 => 전자제품/생활가전/차종/의류/신발류...(중복불허) */
  primary key(categoryMiddleCode),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode)
);



/* 상품 테이블 */
create table dbProduct (
  idx  int not null, 				/* 상품 고유번호 */
	categoryMainCode  char(1)  not null,			/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2)  not null,		/* 중분류코드를 외래키로 지정 */
  productCode   varchar(20) not null,				/* 상품고유코드(대분류코드+중분류코드+소분류코드+상품고유번호) 예 : A 01 002 5 */
  productName   varchar(50) not null,				/* 상품명(상품모델명) */
  detail				varchar(100) not null,			/* 상품의 간단설명(초기화면 메인창에 출력할 간단한 설명) */
  mainPrice     int not null,								/* 상품의 기본가격 */
  fSName				varchar(200) not null,			/* 상품의 기본사진(1장이상 처리시는 '/'로 구분한다.) */
  content				text not null,							/* 상품의 상세설명 - ckeditor를 이용 */
  primary key(idx),
  unique key(productCode,productName),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode),
  foreign key(categoryMiddleCode) references categoryMiddle(categoryMiddleCode)
);

ALTER TABLE dbProduct
ADD COLUMN isRecommended BOOLEAN DEFAULT FALSE;




/* 상품 옵션 테이블 */
create table dbOption (
  idx    int not null auto_increment, /* 옵션 고유번호 */
  productIdx int not null,						/* product테이블(상품)의 고유번호 - 외래키로 지정 */
  optionName varchar(50) not null, 		/* 옵션 이름 */
  optionPrice int not null default 0, /* 옵션 가격 */
  primary key(idx),
  foreign key(productIdx) references dbProduct(idx)
);


/* 장바구니 테이블 */
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

/* 주문 테이블 : 한 번의 주문에 대한 마스터 정보 (주문자, 배송지, 총액, 상태 등) */
CREATE TABLE orders (
    idx BIGINT AUTO_INCREMENT PRIMARY KEY,            -- 주문 고유번호 (PK)
    orderId VARCHAR(50) NOT NULL UNIQUE,              -- 사용자에게 보여줄 주문번호 (예: 20251014-A3B5D7)
    memberIdx BIGINT NOT NULL,                        -- 주문한 회원 고유번호 (FK)
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    -- 주문 일시
    totalPrice INT NOT NULL,                          -- 최종 결제 금액

    -- 배송지 정보
    recipientName VARCHAR(50) NOT NULL,
    recipientTel VARCHAR(20) NOT NULL,
    recipientPostCode VARCHAR(10) NOT NULL,
    recipientAddress1 VARCHAR(100) NOT NULL,
    recipientAddress2 VARCHAR(100),
    
    -- 주문 상태
    orderStatus VARCHAR(20) NOT NULL DEFAULT '결제대기', -- (결제완료, 배송준비중, 배송중, 배송완료, 주문취소 등)
    
    -- 외래키 설정 (회원이 탈퇴해도 주문 기록은 남아야 하므로 ON DELETE CASCADE를 사용하지 않음)
    FOREIGN KEY (memberIdx) REFERENCES member(idx) ON DELETE RESTRICT
);

ALTER TABLE orders 
ADD COLUMN shippingMessage VARCHAR(255) NULL AFTER recipientAddress2;

ALTER TABLE orders 
ADD COLUMN imp_uid VARCHAR(255) NULL AFTER shippingMessage;




/* 주문 상세 테이블 : 특정 주문에 어떤 상품들이 포함되어 있는지에 대한 상세 정보 */
CREATE TABLE orderDetails (
    idx BIGINT AUTO_INCREMENT PRIMARY KEY,          -- 주문 상세 항목 고유번호 (PK)
    orderIdx BIGINT NOT NULL,                       -- 어떤 주문에 속해 있는지 (FK from orders)
    productIdx INT NOT NULL,                        -- 어떤 상품인지 (FK from dbProduct)
    optionIdx INT,                                  -- 어떤 옵션인지 (Nullable, FK from dbOption)
    quantity INT NOT NULL,                          -- 주문 수량
    price INT NOT NULL,                             -- '주문 당시'의 상품+옵션 1개당 가격 (매우 중요!)
    
    -- 개별 상품 상태 (부분 반품의 핵심!)
    itemStatus VARCHAR(20) NOT NULL DEFAULT '정상', -- (반품요청, 반품완료, 교환요청 등)

    -- 외래키 설정 (주문이 삭제되면 상세 항목도 함께 삭제)
    FOREIGN KEY (orderIdx) REFERENCES orders(idx) ON DELETE CASCADE,
    -- 상품이 삭제되어도 주문 내역에는 남아있어야 함
    FOREIGN KEY (productIdx) REFERENCES dbProduct(idx) ON DELETE RESTRICT,
    FOREIGN KEY (optionIdx) REFERENCES dbOption(idx) ON DELETE RESTRICT
);




