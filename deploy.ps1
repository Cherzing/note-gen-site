param(
    [string]$CommitMessage = "Update notes via Quartz"
)

try {
    Write-Host "🔄 Syncing Obsidian notes..." -ForegroundColor Cyan
    npx quartz sync
    if ($LASTEXITCODE -ne 0) { throw "Quartz sync failed" }

    Write-Host "📤 Committing changes..." -ForegroundColor Yellow
    git add .
    git commit -m $CommitMessage
    if ($LASTEXITCODE -ne 0) { throw "Git commit failed (maybe no changes)" }

    git push
    if ($LASTEXITCODE -ne 0) { throw "Git push failed" }

    Write-Host "✅ Deployment succeeded!" -ForegroundColor Green
}
catch {
    Write-Host "❌ Error: $_" -ForegroundColor Red
    pause
    exit 1
}