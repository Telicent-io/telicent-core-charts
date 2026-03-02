#
# Data Sharing gRPC Client - Configuration
#
# ── Connection ──────────────────────────────────────────────────────────

# Unique client identifier (used for offset tracking and server logging)
client.name=my-client

# gRPC server hostname
server.host=data-sharing-server

# gRPC server port
server.port=8080

# ── TLS / mTLS ──────────────────────────────────────────────────────────
# Enable TLS for the gRPC channel (default: false)
tls.enabled=false

# Enable mutual TLS authentication; requires tls.enabled=true (default: false)
mTLSAuth.enabled=false

# Path to custom CA PEM bundle for server verification (mTLS only; empty = system defaults)
tls.ca.pem=

# Path to client certificate PEM file (required when mTLSAuth.enabled=true)
tls.client.pem=

# Path to client private key file (required when mTLSAuth.enabled=true)
tls.client.key=

# ── gRPC Channel Tuning ────────────────────────────────────────────────

# Keep-alive ping interval in seconds (default: 30)
client.keepAliveTime.secs=30

# Keep-alive ping timeout in seconds (default: 10)
client.keepAliveTimeout.secs=10

# Idle channel timeout in seconds (default: 10)
client.idleTimeout.secs=10

# ── Retry Logic ─────────────────────────────────────────────────────────

# Maximum retry attempts; 0 = unlimited (default: 200)
retries.max_attempts=200

# Initial backoff in milliseconds; doubles each retry (default: 500)
retries.initial_backoff=500

# Maximum backoff ceiling in milliseconds (default: 60000)
retries.max_backoff=60000

# Keep running after successful processing to poll for new data (default: true)
retries.forever=true

# ── Kafka (Local Producer) ──────────────────────────────────────────────

# Kafka bootstrap servers
kafka.bootstrapServers=localhost:9092

# Kafka consumer group
kafka.consumerGroup=my-consumer-group

# Key serializer class for the local Kafka producer
kafka.sender.defaultKeySerializerClass=org.apache.kafka.common.serialization.BytesSerializer

# Value serializer class for the local Kafka producer
kafka.sender.defaultValueSerializerClass=org.apache.kafka.common.serialization.BytesSerializer

# Suffix appended to topic names when producing locally (format: {topic}-{client}{suffix})
kafka.topic.suffix=-staging

# Path to Kafka SASL/SSL auth properties file (empty = no auth)
kafka.auth.filepath=

# ── Authorization Storage ───────────────────────────────────────────────

# Path to the storage configuration properties file (message consumption offset store)
ds.authz.config.filepath=/app/config/storage.properties
