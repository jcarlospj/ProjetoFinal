#!/bin/bash
#===================================================================================================================
# NOME DO SCRIPT: executa_processos.sh
# FUNCAO: Executa a cadeia de processos por comando de linha
# ==================================================================================================================

# Cria os diretorios no HDFS e no Unix
sh /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/cria.diretorios.sh

# Executa o hql para criacao da tabela TB_COVID_TMP
beeline -u jdbc:hive2://localhost:10000 -f /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/cria.tabCovid.hive.tmp.hql

# Executa o hql para criacao da tabela TB_COVID_RAW
beeline -u jdbc:hive2://localhost:10000 -f /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/cria.tabCovid.hive.raw.hql

# Executa o hql para criacao da tabela tabela TB_VIZUAL1_RAW
beeline -u jdbc:hive2://localhost:10000 -f /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/cria.tabVizual1.hive.raw.hql

# Executa o hql para criacao da tabela tabela TB_VIZUAL2_RAW
beeline -u jdbc:hive2://localhost:10000 -f /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/cria.tabVizual2.hive.raw.parquet.hql

# Executa python de captura do arquivo fonte dos dados
cd /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/ && python captura.dados.origem.tar.py

# Tranfere arquivos para HDFS
sh /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/transfere.hdfs.csv.sh

# Executa o hql para inserir registros tabela TB_COVID_RAW
beeline -u jdbc:hive2://localhost:10000 -f /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/insere.tabCovid.hive.raw.hql

# Executa python para consulta das informações da primeira vizualização
cd /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/ && python gera.vizualizacao1.hive.py

# Executa python para consulta das informações da segunda vizualização
cd /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/ && python gera.vizualizacao2.hive.parquet.py

# Cria topico producer kafka vizualizacao3
sh /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/cria.topico.kafka.sh

# Executa python para consulta das informações da terceira vizualização, envia topico kafka
cd /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/ && python gera.vizualizacao3.kafka.py

# Executa python para criar visualização pelo Spark com os dados enviados para o HDFS
# Salva a visualização do covid_dados_enviados_hdfs para tópico no Elastic
cd /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/ && python gera.vizualizacao.spark.py

# Consome API de Elastic salvando em aqruivo .csv
cd /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/ && python consome.API.vacinacao.json

# Deleta e/ou armazena arquivos para bkp
sh /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts/rotina.final.expurgos.sh
