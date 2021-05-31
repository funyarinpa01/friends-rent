DROP TABLE client CASCADE;
DROP TABLE friend CASCADE;
DROP TABLE day_off CASCADE;
DROP TABLE friend_type CASCADE;
DROP TABLE party_friend CASCADE;
DROP TABLE report CASCADE;
DROP TABLE party CASCADE;
DROP TABLE category CASCADE;
DROP TABLE client_report CASCADE;
DROP TABLE present CASCADE;

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

-- Change the date style
SET datestyle = "ISO, DMY";

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
(2, '05-05-2021'),
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
(8, 'Too skinny', '01-07-2021'),
(1, 'Hard working', '02-02-2021');

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
(10, 10),
(2, 11);

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

CREATE VIEW friend_client AS
	SELECT f.friend_id, f.first_name AS friend_first_name, f.last_name AS friend_last_name, 
		   friend_type, 
		   c.client_id, c.first_name AS client_first_name, c.last_name AS client_last_name,
		   p.party_id, p.begin_date, p.end_date 
	FROM friend f
	LEFT JOIN party_friend pf ON pf.friend_id = f.friend_id
	LEFT JOIN party p ON pf.party_id = p.party_id
	LEFT JOIN client c ON p.party_id = c.client_id;
	
	
DROP VIEW friend_client;


CREATE INDEX idx_client_name 
	ON client((first_name || ' ' || last_name));


CREATE INDEX idx_friend_name 
	ON friend((first_name || ' ' || last_name));


CREATE INDEX idx_party_time
	ON party(begin_date, end_date);


CREATE INDEX idx_friend_type 
	ON friend_type(name);
	
CREATE INDEX idx_present_return_date 
	ON present(date_returned);


-- 1. Для клiєнта С знайти усiх друзiв, яких вiн наймав принаймнi N разiв за вказаний перiод (з
-- дати F по дату T);
SELECT (fc.friend_first_name || ' ' || fc.friend_last_name) AS friend_name, COUNT(friend_id) AS times_ordered
	FROM friend_client fc
	WHERE (fc.client_first_name || ' ' || fc.client_last_name) = 'Oleksandr Dubas' AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY friend_name
	HAVING COUNT(friend_id) >= 1;
	

-- 2. Для найманого друга Х знайти усiх клiєнтiв, якi наймали його принаймнi N разiв за вказаний перiод 
-- (з дати F по дату T);
SELECT (fc.client_first_name || ' ' || fc.client_last_name) AS client_name, COUNT(client_id) AS times_ordered 
	FROM friend_client fc
	WHERE (fc.friend_first_name || ' ' || fc.friend_last_name) = 'Nazar Mamonov' AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY client_name
	HAVING COUNT(client_id) >= 1;
	

-- 3. Для найманого друга Х знайти усi свята, на якi його наймали принаймнi N разiв за вказаний
-- перiод (з дати F по дату T);
SELECT ft.name AS party_name, COUNT(ft.type_id) AS times_ordered
	FROM friend_client fc
	LEFT JOIN friend_type ft ON fc.friend_type = ft.type_id
	WHERE (fc.friend_first_name || ' ' || fc.friend_last_name) = 'Nazar Mamonov' AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY ft.type_id
	HAVING COUNT(ft.type_id) >= 1;
	

-- 4. Знайти усiх клiєнтiв, якi наймали щонайменше N рiзних друзiв за вказаний перiод (з дати
-- F по дату T);
SELECT d.client_name, COUNT(d.client_id) AS times_ordered 
	FROM (SELECT DISTINCT friend_id, client_id, (fc.client_first_name || ' ' || fc.client_last_name) AS client_name 
		  FROM friend_client fc
		  WHERE begin_date <= '06-05-2021' AND '06-05-2021' <= end_date) AS d
	GROUP BY d.client_id, d.client_name
	HAVING COUNT(d.client_id) >= 3;
	

-- 5. Знайти усiх найманих друзiв, яких наймали хоча б N разiв за вказаний перiод (з дати F по
-- дату T);
SELECT (fc.friend_first_name || ' ' || fc.friend_last_name) AS friend_name, COUNT(friend_id) AS times_ordered 
	FROM friend_client fc
	WHERE begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY friend_id, friend_name
	HAVING COUNT(friend_id) >= 2;
	

-- 6. Знайти сумарну кiлькiсть побачень по мiсяцях;
SELECT EXTRACT(MONTH FROM p.begin_date) AS month, COUNT(ft.name) AS occurence_num 
	FROM party p
	LEFT JOIN party_friend pf ON pf.party_id = p.party_id
	LEFT JOIN friend f ON pf.friend_id = f.friend_id
	LEFT JOIN friend_type ft ON f.friend_type = ft.type_id
	WHERE ft.name = 'One night friend'
	GROUP BY ft.name, month;


-- 7. Для найманого друга Х та кожного свята, на якому вiн побував, знайти скiльки разiв
-- за вказаний перiод (з дати F по дату T) вiн був найнятий на свято у групi з принаймнi N друзiв;
SELECT 
	fc.friend_first_name || ' ' || fc.friend_last_name AS friend_name, 
	ft.name AS party_name, 
	COUNT(ft.type_id) AS times_ordered
	FROM friend_client fc
	LEFT JOIN friend_type ft ON fc.friend_type = ft.type_id
	WHERE (fc.friend_first_name || ' ' || fc.friend_last_name) = 'Nazar Mamonov' 
		AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY friend_name, ft.name
	HAVING COUNT(fc.friend_id) >= 1;

-- 8. Вивести подарунки у порядку спадання середньої кiлькостi вихiдних, що брали 
-- найманi друзi, якi отримували подарунок вiд клiєнта С протягом вказаного перiоду (з дати F по дату T);
SELECT cat.name
	FROM friend_client fc
	LEFT JOIN present pr ON fc.client_id = pr.client_id
	LEFT JOIN category cat ON pr.category_id = cat.category_id
	LEFT JOIN day_off dof ON fc.friend_id = dof.friend_id 
	WHERE (fc.client_first_name || ' ' || fc.client_last_name) = 'Oleksandr Dubas'
		AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY  cat.name 
	ORDER BY COUNT(day_off_id) DESC;

-- 9. Вивести найманих друзiв у порядку спадання кiлькость скарг вiд груп з принаймнi N 
-- клiєнтiв за вказаний перiод (з дати F по дату T);
SELECT fc.friend_first_name || ' ' || fc.friend_last_name AS friend_name
	FROM friend_client fc
	LEFT JOIN client_report cr ON fc.client_id = cr.client_id
	LEFT JOIN report r ON fc.friend_id = r.friend_id
	WHERE begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY friend_name
	HAVING COUNT(cr.client_id) >= 2;

-- 10. Знайти усi спiльнi подiї для клiєнта С та найманого друга Х 
-- за вказаний перiод (з дати F по дату T);
SELECT ft.name AS party_name
	FROM friend_client fc
	LEFT JOIN friend_type ft ON fc.friend_type = ft.type_id
	WHERE (fc.friend_first_name || ' ' || fc.friend_last_name) = 'Nazar Mamonov'
		AND (fc.client_first_name || ' ' || fc.client_last_name) = 'Oleksandr Dubas'
		AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY ft.name;


-- 11. Знайти усi днi коли вихiдними були вiд А до В найманих друзiв, включно;
CREATE VIEW friend_day_off AS
	SELECT f.friend_id, f.first_name || ' ' || f.last_name AS friend_name, friend_type, 
		   c.client_id, c.first_name || ' ' || c.last_name AS client_name,
		   p.party_id, p.begin_date, p.end_date,
		   dof.day_off_id, dof.date FROM friend f
	LEFT JOIN party_friend pf ON pf.friend_id = f.friend_id
	LEFT JOIN party p ON pf.party_id = p.party_id
	LEFT JOIN client c ON p.party_id = c.client_id
	LEFT JOIN day_off dof ON f.friend_id = dof.friend_id;
	
DROP VIEW friend_day_off;

SELECT date FROM friend_day_off
WHERE date IN (
	SELECT date 
	FROM friend_day_off
	GROUP BY date
	HAVING COUNT(distinct friend_name) >= 2 AND COUNT(distinct friend_name) <= 2)
GROUP BY date;
	

--12. По мiсяцях знайти середню кiлькiсть клiєнтiв у групi, що реєстрували скаргу
-- на найманого друга Х;
CREATE VIEW party_report AS
	SELECT f.friend_id, f.first_name || ' ' || f.last_name AS friend_name, 
		   c.client_id, c.first_name || ' ' || c.last_name AS client_name,
		   p.party_id, p.begin_date, p.end_date,
		   cr.report_id, r.date
		   FROM friend f
		  
	
	LEFT JOIN party_friend pf ON pf.friend_id = f.friend_id
	LEFT JOIN party p ON pf.party_id = p.party_id
	LEFT JOIN client c ON p.party_id = c.client_id
	LEFT JOIN client_report cr ON c.client_id = cr.client_id
	LEFT JOIN report r ON f.friend_id = r.friend_id;
	
DROP VIEW party_report;


SELECT EXTRACT(month FROM pr.date) AS month_num,
COUNT(client_id) / COUNT(party_id) AS avg_client
FROM party_report pr
WHERE client_id IN (
	SELECT client_id
	FROM party_report
	GROUP BY client_id
	HAVING COUNT(party_id) > 1 )
	
	AND friend_name IN (
	'Nazar Mamonov')
GROUP BY month_num;
