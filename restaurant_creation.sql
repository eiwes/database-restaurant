create table customer(
    customer_id int,
    customer_name VARCHAR(20),
    customer_surname VARCHAR(20),
    customer_gender VARCHAR(20),
    customer_card_number int
);
alter table customer add(
    constraint customer_pk primary key (customer_id)
);
create sequence customer_seq start with 1;
create trigger customer_bir
before insert on customer
for each row
begin
    SELECT customer_seq.NEXTVAL
    INTO   :new.customer_id
    FROM   dual;
end;
/
create table restaurant(
    restaurant_id int,
    restaurant_name VARCHAR(20),
    restaurant_address VARCHAR(20)
);
alter table restaurant add(
    constraint restaurant_pk primary key (restaurant_id)
);
create sequence restaurant_seq start with 1;
create trigger restaurant_bir
before insert on restaurant
for each row
begin
    SELECT restaurant_seq.NEXTVAL
    INTO   :new.restaurant_id
    FROM   dual;
end;
/
create table dish(
    dish_id int,
    dish_name VARCHAR(20),
    dish_calories int,
    dish_price int
);
alter table dish add(
    constraint dish_pk primary key (dish_id)
);
create sequence dish_seq start with 1;
create trigger dish_seq
before insert on dish
for each row
begin
    SELECT dish_seq.NEXTVAL
    INTO   :new.dish_id
    FROM   dual;
end;
/

create table placed_orders(
    placed_orders_id int,
    po_price int,
    po_discount int,
    po_final_price int,
    po_delivery_time TIMESTAMP,
    constraint placed_orders_pk primary key (placed_orders_id)
);
create sequence placed_orders_seq start with 1;

create trigger placed_orders_bir
before insert on placed_orders
for each row
begin
    select placed_orders_seq.nextval
    into :new.placed_orders_id
    from dual;
end;
alter table placed_orders add(
    po_customer_id int,
    po_restaurant_id int,
    foreign key (po_customer_id) references customer(customer_id)
);
alter table placed_orders add(
    po_dish_id int,
    foreign key (po_dish_id) references dish(dish_id)
);
alter table dish add(
    dish_restaurant_id int,
    foreign key (dish_restaurant_id) references restaurant(restaurant_id)
);

create table rare_dish(
    rare_dish_id int,
    rd_dish_id int,
    special_ingredient VARCHAR(20),
    foreign key (rd_dish_id) references dish(dish_id),
    constraint rare_dish_pk primary key (rare_dish_id)
);
create sequence rare_dish_seq start with 1;
create trigger rare_dish_bir
before insert on rare_dish
for each row
begin
    SELECT rare_dish_seq.NEXTVAL
    INTO   :new.rare_dish_id
    FROM   dual;
end;
/

create table cooking(
    cooking_id int,
    c_dish_id int,
    c_restaurant_id int,
    cooking_time TIMESTAMP,
    foreign key(c_dish_id) references dish(dish_id),
    foreign key(c_restaurant_id) references restaurant(restaurant_id),
    constraint cooking_pk primary key (cooking_id)
);
create sequence cooking_seq start with 1;
create trigger cooking_bir
before insert on cooking
for each row
begin
    select cooking_seq.nextval
    into :new.cooking_id
    from dual;
end;
/
create table customer_address(
    address_id int,
    a_customer_id int,
    a_street VARCHAR(20),
    a_flat INT,
    foreign key (a_customer_id) references customer(customer_id),
    constraint address_pk primary key (address_id)
);
create sequence address_seq start with 1;
create trigger address_bir
before insert on customer_address
for each row
begin
    select address_seq.nextval
    into :new.address_id
    from dual;
end;
/
create table employees(
    employees_id int,
    e_restaurant_id int,
    employees_name VARCHAR(20),
    employees_surname VARCHAR(20),
    employees_salary int,
    foreign key (e_restaurant_id) references restaurant(restaurant_id),
    constraint employees_pk primary key (employees_id)
);
create sequence employee_seq start with 1;
create trigger employee_bir
before insert on employees
for each row
begin
    select employee_seq.nextval
    into :new.employees_id
    from dual;
end;
/
create table cook(
    cook_employees_id int,
    cook_category int,
    cook_position varchar(20),
    foreign key (cook_employees_id) references employees(employees_id)
);
drop table courier;
create table courier(
    courier_employees_id int,
    courier_type varchar(20),
    foreign key (courier_employees_id) references employees(employees_id)
);