# Update WhatsApp Access Token in Lambda (PowerShell)

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "UPDATE WHATSAPP TOKEN" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Get your new token from:" -ForegroundColor Yellow
Write-Host "https://developers.facebook.com/apps" -ForegroundColor Yellow
Write-Host "WhatsApp > API Setup > Temporary access token" -ForegroundColor Yellow
Write-Host ""

$NEW_TOKEN = Read-Host "Enter new WhatsApp token"

if ([string]::IsNullOrWhiteSpace($NEW_TOKEN)) {
    Write-Host "❌ No token provided" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Updating Lambda function..." -ForegroundColor Yellow

$EnvVars = @{
    WHATSAPP_TOKEN = $NEW_TOKEN
    PHONE_NUMBER_ID = "1049535664900621"
    VERIFY_TOKEN = "mySecret_123"
    USE_ANTHROPIC_DIRECT = "true"
    ANTHROPIC_API_KEY = "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"
    OPENWEATHER_API_KEY = "778806f14f0375755d373c9dd5d83b50"
    AGMARKNET_API_KEY = "579b464db66ec23bdd00000119f70d45e4cd49847920b6afd2711c993"
    CROP_HEALTH_API_KEY = "7zcdeWIQkRj5k5DyBLS32bKRtSvlTNw7nfGmWYIl9Hvk41TaVs"
    S3_BUCKET = "kisaanmitra-images"
    CONVERSATION_TABLE = "kisaanmitra-conversations"
    PRICE_FORECAST_TABLE = "kisaanmitra-price-forecasts"
}

$EnvString = ($EnvVars.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join ","

aws lambda update-function-configuration `
  --function-name whatsapp-llama-bot `
  --environment "Variables={$EnvString}" `
  --region ap-south-1

Write-Host ""
Write-Host "✅ Token updated!" -ForegroundColor Green
Write-Host ""
Write-Host "Test by sending 'Hi' to your WhatsApp number" -ForegroundColor Cyan
Write-Host ""
