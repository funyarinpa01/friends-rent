num_args = [4, 4, 4, 3, 3, 0, 4, 3, 3, 4, 2, 1]

queries = [
    """
SELECT friend_name, COUNT(friend_id) AS times_ordered
FROM friend_client fc
WHERE client_name = %s AND begin_date >= %s AND begin_date <= %s
GROUP BY friend_name
HAVING COUNT(friend_id) >= %s;
""",
    """
SELECT friend_name, COUNT(friend_id) AS times_ordered
FROM friend_client fc
WHERE client_name = %s AND begin_date >= %s AND begin_date <= %s
GROUP BY friend_name
HAVING COUNT(friend_id) >= %s;
""",
    """
SELECT ft.name AS party_name, COUNT(ft.type_id) AS times_ordered
FROM friend_client fc
LEFT JOIN friend_type ft ON fc.friend_type = ft.type_id
WHERE friend_name = %s AND begin_date >= %s AND begin_date <= %s
GROUP BY ft.type_id
HAVING COUNT(ft.type_id) >= %s;
""",
    """
SELECT d.client_name, COUNT(d.client_id) AS times_ordered 
FROM (SELECT DISTINCT friend_id, client_id, client_name 
FROM friend_client fc
WHERE begin_date >= %s AND begin_date <= %s) AS d
GROUP BY d.client_id, d.client_name
HAVING COUNT(d.client_id) >= %s;
""",
    """
SELECT friend_name, COUNT(friend_id) AS times_ordered 
FROM friend_client fc
WHERE begin_date >= %s AND begin_date <= %s
GROUP BY friend_id, friend_name
HAVING COUNT(friend_id) >= %s;
""",
    """
SELECT EXTRACT(MONTH FROM p.begin_date) AS month, COUNT(ft.name) AS occurence_num 
FROM party p
LEFT JOIN party_friend pf ON pf.party_id = p.party_id
LEFT JOIN friend f ON pf.friend_id = f.friend_id
LEFT JOIN friend_type ft ON f.friend_type = ft.type_id
WHERE ft.name = 'One night friend'
GROUP BY ft.name, month;
""",
    """
SELECT fc.friend_name, ft.name AS party_name, COUNT(ft.type_id) AS times_ordered
FROM friend_client fc
LEFT JOIN friend_type ft ON fc.friend_type = ft.type_id
WHERE friend_name = %s AND begin_date >= %s AND begin_date <= %s
GROUP BY fc.friend_name, ft.name
HAVING COUNT(fc.friend_id) >= %s;
""",
    """
SELECT cat.name
FROM friend_client fc
LEFT JOIN present pr ON fc.client_id = pr.client_id
LEFT JOIN category cat ON pr.category_id = cat.category_id
LEFT JOIN day_off dof ON fc.friend_id = dof.friend_id 
WHERE client_name = %s AND begin_date >= %s AND begin_date <= %s
GROUP BY cat.name
ORDER BY COUNT(day_off_id) DESC;
""",
    """
SELECT fc.friend_name
FROM friend_client fc
LEFT JOIN client_report cr ON fc.client_id = cr.client_id
LEFT JOIN report r ON fc.friend_id = r.friend_id
WHERE begin_date >= %s AND begin_date <= %s
GROUP BY fc.friend_name
HAVING COUNT(cr.client_id) >= %s;
""",
    """
SELECT ft.name AS party_name
FROM friend_client fc
LEFT JOIN friend_type ft ON fc.friend_type = ft.type_id
WHERE friend_name = %s AND client_name = %s AND begin_date >= %s AND begin_date <= %s
GROUP BY ft.name;
""",
    """
SELECT date FROM friend_day_off
WHERE date IN (
SELECT date 
FROM friend_day_off
GROUP BY date
HAVING COUNT(distinct friend_name) >= %s AND COUNT(distinct friend_name) <= %s)
GROUP BY date;
""",
    """
SELECT EXTRACT(month FROM pr.date) AS month_num,
COUNT(client_id) / COUNT(party_id) AS avg_client
FROM party_report pr
WHERE client_id IN
(SELECT client_id FROM party_report GROUP BY client_id HAVING COUNT(party_id) > 1)
AND friend_name = %s
GROUP BY month_num;
"""
]


if __name__ == '__main__':
    print(len(num_args), len(queries))
