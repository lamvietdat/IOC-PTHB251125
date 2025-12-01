create schema company ;
set SEARCH_PATH to company;
create table employees (
    emp_id serial primary key ,
    name varchar(50) not null,
    department_id integer
);
create table departments (
    derpartment_id serial primary key ,
    department_name varchar(50) not null

);
create table projects (
    project_id serial primary key ,
    project_name varchar(50),
    start_date date not null,
    end_date date check(end_date>start_date)
);
create table employeeProject (
    emp_id int ,
    project_id int
);
alter table employees add foreign key (department_id) references departments(derpartment_id);
alter table employeeProject add foreign key (emp_id) references employees(emp_id);
alter table employeeProject add foreign key (project_id) references projects(project_id);

