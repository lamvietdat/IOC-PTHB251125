create schema if not exists sales;
set search_path to sales;

create table Customers(
    customer_id serial primary key ,
    first_name varchar(50) not null ,
    last_name varchar(50) not null ,
    email text not null unique ,
    phone int
);

create  table Products(
    product_id serial primary key ,
    product_name varchar(100) not null ,
    price numeric not null ,
    stock_quantity int not null
);

create table Orders(
    order_id serial primary key ,
    customer_id int references Customers(customer_id),
    order_date date not null
);

create table OrderItems(
    order_item_id serial primary key ,
    order_id int references Orders(order_id),
    product_id int references Products(product_id),
    quantity int check ( quantity > 1 )
);