# ---------------------------------------------------------------------------------------------
# NOME DO SCRIPT: gera.vizualizacao3.kafka.py
# FUNCAO: Consulta informações da terceira vizualização e envia para topico Kafka
# ---------------------------------------------------------------------------------------------

import pyspark
from pyspark.sql.functions import *
from pyspark.sql import functions as Func
from pyspark.sql import SparkSession
from pyspark.sql.types import IntegerType, StringType
from kafka import KafkaProducer
import json

spark = SparkSession.builder.appName("Vizualizacao3").getOrCreate()

# Importando dados
df = spark.sql("SELECT SUM(OBITOSACUMULADO) AS OBITOSACUMULADO, SUM(OBITOSNOVOS) AS OBITOSNOVOS, SUM(CASOSACUMULADO) AS CASOSACUMULADO, SUM(POPULACAO) AS POPULACAO from COVID.TB_COVID_RAW")

# Calcula Letalidade: é uma medida da gravidade da doença, calculada dividindo-se o número de óbitos por determinada doença pelo número de casos da mesma doença.
df.withColumn("LETALIDADE", Func.col("OBITOSACUMULADO") / Func.col("CASOSACUMULADO"))

# Calcula taxa de mortalidade é um índice demográfico obtido pela relação entre o número de mortos de uma população e um determinado espaço de tempo 
df.withColumn("MORTALIDADE", Func.col("OBITOSACUMULADO") / Func.col("POPULACAO"))

# Deleta coluna de apoio POPULACAO
df.drop(Func.col("POPULACAO"))

# Converte df para formato json 
df = df.to_json()

# Inicializa producer e seta parametro para JSON encode
producer = KafkaProducer(bootstrap_servers=['localhost:9092'],value_serializer=lambda v: json.dumps(v).encode('utf-8'))

# Envia dados em fotmato JSON
producer.send('vizualizacao3', df.encode('utf8'))

# Fecha producer
producer.close()
