--===================================================================================================================
-- NOME DO SCRIPT: insere.tabela.hive.raw.hql
-- FUNCAO: Insere dados na tabela Definitiva, excluíndo sem municipio preenchido
--====================================================================================================================


-- Insere os registros
INSERT INTO TABLE TABLE COVID.TB_COVID_RAW 
[PARTITION(MUNICIPIO = MUNICIPIO)]
SELECT
    `REGIAO`
    ,`ESTADO`
    ,`MUNICIPIO`
    ,`CODUF` 
    ,`CODMUN`
    ,`CODREGIAOSAUDE`
    ,`NOMEREGIAOSAUDE`
    ,`DATA`
    ,`SEMANAEPI`
    ,`POPULACAO`
    ,`CASOSACUMULADO`
    ,`CASOSNOVOS`
    ,`OBITOSACUMULADO`
    ,`OBITOSNOVOS`
    ,`RECUPERADOSNOVOS`
    ,`EMACOMPANHAMENTONOVOS`
    ,`INTERIORMETROPOLITANA`
FROM COVID.TB_COVID_TMP
WHERE MUNICIPIO <> 'NULL'
;
