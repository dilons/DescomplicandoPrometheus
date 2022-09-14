# Tipos de Dados

## gauge: Medidor  
* é utilizado para criar métricas de valores que variam para mais ou para menos, por exemplo uso de memória e CPU, ou a temperatura ambiente por exemplo. Já dentro do Prometheus, um exemplo de métrica Gauge é a métrica _memory_usage_ que pode ser encontrada em:

    ```
    requests_total{instance="localhost:8899",job="Primeiro Exporter"}
    ```

## counter: Contador  
* é o tipo de dado que vai incrementando ao decorrer do tempo, por exemplo, quanto acessos determinado endereço teve. O Valor atual dessa métrica, quase não é utilizado, pois sempre vamos utilizar uma janela de tempo. Esse tipo de métrica, normalmente tem o sufixo __total_ para indicar o total de valores em determinado período de tempo.

    ```
    requests_total{instance="localhost:8899",job="Primeiro Exporter"}
    ```

## histogram: Histograma  
* o dado _histogram_ é o tipo de dado que permite especificar o valor à partir de períodos de tempo, chamados buckets. Por exemplo, temos os buckets onde o tempo de requisição foi de 0 até 0.5 segundos, ou seja, quando uma requisição levar até 0.5 segundos, ela será armazenada nesse bucket. Caso a requisição leve 0.6 segundos, ela será armazenada no próximo bucket, no caso de 0.5 até 1 segundo. Um exempolo de consulta é:
    ```
    requests_duration_seconds_bucket{le="0.5"}
    ```

* ainda no _histogram_ podemos encontrar alguns sufixos que podem ser úteis pra nós, por exemplo:  
  * __count_: Este sufixo, indica que o valor é um contador, ou seja, sempre é incrementado a cada vez que a métrica é atualizada.
  * __sum_:  Este sufixo, indica que o valor é uma soma, ou seja, os valores sempre são somados a cada vez que a métrica é atualizada
  * __bucket_: Este sufixo, indica que o valor é um bucket.  

## summary: Resumo  
* Parecido com o _histogram_, porem os buckets são chamados de _quantiles_ e são definidos por um valor entre 0 e 1, sendo assim, o valor do bucket, é o que está nos quantiles. Assim como no _histogram_, aqui podemos criar métricas do tipo _summary_ como por exemplo:  
    ```
    requests_duration_seconds_sum{instance="localhost:8899",job="Primeiro Exporter"}
    ```  
    O ponto alto do _summary_ é a excelente precisão, porém ele não é tão versátil quanto o _histogram_, pois percentuais e janelas de tempo, precisam ser definidos na criação da métrica. Sendo que não é possível agregar métricas do tipo _summary_ com outras métricas do mesmo tipo durante as queries.
