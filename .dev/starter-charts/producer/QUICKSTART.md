# Quick Start Guide for Data

## 🚀 Getting Started in 3 Steps

### Step 1: Create Your Chart
```bash
helm create -p ~/Projects/telicent-helm-starters my-data-job
cd my-data-job
```

### Step 2: Configure Your Job
Edit `values.yaml` and update these key sections:

```yaml
# Your container image
image:
  repository: "your-org/your-image-name"
  tag: "v1.0.0"

# Your environment variables
env:
  INPUT_DATA: "/data/input.csv"
  OUTPUT_PATH: "/data/results"
  LOG_LEVEL: "INFO"
```

### Step 3: Deploy and Run
```bash
# Deploy your job
helm install my-job .

# Check status
kubectl get jobs

# View logs
kubectl logs job/my-job
```


## 🛠️ Troubleshooting

| Problem | Solution |
|---------|----------|
| Job fails to start | Check image name and registry access |
| Out of memory | Increase `resources.limits.memory` |
| Takes too long | Increase `job.activeDeadlineSeconds` |
| Need more retries | Increase `job.backoffLimit` |

## 📞 Getting Help

- Check logs: `kubectl logs job/your-job-name`
- Describe job: `kubectl describe job your-job-name`
- Contact: data-science@telicent.io
