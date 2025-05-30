package app

import (
	"github.com/gin-gonic/gin"
	"gitlab.mai.ru/4-bogatyra/backend/search/internal/common/transport/rest"
	"log"
)

func Run(engine *gin.Engine) {
	log.Printf("[common_run] starting product search service")
	rest.RegisterRoutes(engine)
	log.Printf("[common_run] REST service started")
}
