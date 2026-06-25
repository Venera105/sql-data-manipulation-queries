SELECT * FROM miniproject1.users;

#1 Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице в период с 2023-11-07 по 2023-11-15.
SELECT COUNT(DISTINCT user_id)
FROM users
WHERE date BETWEEN '2023-11-07' AND '2023-11-15' ;

#2 Определите пользователя, который за весь период посмотрел наибольшее количество объявлений. 
SELECT user_id,
       SUM(view_adverts) AS total_views
FROM users
GROUP BY user_id
ORDER BY total_views DESC
LIMIT 1;

#3 Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, но учитывайте только дни с более чем 500 уникальными пользователями.
SELECT date, COUNT(DISTINCT user_id) AS users_count, ROUND(AVG(view_adverts)) AS avg_view_adverts
FROM users
GROUP BY date
HAVING COUNT(DISTINCT user_id) > 500
ORDER BY avg_view_adverts DESC
LIMIT 1;

#4 Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю. Отсортировать LT по убыванию.
SELECT user_id, MAX(date)-MIN(date) AS LT
FROM users
GROUP BY user_id
ORDER BY LT DESC;

#5 Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните, у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней.
WITH user_stats AS (
    SELECT user_id,
           ROUND(AVG(view_adverts)) AS avg_views_per_day,
           COUNT(DISTINCT date) AS active_days
    FROM users
    GROUP BY user_id
)
SELECT *
FROM user_stats
WHERE active_days >= 5
  AND avg_views_per_day = (
      SELECT MAX(avg_views_per_day)
      FROM user_stats
      WHERE active_days >= 5
  );
