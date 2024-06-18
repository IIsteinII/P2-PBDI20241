-- Active: 1712670173221@@127.0.0.1@5432@p220241
-- 1 Base de dados e criação de tabela
CREATE TABLE tb_student
( cod_student SERIAL PRIMARY KEY,
  grade       INTEGER,
  mother_edu  INTEGER,
  father_edu  INTEGER,
  prep_study  INTEGER,
  salary      INTEGER,
  prep_exam   INTEGER
);

-- 2 Resultado em função da formação dos pais
-- Escreva um stored procedure que exibe o número de alunos aprovados e cujos pais são
-- ambos PhDs.

CREATE OR REPLACE PROCEDURE sp_aprovados_phd(OUT resultado INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT (COUNT(*) FILTER (WHERE grade > 0)) FROM tb_student
    WHERE mother_edu = 6 AND father_edu = 6
    INTO resultado;
END;
$$

DO $$
DECLARE
    resultado INT;
BEGIN
    CALL sp_aprovados_phd(resultado);
    RAISE NOTICE 'Total de aprovados com ambos pais PHD: %', resultado;
END;
$$