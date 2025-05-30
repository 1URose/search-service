package metrics

import (
	"github.com/gin-gonic/gin"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"log"
)

// AllMetricsHandler отдаёт все метрики Prometheus.
// @Summary      Prometheus metrics
// @Description  Экспортирует все зарегистрированные в приложении метрики в формате Prometheus.
// @Tags         metrics
// @Produce      plain
// @Success      200  {string}  string  "metrics in Prometheus format"
// @Router       /metrics [get]
func AllMetricsHandler(c *gin.Context) {
	log.Printf("[Metrics Handler] serving /metrics request from %s", c.Request.RemoteAddr)
	promhttp.Handler().ServeHTTP(c.Writer, c.Request)
}
