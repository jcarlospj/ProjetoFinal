--===================================================================================================================
-- NOME DO SCRIPT: cria.tabCovid.hive.raw.hql
-- FUNCAO: Criacao de tabela Raw Data COVID
--====================================================================================================================

-- Cria o Database caso não exista
CREATE DATABASE IF NOT EXISTS COVID;

-- Dropa a tabela TB_COVID_RAW caso exista
DROP TABLE IF EXISTS COVID.TB_COVID_RAW;

-- Comando para criar uma tabela TB_COVID_RAW, particionada por municipio
CREATE EXTERNAL TABLE COVID.TB_COVID_RAW (
 `REGIAO`	VARCHAR(50)
,`ESTADO`	VARCHAR(2)
,`CODUF` INT 
,`CODMUN` INT
,`CODREGIAOSAUDE` INT
,`NOMEREGIAOSAUDE` VARCHAR(70)
,`DATA` VARCHAR(25)
,`SEMANAEPI` VARCHAR(50)
,`POPULACAO` INT
,`CASOSACUMULADO` INT
,`CASOSNOVOS` INT
,`OBITOSACUMULADO` INT
,`OBITOSNOVOS` INT
,`RECUPERADOSNOVOS` INT
,`EMACOMPANHAMENTONOVOS` INT
,`INTERIORMETROPOLITANA` INT
)
PARTITIONED BY (MUNICIPIO STRING)
STORED AS TEXTFILE
TBLPROPERTIES ('skip.header.line.count'='1', 'store.charset'='UTF-8', 'retrieve.charset'='UTF-8');
