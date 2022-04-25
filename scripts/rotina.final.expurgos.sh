#!/bin/bash
#===================================================================================================================
# NOME DO SCRIPT: rotina.final.expurgos.sh
# FUNCAO: Deleta e/ou armazena arquivos para bkp.
# ====================================================================================================================


# Move arquivo para bkp
hdfs dfs -mv /user/jcarlospj/projetos/covid/data/HIST_PAINEL_COVIDBR*.csv /user/jcarlospj/projetos/covid/bkp/

# Remove do HDFS arquivos com mais de 30 dias
# Mascara: HIST_PAINEL_COVIDBR_2020_Parte1_19abr2022.csv
DATE_EXPURGO="$(date --date="-30 day" "+%d%b%Y")"
hdfs dfs -rm /user/jcarlospj/projetos/covid/bkp/HIST_PAINEL_COVIDBR_2020_Parte1_${DATA_EXPURGO}.csv

# Deleta do diretorio do UNIX o arquivo que chegou
rm /home/jcarlospj/treinamentos/docker-bigdata/input/data/covid/tmp/arquivo_original.rar
rm /home/jcarlospj/treinamentos/docker-bigdata/input/data/covid/in/HIST_PAINEL_COVIDBR*.csv

