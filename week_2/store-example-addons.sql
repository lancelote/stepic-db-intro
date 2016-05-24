USE store;

# Авто увеличение полей
ALTER TABLE `sale` MODIFY id INTEGER AUTO_INCREMENT;
ALTER TABLE `sale_history` MODIFY id INTEGER AUTO_INCREMENT;

ALTER TABLE `sale_history` MODIFY active_from DATETIME;
ALTER TABLE `sale_history` MODIFY active_to DATETIME;

INSERT INTO `status` VALUES (0, "new");
INSERT INTO `status` VALUES (1, "processing");
INSERT INTO `status` VALUES (2, "ready");

SELECT * FROM status;

INSERT INTO `source` VALUES (0, "search");

SELECT * FROM source;

INSERT INTO `client` VALUES (0, "vasya_pupkin", "Vasily", "Pupkin", 0);

SELECT * FROM client;

INSERT INTO `sale` (id, client_id, number, dt_created, dt_modified, sale_sum, status_id) 
	VALUES (0, 0, "cl_0_0", NOW(), NOW(), 195.23, 0);
    
SELECT * FROM sale;
SELECT * FROM sale_history;

# Вызов хранимой процедуры
CALL update_sale_history(1, 0, 195.23);

UPDATE `sale` SET status_id = 1 WHERE id = 1;
UPDATE `sale` SET status_id = 2, sum = 212.35 WHERE id = 1;