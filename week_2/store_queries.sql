USE store;

# Выведите все позиций списка товаров принадлежащие какой-либо категории
# с названиями товаров и названиями категорий. Список должен быть отсортирован
# по названию товара, названию категории.
SELECT good.name, category.name FROM category_has_good
	INNER JOIN good ON category_has_good.good_id = good.id
    INNER JOIN category ON category_has_good.category_id = category.id
    ORDER BY good.name, category.name;

# Выведите список клиентов (имя, фамилия) и количество заказов данных клиентов, имеющих статус "new"
SELECT client.first_name, client.last_name, count(1) AS new_sale_num FROM client
	INNER JOIN sale ON client.id = sale.client_id
    INNER JOIN status ON sale.status_id = status.id WHERE status.name = "new"
    GROUP BY client.first_name, client.last_name;

# Выведите список товаров с названиями товаров и названиями категорий, в том числе товаров,
# не принадлежащих ни одной из категорий
SELECT good.name, category.name FROM good
	LEFT OUTER JOIN category_has_good ON good.id = category_has_good.good_id
    LEFT OUTER JOIN category ON category.id = category_has_good.category_id;

# Выведите список товаров с названиями категорий, в том числе товаров,
# не принадлежащих ни к одной из категорий, в том числе категорий не содержащих ни одного товара
SELECT good.name, category.name FROM good
	LEFT OUTER JOIN category_has_good ON good.id = category_has_good.good_id
    LEFT OUTER JOIN category ON category.id = category_has_good.category_id
UNION
SELECT good.name, category.name FROM good
	RIGHT OUTER JOIN category_has_good ON good.id = category_has_good.good_id
    RIGHT OUTER JOIN category ON category.id = category_has_good.category_id;

# Выведите список всех источников клиентов и суммарный объем заказов по каждому источнику.
# Результат должен включать также записи для источников, по которым не было заказов
SELECT source.name, sum(sale.sale_sum) FROM source
	LEFT OUTER JOIN client ON source.id = client.source_id
    LEFT OUTER JOIN sale ON client.id = sale.client_id
    GROUP BY source.name;

# Выведите названия товаров, которые относятся к категории 'Cakes'
# или фигурируют в заказах текущий статус которых 'delivering'.
# Результат не должен содержать одинаковых записей
SELECT good.name FROM good
	INNER JOIN category_has_good ON good.id = category_has_good.good_id
    INNER JOIN category ON category.id = category_has_good.category_id WHERE category.name = "Cakes"
UNION
SELECT good.name FROM good
	INNER JOIN sale_has_good ON good.id = sale_has_good.good_id
    INNER JOIN sale ON sale.id = sale_has_good.sale_id
    INNER JOIN status ON status.id = sale.status_id WHERE status.name = "delivering";

# Выведите список всех категорий продуктов и количество продаж товаров, относящихся к данной категории.
# Под количеством продаж товаров подразумевается суммарное количество единиц товара данной категории,
# фигурирующих в заказах с любым статусом.
SELECT category.name, count(sale.id) FROM category
	LEFT OUTER JOIN category_has_good ON category.id = category_has_good.category_id
    LEFT OUTER JOIN good ON good.id = category_has_good.good_id
    LEFT OUTER JOIN sale_has_good ON good.id = sale_has_good.good_id
    LEFT OUTER JOIN sale ON sale.id = sale_has_good.sale_id
    GROUP BY category.name;

# Выведите список источников, из которых не было клиентов, либо клиенты пришедшие из которых не совершали
# заказов или отказывались от заказов. Под клиентами, которые отказывались от заказов, необходимо понимать
# клиентов, у которых есть заказы, которые на момент выполнения запроса находятся в состоянии 'rejected'.
SELECT source.name FROM source
	WHERE NOT EXISTS (SELECT * FROM client WHERE client.source_id = source.id)
UNION
SELECT source.name FROM source
	INNER JOIN client ON client.source_id = source.id
    INNER JOIN sale ON sale.client_id = client.id
    INNER JOIN status ON status.id = sale.status_id WHERE status.name = "rejected";

# Источники из которых не было хороших клинетов
SELECT source.name FROM source
	WHERE NOT EXISTS (
		SELECT * FROM client
		INNER JOIN sale ON sale.client_id = client.id
		INNER JOIN status ON status.id = sale.status_id WHERE status.name != "rejected" AND client.source_id = source.id
);