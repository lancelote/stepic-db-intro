USE store;
SELECT * FROM client;

# В импортированной базе магазина посмотрите план следующего запроса
# Сколько кортежей будет обработано из таблицы good?
EXPLAIN
select 
  name, 
    ifnull((select category.name from category 
    join category_has_good on category.id=category_has_good.category_id
        where category_has_good.good_id=good.id
        order by category.name limit 1)
  , 0) as first_category 
from good where name like 'F%';

# Создайте B-tree индекс на поле с названием товара в отношении good
# Сколько теперь кортежей будет обработано из таблицы good?
CREATE INDEX good_name_index ON good(name);

# Укажите, в каком порядке будут выполняться операции над отношениями в следующем запросе:
EXPLAIN
select number, code from sale 
join client on sale.client_id=client.id
join status on status.id=status_id
where status.id in (6, 7);