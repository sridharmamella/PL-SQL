DROP TABLE BOOKING_HIST;


CREATE TABLE BOOKING_HIST
  (
    BOOKING_ID               NUMBER NOT NULL ,
    BOOKING_STATUS_CODE      VARCHAR(10) NOT NULL ,
    CUSTOMER_ID              NUMBER NOT NULL ,
    REG_NUMBER               VARCHAR2(10) NOT NULL ,
    DATE_FROM                DATE NOT NULL ,
    DATE_TO                  DATE ,
    CONFIRM_LETTER_SENT_FLAG CHAR(1) ,
    PAYMENT_RECEIVED_FLAG    CHAR(1),
    BOOKING_DATE             DATE,
    DATE_UPDATED             DATE ,
    CONSTRAINT BOOKING_HIST_PK PRIMARY KEY ( BOOKING_ID ) ENABLE
  );




---adding Unique constraint on the column as email will be unique for every customer and email address will be used in the search

ALTER TABLE customer
ADD CONSTRAINT email_should_be_unique  UNIQUE
(
  email_address 
);