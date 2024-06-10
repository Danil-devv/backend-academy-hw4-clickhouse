-- Задача № 3
CREATE TABLE IF NOT EXISTS payments_for_parents
(
    id       String,
    date     Date,
    category String,
    purpose  String,
    money    Int64,
    ind      Int64
) ENGINE = ReplacingMergeTree(ind)
      ORDER BY (id, date, category);

CREATE MATERIALIZED VIEW IF NOT EXISTS payments_for_parents_mv TO payments_for_parents AS
SELECT JSONExtractString(value, 'id')                            AS id,
       parseDateTimeBestEffort(JSONExtractString(value, 'date')) AS date,
       JSONExtractString(value, 'category')                      AS category,
       JSONExtractString(value, 'purpose')                       AS purpose,
       JSONExtractInt(value, 'money')                            AS money,
       JSONExtractInt(value, 'index')                            AS ind
FROM source
WHERE JSONExtractString(value, 'type') = 'payment'
  AND JSONExtractString(value, 'category') != 'gaming'
  AND JSONExtractString(value, 'category') != 'useless';
