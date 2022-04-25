#!/bin/bash
#===================================================================================================================
# NOME DO SCRIPT: transfere.hdfs.csv.sh
# FUNCAO: Efetua a tranferencia dos arquivos do diretorio de entrada para o HDFS
# ====================================================================================================================


# Tranfere arquivos para HDFS
path='/home/jcarlospj/treinamentos/docker-bigdata/input/data/covid/in/'
hdfs dfs -put ${path}HIST_PAINEL_COVIDBR*csv /user/jcarlospj/projetos/covid/data
