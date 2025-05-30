package routers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	productMetrics "gitlab.mai.ru/4-bogatyra/backend/search/internal/common/metrics"
	"gitlab.mai.ru/4-bogatyra/backend/search/internal/common/transport/rest/metrics"
	"log"
	"time"
)

func PrometheusMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		start := time.Now()
		log.Printf("[Metrics Middleware] started %s %s", c.Request.Method, c.FullPath())

		c.Next()

		duration := time.Since(start).Seconds()
		status := fmt.Sprint(c.Writer.Status())
		handler := c.FullPath()

		log.Printf(
			"[Metrics Middleware] completed %s %s → status=%s, duration=%.3fsec",
			c.Request.Method, handler, status, duration,
		)

		// собираем метрики
		productMetrics.HTTPRequestsTotal.WithLabelValues(c.Request.Method, handler, status).Inc()
		productMetrics.HTTPRequestDuration.WithLabelValues(c.Request.Method, handler, status).Observe(duration)
	}
}

func StartCollectingMetrics(engine *gin.Engine) {
	log.Println("[Metrics Router] initializing Prometheus metrics endpoint at /metrics")

	engine.Use(PrometheusMiddleware())

	engine.GET("/metrics", metrics.AllMetricsHandler)
}
