# 🛍️ Product Search Microservice

Микросервис **product-search** обеспечивает индексацию и полнотекстовый поиск товаров с поддержкой:

* **Массовой** и **инкрементальной** индексации через Kafka-сообщения
* **Фильтрации** по категориям, бренду и ценовым диапазонам
* **Сортировки** по релевантности, цене и популярности
* **Пагинации** и **подсветки** (highlighting) найденных фрагментов
* **Фасетной навигации** (aggregation buckets)
* 📈 **Metrics & Monitoring**: Prometheus-метрики, Grafana-дашборды, статус кластера ES

---

## 🚀 Возможности

* 🔄 **Bulk / Incremental Indexing** — через Kafka consumer
* 🔍 **Search API** с JSON-запросом (multi\_match, фильтры, sort, from/size)
* ✨ **Highlighting** ключевых слов в полях `name` и `description`
* 📊 **Facet Aggregations** по `category` и `brand`
* ❤️‍🔥 **Cluster Health** (`GET /product/health`) + ES-метрики
* 📈 **Prometheus Endpoint** (`GET /metrics`) для сбора всех метрик
* 📦 **Docker Compose** для Elasticsearch (кластер из 3-х нод) и Kibana
* 🧩 **Clean Architecture** (domain, use\_cases, transport, infrastructure)

---

## ⚙️ Технологии

* **Go**
* **gin-gonic/gin** (REST API)
* **github.com/elastic/go-elasticsearch/v8**
* **github.com/segmentio/kafka-go**
* * **github.com/prometheus/client_golang** + **promhttp**
* **Docker & Docker Compose**
* **Clean Architecture**

---

## 🛠 Makefile

В корне проекта есть `Makefile` с основными целями:

* `make help`
  Показать список целей.

* `make deps`
  Установить Go-модули и инструменты (swag, protoc-gen-go).

* `make build`
  Собрать бинарник в `bin/product-search`.

* `make run`
  Запустить сервис локально (сначала `build`, потом бинарник).

* `make docker-up` / `make docker-down`
  Поднять/остановить ES-кластер и Kibana через `docker-compose.yml`.

* `make clean`
  Удалить артефакты сборки.

---

## 🧪 Переменные окружения

Создайте файл `.env` в корне с такими ключами:

```env
# Elasticsearch
ES_PORT=
ELASTIC_USER=
ELASTIC_PASSWORD=

# ES cluster settings
STACK_VERSION=
CLUSTER_NAME=
LICENSE=
MEM_LIMIT=

# HTTP-пул
ES_MAX_IDLE_CONNS=
ES_MAX_IDLE_CONNS_PER_HOST=
ES_IDLE_CONN_TIMEOUT=

# (Опционально) Kibana
KIBANA_PORT=

# Kafka

KAFKA_USERNAME=
KAFKA_PASSWORD=
KAFKA_BOOTSTRAP_SERVERS=
KAFKA_USE_TLS=

KAFKA_CONSUMER_GROUP_ID=
KAFKA_CONSUMER_USER_ORDER_TOPIC=
KAFKA_CONSUMER_START_OFFSET=
KAFKA_CONSUMER_COMMIT_INTERVAL=
KAFKA_CONSUMER_MIN_BYTES=
KAFKA_CONSUMER_MAX_BYTES=

KAFKA_CONSUMER_WORKERS=
KAFKA_PRODUCER_WORKERS=

PROMETHEUS_PORT=
GRAFANA_PORT=
GF_ADMIN_USER=
GF_ADMIN_PASSWORD=

```
---
````markdown
# 🛍️ Product Search Microservice

Микросервис **product-search** обеспечивает индексацию и полнотекстовый поиск товаров с поддержкой:

* 🔄 **Массовой** и **инкрементальной** индексации через Kafka-сообщения  
* 🔍 **Фильтрации** по категориям, бренду и ценовым диапазонам  
* 🔀 **Сортировки** по релевантности, цене и популярности  
* 📑 **Пагинации** и **подсветки** (highlighting) найденных фрагментов  
* 📊 **Фасетной навигации** (aggregation buckets)  
* 📈 **Metrics & Monitoring**: Prometheus-метрики, Grafana-дашборды, статус кластера ES  

---

## 🚀 Возможности

* 🔄 **Bulk / Incremental Indexing** — через Kafka consumer  
* 🔍 **Search API** с JSON-запросом (multi_match, фильтры, sort, from/size)  
* ✨ **Highlighting** ключевых слов в полях `name` и `description`  
* 📊 **Facet Aggregations** по `category` и `brand`  
* ❤️‍🔥 **Cluster Health** (`GET /product/health`) + ES-метрики  
* 📈 **Prometheus Endpoint** (`GET /metrics`) для сбора всех метрик  
* 📦 **Docker Compose** для Elasticsearch (3-node) и Kibana  
* 🧩 **Clean Architecture** (domain, use_cases, transport, infrastructure)  

---

## ⚙️ Технологии

* **Go**  
* **gin-ginic/gin** (REST API + middleware для метрик)  
* **github.com/elastic/go-elasticsearch/v8**  
* **github.com/segmentio/kafka-go** (Kafka consumer)  
* **github.com/prometheus/client_golang** + **promhttp**  
* **Docker & Docker Compose**  
* **Clean Architecture**  

---

## 🛠 Makefile

В корне проекта есть `Makefile`:

| Цель              | Описание                                             |
|-------------------|------------------------------------------------------|
| `make help`       | Показать список целей                                |
| `make deps`       | Установить Go-модули и инструменты (swag, protoc)    |
| `make build`      | Скомпилировать бинарник в `bin/product-search`       |
| `make run`        | Сборка и запуск сервиса локально                     |
| `make docker-up`  | Поднять ES-кластер и Kibana через `docker-compose`   |
| `make docker-down`| Остановить контейнеры                                |
| `make clean`      | Очистить артефакты сборки                            |

---

## 🐳 Docker & Docker Compose

Файл `docker-compose.yml` поднимает:

* **setup**: генерирует CA и node-сертификаты  
* **es01/es02/es03**: трёхнодовый ES-кластер (без HTTP-SSL)  
* **kibana**: UI для просмотра индексов  

---

## 🧪 Переменные окружения

Создайте `.env` с:

```env
# Elasticsearch
ES_PORT=
ELASTIC_USER=
ELASTIC_PASSWORD=

# ES cluster settings
STACK_VERSION=
CLUSTER_NAME=
LICENSE=
MEM_LIMIT=

# HTTP-пул
ES_MAX_IDLE_CONNS=
ES_MAX_IDLE_CONNS_PER_HOST=
ES_IDLE_CONN_TIMEOUT=

# Kafka
KAFKA_USERNAME=
KAFKA_PASSWORD=
KAFKA_BOOTSTRAP_SERVERS=
KAFKA_USE_TLS=
KAFKA_CONSUMER_GROUP_ID=
KAFKA_CONSUMER_START_OFFSET=
KAFKA_CONSUMER_COMMIT_INTERVAL=
KAFKA_CONSUMER_MIN_BYTES=
KAFKA_CONSUMER_MAX_BYTES=
KAFKA_CONSUMER_WORKERS=
KAFKA_PRODUCER_WORKERS=
````

---

## 📡 Monitoring

### 1. `/metrics`

Экспортирует все Prometheus-метрики вашего приложения:

* HTTP: общее число запросов и гистограммы времени ответа
* ES: число и длительность операций (`Save`, `Search`, `BulkSave`, `Delete`, `Health`)
* ES: статус кластера (`0=red,1=yellow,2=green`), количество активных/relocating/unassigned шаров

### 2. Промetheus

В `prometheus.yml` добавьте:

```yaml
scrape_configs:
  - job_name: 'product_search'
    metrics_path: /metrics
    static_configs:
      - targets: ['<HOST>:<PORT>']
```

Проверьте на [http://localhost:9090](http://localhost:9090) → **Status → Targets**, что `product_search` UP.

### 3. Grafana

1. Откройте Grafana ([http://localhost:3000](http://localhost:3000)), добавьте **Prometheus** как Data Source (`http://localhost:9090`).
2. Создайте Dashboard или **Import** готовый JSON:

    * **QPS per endpoint**:

      ```promql
      rate(product_search_http_requests_total[1m])
      ```
    * **HTTP Error Rate**:

      ```promql
      sum(rate(product_search_http_requests_total{status!="200"}[5m])) 
      / sum(rate(product_search_http_requests_total[5m]))
      ```
    * **P95 HTTP Latency**:

      ```promql
      histogram_quantile(0.95, sum by(le, handler) (
        rate(product_search_http_request_duration_seconds_bucket[5m])
      ))
      ```
    * **ES Cluster Status**:

      ```promql
      product_search_elastic_cluster_status
      ```
    * **Shards**:

      ```promql
      product_search_elastic_active_shards
      product_search_elastic_relocating_shards
      product_search_elastic_unassigned_shards
      ```
3. Настройте **time range** (Last 1h) и **Auto-refresh** (15s).

---

## 🔌 API Endpoints

### POST `/product/search`

Поиск товаров
**Request** (`application/json`):

```go
{
  "query": "laptop",                          // строка поиска
  "categories": ["electronics","computers"],  // фильтр по категориям
  "brand": ["Dell","HP"],                     // фильтр по брендам
  "minPrice": 500,                            // минимальная цена
  "maxPrice": 2000,                           // максимальная цена
  "sortBy": "price",                          // поле для сортировки ("relevance" | "price" | "popularity")
  "sortOrder": "asc",                         // порядок сортировки ("asc" | "desc")
  "page": 1,                                  // номер страницы (начиная с 1)
  "pageSize": 10,                             // размер страницы (кол-во элементов)
  "highlightFields": ["name","description"]   // поля, в которых подсвечивать совпадения
}
```

**Response** (`200 OK`, `application/json`):

```go
{
  "Products":[
    {"Id":"1","Name":"Dell XPS 13","Description":"...","Price":999,"Stock":42,"Category":"electronics","Brand":"Dell"},
    // ...
  ],
  "Total": 42,
  "Page": 1,
  "Page_size": 10,
  "Highlights": {"1":["<em>Dell</em> XPS 13"]},
  "Facets": {
    "Category":[{"key":"electronics","count":42}],
    "Brand":[{"key":"Dell","count":23}]
  }
}
```

### GET `/product/health`

Проверка состояния кластера
**Response** (`200 OK`, `application/json`):

```json
{
  "status":"green",
  "active_shards":3,
  "relocating_shards":0,
  "unassigned_shards":0,
  "timed_out":false
}
```


---

## 📝 DTO

Все HTTP-DTO лежат в `transport/rest/product/product_dto`:

```go
// SearchRequest — параметры поиска
type SearchRequest struct {
Query           string   `json:"query"`
Categories      []string `json:"categories"`
Brand           []string `json:"brand"`
MinPrice        float64  `json:"minPrice"`
MaxPrice        float64  `json:"maxPrice"`
SortBy          string   `json:"sortBy"`
SortOrder       string   `json:"sortOrder"`
Page            int      `json:"page"`
PageSize        int      `json:"pageSize"`
HighlightFields []string `json:"highlightFields"`
}

// ProductRequest — параметры одного продукта
type ProductRequest struct {
ID          string  `json:"id"`
Name        string  `json:"name"`
Description string  `json:"description"`
Price       float64 `json:"price"`
Stock       int     `json:"stock"`
Category    string  `json:"category"`
Brand       string  `json:"brand"`
}

// HealthResponse — ответ health
type HealthResponse struct {
  Status           string `json:"status"`
  ActiveShards     int64  `json:"active_shards"`
  RelocatingShards int64  `json:"relocating_shards"`
  UnassignedShards int64  `json:"unassigned_shards"`
  TimedOut         bool   `json:"timed_out"`
}
```

---

## 📚 Swagger Documentation

1. Установите `swag`:

   ```bash
   go install github.com/swaggo/swag/cmd/swag@latest
   ```

2. Сгенерируйте docs:

   ```bash
   swag init -g cmd/search_service/main.go
   ```

3. Swagger UI доступен по адресу:

   ```
   http://localhost:8080/swagger/index.html
   ```

---

## 🙌 Логирование

Везде используется `log` с префиксами:

| Префикс                   | Слой                     |
| ------------------------- | ------------------------ |
| `[transport]`             | HTTP-хендлеры (gin)      |
| `[use_cases]`             | Бизнес-логика            |
| `[repository]`            | ES-репозитории           |
| `[kafka_product_service]` | Kafka consumer service   |
| `[elasticsearch]`         | Подключение и ping       |
| `[db]`                    | Инициализация соединений |

**Пример:**

```
[transport] SearchProducts called
[use_cases] SearchProducts succeeded: found 42 items
[repository] Bulk save succeeded for 5 products
[kafka_product_service][consumer-0] message processed successfully
```
