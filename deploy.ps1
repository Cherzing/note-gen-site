# deploy.ps1 - 按你的顺序：先 Git 提交推送，再 Quartz 同步
# 用法: .\deploy.ps1 "your commit message"

param(
    [string]$CommitMessage = "Update notes"
)

try {
    Write-Host "📤 正在提交笔记到 Git..." -ForegroundColor Yellow
    git add .
    git commit -m $CommitMessage
    if ($LASTEXITCODE -ne 0) { throw "Git commit failed (maybe no changes)" }

    git push
    if ($LASTEXITCODE -ne 0) { throw "Git push failed" }

    Write-Host "🔄 正在运行 Quartz 同步..." -ForegroundColor Cyan
    npx quartz sync
    if ($LASTEXITCODE -ne 0) { throw "Quartz sync failed" }

    Write-Host "✅ 全部操作完成！" -ForegroundColor Green
}
catch {
    Write-Host "❌ 错误: $_" -ForegroundColor Red
    pause
    exit 1
}