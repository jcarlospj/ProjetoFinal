# ---------------------------------------------------------------------------------------------
# NOME DO SCRIPT: consome.API.vacinacao.json.py
# FUNCAO: Consome API de Elastic salvando em aqruivo .csv
# ---------------------------------------------------------------------------------------------

import requests
from requests import status_codes
from requests.exceptions import FileModeWarning
from requests.models import HTTPBasicAuth
import pandas as pd
from pathlib import Path
import json

# Usuario para chamada da API 
url = 'https://imunizacao-es.saude.gov.br/_search'
user = 'imunizacao_public'
pwd = 'qlto5t&7r_@+#Tlstigi'
resultado = requests.get(url, auth=HTTPBasicAuth(user, pwd))
resultado = resultado.json()
#print(resultado)

# Cria dataframe
df = pd.json_normalize(resultado)

# Grava resultado em arquivo csv
nomeArq='/user/jcarlospj/projetos/consome_api/data/dados_api.csv'
df.to_csv(nomeArq, index=False, encoding='utf-8')



