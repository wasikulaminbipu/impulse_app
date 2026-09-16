# Google Play Developer API Quotas, Concurrency & Rate Limits Guide

This guide details managing Google Play Developer API v3 quotas, edit session lifecycles, and concurrency errors during automated Fastlane `upload_to_play_store` deployments.

---

## 1. Google Play Developer API Limits

| Resource | Default Quota | Failure Symptom |
|---|---|---|
| **Daily API Requests** | 200,000 queries/day | `Google::Apis::RateLimitError: Daily Limit Exceeded` |
| **Simultaneous App Edits** | Exactly **1 active edit** per package | `Google::Apis::ClientError: An edit with this ID already exists or is in progress` |
| **Edit Session Inactivity Timeout** | ~10 minutes | `Google::Apis::ClientError: The edit has expired` |
| **Artifact Upload Bandwidth** | 100 uploads / hour | HTTP 429 Too Many Requests |

---

## 2. Preventing Concurrent Edit Collisions

When multiple CI/CD pipelines trigger simultaneously (e.g. rapid pushes to `main` or merge queues):
- Google Play API locks the package to a single active edit session.
- Secondary pipelines trying to open an edit fail immediately with `400 Bad Request: Edit conflict`.

### Remediation in Fastlane / CI:

#### A. Concurrency Control in GitHub Actions
```yaml
concurrency:
  group: deploy-playstore-${{ github.ref }}
  cancel-in-progress: false # Queue or serialize deployment jobs
```

#### B. Fastlane Exponential Backoff Retry Block
Wrap Fastlane supply calls with automatic retry and exponential backoff:

```ruby
def upload_with_retry(max_retries = 3)
  attempts = 0
  begin
    attempts += 1
    yield
  rescue => ex
    if attempts <= max_retries && (ex.message.include?("RateLimitError") || ex.message.include?("edit has expired"))
      delay = attempts * 15
      UI.important("⚠️ Google Play API transient error. Retrying in #{delay}s (attempt #{attempts}/#{max_retries})...")
      sleep(delay)
      retry
    else
      raise ex
    end
  end
end

lane :deploy_with_backoff do
  upload_with_retry(3) do
    upload_to_play_store(
      track: "internal",
      aab: "../build/app/outputs/bundle/release/app-release.aab",
      timeout: 1200 # Extend socket timeout to 20 minutes for large AABs
    )
  end
end
```

---

## 3. Discarding Stale Edits

If a failed CI job aborts mid-flight without committing its edit:
- The Google Play Console may hold the edit session until it times out.
- Fastlane can be instructed to clean up and ignore uncommitted edits:

```ruby
upload_to_play_store(
  track: "beta",
  aab: aab_path,
  # Ensure uncommitted edits are automatically handled
  skip_upload_metadata: true,
  skip_upload_images: true,
  skip_upload_screenshots: true
)
```
