# In-App Purchases (IAP) & Subscription Sync via Fastlane

This guide explains how to manage, version-control, and synchronize in-app purchases (consumables, non-consumables) and recurring subscriptions across Google Play Console and Apple App Store using Fastlane and declarative JSON/CSV configs.

---

## 1. Declarative In-App Product Catalog

Rather than manually clicking through App Store Connect and Google Play Console web dashboards, define your digital catalog in version-controlled JSON files:

`config/iap_products.json`:
```json
[
  {
    "sku": "dex_pro_monthly",
    "type": "subscription",
    "period": "P1M",
    "free_trial": "P7D",
    "prices": {
      "US": "4.99",
      "BD": "499.00",
      "IN": "399.00"
    },
    "titles": {
      "en-US": "Impulse DEX Pro Monthly",
      "bn-BD": "ইমপালস ডেক্স প্রো মাসিক"
    },
    "descriptions": {
      "en-US": "Unlimited offline exports, custom price sheets, priority sync.",
      "bn-BD": "সীমাহীন অফলাইন এক্সপোর্ট, কাস্টম রেট শিট এবং অগ্রাধিকার সিঙ্ক।"
    }
  },
  {
    "sku": "dex_export_pack_100",
    "type": "inapp",
    "consumable": true,
    "prices": {
      "US": "0.99",
      "BD": "100.00"
    },
    "titles": {
      "en-US": "100 Export Credits",
      "bn-BD": "১০০ এক্সপোর্ট ক্রেডিট"
    }
  }
]
```

---

## 2. Google Play In-App Product Sync with Fastlane

Google Play Developer API v3 exposes the `inappproducts` endpoint. Fastlane can automate synchronization of SKUs, pricing, and localized titles:

```ruby
desc "Sync In-App Products with Google Play Console"
lane :sync_play_iap do
  require "google/apis/androidpublisher_v3"
  
  service = Google::Apis::AndroidpublisherV3::AndroidPublisherService.new
  # Authorize using service account JSON key
  # ...
  
  catalog = JSON.parse(File.read("../../config/iap_products.json"))
  
  catalog.each do |item|
    product = Google::Apis::AndroidpublisherV3::InAppProduct.new(
      package_name: "com.impulse.dex",
      sku: item["sku"],
      status: "active",
      purchase_type: item["type"] == "subscription" ? "subscription" : "managedUser",
      default_price: { price_micros: (item["prices"]["US"].to_f * 1_000_000).to_i, currency: "USD" },
      listings: {
        "en-US" => { title: item["titles"]["en-US"], description: item["descriptions"]["en-US"] },
        "bn-BD" => { title: item["titles"]["bn-BD"], description: item["descriptions"]["bn-BD"] }
      }
    )
    
    # Insert or update SKU
    # service.insert_inappproduct(package_name, product)
    UI.message("Synchronized SKU: #{item['sku']}")
  end
end
```

---

## 3. Apple App Store IAP Sync with `deliver`

Apple App Store Connect supports uploading IAP metadata via Fastlane `deliver`:

```ruby
lane :sync_appstore_iap do
  deliver(
    skip_binary_upload: true,
    skip_screenshots: true,
    skip_metadata: true,
    # In-app purchase configuration folder
    # fastlane/in_app_purchases/
  )
end
```

---

## 4. Best Practices & Policy Verification

1. **Grace Periods & Account Holds**:
   - Google Play policy mandates offering a grace period (e.g. 16 days for monthly, 30 days for yearly) and account hold for subscriptions.
2. **Pricing Consistency**:
   - Keep local tax-inclusive pricing aligned across currencies using Google Play's auto-converted exchange rates.
3. **Restoration Testing in Beta**:
   - Validate receipt validation and transaction restore flows in Closed Beta tracks before promoting to production.
