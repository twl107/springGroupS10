
create table categoryMain(
  categoryMainCode  char(1)  not null,
  categoryMainName  varchar(20) not null,
  primary key(categoryMainCode),
  unique key(categoryMainName)
);

create table categoryMiddle(
	categoryMainCode  char(1)  not null,
  categoryMiddleCode  char(2)  not null,
  categoryMiddleName  varchar(20) not null,
  primary key(categoryMiddleCode),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode)
);



create table dbProduct (
  idx  int not null,
	categoryMainCode  char(1)  not null,
  categoryMiddleCode  char(2)  not null,
  productCode   varchar(20) not null,
  productName   varchar(50) not null,
  detail				varchar(100) not null,
  mainPrice     int not null,
  fSName				varchar(200) not null,
  content				text not null,
  primary key(idx),
  unique key(productCode,productName),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode),
  foreign key(categoryMiddleCode) references categoryMiddle(categoryMiddleCode)
);

ALTER TABLE dbProduct
ADD COLUMN isRecommended BOOLEAN DEFAULT FALSE;




create table dbOption (
  idx    int not null auto_increment,
  productIdx int not null,
  optionName varchar(50) not null,
  optionPrice int not null default 0,
  primary key(idx),
  foreign key(productIdx) references dbProduct(idx)
);


CREATE TABLE cart (
    idx         INT          NOT NULL AUTO_INCREMENT,
    memberIdx   BIGINT       NOT NULL,
    productIdx  INT          NOT NULL,
    optionIdx   INT,
    quantity    INT          NOT NULL DEFAULT 1,
    addDate     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (idx),
    
    FOREIGN KEY (memberIdx)  REFERENCES member(idx)     ON DELETE CASCADE,
    FOREIGN KEY (productIdx) REFERENCES dbProduct(idx)  ON DELETE CASCADE,
    FOREIGN KEY (optionIdx)  REFERENCES dbOption(idx)   ON DELETE CASCADE,
    
    UNIQUE (memberIdx, productIdx, optionIdx)
);

CREATE TABLE orders (
    idx BIGINT AUTO_INCREMENT PRIMARY KEY,
    orderId VARCHAR(50) NOT NULL UNIQUE,
    memberIdx BIGINT NOT NULL,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalPrice INT NOT NULL,

    recipientName VARCHAR(50) NOT NULL,
    recipientTel VARCHAR(20) NOT NULL,
    recipientPostCode VARCHAR(10) NOT NULL,
    recipientAddress1 VARCHAR(100) NOT NULL,
    recipientAddress2 VARCHAR(100),
    
    orderStatus VARCHAR(20) NOT NULL DEFAULT '결제대기',
    
    FOREIGN KEY (memberIdx) REFERENCES member(idx) ON DELETE RESTRICT
);

ALTER TABLE orders 
ADD COLUMN shippingMessage VARCHAR(255) NULL AFTER recipientAddress2;

ALTER TABLE orders 
ADD COLUMN imp_uid VARCHAR(255) NULL AFTER shippingMessage;




CREATE TABLE orderDetails (
    idx BIGINT AUTO_INCREMENT PRIMARY KEY,
    orderIdx BIGINT NOT NULL,
    productIdx INT NOT NULL,
    optionIdx INT,
    quantity INT NOT NULL,
    price INT NOT NULL,
    
    itemStatus VARCHAR(20) NOT NULL DEFAULT '정상',

    FOREIGN KEY (orderIdx) REFERENCES orders(idx) ON DELETE CASCADE,
    FOREIGN KEY (productIdx) REFERENCES dbProduct(idx) ON DELETE RESTRICT,
    FOREIGN KEY (optionIdx) REFERENCES dbOption(idx) ON DELETE RESTRICT
);




