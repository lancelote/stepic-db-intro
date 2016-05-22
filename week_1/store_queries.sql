USE store_simple;

SELECT * FROM store;

# Сколько различных товаров в каждой категории
SELECT
	category,
    count(product_name) AS quantity
FROM store
GROUP BY category
ORDER BY quantity DESC;

# Общая выручка магазина
SELECT
	sum(price*sold_num) AS revenue
FROM store;

# Наиболее популярные категории товаров
SELECT
	category,
    sum(sold_num) AS sold
FROM store
GROUP BY category
ORDER BY sold DESC;

# 10 наиболее популярных товаров
SELECT
	product_name,
    sold_num
FROM store
ORDER BY sold_num DESC
LIMIT 10;

# Выведите количество товаров в каждой категории, результат должен содержать два столбца:
#	- название категории
#	- количество товаров в данной категории
SELECT
	category,
	count(product_name)
FROM store
GROUP BY category;

# Выведите 5 категорий товаров, продажи которых принесли наибольшую выручку.
# Под выручкой понимается сумма произведений стоимости товара на количество проданных единиц. Результат должен содержать два столбца: 
#	- название категории
#	- выручка от продажи товаров в данной категории
SELECT
	category,
    sum(price*sold_num) AS revenue
FROM store
GROUP BY category
ORDER BY revenue DESC
LIMIT 5;