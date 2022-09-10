# Tutorial Descomplicando Prometheus - Parte I - Instalação do Prometheus

## Realizando o download do Prometheus:

1. Acesse [Prometheus.io](https://prometheus.io/download/) e selecione a versão desejada, para este tutorial, vamos utilizar a [versão 2.38.0](https://github.com/prometheus/prometheus/releases/download/v2.38.0/prometheus-2.38.0.linux-amd64.tar.gz) para linux. Caso deseja baixar a versão direto no terminal, pode se usar o comando:  
_wget -q https://github.com/prometheus/prometheus/releases/download/v2.38.0/prometheus-2.38.0.linux-amd64.tar.gz_ 

2. Depois de realizado o download, vamos extrair o conteúdo do zip através do comando _tar -xvf prometheus-2.38.0.linux-amd64.tar.gz_  

3. Extraído os arquivos, vamos mover os binários _prometheus_ e _promtool_ para /usr/local/bin:  
    sudo mv prometheus-2.38.0.linux-amd64/prometheus /usr/local/bin/prometheus  
    sudo mv prometheus-2.38.0.linux-amd64/promtool /usr/local/bin/promtool  

4. Criando os diretórios para o nosso serviço do Prometheus:  
    sudo mkdir /etc/prometheus  _#Aqui é onde vamos armazenar as configurações do nosso serviço do prometheus_  
    sudo mkdir /var/lib/prometheus  _#Aqui é onde o prometheus vai guardar suas métricas, no caso onde os dados do TSDB estarão salvos_  
    sudo mkdir /var/log/prometheus _#Aqui é onde o Prometheus vai armazenar os seus logs_  

5. Depois de criados os diretórios, precisamos criar os arquivos [_prometheus.service_](https://github.com/dilons/DescomplicandoPrometheus/blob/main/conf/prometheus.service) e [_prometheus.yml_](https://github.com/dilons/DescomplicandoPrometheus/blob/main/conf/prometheus.yml) que podem ser baixados nesse mesmo [repositório](https://github.com/dilons/DescomplicandoPrometheus/tree/main/conf).  

6. Com os arquivos já salvos devemos mover os arquivos para:  
_prometheus.service_ > /etc/systemd/system/prometheus.service  
_prometheus.yml_ > /etc/prometheus/prometheus.yml   
   
    **OBS:** Caso deseja salvar os arquivos direto em seus respectivos diretórios, pode se usar os comando:   
    _curl -s https://raw.githubusercontent.com/dilons/DescomplicandoPrometheus/main/conf/prometheus.service | sudo tee  /etc/systemd/system/prometheus.service_  
    _curl -s https://raw.githubusercontent.com/dilons/DescomplicandoPrometheus/main/conf/prometheus.yml | sudo tee /etc/prometheus/prometheus.yml_  

7. Agora vamos criar o grupo e o usuário do prometheus:  
sudo addgroup --system prometheus  _#cria o grupo prometheus_  
sudo adduser --shell /sbin/nologin --system --group prometheus _#cria o usuario prometheus e adiciona ao grupo prometheus e nao permite o login ao sistema._

8. Depois dos usuários criados, precisamos alterar o **owner** das respectivas pastas e binários do prometheus os quais criamos.  
sudo chown -R prometheus:prometheus /var/log/prometheus  
sudo chown -R prometheus:prometheus /etc/prometheus  
sudo chown -R prometheus:prometheus /var/lib/prometheus  
sudo chown -R prometheus:prometheus /usr/local/bin/prometheus  
sudo chown -R prometheus:prometheus /usr/local/bin/promtool  

9. Com tudo configurado, precisamos reiniciar o systemD, habilitar o serviço do prometheus para ser inicializado junto do servidore inicializar o serviço com os respectivos comandos:  
sudo systemctl daemon-reload _#recarrega o systemD_
sudo systemctl enable prometheus _#habilita o serviço do prometheus na inicialização do sistema_  
sudo systemctl start prometheus _#inicializa o serviço do prometheus_