
-- Drop Constraint, Rename and Create Table SQL

ALTER TABLE Test
    RENAME TO Test_d62ba558

;

CREATE TABLE gstest.Test
(
    col1 string,
    col2 string,
    col3 string
)

;

INSERT INTO gstest.Test
( col1,
  col2,
  col3 ) 
SELECT
col1,
col2,
col3
FROM Test_d62ba558

;

DROP TABLE IF EXISTS Test_d62ba558

;
