package main

import ( 
  "log"
  "net/http"
  "github.com/pbnjay/memory"
  "github.com/prometheus/client_golang/prometheus"
  "github.com/prometheus/client_golang/prometheus/promhttp"
)

func f_mem_free() float64 {
  mem_free := memory.FreeMemory()
  return float64(mem_free)
}

func f_mem_total() float64 {
  mem_total := memory.TotalMemory()
  return float64(mem_total)
}

var (
	memFreeBytesGauge = prometheus.NewGauge(prometheus.GaugeOpts{
		Name:"mem_free_bytes",
		Help:"free memory in bytes",
	})
	memFreeMegabytesGauge = prometheus.NewGauge(prometheus.GaugeOpts{
		Name:"mem_total_megabytes",
		Help:"free memory in megabytes",
	})

	memTotalBytesGauge = prometheus.NewGauge(prometheus.GaugeOpts{
		Name:"mem_total_bytes",
		Help:"free memory in bytes",
	})
	memTotalGigabytesGauge = prometheus.NewGauge(prometheus.GaugeOpts{
		Name:"mem_total_gigabytes",
		Help:"free memory in gigabytes",
	})
)

func init() { 
	prometheus.MustRegister(memFreeBytesGauge)
	prometheus.MustRegister(memFreeMegabytesGauge)
	prometheus.MustRegister(memTotalBytesGauge)
	prometheus.MustRegister(memTotalGigabytesGauge)
}

func main() { 
	memFreeBytesGauge.Set(f_mem_free())
	memFreeMegabytesGauge.Set(f_mem_free() / 1024 / 1024)
	memTotalBytesGauge.Set(f_mem_total())
	memTotalGigabytesGauge.Set(f_mem_total() / 1024 / 1024 / 1024 )
	http.Handle("/metrics",promhttp.Handler())

	log.Fatal(http.ListenAndServe(":7788", nil))
}