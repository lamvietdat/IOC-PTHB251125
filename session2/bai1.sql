create database  LibraryDB;
create schema if not exists library;
set search_path to library;
create table Books(
    book_id serial primary key,
    title varchar(100) not null ,
    author varchar(50) not null ,
    published_year int,
    price numeric
);