# ---------------------------------------------------------------------------------------------
# NOME DO SCRIPT: captura.dados.origem.tar.py
# FUNCAO: Captura as informações na fonte dos dados e descompacta o arquivo
# ---------------------------------------------------------------------------------------------

import wget
import rarfile

path_tmp='/home/jcarlospj/treinamentos/docker-bigdata/input/data/covid/tmp/'
path_final='/home/jcarlospj/treinamentos/docker-bigdata/input/data/covid/in/'

# Executando a captura do arquivo
file_url = 'https://mobileapps.saude.gov.br/esus-vepi/files/unAFkcaNDeXajurGB7LChj8SgQYS2ptm/04bd3419b22b9cc5c6efac2c6528100d_HIST_PAINEL_COVIDBR_06jul2021.rar'
file = path_tmp+'arquivo_original.rar'
wget.download(file_url , file )

# Descompacta o arquivo
r = rarfile.RarFile(file)
r.extractall(path_final)
r.close()




