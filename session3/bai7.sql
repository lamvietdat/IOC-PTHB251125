create schema sales;
set search_path to sales;
create table products (
    product_id serial primary key,
    product_name varchar(50),
    price numeric(10,2),
    stock_quantity integer
);
create table orders(
    order_id serial primary key,
    order_date date default current_date,
    member_id integer

);
create table membres (
    member_id serial primary key ,
    ten varchar(50)

);
create table  orderdetails (
    order_detail_id serial primary key ,
    order_id integer ,
    product_id integer ,
    quantity integer
);
alter table  orders add foreign key (member_id) references membres(member_id);
alter table orderdetails add foreign key (order_id) references orders(order_id);
alter TABLE orderdetails add foreign key (product_id) references products(product_id);