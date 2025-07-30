param(
    [Parameter(Mandatory = $true)]
    [string]$CommitMessage
)

# Project code pattern - should start with project code and work item number
$pattern = "^[A-Z]+-\d+\s+.+"

if ($CommitMessage -match $pattern) {
    Write-Host "✅ Commit message validation passed: $CommitMessage" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ Commit message validation failed!" -ForegroundColor Red
    Write-Host "Expected format: {ProjectCode}-{WorkItemNumber} Your comment" -ForegroundColor Yellow
    Write-Host "Example: ADO-123 Fix database connection issue" -ForegroundColor Yellow
    Write-Host "Actual message: $CommitMessage" -ForegroundColor Red
    exit 1
}