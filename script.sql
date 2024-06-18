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



