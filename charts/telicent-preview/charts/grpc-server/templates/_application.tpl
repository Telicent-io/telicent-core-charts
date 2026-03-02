#
# Data Sharing gRPC Server - Configuration
#
# ── Listening ───────────────────────────────────────────────────────────

# gRPC server port (default: 8080)
server.port=8080

# ── TLS / mTLS ──────────────────────────────────────────────────────────

# Enable TLS for the gRPC server (default: false)
server.tlsEnabled=false

# Enable mutual TLS client authentication; requires server.tlsEnabled=true (default: false)
server.mTLSAuth=false

# Path to server certificate chain PEM file (required when server.tlsEnabled=true)
server.certChainFile=

# Path to server private key file (required when server.tlsEnabled=true)
server.privateKeyFile=

# Path to CA PEM file for client certificate verification (enables ClientAuth.REQUIRE)
server.caPem=

# ── gRPC Server Tuning ─────────────────────────────────────────────────

# Keep-alive ping interval in seconds (default: 5)
server.keepAliveTime=5

# Keep-alive ping timeout in seconds (default: 1)
server.keepAliveTimeout=1

# ── Shared Headers ──────────────────────────────────────────────────────

# Kafka headers to include in gRPC messages; '^' separated (default: Content-Type)
shared.headers=Content-Type

# ── Kafka (Source Consumer) ─────────────────────────────────────────────

# Kafka bootstrap servers
kafka.bootstrapServers=localhost:9092

# Kafka consumer group
kafka.consumerGroup=server-consumer

# Key deserializer class for the Kafka consumer
kafka.defaultKeyDeserializerClass=org.apache.kafka.common.serialization.StringDeserializer

# Value deserializer class for the Kafka consumer
kafka.defaultValueDeserializerClass=org.apache.kafka.common.serialization.StringDeserializer

# Maximum records per Kafka poll
kafka.pollRecords=100

# Kafka poll timeout in ISO-8601 duration format (default: PT2S)
kafka.pollDuration=PT2S

# Starting offset; 0 = from beginning (default: 0)
kafka.offset=0

# Path to Kafka SASL/SSL auth properties file (empty = no auth)
kafka.auth.filepath=

# ── Authorization / Storage ─────────────────────────────────────────────

# Path to the storage configuration properties file (data sharing agreement store)
ds.authz.config.filepath=/config/storage.properties

# Cache TTL in seconds for authorization lookups (default: 5)
data.sharing.authz.expiry=5
