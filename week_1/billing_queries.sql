USE billing_simple;

SELECT * FROM billing;
SELECT payer_email, sum FROM billing;
SELECT payer_email, sum FROM billing WHERE sum > 900;

# Комбинирование условий
SELECT * FROM billing
	WHERE sum > 900 AND currency = 'CHF';

# Несколько значений атрибутов
SELECT * FROM billing
	WHERE sum > 900 AND currency IN ('CHF', 'GBP');

# Исключение значений
SELECT * FROM billing
	WHERE sum > 900 AND currency NOT IN ('CHF', 'GBP');
    
# Выведите поступления денег от пользователя с email 'vasya@mail.com'
SELECT * FROM billing WHERE payer_email = 'vasya@mail.com';

# Обновить записи
UPDATE billing SET currency = 'USD';

# Добавить записи в таблицу
INSERT INTO billing VALUES (
	'alex@mail.com',
	'leo@mail.com',
	'500.00', 'MYR',
	'2010-08-20',
	'Here are some money for you');

SELECT * FROM billing
	WHERE payer_email = 'alex@mail.com'
		AND recipient_email = 'leo@mail.com'
        AND sum = 500.00;

# Добавить только некоторые атрибуты
INSERT INTO billing (payer_email, recipient_email, sum, currency, billing_date)
VALUES ('alex@mail.com', 'leo@mail.com', '500.00', 'MYR', '2010-08-21');

# Добавьте в таблицу одну запись о платеже со следующими значениями:

#    email плательщика: 'pasha@mail.com'
#    email получателя: 'katya@mail.com'
#    сумма: 300.00
#    валюта: 'EUR'
#    дата операции: 14.02.2016
#    комментарий: 'Valentines day present)'

INSERT INTO billing VALUES (
	'pasha@mail.com',
    'katya@mail.com',
    '300.00', 'EUR',
    '2016-02-14',
    'Valentines day present');

SELECT * FROM billing WHERE payer_email = 'pasha@mail.com';

# Измените адрес плательщика на 'igor@mail.com' для всех записей таблицы, где адрес плательщика 'alex@mail.com'
UPDATE billing SET payer_email = 'igor@mail.com' WHERE payer_email = 'alex@mail.com';

# Удалите из таблицы записи, где адрес плательщика или адрес получателя установлен в неопределенное значение или пустую строку
DELETE FROM billing
	WHERE payer_email IS NULL
		OR payer_email = ''
		OR recipient_email IS NULL
        OR recipient_email = '';