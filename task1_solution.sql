CREATE TABLE IF NOT EXISTS source
(
    value String
) ENGINE Memory;

-- Задача № 1
CREATE TABLE IF NOT EXISTS counters
(
    id      String,
    counter Int64
) ENGINE = SummingMergeTree(counter)
      ORDER BY id;

CREATE MATERIALIZED VIEW IF NOT EXISTS counters_mv TO counters
AS
SELECT JSONExtractString(value, 'id') AS id,
       JSONExtractInt(value, 'value') AS counter
FROM source
WHERE JSONExtractString(value, 'type') = 'counter';
