CREATE TABLE theater(
theater_id    VARCHAR(10) NOT NULL,
theater_name  VARCHAR(20) NOT NULL,
zipcode       INT         NOT NULL,
phone_number  VARCHAR(50) NOT NULL,
manager       VARCHAR(50) NOT NULL,
CONSTRAINT PKtheater_id PRIMARY KEY (theater_id)
); 

INSERT INTO theater VALUES ('12', 'NewPark 12', '94560', '510-371-0353', 'David May');
INSERT INTO theater VALUES ('14', 'Saratoga 14', '95130', '408-871-2277', 'Jenson Young');
INSERT INTO theater VALUES ('20', 'Mercado 20', '95054', '408-919-0282', 'Tyler Stevens');
INSERT INTO theater VALUES ('15', 'Eastridge 15', '95122' , '408-274-2274', 'John Brock');
INSERT INTO theater VALUES ('16', 'Metreon 16', '94103', '415-369-6207', 'Walter Stones');

--SELECT * FROM theater;

CREATE TABLE employees(
employee_id   VARCHAR(20) NOT NULL,
gender        VARCHAR(15)  NOT NULL,
employee_name VARCHAR(20) NOT NULL,
CONSTRAINT employee_id PRIMARY KEY (employee_id)
);

INSERT INTO employees VALUES ('A122', 'Male', 'Leon Thomas');
INSERT INTO employees VALUES ('A241', 'Female', 'Erika Bullock');
INSERT INTO employees VALUES ('A430', 'Male', 'Harry Hull');
INSERT INTO employees VALUES ('A257', 'Female', 'Evelyn Riley');

--SELECT * FROM employees;

CREATE TABLE movie(
movie_id     VARCHAR(10) NOT NULL,
movie_title  VARCHAR(50) NOT NULL,
genre        VARCHAR(20) NOT NULL,
film_rating  VARCHAR(5)  NULL,
CONSTRAINT PKmovie_id PRIMARY KEY (movie_id)
);

INSERT INTO movie VALUES ('1', 'Knives Out', 'Thriller', 'PG-13'); 
INSERT INTO movie VALUES ('2', 'Once Upon A Time in Hollywood', 'Comedy', 'PG');
INSERT INTO movie VALUES ('3', 'The Farewell', 'Comedy', 'PG');
INSERT INTO movie VALUES ('4', 'La La Land', 'Comedy', 'PG-13');
INSERT INTO movie VALUES ('5','Lion King', 'Music', 'PG');
INSERT INTO movie VALUES ('6', 'Despicable Me 3', 'Action', 'PG');
INSERT INTO movie VALUES ('7', 'Spider-Man: Homecoming', 'Fantasy', 'PG-13');
INSERT INTO movie VALUES ('8', 'Dunkirk', 'Historical', 'PG-13');
INSERT INTO movie VALUES ('9', 'Logan', 'Sci-fi', 'R');
INSERT INTO movie VALUES ('10', 'Ne Zha', 'Adventure', 'G');

--SELECT * FROM movie;

CREATE TABLE members(
member_id      VARCHAR(20)  NOT NULL,
member_name     VARCHAR(50)  NULL,
payment_method VARCHAR(20)  NOT NULL,
CONSTRAINT PKmember_id PRIMARY KEY (member_id)
);

INSERT INTO members VALUES ('12693200', 'Eric Yin', 'Cash');
INSERT INTO members VALUES ('18258313', 'Jillian Staurt', 'Credit Card');
INSERT INTO members VALUES ('19345834', 'Dean Kennedy', 'Cash');
INSERT INTO members VALUES ('13874916', 'Anthony Walters', 'Cash');
INSERT INTO members VALUES ('87345924', 'Mason Gill', 'Credit Card');
INSERT INTO members VALUES ('84759827', 'Jackie	Hill', 'Credit Card');
INSERT INTO members VALUES ('87459284', 'Ash Heath', 'Credit Card');
INSERT INTO members VALUES ('57695849', 'Casey Summers', 'Cash');

--SELECT * FROM members;

CREATE TABLE schedules(
schedule_id   VARCHAR(10)  NOT NULL,
theater_id    VARCHAR(10)  NOT NULL,
movie_id      VARCHAR(10)  NOT NULL,
movie_time    TIMESTAMP         NOT NULL,
version       VARCHAR(20)  NOT NULL,
auditorium    VARCHAR(5)   NOT NULL,
CONSTRAINT  PKschedule_id PRIMARY KEY (schedule_id),
CONSTRAINT  FKtheater_id FOREIGN KEY (theater_id) REFERENCES theater (theater_id),
CONSTRAINT  FKmovie_id FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
);

INSERT INTO schedules VALUES ('1', '12', '1', to_timestamp('31-dec-2019 16:45:00','DD-MON-RRRR HH24:MI:SS.FF'),'Standard', '9');
INSERT INTO schedules VALUES ('2', '14', '2', to_timestamp('27-jul-2019 15:45:00','DD-MON-RRRR HH24:MI:SS.FF'),'Standard', '17');
INSERT INTO schedules VALUES ('3', '20', '3', to_timestamp('07-aug-2019 18:30:00','DD-MON-RRRR HH24:MI:SS.FF'),'Standard', '2');
INSERT INTO schedules VALUES ('4', '15', '4', to_timestamp('07-jan-2017 21:15:00','DD-MON-RRRR HH24:MI:SS.FF'),'Standard', '2');
INSERT INTO schedules VALUES ('5', '16', '5', to_timestamp('19-jul-2019 19:30:00','DD-MON-RRRR HH24:MI:SS.FF'),'Real 3D', '6');
INSERT INTO schedules VALUES ('6', '20', '6', to_timestamp('30-jul-2017 16:20:00','DD-MON-RRRR HH24:MI:SS.FF'),'Real 3D', '4');
INSERT INTO schedules VALUES ('7', '14', '7', to_timestamp('07-jul-2017 16:20:00','DD-MON-RRRR HH24:MI:SS.FF'),'Real 3D', '4');
INSERT INTO schedules VALUES ('8', '15', '8', to_timestamp('04-aug-2017 21:45:00','DD-MON-RRRR HH24:MI:SS.FF'),'IMAX', '10');
INSERT INTO schedules VALUES ('9', '20', '9', to_timestamp('04-mar-2017 21:00:00','DD-MON-RRRR HH24:MI:SS.FF'),'IMAX', '9');
INSERT INTO schedules VALUES ('10','12', '10',to_timestamp('06-sep-2019 20:10:00','DD-MON-RRRR HH24:MI:SS.FF'), 'Standard', '19');

--SELECT * FROM schedules;

CREATE TABLE ticket(
ticket_confirmation_id  VARCHAR(50)  NOT NULL,
schedule_id             VARCHAR(10)  NOT NULL,
reserved_seats          VARCHAR(20)  NULL,
CONSTRAINT PKticket_confirm PRIMARY KEY (ticket_confirmation_id),
CONSTRAINT FKschedule_id  FOREIGN KEY (schedule_id) REFERENCES schedules (schedule_id)
); 

INSERT INTO ticket VALUES ('0662973476', '1', 'F5,F6');
INSERT INTO ticket VALUES ('0138367428', '2', 'E3,E4');
INSERT INTO ticket VALUES ('0585891590', '3', 'I7,I8');
INSERT INTO ticket (ticket_confirmation_id, schedule_id) VALUES ('0757974854', '4');
INSERT INTO ticket VALUES ('0172208105', '5', 'G12,G13');
INSERT INTO ticket (ticket_confirmation_id, schedule_id) VALUES ('0212467202', '6');
INSERT INTO ticket (ticket_confirmation_id, schedule_id) VALUES ('0132844500', '7');
INSERT INTO ticket VALUES ('0143325021', '8', 'H13,H14');
INSERT INTO ticket VALUES ('0177413483', '9', 'K1,K2');
INSERT INTO ticket VALUES ('0249503885', '10', 'E3,E4');

--DELETE FROM ticket WHERE schedule_id = '9';

--SELECT * FROM ticket;

CREATE TABLE orders(
order_id     VARCHAR(20)  NOT NULL,
member_id  VARCHAR(20) NULL,
employee_id VARCHAR(20) NULL,
order_date   DATE    NOT NULL,
ticket_confirmation_id  VARCHAR(50)  NOT NULL,
regular_quantity INT,
regular_unit_price DECIMAL(4,2)  NOT NULL,
special_quantity INT,
special_unit_price DECIMAL(4,2)  NOT NULL,
fee  DECIMAL(4,2),
total_amount DECIMAL(7,3) NOT NULL,
CONSTRAINT PKorder_id PRIMARY KEY (order_id),
CONSTRAINT FKticket_confirmation FOREIGN KEY (ticket_confirmation_id) REFERENCES ticket(ticket_confirmation_id),
CONSTRAINT FKmember_id FOREIGN KEY (member_id) REFERENCES members (member_id),
CONSTRAINT FKemployee_id FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

INSERT INTO orders (order_id, member_id, employee_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('389531283', '12693200', 'A122', to_date('2019-12-30','yyyy-mm-dd'), '0662973476', '2', '13.79', '0', '12.29', '3.78', '31.36');

INSERT INTO orders (order_id, member_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('328138958', '18258313', to_date('2019-07-22','yyyy-mm-dd'), '0138367428', '2', '12.19', '0', '11.09', '3.78', '28.16');

INSERT INTO orders (order_id, member_id, employee_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('335112877', '19345834', 'A241', to_date('2019-08-07','yyyy-mm-dd'), '0585891590', '3', '13.69', '1', '12.19', '5.67', '58.93');

INSERT INTO orders (order_id, member_id, employee_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('80402454', '13874916', 'A430', to_date('2017-01-07','yyyy-mm-dd'), '0757974854', '2', '12.99', '0', '11.29', '3.00', '28.98');

INSERT INTO orders (order_id, member_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('325433697', '87345924', to_date('2019-07-19','yyyy-mm-dd'), '0172208105', '2', '18.69', '0', '17.29', '3.78', '41.16');
  
INSERT INTO orders (order_id, member_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('107658262', '84759827', to_date('2017-07-30','yyyy-mm-dd'), '0212467202', '2', '13.69', '0', '12.29', '0.00', '27.38');
  
INSERT INTO orders (order_id, member_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('103752785', '87459284', to_date('2017-07-07','yyyy-mm-dd'), '0132844500', '2', '18.69', '0', '17.19', '0.00', '37.38');
  
INSERT INTO orders (order_id, member_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('108168069', '12693200', to_date('2017-08-04','yyyy-mm-dd'), '0143325021', '2', '19.69', '0', '18.39', '0.00', '39.38');
  
INSERT INTO orders (order_id, member_id, employee_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('86245754', '57695849', 'A257', to_date('2017-03-04','yyyy-mm-dd'), '0177413483', '2', '13.49', '0', '12.19', '0.00', '26.98');
  
INSERT INTO orders (order_id, member_id, order_date, ticket_confirmation_id, regular_quantity, regular_unit_price, special_quantity, special_unit_price, fee, total_amount)
VALUES ('343455414', '57695849', to_date('2019-09-03','yyyy-mm-dd'), '0249503885', '2', '14.69', '0', '13.29', '0.00', '29.38');

--DELETE FROM orders WHERE ticket_confirmation_id = '0177413483';
--SELECT * FROM orders;