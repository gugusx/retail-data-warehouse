// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

table global.olist_customers_dataset {
    customer_id varchar(100) [primary key]
    customer_unique_id varchar(100)
    customer_zip_code_prefix varchar(10)
    customer_city varchar(100)
    customer_state varchar(10)
}

table global.olist_geolocation_dataset {
    geolocation_zip_code_prefix varchar(10)
    geolocation_lat varchar(100)
    geolocation_lng varchar(100)
    geolocation_city varchar(100)
    geolocation_state varchar(10)
}

table global.olist_order_items_dataset {
    order_id varchar(100) 
    order_item_id int [primary key]
    product_id varchar(100)
    seller_id varchar(100)
    shipping_limit_date timestamp
    price numeric(20,2)
    freight_value numeric(20,2)
}

table global.olist_order_payments_dataset {
    order_id varchar(100)
    payment_sequential int
    payment_type varchar(50)
    payment_installments int
    payment_value numeric(20,2)
}

table global.olist_order_reviews_dataset {
    review_id varchar(100)
    order_id varchar(100)
    review_score int
    review_comment_title varchar(100)
    review_comment_message text
    review_creation_date timestamp
    review_answer_timestamp timestamp
}

table global.olist_orders_dataset {
    order_id varchar(100) [primary key]
    customer_id varchar(100)
    order_status varchar(100)
    order_purchase_timestamp timestamp
    order_approved_at timestamp
    order_delivered_carrier_date timestamp
    order_delivered_customer_date timestamp
    order_estimated_delivery_date timestamp
}

table global.olist_products_dataset {
    product_id varchar(100) [primary key]
    product_category_name varchar(100)
    product_name_length int
    product_description_length int
    product_photos_qty int
    product_weight_g int
    product_length_cm int
    product_height_cm int
    product_width_cm int
}

table global.olist_sellers_dataset {
    seller_id varchar(100) [primary key]
    seller_zip_code_prefix varchar(10)
    seller_city varchar(100)
    seller_state varchar(10)
}

table global.product_category_name_translation {
    product_category_name varchar(100)
    product_category_name_english varchar(100)
}

// Define Relationships
Ref: global.olist_orders_dataset.customer_id > global.olist_customers_dataset.customer_id
Ref: global.olist_order_payments_dataset.order_id > global.olist_orders_dataset.order_id

Ref: global.olist_order_items_dataset.order_id > global.olist_orders_dataset.order_id
Ref: global.olist_order_items_dataset.product_id > global.olist_products_dataset.product_id
Ref: global.olist_order_items_dataset.seller_id > global.olist_sellers_dataset.seller_id

Ref: global.olist_customers_dataset.customer_zip_code_prefix > global.olist_geolocation_dataset.geolocation_zip_code_prefix

Ref: global.olist_order_reviews_dataset.order_id > global.olist_orders_dataset.order_id

Ref: global.olist_products_dataset.product_category_name > global.product_category_name_translation.product_category_name