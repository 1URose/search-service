package metrics

import "github.com/prometheus/client_golang/prometheus"

var (
	HTTPRequestsTotal = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Namespace: "product_search",
			Name:      "http_requests_total",
			Help:      "Количество HTTP-запросов, лейблы: метод, маршрут, статус.",
		},
		[]string{"method", "handler", "status"},
	)

	HTTPRequestDuration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Namespace: "product_search",
			Name:      "http_request_duration_seconds",
			Help:      "Гистограмма времени обработки HTTP-запросов (в секундах).",
			Buckets:   prometheus.DefBuckets,
		},
		[]string{"method", "handler", "status"},
	)

	ESRequestsTotal = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Namespace: "product_search",
			Name:      "es_requests_total",
			Help:      "Количество запросов к ES по операциям и статусу.",
		},
		[]string{"op", "status"},
	)
	ESRequestDuration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Namespace: "product_search",
			Name:      "es_request_duration_seconds",
			Help:      "Гистограмма длительности запросов к ES (в секундах).",
			Buckets:   prometheus.DefBuckets,
		},
		[]string{"op", "status"},
	)

	ESClusterStatus    = prometheus.NewGauge(prometheus.GaugeOpts{Namespace: "product_search", Name: "elastic_cluster_status", Help: "Статус кластера ES: 0=red,1=yellow,2=green."})
	ESActiveShards     = prometheus.NewGauge(prometheus.GaugeOpts{Namespace: "product_search", Name: "elastic_active_shards", Help: "Количество активных шардов ES."})
	ESRelocatingShards = prometheus.NewGauge(prometheus.GaugeOpts{Namespace: "product_search", Name: "elastic_relocating_shards", Help: "Количество перемещаемых шардов ES."})
	ESUnassignedShards = prometheus.NewGauge(prometheus.GaugeOpts{Namespace: "product_search", Name: "elastic_unassigned_shards", Help: "Количество неприсвоенных шардов ES."})
)

func init() {
	prometheus.MustRegister(
		HTTPRequestsTotal,
		HTTPRequestDuration,
		ESRequestsTotal,
		ESRequestDuration,
		ESClusterStatus,
		ESActiveShards,
		ESRelocatingShards,
		ESUnassignedShards,
	)
}
