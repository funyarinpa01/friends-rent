CREATE TABLE client (
	client_id serial primary key,
	first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(40) NOT NULL
);

CREATE TABLE friend (
	friend_id serial primary key,
	friend_type INT NOT NULL,
	first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(40) NOT NULL
);

CREATE TABLE day_off (
	day_off_id serial primary key,
	friend_id INT NOT NULL,
	date DATE NOT NULL
);

CREATE TABLE friend_type (
	type_id serial primary key,
	name VARCHAR(40) NOT NULL
);

CREATE TABLE party_friend (
	party_id INT NOT NULL,
	friend_id INT NOT NULL
);

CREATE TABLE report (
	report_id serial primary key,
	friend_id INT NOT NULL,
	text TEXT NOT NULL,
	date DATE
);

CREATE TABLE party (
	party_id serial primary key,
	client_id INT NOT NULL,
	begin_date DATE NOT NULL,
	end_date DATE NOT NULL
);

CREATE TABLE category (
	category_id serial primary key,
	name VARCHAR(40) NOT NULL
);

CREATE TABLE client_report (
	client_id INT NOT NULL,
	report_id INT NOT NULL
);

CREATE TABLE present (
	present_id serial primary key,
	client_id INT NOT NULL,
	friend_id INT NOT NULL,
	date_returned DATE,
	category_id INT NOT NULL
);

INSERT INTO client (first_name, last_name) VALUES 
('Oleksandr', 'Dubas'),
('Yewgen', 'Domeretskiy'),
('Vasya', 'Pupkin'),
('Vasility', 'Utkin'),
('Oleksandr', 'Pishnograev'),
('Petro', 'Soloviov'),
('Panas', 'Shevchenko'),
('Lesya', 'Teliha'),
('Volodymyr', 'Ostapenko'),
('Vlad', 'Semikin');

INSERT INTO party (client_id, begin_date, end_date) VALUES
(1, '05-05-2021', '07-05-2021'),
(2, '09-05-2021', '10-05-2021'),
(3, '15-05-2021', '18-05-2021'),
(4, '18-05-2021', '19-05-2021'),
(5, '18-05-2021', '21-05-2021'),
(6, '30-05-2021', '02-06-2021'),
(7, '01-06-2021', '03-06-2021'),
(8, '09-06-2021', '10-06-2021'),
(9, '20-06-2021', '25-06-2021'),
(10, '29-06-2021', '30-06-2021');

INSERT INTO friend_type (name) VALUES
('One night friend'),
('Long-term relationship'),
('For birthday'),
('For love'),
('For party'),
('For wedding'),
('For funeral'),
('For prom'),
('For drinking'),
('Other');

INSERT INTO friend (friend_type, first_name, last_name) VALUES
(1, 'Nazar', 'Mamonov'),
(2, 'Pavlo', 'Yasinovskiy'),
(3, 'Nazar', 'Dobrovolskyy'),
(4, 'Ilya', 'Konstantynenko'),
(5, 'Yarik', 'Morozevich'),
(6, 'Yarema', 'Mischenko'),
(7, 'Maxym', 'Kryval'),
(8, 'Andrii', 'Uhera'),
(9, 'Andrii', 'Turko'),
(10, 'Pavlo', 'Semchyshyn');

INSERT INTO day_off (friend_id, date) VALUES
(1, '05-05-2021'),
(2, '09-05-2021'),
(3, '15-05-2021'),
(1, '20-05-2021'),
(4, '25-05-2021'),
(5, '26-05-2021'),
(3, '30-05-2021'),
(6, '05-06-2021'),
(10, '14-05-2021'),
(8, '01-06-2021'),
(7, '29-05-2021'),
(9, '10-05-2021');

INSERT INTO party_friend (party_id, friend_id) VALUES 
(3, 6),
(1, 5),
(1, 1),
(1, 9),
(2, 2),
(2, 9),
(3, 7),
(3, 1),
(4, 5),
(4, 8),
(5, 10),
(5, 7),
(6, 2),
(7, 3),
(8, 10),
(9, 6),
(10, 8),
(1, 3),
(8, 4),
(7, 4);

INSERT INTO report (friend_id, text, date) VALUES
(4, 'Horrible smile', '10-07-2021'),
(9, 'Worst handshake ever', '15-07-2021'),
(10, 'Bad manners', '11-07-2021'),
(3, 'Disgusting kisser', '20-07-2021'),
(6, 'Came to the party naked', '13-07-2021'),
(5, 'Has smelly feet', '14-07-2021'),
(1, 'Messy hairstyle', '25-07-2021'),
(2, 'Girly clothes', '30-07-2021'),
(7, 'Cannot dance', '01-07-2021'),
(8, 'Too skinny', '01-07-2021');

INSERT INTO client_report (client_id, report_id) VALUES
(7, 1),
(8, 1),
(1, 2),
(2, 2),
(5, 3),
(8, 3),
(1, 4),
(7, 4),
(3, 5),
(9, 5),
(1, 6),
(4, 6),
(1, 7),
(3, 7),
(2, 8),
(6, 8),
(3, 9),
(5, 9),
(4, 10),
(10, 10);

INSERT INTO category (name) VALUES 
('food'),
('flowers'),
('toy'),
('jewelry'),
('tickets'),
('technology'),
('chancellery'),
('sertificate'),
('money'),
('alchohol');

INSERT INTO present (client_id, friend_id, date_returned, category_id) VALUES
(1, 1, '30-05-2021', 1),
(2, 9, '29-05-2021', 2),
(3, 6, '25-05-2021', 3),
(4, 5, '01-06-2021', 4),
(5, 10, '01-06-2021', 5),
(6, 2, '05-06-2021', 6),
(7, 3, '05-06-2021', 7),
(8, 10, '01-07-2021', 8),
(9, 6, '01-07-2021', 9),
(10, 8, '01-07-2021', 10);












































