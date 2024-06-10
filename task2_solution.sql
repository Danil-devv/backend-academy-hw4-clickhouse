-- Задача № 2
CREATE TABLE IF NOT EXISTS payments
(
    id       String,
    date     Date,
    category String,
    purpose  String,
    money    Int64,
    ind      Int64
) ENGINE = ReplacingMergeTree(ind)
      ORDER BY (id, date, category);

CREATE MATERIALIZED VIEW IF NOT EXISTS payments_mv TO payments AS
SELECT JSONExtractString(value, 'id')                            AS id,
       parseDateTimeBestEffort(JSONExtractString(value, 'date')) AS date,
       JSONExtractString(value, 'category')                      AS category,
       JSONExtractString(value, 'purpose')                       AS purpose,
       JSONExtractInt(value, 'money')                            AS money,
       JSONExtractInt(value, 'index')                            AS ind
FROM source
WHERE JSONExtractString(value, 'type') = 'payment';
