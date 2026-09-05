# CI/CD Security Hardening & Secrets Management Guide

Enterprise security specifications, secret rotation runbooks, least-privilege IAM policies, and script injection defenses for GitHub Actions and Google Play Console.

---

## 1. Principle of Least Privilege in GitHub Actions

GitHub Actions workflows should request only the minimal token permissions required for their specific jobs.

### Workflow Permissions Matrix

| Workflow | Job | Required Permissions | Justification |
| :--- | :--- | :--- | :--- |
| `pr_ci.yml` | `quality-gate` | `contents: read` | Code checkout only. |
| `pr_ci.yml` | `test-suite` | `contents: read`<br/>`pull-requests: write` | Read source and post/update coverage sticky comments on PR. |
| `deploy_playstore.yml` | `quality-gate` | `contents: read` | Code checkout only. |
| `deploy_playstore.yml` | `test-suite` | `contents: read` | Code checkout only. |
| `deploy_playstore.yml` | `build-release-artifacts` | `contents: read` | Compile and upload artifacts. |
| `deploy_playstore.yml` | `deploy-google-play` | `contents: read` | Fastlane API upload. |
| `deploy_playstore.yml` | `publish-github-release` | `contents: write` | Create official GitHub release and upload binary assets. |
| `promote_release.yml` | `promote` | `contents: read` | Execute Fastlane promotion lane. |
| `weekly_maintenance.yml` | `audit` | `contents: read` | Scan dependencies and assets. |

---

## 2. Secrets Management & Sanitization

### A. Repository Secrets Specification

| Secret | Permitted Scope | Secret Rotation Frequency |
| :--- | :--- | :--- |
| `PLAYSTORE_UPLOAD_KEYSTORE_BASE64` | Production deployment runners only | Annual / on compromise |
| `PLAYSTORE_KEY_PROPERTIES` | Production deployment runners only | Annual / on compromise |
| `PLAYSTORE_SERVICE_ACCOUNT_JSON` | Deployment and promotion runners | Annual / on GCP service account key expiry |

### B. Secure Runner Decoding Pattern
Always sanitize base64 strings against whitespace and newline corruption before decoding:
```bash
printf '%s' "${{ secrets.PLAYSTORE_UPLOAD_KEYSTORE_BASE64 }}" | tr -d ' \r\n' | base64 --decode > android/app/key.p12
cp android/app/key.p12 android/key.p12 2>/dev/null || true

if [ -n "${{ secrets.PLAYSTORE_KEY_PROPERTIES }}" ]; then
  printf '%s\n' "${{ secrets.PLAYSTORE_KEY_PROPERTIES }}" > android/key.properties
fi

if [ -n "${{ secrets.PLAYSTORE_SERVICE_ACCOUNT_JSON }}" ]; then
  printf '%s\n' "${{ secrets.PLAYSTORE_SERVICE_ACCOUNT_JSON }}" > android/pc-api-key.json
fi
```

### C. Keystore Clean-Up / Teardown
To prevent residual keys on self-hosted or pooled runners:
```bash
- name: Clean Up Release Credentials
  if: always()
  run: |
    rm -f android/app/key.p12 android/key.p12 android/key.properties android/pc-api-key.json
```

---

## 3. Defense Against Script & Expression Injection

Never directly interpolate untrusted context variables (`github.event.pull_request.title`, `github.event.head_commit.message`, `github.head_ref`) into inline bash scripts.

### ❌ Vulnerable to Injection
```yaml
# DANGEROUS: PR title containing `"; rm -rf /; echo "` will execute arbitrary shell commands
run: echo "PR Title: ${{ github.event.pull_request.title }}"
```

### ✅ Secure: Environment Variable Assignment
```yaml
# SAFE: GitHub Actions passes the value as a safe environment variable
env:
  PR_TITLE: ${{ github.event.pull_request.title }}
run: echo "PR Title: $PR_TITLE"
```

---

## 4. Google Play Console Service Account Least-Privilege Roles

In Google Play Console **API Access > Permissions**, configure the service account with only:
- **Releases**:
  - *View app information (read-only)*: `Enabled`
  - *Create, edit, and delete draft apps*: `Enabled`
  - *Release apps to testing tracks*: `Enabled`
  - *Release apps to production*: `Enabled`
- **Store presence**:
  - *Manage store presence*: `Enabled` (for localized metadata)
- **Financial & User Data**:
  - *View financial data*: `Disabled`
  - *Manage orders and subscriptions*: `Disabled`
  - *Reply to reviews*: `Disabled`
