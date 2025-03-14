--- CREATE NEW DATABASE IF NOT EXIST
--create database brazilian_ecommerce;

--- CREATE SCHEMA FOR DBT
create schema global_raw;
create schema global_intermediate;
create schema global_mart;

--- CREATE SCHEMA FOR DATASET
create schema global;

--- CREATE TABLE FOR DATASET
--1. olist_customers_dataset
create table global.olist_customers_dataset
(
    customer_id varchar(100) not null primary key,
    customer_unique_id varchar(100),
    customer_zip_code_prefix varchar(10),
    customer_city varchar(100),
    customer_state varchar(10)
);

--2. olist_geolocation_dataset
create table global.olist_geolocation_dataset
(
    geolocation_zip_code_prefix varchar(10),
    geolocation_lat varchar(100),
    geolocation_lng varchar(100),
    geolocation_city varchar(100),
    geolocation_state varchar(10)
);

--3. olist_order_items_dataset
create table global.olist_order_items_dataset
(
    order_id varchar(100),
    order_item_id int,
    product_id varchar(100),
    seller_id varchar(100),
    shipping_limit_date timestamp,
    price numeric(20,2),
    freight_value numeric(20,2)
);

--4. olist_order_payments_dataset
create table global.olist_order_payments_dataset
(
    order_id varchar(100),
    payment_sequential int,
    payment_type varchar(50),
    payment_installments int,
    payment_value numeric(20,2)
);

--5. olist_order_reviews_dataset
create table global.olist_order_reviews_dataset
(
    review_id varchar(100),
    order_id varchar(100),
    review_score int,
    review_comment_title varchar(100),
    review_comment_message text,
    review_creation_date timestamp,
    review_answer_timestamp timestamp
);

--6. olist_orders_dataset
create table global.olist_orders_dataset
(
    order_id varchar(100) not null primary key,
    customer_id varchar(100),
    order_status varchar(100),
    order_purchase_timestamp timestamp,
    order_approved_at timestamp,
    order_delivered_carrier_date timestamp,
    order_delivered_customer_date timestamp,
    order_estimated_delivery_date timestamp
);

--7. olist_products_dataset
create table global.olist_products_dataset
(
    product_id varchar(100) not null primary key,
    product_category_name varchar(100),
    product_name_length int,
    product_description_length int,
    product_photos_qty int,
    product_weight_g int,
    product_length_cm int,
    product_height_cm int,
    product_width_cm int
);


--8. olist_sellers_dataset
create table global.olist_sellers_dataset
(
    seller_id varchar(100) not null primary key,
    seller_zip_code_prefix varchar(10),
    seller_city varchar(100),
    seller_state varchar(10)
);

--9. product_category_name_translation
create table global.product_category_name_translation
(
    product_category_name varchar(100) not null primary key,
    product_category_name_english varchar(100)
);

---INSERT FOR FOREIGN MAPPING
insert into global.product_category_name_translation values ('portateis_cozinha_e_preparadores_de_alimentos', 'portateis_cozinha_e_preparadores_de_alimentos'), ('pc_gamer', 'pc_gamer');

--- CREATE INDEX
create index idx_orders_status on global.olist_orders_dataset (order_status);
create index idx_orders_date on global.olist_orders_dataset (order_purchase_timestamp);
create index idx_orders_delivery_date on global.olist_orders_dataset (order_estimated_delivery_date);

--- SETUP FOREIGN KEY
alter table global.olist_orders_dataset add constraint FK_CustomerOrder foreign key (customer_id) references global.olist_customers_dataset (customer_id);

alter table global.olist_order_payments_dataset add constraint FK_OrderPayment foreign key (order_id) references global.olist_orders_dataset (order_id);

alter table global.olist_order_reviews_dataset add constraint FK_OrderReview foreign key (order_id) references global.olist_orders_dataset (order_id);

alter table global.olist_order_items_dataset add constraint FK_OrderItem foreign key (order_id) references global.olist_orders_dataset (order_id);

alter table global.olist_order_items_dataset add constraint FK_ProductOrderItem foreign key (product_id) references global.olist_products_dataset (product_id);

alter table global.olist_order_items_dataset add constraint FK_SellerOrderItem foreign key (seller_id) references global.olist_sellers_dataset (seller_id);

alter table global.olist_products_dataset add constraint FK_CategoryProduct foreign key (product_category_name) references global.product_category_name_translation (product_category_name);