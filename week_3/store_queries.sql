ALTER TABLE `store`.`sale`
	DROP COLUMN dt_created,
    DROP COLUMN dt_modified,
    DROP FOREIGN KEY fk_order_status1,
    DROP COLUMN status_id,
    ADD COLUMN ts_modified TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ADD COLUMN sale_status VARCHAR(45) NOT NULL DEFAULT 'new'
        CHECK (VALUE IN ('new', 'process', 'assembly', 'ready', 'delivering', 'issued', 'rejected'));  # Не будет работать в MySQL

INSERT INTO `store`.`sale` (id, client_id, number, sale_sum, sale_status)
	VALUES (51, 1, '51', NULL, 'process');

UPDATE `store`.`sale` SET sale_status = 'ready' WHERE id = 51;

INSERT INTO `store`.`sale` (id, client_id, number, sale_sum, sale_status)
	VALUES (52, 1, '52', NULL, 'process1');

# Удалите из таблицы 'client' поля 'code' и 'source_id'
ALTER TABLE `client`
    DROP COLUMN code,
    DROP FOREIGN KEY fk_client_source1,
    DROP COLUMN source_id;

# Удалите таблицу 'source'
DROP TABLE `source`;

# Добавьте в таблицу 'sale_has_good' следующие поля:
#     Название: `num`, тип данных: INT, возможность использования неопределенного значения: Нет
#     Название: `price`, тип данных: DECIMAL(18,2), возможность использования неопределенного значения: Нет
ALTER TABLE `sale_has_good`
    ADD COLUMN num INT NOT NULL,
    ADD COLUMN price DECIMAL(18,2) NOT NULL;

# Добавьте в таблицу 'client' поле 'source_id' тип данных: INT, возможность использования неопределенного значения: Да.
# Для данного поля определите ограничение внешнего ключа как ссылку на поле 'id' таблицы 'source'.
ALTER TABLE `client`
	ADD COLUMN source_id INT NULL,
    ADD CONSTRAINT fk_source_id FOREIGN KEY (source_id) REFERENCES source(id);