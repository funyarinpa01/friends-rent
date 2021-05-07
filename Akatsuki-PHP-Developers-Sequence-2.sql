-- 7. Для найманого друга Х та кожного свята, на якому вiн побував, знайти скiльки разiв
-- за вказаний перiод (з дати F по дату T) вiн був найнятий на свято у групi з принаймнi N друзiв;
SELECT fc.friend_name, ft.name AS party_name, COUNT(ft.type_id) AS times_ordered
FROM friend_client fc
LEFT JOIN friend_type ft ON fc.friend_type = ft.type_id
WHERE friend_name = 'Nazar Mamonov' AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
GROUP BY fc.friend_name, ft.name
HAVING COUNT(fc.friend_id) >= 1;

-- 8. Вивести подарунки у порядку спадання середньої кiлькостi вихiдних, що брали 
-- найманi друзi, якi отримували подарунок вiд клiєнта С протягом вказаного перiоду (з дати F по дату T);
SELECT cat.name
FROM friend_client fc
LEFT JOIN present pr ON fc.client_id = pr.client_id
LEFT JOIN category cat ON pr.category_id = cat.category_id
LEFT JOIN day_off dof ON fc.friend_id = dof.friend_id 
WHERE client_name = 'Oleksandr Dubas' AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
GROUP BY  cat.name 
ORDER BY COUNT(day_off_id) DESC;

-- 9. Вивести найманих друзiв у порядку спадання кiлькость скарг вiд груп з принаймнi N 
-- клiєнтiв за вказаний перiод (з дати F по дату T);
SELECT fc.friend_name
FROM friend_client fc
LEFT JOIN client_report cr ON fc.client_id = cr.client_id
LEFT JOIN report r ON fc.friend_id = r.friend_id
WHERE begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
GROUP BY fc.friend_name
HAVING COUNT(cr.client_id) >= 2 --N

-- 10. Знайти усi спiльнi подiї для клiєнта С та найманого друга Х 
-- за вказаний перiод (з дати F по дату T);
SELECT ft.name AS party_name
FROM friend_client fc
LEFT JOIN friend_type ft ON fc.friend_type = ft.type_id
WHERE friend_name = 'Nazar Mamonov' AND client_name = 'Oleksandr Dubas' AND begin_date <= '06-05-2021' AND '06-05-2021' <= end_date
GROUP BY ft.name

-- 11. Знайти усi днi коли вихiдними були вiд А до В найманих друзiв, включно;
SELECT dof.date
FROM friend_client fc
LEFT JOIN day_off dof ON fc.friend_id = dof.friend_id
GROUP BY dof.date
HAVING COUNT(dof.date) >= 2 AND COUNT(dof.date) <= 4
ORDER BY dof.date

--12. По мiсяцях знайти середню кiлькiсть клiєнтiв у групi, що реєстрували скаргу
-- на найманого друга Х;
