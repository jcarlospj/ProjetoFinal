--===================================================================================================================
-- NOME DO SCRIPT: cria.tabVizual1.hive.raw.hql
-- FUNCAO: Criacao de tabela Raw Data VIZUAL1
--====================================================================================================================

-- Cria o Database caso não exista
CREATE DATABASE IF NOT EXISTS COVID;

-- Dropa a tabela caso exista
DROP TABLE IF EXISTS COVID.TB_VIZUAL1_RAW;

-- Comando para criar uma tabela
CREATE EXTERNAL TABLE COVID.TB_VIZUAL1_RAW (
`CASOSRECUPERADOS` INT
,`EMACOMPANHAMENTO` INT
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/user/jcarlospj/projetos/vizual1/data'
TBLPROPERTIES ('skip.header.line.count'='1', 'store.charset'='UTF-8', 'retrieve.charset'='UTF-8');
