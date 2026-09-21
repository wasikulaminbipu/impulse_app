# Security Policy

Impulse DEX takes security and data integrity seriously. This document outlines our security policies, supported versions, and how to report vulnerabilities responsibly.

---

## Supported Versions

Only the latest release branch and official Google Play Store releases receive active security updates.

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0.0 | :x:                |

---

## Reporting a Vulnerability

If you discover a security vulnerability, please do **NOT** open a public issue on GitHub. Instead, report it confidentially using one of the following methods:

1. **GitHub Private Vulnerability Reporting**:
   - Navigate to the **Security** tab of this repository.
   - Click **Report a vulnerability** to submit an advisory draft privately to maintainers.

2. **Direct Email**:
   - Email: `security@impulseagrisciencelimited.com`
   - Subject: `[SECURITY] Potential vulnerability in Impulse App`
   - Include:
     - Description of the issue and potential impact
     - Steps to reproduce or a minimal proof-of-concept (PoC)
     - Device, OS version, and app version tested

---

## Response & Disclosure Timeline

- **Initial Acknowledgment**: Within 48 hours of receipt.
- **Triage & Assessment**: Within 5 business days.
- **Fix & Remediation**: Deployed via GitHub Actions CI/CD and released to Google Play Store.
- **Public Disclosure**: Coordinated with the reporter after a fix has been published.

---

## Security Practices in this Codebase

- **No Remote Credentials**: Zero API secrets, keystores, or private tokens in tracked git history.
- **Strict HTTPS**: Enforced via Android Network Security Config (`network_security_config.xml`).
- **Data Sandboxing**: Internal SQLite database files excluded from cloud and ADB backups.
- **Static Analysis**: Enforced zero fatal warnings/lints via CI/CD gates.
- **Secret Scanning**: Automated scans on every commit via Gitleaks.
