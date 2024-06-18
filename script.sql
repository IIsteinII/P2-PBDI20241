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

-- 3 Resultado em função dos estudos
-- Escreva um stored procedure que disponibiliza, utilizando um parâmetro em modo OUT, o
-- número de alunos aprovados dentre aqueles que estudam sozinhos

DROP PROCEDURE sp_resultado_estudo;
CREATE OR REPLACE PROCEDURE sp_resultado_estudo (OUT p_qtde_aprov INT)
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT COUNT(cod_student) 
	FROM tb_student 
	WHERE grade > 0
	  AND prep_study = 1 -- alone 
	INTO $1;
END;
$$
 
DO $$
DECLARE
	p_qtde_aprov  INT;
BEGIN
    CALL sp_resultado_estudo(p_qtde_aprov);
	RAISE NOTICE 'Quantidade de alunos aprovados que estudaram sozinhos: %', p_qtde_aprov;
END;
$$

-- 4 Salário versus estudos
-- Dentre os alunos que têm salário maior que 410, quantos costumam se preparar com
-- frequência (regularmente) para os exames? Escreva uma função que devolva esse número

CREATE OR REPLACE FUNCTION fn_salario_estudo_regular() RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
	v_qtde INT;
BEGIN 	
	SELECT count(salary) 
	  FROM tb_student
	WHERE salary = 5 
	  AND prep_exam = 2
	 INTO v_qtde;
	 RETURN v_qtde;
END;
$$
 
DO $$
DECLARE
	v_qtde INT;
BEGIN
	SELECT fn_salario_estudo_regular() INTO v_qtde;
	RAISE NOTICE 'Quantidade de alunos que tem salario maior que 410 e se preparam regularmente: %', v_qtde;	
END;
$$
