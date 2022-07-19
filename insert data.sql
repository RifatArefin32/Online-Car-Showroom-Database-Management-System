--Customer Table
insert into customer values (1, 'Mr A', 'mra@gmail.com', '01881445911', 'Mirpur-1, Dhaka-1216');
insert into customer values (2, 'Mr B', 'mrb@gmail.com', '01881445912', 'Mirpur-2, Dhaka-1216');
insert into customer values (3, 'Mr C', 'mrc@gmail.com', '01881445913', 'Mirpur-6, Dhaka-1216');
insert into customer values (4, 'Mr D', 'mrd@gmail.com', '01881445914', 'Dhanmondi-27, Dhaka-1209');


--Catagory Table
insert into catagory values(1,'Hatchback');
insert into catagory values(2,'Sedan');
insert into catagory values(3,'SUV');
insert into catagory values(4,'MUV');
insert into catagory values(5,'Crossover');
insert into catagory values(6,'Coupe');
insert into catagory values(7,'Convertible');


--Selects Table
insert into selects values (1, 1);
insert into selects values (1, 4);
insert into selects values (1, 5);
insert into selects values (2, 4);
insert into selects values (3, 7);
insert into selects values (3, 5);
insert into selects values (4, 6);


--Car Table
insert into car values (1, 1, 'Tata', 'Tata Indica', 1000000, '2021',  'CNG', 'Auto', 3);
insert into car values (2, 1, 'Hyundai', 'Hyundai i10', 1500000, '2015',  'Diesel', 'Auto', 5);
insert into car values (3, 2, 'Ford', 'Ford Fiesta', 1500000, '2012',  'Petrol', 'Auto', 2);
insert into car values (4, 2, 'Honda', 'Honda Amaze', 2000000, '2016',  'Octane', 'Auto', 8);
insert into car values (5, 3, 'Toyota', 'Toyota Fortuner', 2100000, '2009',  'Petrol', 'Auto', 3);
insert into car values (6, 3, 'Ford', 'Ford Endeavour', 2500000, '2018',  'Petrol', 'Auto', 4);
insert into car values (7, 4, 'Toyota', 'Toyota Innova', 3000000, '2011',  'Petrol', 'Auto', 2);
insert into car values (8, 4, 'Chevrolet', 'Chevrolet Tavera', 3000000, '2016',  'Diesel', 'Auto', 1);
insert into car values (9, 5, 'Chevrolet', 'Chevrolet Adra', 3400000, '2018',  'Diesel', 'Auto', 6);
insert into car values (10, 5, 'Toyota', 'Toyota Etios', 2600000, '2018',  'Petrol', 'Auto', 6);
insert into car values (11, 6, 'Rolls Royce', 'Rolls Royce Phantom ', 4000000, '2018',  'Octane', 'Auto', 3);
insert into car values (12, 6, 'Audi', 'Audi R8,', 3700000, '2015',  'Petrol', 'Auto', 4);
insert into car values (13, 7, 'Porche', 'Porsche Boxste', 4300000, '2014',  'Petrol', 'Auto', 3);
insert into car values (14, 7, 'BMW', 'BMW Z4', 5000000, '2016',  'Petrol', 'Auto', 2);
insert into car values (15, 7, 'Rolls Royce', 'Rolls Royce Dawn', 4500000, '2018',  'Gasoline', 'Auto', 3);


--Buy Table
insert into buy values (1, 10);
insert into buy values (1, 5);
insert into buy values (2, 3);
insert into buy values (2, 2);
insert into buy values (3, 15);
insert into buy values (3, 14);
insert into buy values (4, 6);
insert into buy values (4, 8);
insert into buy values (4, 4);


--Payment Table
insert into payment values (1, 1, 'Cash', 2000000, 200000, '01-April-22' );
insert into payment values (2, 1, 'Bank', 5000000, 500000, '01-May-22' );
insert into payment values (3, 4, 'Bank', 4000000, 400000, '03-April-22' );
insert into payment values (4, 3, 'Cash', 6000000, 600000, '08-April-22' );
insert into payment values (5, 3, 'Cash', 1000000, 100000, '10-April-22' );
insert into payment values (6, 3, 'Cash', 1000000, 100000, '10-August-22' );


--Car-Added Table
insert into car_added values (1, 1, 2, 2000000);
insert into car_added values (2, 14, 1, 5000000);
insert into car_added values (3, 11, 1, 4000000);
insert into car_added values (4, 3, 1, 1500000);
insert into car_added values (5, 10, 1, 1000000);

