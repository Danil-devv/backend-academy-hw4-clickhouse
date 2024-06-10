-- Задача № 4
-- Находим максимальное значение index в таблице source
SELECT max(JSONExtractInt(value, 'index')) FROM source
WHERE JSONExtractString(value, 'id') = 'recipe1'
  AND JSONExtractString(value, 'type') = 'payment'
  AND JSONExtractString(value, 'category') = 'education'
  AND JSONExtractString(value, 'date') = '2021-01-01';

-- Максимальное значение index равно 3
-- Тогда вставляем новую запись с index = 4
INSERT INTO source (value) VALUES ('{"category":"education","type":"payment","index":4,"id":"recipe1","money":50000,"date":"2021-01-01","purpose":"подкуп преподавателя"}');
