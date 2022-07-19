--selction of all items from the table
select * from customer;
select * from catagory;
select * from selects;
select * from car;
select * from buy;
select * from payment;
select * from car_added;


--find distinct car name(s) available in the showroom
--with distinct clause
select distinct(car_name) from car;


--find the average price of the cars available in th showroom
--with avg clause and as clause
select avg(price) as average_price_of_the_cars from car;


--find the cars with less or equal price than the average price
select car_id, car_name, model, price from car where car.price <= (select avg(price) from car);


--find the cars with higher price than the average
select car_id, car_name, model, price from car where car.price > (select avg(price) from car);


--find the cars with maximum value in the showroom
select * from car where price = (select max(price) from car);


--find the cars with minimum value in the showroom
select * from car where price = (select min(price) from car);


--find the cars with the value between 200000-400000
--range search
select car_id,cat_id,model,car_name, price from car 
where price between 2000000 and 4000000;


--find the customer who are from Mirpur
select cast_id, name, phone, address from customer
where address 
in (select address from customer where address like '%Mirpur%');


--find the customer who are from outside of Mirpur
select cast_id, name, phone, address from customer
where address 
not in (select address from customer where address like 'Mirpur%');


--show the cars in descending order according to year
select car_id,cat_id,car_name,model,year from car 
order by year DESC;


--show the cars in ascending order according to year
select car_id,cat_id,car_name,model,year from car 
order by year;


--show the number of cars according to fuel
select fuel, COUNT(*) as Quantity from car
group by fuel;


--show the average price of the car according to fuel if the quantity 
--is greater than 2
select fuel, avg(price) as Average_Price from car
group by fuel
having COUNT(*)>2;
-- Note: COUNT(*) returns the number of rows in a specified table


--show the cars with their catagory type name
select car_id,type,car_name,model,price,year,fuel,transmission,quantity
from catagory join car
on catagory.cat_id = car.cat_id;


--show the customer(s) name with phone number and  id who buy cars with cash
select c.cast_id, c.name, c.phone
from customer c
where c.cast_id in ( select cast_id from payment
                     where payment_type = 'Cash');


--show the total cost against a payment_id
select payment_id, sum((cost*quantity)) as Total_Cost
from car_added
group by(payment_id);

--select the cast_id(s) who live in Mirpur along with the cast_id who adds at 
--least two different types of car using 'UNION ALL' 
select cast_id 
from customer 
where address like '%Mirpur%'
UNION All
select cast_id
from payment
where payment_id in (select payment_id from car_added group by payment_id having COUNT(*)>=2);

--select the cast_id(s) who live in Mirpur along with the cast_id who adds at 
--least two different types of car using 'UNION' 
select cast_id 
from customer 
where address like '%Mirpur%'
UNION
select cast_id
from payment
where payment_id in (select payment_id from car_added group by payment_id having COUNT(*)>=2);

--select the cast_id(s) who live in Mirpur and 
--adds at least two different types of car
select cast_id 
from customer 
where address like '%Mirpur%'
INTERSECT
select cast_id
from payment
where payment_id in 
(select payment_id from car_added group by payment_id having COUNT(*)>=2);


--find the cast_id(s) who do not buy a car
select cast_id
from customer
MINUS
select cast_id
from buy;

--select the cast_id(s) who live in Mirpur and adds at least two different types 
--of car or do not buy a car
(select cast_id 
from customer 
where address like '%Mirpur%'
INTERSECT
select cast_id
from payment
where payment_id in 
(select payment_id from car_added group by payment_id having COUNT(*)>=2))
UNION
(select cast_id
from customer
MINUS
select cast_id
from buy);


--find which types of cars are selected
select c.type
from catagory c, selects s
where c.cat_id = s.cat_id
group by c.type;

--find the customer name, email, payment_type 
select name, email, payment_type
from customer inner join payment
on customer.cast_id = payment.cast_id;

--find the customer name, email, payment_type (another way)
select name, email, payment_type
from customer join payment
using (cast_id);

--find the customer cust_id, email, payment_type (select join column)
select cast_id, email, payment_type
from customer join payment
using (cast_id);

--find the customer name, phone number with payment id who make payment
select cast_id, name, phone, payment_id
from customer natural join payment;

--find the customer name with who buy at least a car with car model
select cast_id, name, model
from customer JOIN (select cast_id, model from buy inner join car using(car_id))
using(cast_id);

--find the cast_id from selection section who selects at 
--least two types of car
select distinct(s1.cast_id) 
from selects s1, selects s2
where s1.cast_id = s2.cast_id and s1.cat_id <> s2.cat_id;

--find the cast_id from selection section who selects at 
--least two types of car (another way: self join)
select distinct(s1.cast_id) 
from selects s1 join selects s2
on (s1.cast_id = s2.cast_id and s1.cat_id <> s2.cat_id);

--find name and phone all customers who have an amount or not (using left outer join)
select a.name, a.phone, b.amount 
from customer a left outer join payment b
on a.cast_id = b.cast_id;

--find name and phone all customers who have an amount or not (using right outer join)
select a.name, a.phone, b.amount 
from payment b right outer join customer a
on a.cast_id = b.cast_id;

--find name and phone all customers who have an amount or not (using full outer join)
select a.name, a.phone, b.amount 
from payment b full outer join customer a
on a.cast_id = b.cast_id;



--find the number of people who are registered with a cast_id
SET SERVEROUTPUT ON
DECLARE
    number_of__customer customer.cast_id%type;
BEGIN
    select COUNT(cast_id) INTO number_of__customer
    from customer;
    DBMS_OUTPUT.PUT_LINE('The number of customers registered is ' || number_of__customer);
    END;
/

--find all the customers who are registered with a cast_id using cursor
set serveroutput on

declare 
c_id customer.cast_id%type; 
c_name customer.name%type;
c_email customer.email%type;
c_phone customer.phone%type; 
c_address customer.address%type;
cursor car is 
select * from customer;

begin
open car;

dbms_output.put_line('All customer informations: ');
loop
fetch car into c_id, c_name, c_email, c_phone, c_address;

dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_email || ' ' || c_phone || ' ' || c_address);

exit when car%notfound;
end loop;

close car;

end;
/


--find the quantity of convertiblle cars available in the showroom 
--and show comments what action to be taken accordingly
SET SERVEROUTPUT ON
DECLARE
    CONVERTIBLE catagory.type%type := 'Convertible';
    Quantity number;
BEGIN
    select sum(quantity) INTO Quantity
    from catagory, car
    where catagory.cat_id = car.cat_id and type = CONVERTIBLE;

    IF Quantity>=0 and Quantity<=5 THEN
    DBMS_OUTPUT.PUT_LINE('The number of available Convertible cars is: ' || Quantity || ' which is not enough and needs to be imported');
    ELSIF Quantity>5 and Quantity<=15 THEN
    DBMS_OUTPUT.PUT_LINE('The number of available Convertible cars is: ' || Quantity || ' which is sufficient');
    ELSE
    DBMS_OUTPUT.PUT_LINE('The number of available Convertible cars is: ' || Quantity || ' which is more than enough in the showroom');
    END IF;
END;

--find which car model is available in the showroom in highest number 
--using procedure
create or replace procedure getHighestQuantityCarName
as
Name_of_the_car_model car.model%type;
BEGIN
select model into Name_of_the_car_model from car 
where quantity = (select max(quantity) from car);
DBMS_OUTPUT.PUT_LINE(Name_of_the_car_model);
end;
/

BEGIN
    getHighestQuantityCarName;
END;
/

--insert data into selects table using procedure
create or replace procedure insertIntoSelects
(customer_id customer.cast_id%type, catagory_id selects.cat_id%type)
IS
BEGIN
    insert into selects VALUES (customer_id,catagory_id);
    commit;
END insertIntoSelects;
/
--calling procedure for inserting data into selects
SET SERVEROUTPUT ON
BEGIN
    insertIntoSelects(4, 2);
END;
/ 
select * from selects;




--update data of customer table using procedure
create or replace procedure updateCustomerInfo 
(customer_id customer.cast_id%type, 
newName customer.name%type, newEmail customer.email%type, 
newPhone customer.phone%type, newAdd customer.address%type) 
IS
BEGIN
    UPDATE customer SET name = newName, email= newEmail, phone = newPhone, 
    address = newAdd where cast_id = customer_id;
    commit;
END updateCustomerInfo;
/
--calling procedure for updating data of customer table
select * from customer where cast_id = 6;

Set SERVEROUTPUT on
BEGIN
    updateCustomerInfo(4,'Karim','karim@gmail.com','01517006253','Banani');
END;
/
select * from customer where cast_id = 4;




--Delating from customer table using PROCEDURE
CREATE OR REPLACE PROCEDURE deleteCustomerInfo(customer_id NUMBER) IS
BEGIN
	DELETE FROM customer WHERE cast_id = customer_id;
	commit;
END deleteCustomerInfo;
/
--Calling the PROCEDURE for Delating from customer
select * from customer where cast_id = 4;
select * from customer;
SET SERVEROUTPUT ON
BEGIN
	deleteCustomerInfo(4);
END;
/
select * from customer where cast_id = 4;
select * from customer;




--find total types of car from  the catagory section using function
CREATE OR REPLACE FUNCTION totalCarTypes 
RETURN number IS 
   total number(3) := 0; 
BEGIN 
   SELECT count(*) into total 
   FROM catagory; 
    
   RETURN total; 
END; 
/ 
--calling function 
DECLARE 
   c number(3); 
BEGIN 
   c := totalCarTypes(); 
   dbms_output.put_line('Total no. of types of Cars: ' || c); 
END; 
/


--creating trigger for the price update of the car
CREATE OR REPLACE TRIGGER display_price_changes 
BEFORE DELETE OR INSERT OR UPDATE ON car 
FOR EACH ROW 
WHEN (NEW.car_id > 0) 
DECLARE 
   price_diff number; 
BEGIN 
   price_diff := :NEW.price  - :OLD.price; 
   dbms_output.put_line('Old price: ' || :OLD.price); 
   dbms_output.put_line('New price: ' || :NEW.price); 
   dbms_output.put_line('Price difference: ' || price_diff); 
END; 
/
--insert new data into car table
insert into car values (16, 4, 'Chevrolet', 'Chevrolet Cruze', 3500000, '2018',  'Diesel', 'Auto', 3);
--update data of car table and check the result 
update car 
set price = price + 100000
where car_id  = 16;



--creating trigger for the reason if we don't insert any value then 
--insert a default value
drop trigger null_remover;
CREATE TRIGGER null_remover
BEFORE
INSERT or UPDATE or DELETE
ON CUSTOMER
FOR EACH ROW
WHEN(NVL(old.cast_id, 0) <> NVL(new.cast_id, 0) and new.cast_id>0) 

BEGIN
:new.name := NVL(:new.name, 'NO name');
:new.email := NVL(:new.email, 'NO email');
:new.phone := NVL(:new.phone, 'NO phone');
:new.address := NVL(:new.address, 'NO address');

END null_remover;
/
show errors;
-- insert a data without giving all values of attributes 
insert into customer (cast_id, name) values (5, 'Mahim');
-- select all values from customer table where id = 5
select * from customer where cast_id = 5;


insert into customer values (6, 'Rifat', 'rifat@gmail.com', '01991554919', 'Uttara');
commit;
select count(*) from customer;
delete from customer where cast_id = 6;
select count(*) from customer;
Rollback;
select count(*) from customer;




--increase the price of the car which has car_id = 15 by 100000, 
--if any discrepancy happens, use transaction management to correct this
update car 
set price = price + 100000
where car_id  = 15;
SAVEPOINT sav_1;
-- See updated price
select price from car where car_id = 15;
-- Again Update the price
update car 
set price = price + 200000
where car_id  = 15;
-- See updated price
select price from car where car_id = 15;
Rollback to sav_1;
commit;
-- Finally See the price again
select price from car where car_id = 15;


--Find the system date
select sysdate from dual;


--Find the system date and time
select systimestamp from dual;


--find current date
select current_date from dual;


--Find the number of pending delivery 
select count(*)  from payment 
where delivary_date > (select current_date from dual);


--Add 6 month to current delivery date where payment id = 5
--current delivary date
select delivary_date from payment where payment_id = 5;
--new delivery date
select add_months (delivary_date, 6) as new_delivary_date
from payment where payment_id = 5;


--subtract 2 months of the current delivery date where id = 5
select add_months (delivary_date, -2) as new_delivary_date
from payment where payment_id = 5;


--To find the payment id and amount of the car to be
-- delivered first between id 1 and id 2
select payment_id, amount from payment where delivary_date = 
(SELECT LEAST ((select delivary_date from payment
where payment_id = 1),(select delivary_date from
payment where payment_id = 2))
FROM dual);


--To find the payment id and amount of the car to be 
-- delivered later between id 1 and id 2
select payment_id, amount from payment where delivary_date = 
(SELECT GREATEST ((select delivary_date from payment
where payment_id = 1),(select delivary_date from
payment where payment_id = 2))
FROM dual);


--To find the last day of the delivary month of car id 1 
select last_day(delivary_date) from payment
where payment_id = 1;


--To find all the deivary date
SELECT  
EXTRACT(Day FROM delivary_date) AS day, 
EXTRACT(Month FROM delivary_date) AS Month,
EXTRACT(Year FROM delivary_date) AS Year
FROM payment;


--Selects all the customers name and phone no
--who lives in mirpur using view
create view v_customers
as
select name, phone from customer where 
address like 'Mirpur%';

--select all customers using view
select * from v_customers;

--drop view
drop view v_customers;