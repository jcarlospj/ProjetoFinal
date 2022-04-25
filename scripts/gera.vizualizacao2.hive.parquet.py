# ---------------------------------------------------------------------------------------------
# NOME DO SCRIPT: gera.vizualizacao2.hive.parquet.py
# FUNCAO: Consulta informações da segunda vizualização e armazena em tabela Hive em formato parquet
# ---------------------------------------------------------------------------------------------

import pyspark
from pyspark.sql.functions import *
from pyspark.sql import functions as Func
from pyspark.sql import SparkSession
from pyspark.sql.types import IntegerType, StringType


spark = SparkSession.builder.appName("Vizualizacao2").getOrCreate()

# Importando dados
df = spark.sql("SELECT SUM(POPULACAO) AS POPULACAO, SUM(CASOSACUMULADO) AS ACUMULADO, SUM(CASOSNOVOS) AS CASOSNOVOS from COVID.TB_COVID_RAW")

# Calcula Incidencia: o número de novos casos de uma doença, dividido pelo número de pessoas em risco
df.withColumn("INCIDENCIA", Func.col("CASOSNOVOS") / Func.col("POPULACAO"))

# Deleta coluna de apoio POPULACAO
df.drop(Func.col("POPULACAO"))

# Definindo diretório
diretorio = '/user/jcarlospj/projetos/vizual2/data/tb_vizual2_raw.csv' 

# Enviando para formato parquet
df.write.format("parquet").options(delimiter='|').save(diretorio)


