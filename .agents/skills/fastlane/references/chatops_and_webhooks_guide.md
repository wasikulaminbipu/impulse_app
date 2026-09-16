# ChatOps & Multi-Platform Webhooks Guide for Fastlane

This guide details configuring automated deployment announcements and incident alerts to Slack, Discord, Microsoft Teams, and Telegram directly from Fastlane lifecycle hooks without requiring extra gem dependencies.

---

## 1. Fastlane Native Slack Integration

Fastlane has built-in support for Slack incoming webhooks:

```ruby
# In Fastfile after_all hook
after_all do |lane|
  version = load_flutter_version
  
  if ENV["SLACK_URL"]
    slack(
      message: "🚀 Successfully published *v#{version[:name]} (Build #{version[:code]})* to `#{lane}` track!",
      channel: "#mobile-releases",
      success: true,
      payload: {
        "Platform"   => "Android / Google Play",
        "Author"     => `git log -1 --pretty=format:'%an'`.strip,
        "Commit"     => `git log -1 --pretty=format:'%h: %s'`.strip,
        "Play Store" => "https://play.google.com/store/apps/details?id=com.impulseagriscienceltd.impulse_app"
      },
      default_payloads: [:git_branch, :last_git_commit_hash]
    )
  end
end
```

---

## 2. Discord Webhooks (Zero Extra Gems)

Discord accepts rich embedded cards via standard JSON POST requests using Ruby's standard library (`net/http` and `json`):

```ruby
require "net/http"
require "json"
require "uri"

def send_discord_notification(title, description, color_hex, fields = [])
  webhook_url = ENV["DISCORD_WEBHOOK_URL"]
  return unless webhook_url && !webhook_url.empty?

  uri = URI.parse(webhook_url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  payload = {
    username: "Impulse CI/CD Bot",
    avatar_url: "https://raw.githubusercontent.com/impulse/assets/main/bot_avatar.png",
    embeds: [
      {
        title: title,
        description: description,
        color: color_hex.to_i(16),
        fields: fields,
        footer: { text: "Impulse DEX Automated Fastlane Pipeline" },
        timestamp: Time.now.utc.iso8601
      }
    ]
  }

  req = Net::HTTP::Post.new(uri.path, { "Content-Type" => "application/json" })
  req.body = payload.to_json
  http.request(req)
rescue => ex
  UI.important("⚠️ Failed to deliver Discord webhook: #{ex.message}")
end
```

Using in `after_all` and `error`:
```ruby
after_all do |lane|
  v = load_flutter_version
  send_discord_notification(
    "✅ Deployment Succeeded: #{lane.to_s.upcase}",
    "Successfully distributed version **v#{v[:name]} (Build #{v[:code]})** to Google Play!",
    "2ECC71", # Emerald Green
    [
      { name: "Track", value: lane.to_s, inline: true },
      { name: "Branch", value: `git rev-parse --abbrev-ref HEAD`.strip, inline: true }
    ]
  )
end

error do |lane, exception|
  send_discord_notification(
    "❌ Deployment Failed: #{lane.to_s.upcase}",
    "Fastlane encountered an error: ```#{exception.message}```",
    "E74C3C" # Ruby Red
  )
end
```

---

## 3. Microsoft Teams Webhook Example

```ruby
def send_teams_alert(title, message, is_success)
  webhook_url = ENV["TEAMS_WEBHOOK_URL"]
  return unless webhook_url && !webhook_url.empty?

  uri = URI.parse(webhook_url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  payload = {
    "@type" => "MessageCard",
    "@context" => "http://schema.org/extensions",
    "themeColor" => is_success ? "0076D7" : "D8000C",
    "summary" => title,
    "sections" => [{
      "activityTitle" => title,
      "activitySubtitle" => "Fastlane Automated Mobile Pipeline",
      "text" => message
    }]
  }

  req = Net::HTTP::Post.new(uri.request_uri, { "Content-Type" => "application/json" })
  req.body = payload.to_json
  http.request(req)
rescue => ex
  UI.important("⚠️ Teams webhook failed: #{ex.message}")
end
```
