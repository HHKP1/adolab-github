param(
    [Parameter(Mandatory = $true)]
    [string]$CommitMessage
)

# Allow Azure DevOps merge commit messages (these are generated automatically)
if ($CommitMessage -match "^Merge pull request \d+ from .* into .*$" -or
    $CommitMessage -match "^Merged PR \d+:.*$") {
    Write-Host "⚠️  Allowing Azure DevOps merge commit message." -ForegroundColor Yellow
    Write-Host "Message: $CommitMessage" -ForegroundColor Cyan
    exit 0
}

# Allow initial repository setup commits
if ($CommitMessage -eq "Initial commit" -or 
    $CommitMessage -eq "Initialize repository" -or
    $CommitMessage -match "^INIT-\d+ .*$") {
    Write-Host "⚠️  Allowing repository initialization commit." -ForegroundColor Yellow
    Write-Host "Message: $CommitMessage" -ForegroundColor Cyan
    exit 0
}

# Project code pattern - should start with project code and work item number
$pattern = "^[A-Z]+-\d+\s+.+"

if ($CommitMessage -match $pattern) {
    Write-Host "✅ Commit message validation passed: $CommitMessage" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "❌ Commit message validation failed!" -ForegroundColor Red
    Write-Host "Expected format: {ProjectCode}-{WorkItemNumber} Your comment" -ForegroundColor Yellow
    Write-Host "Example: ADO-123 Fix database connection issue" -ForegroundColor Yellow
    Write-Host "Actual message: $CommitMessage" -ForegroundColor Red
    exit 1
}