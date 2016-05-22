USE project_simple;

SELECT * FROM project;

# Число проектов в базе
SELECT count(project_name) FROM project;

# Средний бюджет
SELECT avg(budget) FROM project;

# Сколько в дней уходит на выполнение проектов
SELECT
	project_name,
    project_start,
	project_finish,
    datediff(project_finish, project_start)
FROM project WHERE project_finish > project_start;

# Сколько дней в среднем
SELECT avg(datediff(project_finish, project_start)) FROM project
	WHERE project_finish > project_start;

# Минимальная и максимальная длительность проекта в днях
SELECT
	min(datediff(project_finish, project_start)),
	max(datediff(project_finish, project_start))
FROM project WHERE project_finish > project_start;

# Группировка
SELECT
	client_name,
    min(datediff(project_finish, project_start)) AS min_days,
    avg(datediff(project_finish, project_start)) AS avg_days,
    max(datediff(project_finish, project_start)) AS max_days
FROM project WHERE project_finish > project_start
GROUP BY client_name
ORDER BY max_days DESC
LIMIT 10;

# Общее количество заказов
SELECT count(project_name) FROM project;

# Выведите в качестве результата одного запроса общее количество заказов,
# сумму стоимостей (бюджетов) всех проектов, средний срок исполнения заказа в днях.
SELECT
	count(project_name),
    sum(budget),
    avg(datediff(project_finish, project_start))
FROM project;
