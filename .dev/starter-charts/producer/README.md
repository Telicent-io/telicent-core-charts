# Telicent Helm Starter Chart for Kubernetes Jobs

This is a Helm starter chart designed for data engineers to quickly create Kubernetes Jobs for data processing tasks.

## Quick Start

### Prerequisites

- Helm 3.x installed
- Access to a Kubernetes cluster
- kubectl configured for your cluster

### Creating a New Chart

Use this starter chart to create a new chart for your data processing job:

```bash
helm create -p ~/Projects/telicent-helm-starters my-data-job
cd my-data-job
```

Replace `my-data-job` with your desired chart name.

### Essential Configuration

After creating your chart, edit the `values.yaml` file and configure these essential settings:

#### 1. Container Image
```yaml
image:
  registry: "quay.io"
  repository: "your-org/your-data-processor"  # Change this!
  tag: "v1.0.0"  # Use specific versions in production
```

#### 2. Environment Variables
```yaml
env:
  LOG_LEVEL: "INFO"
  DATA_SOURCE: "s3://my-bucket/input-data"
  OUTPUT_PATH: "/tmp/output"
  # Add your custom environment variables here
```

### Deploying Your Job

```bash
# Install the job
helm install my-job-release .

# Check job status
kubectl get jobs

# View logs
kubectl logs job/my-job-release
```

### Advanced Configuration

#### Job Behavior
```yaml
job:
  activeDeadlineSeconds: 3600  # 1 hour timeout
  backoffLimit: 3              # Retry 3 times on failure
  completions: 1               # Run once successfully
  parallelism: 1               # Single pod
  ttlSecondsAfterFinished: 86400  # Clean up after 24 hours
```

#### Resource Limits
```yaml
resources:
  limits:
    cpu: 2000m     # 2 CPU cores
    memory: 4Gi    # 4 GB RAM
  requests:
    cpu: 100m      # Minimum 0.1 CPU
    memory: 128Mi  # Minimum 128 MB
```

#### Security Context
```yaml
podSecurityContext:
  runAsNonRoot: true
  runAsUser: 1000
  fsGroup: 1000

securityContext:
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: false
  capabilities:
    drop:
    - ALL
```

### Working with Kafka

If your job processes Kafka data, configure the global Kafka settings:

```yaml
global:
  kafka:
    bootstrapServers: "kafka-bootstrap.kafka.svc.cluster.local:9092"
    existingConfigSecretName: "kafka-config-secret"  # Optional: use existing secret
```

### Storage and Volumes

To mount additional storage:

```yaml
volumes:
  - name: data-storage
    persistentVolumeClaim:
      claimName: my-data-pvc

volumeMounts:
  - name: data-storage
    mountPath: /data
```

### Examples

#### Simple Python Data Processing Job
```yaml
image:
  repository: "my-org/python-processor"
  tag: "latest"

env:
  PYTHONPATH: "/app"
  INPUT_FILE: "/data/input.csv"
  OUTPUT_FILE: "/data/output.csv"

resources:
  requests:
    cpu: 500m
    memory: 1Gi
  limits:
    cpu: 1000m
    memory: 2Gi
```

#### Spark Job
```yaml
image:
  repository: "my-org/spark-job"
  tag: "3.4.0"

env:
  SPARK_MASTER: "k8s://https://kubernetes.default.svc:443"
  SPARK_DRIVER_MEMORY: "1g"
  SPARK_EXECUTOR_MEMORY: "2g"

resources:
  requests:
    cpu: 1000m
    memory: 3Gi
  limits:
    cpu: 2000m
    memory: 6Gi
```

## Best Practices for data engineers

1. **Use Specific Image Tags**: Always use specific version tags instead of `latest` for reproducible results.

2. **Set Resource Limits**: Configure appropriate CPU and memory limits to prevent resource contention.

3. **Use Environment Variables**: Store configuration in environment variables rather than hardcoding in your application.

4. **Monitor Job Progress**: Use `kubectl logs` to monitor your job's progress and debug issues.

5. **Clean Up**: Set `ttlSecondsAfterFinished` to automatically clean up completed jobs.

6. **Test Locally**: Test your container images locally before deploying to Kubernetes.

## Troubleshooting

### Job Fails Immediately
- Check your image name and tag
- Verify your container registry access
- Review the pod logs for error messages

### Out of Memory Errors
- Increase memory limits in `resources.limits.memory`
- Optimize your data processing code
- Consider processing data in smaller chunks

### Timeout Issues
- Increase `activeDeadlineSeconds`
- Optimize your processing logic
- Consider breaking large jobs into smaller tasks

### Access Issues
- Check service account permissions
- Verify network policies
- Review security contexts

## Getting Help

- Check the [Kubernetes Jobs documentation](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
- Review [Helm documentation](https://helm.sh/docs/)
- Contact the Telicent data engineering team for support

## Chart Structure

```
my-data-job/
├── Chart.yaml              # Chart metadata
├── values.yaml             # Default configuration
├── templates/
│   ├── _helpers.tpl        # Template helpers
│   ├── job.yaml            # Main job definition
│   ├── serviceaccount.yaml # Service account
│   └── NOTES.txt          # Post-install notes
└── README.md              # This file
```
