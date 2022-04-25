--===================================================================================================================
-- NOME DO SCRIPT: cria.tabCovid.hive.tmp.hql
-- FUNCAO: Criacao da tabela Stage/Temporária.
--         Cria uma tabela temporária inserindo conteúdo do arquivo direto do diretório HDFS
--====================================================================================================================

-- Cria o Database caso não exista
CREATE DATABASE IF NOT EXISTS COVID;

-- Dropa a tabela caso exista
DROP TABLE IF EXISTS COVID.TB_COVID_TMP;

-- Comando para criar uma tabela
CREATE EXTERNAL TABLE COVID.TB_COVID_TMP (
 `REGIAO`	VARCHAR(50)
,`ESTADO`	VARCHAR(2)
,`MUNICIPIO` VARCHAR(50)
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
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/jcarlospj/projetos/covid/data'
TBLPROPERTIES ('skip.header.line.count'='1', 'store.charset'='UTF-8', 'retrieve.charset'='UTF-8');
