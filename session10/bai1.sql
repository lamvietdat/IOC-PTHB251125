set SEARCH_PATH  to bai1;
create table products (
    id serial primary key,
    name varchar(50) ,
    price numeric(10,2),
    last_modified int
);
insert into products(name, price, last_modified) VALUES ('điênj thoại',2000000,2),
                                                        ('máy tình',300000,3),
                                                        ('laptop',3000000,1);
create function update_last_modified()
returns trigger
as $$
    begin
       new.last_modified= old.last_modified+1;

        return new;

    end;
    $$ language  plpgsql;

create trigger trg_update_last_modified
before update on products
    for EACH ROW
    execute function update_last_modified();
drop trigger trg_update_last_modified on products;
drop function update_last_modified();