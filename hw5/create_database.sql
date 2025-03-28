CREATE DATABASE customer_shopping;
USE customer_shopping;

CREATE TABLE cart
(
  purchaseID int unsigned NOT NULL,
  itemID     int unsigned NOT NULL
) COMMENT 'linking table for item and purchase';

CREATE TABLE customer
(
  customerID           int unsigned NOT NULL AUTO_INCREMENT,
  age                  int         NOT NULL,
  gender               varchar(50) NOT NULL,
  location             varchar(50) NOT NULL,
  preferred_payment    varchar(50) NULL     COMMENT 'derived',
  historical_purchases varchar(50) NULL     COMMENT 'derived',
  purchase_freq        varchar(50) NULL     COMMENT 'derived',
  PRIMARY KEY (customerID)
);

CREATE TABLE item
(
  itemID      int unsigned NOT NULL AUTO_INCREMENT,
  name        varchar(50) NOT NULL,
  category    varchar(50) NOT NULL,
  price       decimal     NOT NULL,
  tax_rate    decimal     NOT NULL,
  description text        NULL    ,
  size        varchar(50) NULL    ,
  color       varchar(50) NULL    ,
  avg_rating  decimal     NULL     COMMENT 'derived',
  PRIMARY KEY (itemID)
);

CREATE TABLE price_reduction
(
  price_reductionID int unsigned NOT NULL AUTO_INCREMENT,
  reduction_type    varchar(50) NOT NULL COMMENT 'flat amt or rate',
  promo_type        varchar(50) NULL     COMMENT 'discount or promotional code',
  reduction_amount  DECIMAL NOT NULL,
  code              VARCHAR(50) NULL    ,
  description       VARCHAR(50) NULL    ,
  PRIMARY KEY (price_reductionID)
) COMMENT 'new table to account for discounts and promos';

CREATE TABLE purchase
(
  purchaseID     int unsigned NOT NULL AUTO_INCREMENT,
  customerID     int unsigned NOT NULL,
  date           timestamp   NOT NULL,
  payment_method varchar(50) NOT NULL,
  shipping_type  varchar(50) NOT NULL,
  season         varchar(50) NULL     COMMENT 'derived',
  subtotal       decimal     NULL     COMMENT 'derived',
  total          decimal     NULL     COMMENT 'derived',
  PRIMARY KEY (purchaseID)
) COMMENT 'represents a checkout of 1-n items';

CREATE TABLE purchase_price_reduction
(
  purchaseID        int unsigned NOT NULL,
  price_reductionID INT unsigned NOT NULL
) COMMENT 'linking purchase to price reduction';

CREATE TABLE review
(
  reviewID    int unsigned NOT NULL AUTO_INCREMENT,
  customerID  int unsigned NOT NULL,
  itemID      int unsigned NOT NULL,
  rating      int  NULL     COMMENT '0-5',
  review_text text NULL    ,
  PRIMARY KEY (reviewID)
);

CREATE TABLE subscription
(
  subscriptionID int unsigned NOT NULL AUTO_INCREMENT,
  customerID     int unsigned NOT NULL,
  start_date     timestamp NOT NULL,
  end_date       timestamp NULL    ,
  PRIMARY KEY (subscriptionID)
);

ALTER TABLE review
  ADD CONSTRAINT FK_customer_TO_review
    FOREIGN KEY (customerID)
    REFERENCES customer (customerID);

ALTER TABLE review
  ADD CONSTRAINT FK_item_TO_review
    FOREIGN KEY (itemID)
    REFERENCES item (itemID);

ALTER TABLE purchase
  ADD CONSTRAINT FK_customer_TO_purchase
    FOREIGN KEY (customerID)
    REFERENCES customer (customerID);

ALTER TABLE cart
  ADD CONSTRAINT FK_purchase_TO_cart
    FOREIGN KEY (purchaseID)
    REFERENCES purchase (purchaseID);

ALTER TABLE subscription
  ADD CONSTRAINT FK_customer_TO_subscription
    FOREIGN KEY (customerID)
    REFERENCES customer (customerID);

ALTER TABLE cart
  ADD CONSTRAINT FK_item_TO_cart
    FOREIGN KEY (itemID)
    REFERENCES item (itemID);

ALTER TABLE purchase_price_reduction
  ADD CONSTRAINT FK_purchase_TO_purchase_price_reduction
    FOREIGN KEY (purchaseID)
    REFERENCES purchase (purchaseID);

ALTER TABLE purchase_price_reduction
  ADD CONSTRAINT FK_price_reduction_TO_purchase_price_reduction
    FOREIGN KEY (price_reductionID)
    REFERENCES price_reduction (price_reductionID);
