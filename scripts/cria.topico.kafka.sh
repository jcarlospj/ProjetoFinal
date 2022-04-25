#!/bin/bash
#===================================================================================================================
# NOME DO SCRIPT: cria.topico.kafka.sh
# FUNCAO: Cria topico producer kafka vizualizacao3
# ====================================================================================================================


# Cria topico producer kafka vizualizacao3
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic vizualizacao3

