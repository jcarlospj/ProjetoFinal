# ---------------------------------------------------------------------------------------------
# NOME DO SCRIPT: consulta.vizualizacao1.hive.py
# FUNCAO: Consulta informações da primeira vizualização e armazena em tabela Hive
# ---------------------------------------------------------------------------------------------

import pyspark
from pyspark.sql.functions import *
from pyspark.sql import functions as Func
from pyspark.sql import SparkSession
from pyspark.sql.types import IntegerType, StringType


spark = SparkSession.builder.appName("Vizualizacao1").getOrCreate()

# Importando dados
df = spark.sql("SELECT SUM(RECUPERADOSNOVOS) AS CASOSRECUPERADOS, SUM(EMACOMPANHAMENTONOVOS) AS EMACOMPANHAMENTO from COVID.TB_COVID_RAW")

# Definindo diretório
diretorio = '/user/jcarlospj/projetos/vizual1/data/tb_vizual1_raw.csv' 

# Enviando para formato text
df.write.format("textfile").options(delimiter='|').save(diretorio)




