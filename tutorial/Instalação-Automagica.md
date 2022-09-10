# Tutorial Descomplicando Prometheus - Parte II - Instalação Automágica
## Utilizando o autoInstall:
 	
1. Realize o download do script [autoInstall-prometheus.sh](https://github.com/dilons/DescomplicandoPrometheus/blob/main/tutorial/autoInstall-prometheus.sh)
2. Adicione permissão de execução através do comando: _chmod +x autoInstall-prometheus.sh_
3. Na pasta do script, execute o comando: _sudo ./autoInstall-prometheus.sh_
4. Acesse o endereço _<localhost:9090>_ ou _<ip_servidor:9090>_ e divirta-se com o Prometheus.

### Observações: 
1. A versão de instalação é a v2.38.0, a última versão disponível no momento, caso deseje alterar para uma outra versão, pode-se alterar a url de download dentro do [autoInstall-prometheus.sh](https://github.com/dilons/DescomplicandoPrometheus/blob/main/tutorial/autoInstall-prometheus.sh). Num futuro próximo, devo atualizar e adicionar alguns parâmetros para facilitar ainda mais a vida :)