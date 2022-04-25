#!/bin/bash
#===================================================================================================================
# NOME DO SCRIPT: cria.diretorios.sh
# FUNCAO: Cria os diretorios no HDFS e no Unix utilizados no projeto
# ====================================================================================================================


# Cria diretorios no HDFS
hdfs dfs -mkdir /user/jcarlospj/projetos/covid/data
hdfs dfs -mkdir /user/jcarlospj/projetos/covid/bkp
hdfs dfs -mkdir /user/jcarlospj/projetos/vizual1/data
hdfs dfs -mkdir /user/jcarlospj/projetos/vizual2/data
hdfs dfs -mkdir /user/jcarlospj/projetos/vizualspark/data
hdfs dfs -mkdir /user/jcarlospj/projetos/consome_api/data


# Cria diretorios no Unix (Documentacao, scripts, bkp, input)
mkdir /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/docs
mkdir /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/scripts
mkdir /home/jcarlospj/treinamentos/docker-bigdata/projetos/covid/bkp

# Diretório de entrada dados
mkdir /home/jcarlospj/treinamentos/docker-bigdata/input/data/covid/tmp
mkdir /home/jcarlospj/treinamentos/docker-bigdata/input/data/covid/in