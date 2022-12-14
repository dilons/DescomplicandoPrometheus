#!/usr/bin/env bash
cd /tmp
echo "Realizando o Donwload do Prometheus v2.38"
echo "sudo wget -q https://github.com/prometheus/prometheus/releases/download/v2.38.0/prometheus-2.38.0.linux-amd64.tar.gz"
sudo wget -q https://github.com/prometheus/prometheus/releases/download/v2.38.0/prometheus-2.38.0.linux-amd64.tar.gz 
echo " "
echo " "
echo "Download Concluido, iniciando processo de configuracao..."
echo "tar -xvf /tmp/prometheus-2.38.0.linux-amd64.tar.gz"
sudo tar -xvf /tmp/prometheus-2.38.0.linux-amd64.tar.gz
echo " "
echo " "
echo "sudo mv /tmp/prometheus-2.38.0.linux-amd64/prometheus /usr/local/bin/prometheus"
sudo mv /tmp/prometheus-2.38.0.linux-amd64/prometheus /usr/local/bin/prometheus
echo "sudo mv /tmp/prometheus-2.38.0.linux-amd64/promtool /usr/local/bin/promtool"
sudo mv /tmp/prometheus-2.38.0.linux-amd64/promtool /usr/local/bin/promtool
echo "Prometheus e Promtool movidos para a pasta /usr/local/bin"
echo " "
echo " "
echo "Criando diretorio de configuracao"
echo "sudo mkdir /etc/prometheus"
sudo mkdir /etc/prometheus
echo " "
echo " "
echo "Realizando download dos arquivos de configuracao"
echo "curl -s https://raw.githubusercontent.com/dilons/DescomplicandoPrometheus/main/conf/prometheus.service | sudo tee /etc/systemd/system/prometheus.service"
curl -s https://raw.githubusercontent.com/dilons/DescomplicandoPrometheus/main/conf/prometheus.service | sudo tee  /etc/systemd/system/prometheus.service >> /dev/null
echo "curl -s https://raw.githubusercontent.com/dilons/DescomplicandoPrometheus/main/conf/prometheus.yml | sudo tee  /etc/prometheus/prometheus.yml"
curl -s https://raw.githubusercontent.com/dilons/DescomplicandoPrometheus/main/conf/prometheus.yml | sudo tee /etc/prometheus/prometheus.yml >> /dev/null
echo " "
echo " "
echo "Criando diretorio de dados Prometheus"
echo "sudo mkdir /var/lib/prometheus
sudo mkdir /var/log/prometheus"
sudo mkdir /var/lib/prometheus
sudo mkdir /var/log/prometheus
echo " "
echo " "
echo "Criando grupo e usuario Prometheus"
echo "sudo addgroup --system prometheus 
      sudo adduser --shell /sbin/nologin --system --group prometheus"
sudo addgroup --system prometheus 
sudo adduser --shell /sbin/nologin --system --group prometheus
echo " "
echo " "
echo "Ajustando permissoes dos binarios e pastas"
echo "sudo chown -R prometheus:prometheus /var/log/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus
sudo chown -R prometheus:prometheus /usr/local/bin/prometheus
sudo chown -R prometheus:prometheus /usr/local/bin/promtool"
sudo chown -R prometheus:prometheus /var/log/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus
sudo chown -R prometheus:prometheus /usr/local/bin/prometheus
sudo chown -R prometheus:prometheus /usr/local/bin/promtool

echo "Reinicializando systemD e habilitando o servico do prometheus"
echo "sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus"
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
