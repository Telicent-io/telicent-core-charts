#
# Data Preparation Engine - Configuration
#
# ── Core ────────────────────────────────────────────────────────────────

# Kafka Streams application ID (env: APPLICATION_ID)
application.id=streams-data-prep

# Kafka bootstrap servers (env: BOOTSTRAP_SERVERS)
bootstrap.servers=localhost:9092

# Input topic to consume from (env: TOPIC_INPUT)
topic.input=streams-input

# Output topic to produce to (env: TOPIC_OUTPUT)
topic.output=streams-output

# Dead letter queue topic for failed messages (env: TOPIC_DEAD_LETTER)
topic.deadletter=streams-dlq

# Path to Kafka SASL/SSL auth properties file; key must exist, value can be empty (env: KAFKA_AUTH_FILEPATH)
kafka.auth.filepath=

# ── Filter ──────────────────────────────────────────────────────────────

# Filter type: "idh" or "header" (env: FILTER_TYPE)
filter.type=idh

# ── IDH Filter Properties (filter.type=idh) ────────────────────────────

# IDH specification version (env: CLIENT_VERSION)
client.version=1.0

# Space-separated nationality codes; empty = no restriction (env: CLIENT_NATIONALITY)
client.nationality=GBR

# Security classification level (env: CLIENT_CLASSIFICATION)
client.classification=S

# Space-separated organisation codes; empty = no restriction (env: CLIENT_ORG)
client.organisation=

# Space-separated group names; empty = no restriction (env: CLIENT_GROUP)
client.group=

# ── Header Filter Properties (filter.type=header) ──────────────────────
# Define include/exclude rules using prefix conventions.
# Header names are CASE-SENSITIVE in line with the Kafka header specification.
#   header.filter.include.{header-name}=value  (env: HEADER_FILTER_INCLUDE_{HEADER_NAME})
#   header.filter.exclude.{header-name}=value  (env: HEADER_FILTER_EXCLUDE_{HEADER_NAME})
# Example:
# header.filter.include.Content-Type=application/json
# header.filter.exclude.Event-Type=audit

# ── Transformer ─────────────────────────────────────────────────────────

# Transformer type: "distribution-id" (env: TRANSFORMER_TYPE)
transformer.type=distribution-id

# Distribution ID injected as a "Distribution-Id" Kafka header (env: DISTRIBUTION_ID)
distribution.id=ABC-DEF-GHI
