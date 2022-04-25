# ---------------------------------------------------------------------------------------------
# NOME DO SCRIPT: gera.vizualizacao.spark.py
# FUNCAO: Criar visualização pelo Spark com os dados enviados para o HDFS e gera csv para tópico no Elastic
# ---------------------------------------------------------------------------------------------

import pyspark
from pyspark.sql.functions import *
from pyspark.sql import functions as Func
from pyspark.sql import SparkSession
from pyspark.sql.types import IntegerType, StringType

spark = SparkSession.builder.appName("vizualspark").getOrCreate()

# Importando dados Brasil - Geral
dfbr = spark.sql("SELECT 'Brasil' AS REGIAO, SUM(CASOSACUMULADO) AS CASOS, SUM(OBITOSACUMULADO) AS OBITOS,SUM(POPULACAO) AS POPULACAO, MAX(DATA) AS DATA from COVID.TB_COVID_RAW")

# Importando dados por Regioes
dfreg = spark.sql("SELECT REGIAO, SUM(CASOSACUMULADO) AS CASOS, SUM(OBITOSACUMULADO) AS OBITOS,SUM(POPULACAO) AS POPULACAO, MAX(DATA) AS DATA from COVID.TB_COVID_RAW GROUPY BY REGIAO")

# Cria df unico com ambas importações
df = dfbr.union(dfreg)

# Calcula Incidencia: o número de novos casos de uma doença, dividido pelo número de pessoas em risco
df.withColumn("INCIDENCIA", (Func.col("CASOS") / Func.col("POPULACAO"))/100000)

# Calcula taxa de mortalidade é um índice demográfico obtido pela relação entre o número de mortos de uma população e um determinado espaço de tempo 
df.withColumn("MORTALIDADE", (Func.col("OBITOS") / Func.col("POPULACAO"))/100000)

# Deleta coluna de apoio POPULACAO
df.drop(Func.col("POPULACAO"))

# Exibe resultado
df.show()

# grava vizualização em arquivo csv para topico Elastic 
nomeArq='/user/jcarlospj/projetos/vizualspark/data/covid_dados_enviados_hdfs.csv'
df.to_csv(nomeArq, sep=',', header=True, mode='overwrite')

