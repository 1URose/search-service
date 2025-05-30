package rest

import (
	"github.com/gin-gonic/gin"
	"gitlab.mai.ru/4-bogatyra/backend/search/internal/common/transport/rest/routers"
	"log"
)

func RegisterRoutes(engine *gin.Engine) {
	log.Println("[rest:metrics] Registering metrics routes")
	routers.StartCollectingMetrics(engine)
	log.Println("[rest:metrics] Metrics routes registered successfully")
}
