USE `store-medium`;

SELECT * FROM product;
SELECT * FROM category;

# Декартово произведение
SELECT * FROM product, category;
SELECT * FROM product CROSS JOIN category;

# Вывод списка продуктов с наименованием категории для каждого
SELECT p.product_name, p.price, c.category_name FROM product AS p
	INNER JOIN category AS c ON p.category_id = c.category_id;

# Внешние соединения
SELECT * FROM category AS c
	LEFT OUTER JOIN product AS p ON c.category_id = p.category_id;
SELECT * FROM product AS p
	RIGHT OUTER JOIN category AS c ON c.category_id = p.category_id;

# Выборка из нескольких источников и объединение
# Самые дорогие и самые дешевые товары в БД
SELECT * FROM product WHERE price > 900
	UNION SELECT * FROM product WHERE price < 100;