import requests
import json
import time
from prometheus_client import start_http_server, Gauge
url_pessoas = "http://api.open-notify.org/astros.json"
url_iss = "http://api.open-notify.org/iss-now.json"

def get_iss():
  try: 
     """
     Pega o posicionamento atual da ISS
     """
     response = requests.get(url_iss)
     data = response.json()
     return data['iss_position']
  except Exception as e:
        print ("Nao foi possivel obter a localizacao")
        raise e

def get_astronauta():
    try: 
        """
        Realiza get do numero de astronautas nas estacoes espaciais
        """
        response = requests.get(url_pessoas)
        data = response.json()
        return data['number']
    except Exception as e: 
        print ("Nao foi possivel acessar a URL")
        raise e

def atualiza_metricas():
    try:
        """
        Atualiza métrica com o valor atualizado e localizacao da ISS"
        """
        numero_pessoas = Gauge('numero_astronauta','Numero de Astronautas no Espaço') 
        longitude = Gauge('longitude_iss','longitude atual da iss') 
        latitude = Gauge('latitude_iss','latitude atual da iss') 

        while True:
            numero_pessoas.set(get_astronauta())
            longitude.set(get_iss()['longitude'])
            latitude.set(get_iss()['latitude'])
            time.sleep(10)
            print("O numero de pessoas é: %s" % get_astronauta())
            print("latitude : %s" % get_iss()['latitude'])
            print("longitude: %s" % get_iss()['longitude'])
    except Exception as e:
        print ("Erro na atualizacao de metricas")
        raise e

def start_exporter():
    try:
        """
        Inicia http server
        """
        start_http_server(8899)
        return True
    except Exception as e:
        print ("Erro na inicializaçao do HTTP server")
        raise e

def main():
     try:
        """
        Funcao principal que chama o resto
        """
        start_exporter()
        print ("http server started")
        atualiza_metricas()
     except Exception as e:
        print ("Erros na inicializaco do exporter")
        raise e
        exit (1)

if __name__ == '__main__':
    main()
    exit(0)
