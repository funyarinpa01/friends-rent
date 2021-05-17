CREATE VIEW friend_client AS
	SELECT f.friend_id, f.first_name || ' ' || f.last_name) AS friend_name, friend_type, 
		   c.client_id, c.first_name || ' ' || c.last_name AS client_name,
		   p.party_id, p.begin_date, p.end_date FROM friend f
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


-- 1. Для клiєнта С знайти усiх друзiв, яких вiн наймав принаймнi N разiв за вказаний перiод (з
-- дати F по дату T);
SELECT friend_name, COUNT(friend_id) AS times_ordered
	FROM friend_client fc
	WHERE client_name = 'Oleksandr Dubas' AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY friend_name
	HAVING COUNT(friend_id) >= 1;
	

-- 2. Для найманого друга Х знайти усiх клiєнтiв, якi наймали його принаймнi N разiв за вказаний перiод 
-- (з дати F по дату T);
SELECT client_name, COUNT(client_id) AS times_ordered 
	FROM friend_client fc
	WHERE friend_name = 'Nazar Mamonov' AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY client_name
	HAVING COUNT(client_id) >= 1;
	

-- 3. Для найманого друга Х знайти усi свята, на якi його наймали принаймнi N разiв за вказаний
-- перiод (з дати F по дату T);
SELECT ft.name AS party_name, COUNT(ft.type_id) AS times_ordered
	FROM friend_client fc
	LEFT JOIN friend_type ft ON fc.friend_type = ft.type_id
	WHERE friend_name = 'Nazar Mamonov' AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
	GROUP BY ft.type_id
	HAVING COUNT(ft.type_id) >= 1;
	

-- 4. Знайти усiх клiєнтiв, якi наймали щонайменше N рiзних друзiв за вказаний перiод (з дати
-- F по дату T);
SELECT d.client_name, COUNT(d.client_id) AS times_ordered 
	FROM (SELECT DISTINCT friend_id, client_id, client_name 
		  FROM friend_client fc
		  WHERE begin_date <= '06-05-2021' AND '06-05-2021' <= end_date) AS d
	GROUP BY d.client_id, d.client_name
	HAVING COUNT(d.client_id) >= 3;
	

-- 5. Знайти усiх найманих друзiв, яких наймали хоча б N разiв за вказаний перiод (з дати F по
-- дату T);
SELECT friend_name, COUNT(friend_id) AS times_ordered 
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