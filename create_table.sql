-- Database Project on Online Car Showroom Management System
-- Delete the following table if they exist in the 
--database previously


drop table selects; 
drop table buy; 
drop table car_added; 
drop table payment; 
drop table customer; 
drop table car; 
drop table catagory;


-- #create "customer" table# 
create table customer(
    cast_id number(7) not null,
    name varchar(40),
    email varchar(40),
    phone varchar(20),
    address varchar(300)
);

--adding Constrain into table "customer"
alter table customer add CONSTRAINT customer_pk primary key(cast_id);



-- #create "catagory" table#
create table catagory(
    cat_id number(2) not null,
    type varchar(20)
);

--adding Constrain into table "catagory"
alter table catagory add CONSTRAINT catagory_pk primary key(cat_id);



-- #create "selects" table#
create table selects(
    cast_id number(5) not null,
    cat_id number(2) not null
);

--alter the data-type of an attribute
alter table selects modify cast_id number(7);

--adding Constrains into table "customer"
alter table selects add CONSTRAINT selects_pk 
primary key(cast_id, cat_id);

alter table selects add CONSTRAINT selects_fk1 
foreign key(cast_id) references customer(cast_id) ON DELETE CASCADE;

alter table selects add CONSTRAINT selects_fk2 
foreign key(cat_id) references catagory(cat_id) ON DELETE CASCADE;


-- #create "car" table# 
create table car(
    car_id number(4) not null,
    cat_id number(2) not null,
    car_name varchar(20),
    model varchar(20),
    price number(10),
    year varchar(4),
    fuel varchar(10),
    -- quantity number(3), add this attribute later
    transmission varchar(10),
    primary key(car_id),
    foreign key(cat_id) references catagory (cat_id) ON DELETE CASCADE
);

--adding an attribute
alter table car add quantity number(3);



-- #create "buy" table# 
create table buy(
    cas_id number(7) not null, --this will be renamed as 'cast_id'
    car_id number(4) not null,
    primary key(cas_id, car_id),
    foreign key(cas_id) references customer(cast_id) ON DELETE CASCADE,
    foreign key(car_id) references car(car_id) ON DELETE CASCADE
);

--rename an attribute
alter table buy rename column cas_id to cast_id;



-- #create "payment" table# 
create table payment(
    payment_id number(7) not null,
    cast_id number(7) not null,
    payment_type varchar(20)
);

--adding some attributes
alter table payment add (
    amount number(5),
    advance number(5),
    delivary_date varchar(20)
);

--modify some attributes
alter table payment modify (
    amount number(20),
    advance number(20),
    delivary_date date
);

--adding Constrains into table "payment"
alter table payment add CONSTRAINT payment_pk primary key(payment_id);
alter table payment add CONSTRAINT payment_fk foreign key(cast_id) references
customer(cast_id) ON DELETE CASCADE;



-- #create "car_added" table# 
create table car_added(
    payment_id number(7) not null,
    car_id number(7) not null,
    quantity number(5),
    cost number(10),
    exta_attribute varchar(20),
    primary key(payment_id, car_id),
    foreign key(payment_id) references payment ON DELETE CASCADE,
    foreign key (car_id) references car ON DELETE CASCADE
);

--remove 'extra_attribute' from the table
alter table car_added drop column exta_attribute;

