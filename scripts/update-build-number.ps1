param(
    [Parameter(Mandatory = $true)]
    [string]$BuildId
)

try {
    # Get current date and format
    $date = Get-Date -Format "yyyy.MM.dd"
    
    # Create new build number with format Infra-CI-CD-{yyyy.MM.dd.rev}
    $newBuildNumber = "Infra-CI-CD-$date.$BuildId"
    
    # Store old build number for artifact naming
    Write-Host "##vso[task.setvariable variable=oldBuildNumber]$env:BUILD_BUILDNUMBER"
    
    # Update build number
    Write-Host "##vso[build.updatebuildnumber]$newBuildNumber"
    
    Write-Host "✅ Build number updated to: $newBuildNumber" -ForegroundColor Green
    Write-Host "Old build number stored in variable: $env:BUILD_BUILDNUMBER" -ForegroundColor Yellow
    
}
catch {
    Write-Host "❌ Failed to update build number: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}