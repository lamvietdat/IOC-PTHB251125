create schema library;
set search_path to library;
create table books (
    book_id serial primary key,
    title varchar(50),
    author varchar(50),
    published_year integer ,
    available BOOLEAN DEFAULT TRUE

);
create table members (
    member_id serial primary key ,
    name varchar(50),
    email varchar(50) unique ,
    join_date date default  CURRENT_DATE

);