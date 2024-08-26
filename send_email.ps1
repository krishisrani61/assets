# Define the API key and endpoint
$apiKey = "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"
$apiEndpoint = "https://api.brevo.com/v3/smtp/email"

# Define the email parameters
$toEmail = "ikrish61@gmail.com"
$fromEmail = "dxdiag@brevo-transactional-emails.isranicloud.com"
$subject = "DxDiag Report"

# Read the dxdiag report content
$dxdiagContent = Get-Content -Path "dxdiag.txt" -Raw

# Prepare the email body
$body = "Please find the DxDiag report below:`n`n"
$body += $dxdiagContent

# Create the email payload
$emailPayload = @{
    sender = @{
        email = $fromEmail
    }
    to = @(@{
        email = $toEmail
    })
    subject = $subject
    textContent = $body
}

# Convert the payload to JSON
$emailPayloadJson = $emailPayload | ConvertTo-Json -Compress

# Send the email via Brevo API
$response = Invoke-RestMethod -Uri $apiEndpoint -Method Post -Headers @{ "api-key" = $apiKey; "Content-Type" = "application/json" } -Body $emailPayloadJson

# Check the response
if ($response) {
    Write-Output "Email sent successfully!"
} else {
    Write-Output "Failed to send email."
}
