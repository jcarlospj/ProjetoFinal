--===================================================================================================================
-- NOME DO SCRIPT: cria.tabVizual2.hive.raw.parquet.hql
-- FUNCAO: Criacao de tabela Raw Data VIZUAL2 - com formato parquet e compressão snappy
--====================================================================================================================

set parquet.compression=SNAPPY;

-- Cria o Database caso não exista
CREATE DATABASE IF NOT EXISTS COVID;

-- Dropa a tabela caso exista
DROP TABLE IF EXISTS COVID.TB_VIZUAL2_RAW;

-- Comando para criar uma tabela
CREATE EXTERNAL TABLE COVID.TB_VIZUAL2_RAW (
     `ACUMULADO` INT
    ,`CASOSNOVOS` INT
    ,`INCIDENCIA` DECIMAL(8,2)
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|'
STORED AS PARQUET
LOCATION '/user/jcarlospj/projetos/vizual2/data'
TBLPROPERTIES ('parquet.compression'='SNAPPY');


