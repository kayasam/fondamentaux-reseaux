param(
  [string]$Message
)

$ErrorActionPreference = "Stop"

$sourceRoot = "C:\Users\kayaw\Nextcloud\Obsidian\CoffreSam\Formations\fondamentaux-reseaux"
$projectRoot = "D:\Projet-git\fondamentaux-reseaux-web"
$sourceCourses = Join-Path $sourceRoot "cours"
$sourceImages = Join-Path $sourceRoot "Ressources\images"
$sourceHtmlAssets = Join-Path $sourceRoot "Ressources\html-assets"
$sourceRevisionIndexHtml = Join-Path $sourceRoot "Ressources\index-protocoles-et-notions.html"
$sourceRevisionIndexMarkdown = Join-Path $sourceRoot "Ressources\index-protocoles-et-notions.md"
$destinationContent = Join-Path $projectRoot "content"
$stagingRoot = Join-Path $projectRoot ".publication-stage"
$stagingCourses = Join-Path $stagingRoot "cours"
$destinationResources = Join-Path $projectRoot "content\Ressources"
$destinationRevisionIndexHtml = Join-Path $destinationResources "index-protocoles-et-notions-interactif.html"
$destinationImages = Join-Path $projectRoot "content\Ressources\images"
$destinationHtmlAssets = Join-Path $projectRoot "content\Ressources\html-assets"

function Assert-Directory {
  param(
    [string]$Path,
    [string]$Description
  )

  if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
    throw "$Description introuvable : $Path"
  }
}

function Assert-File {
  param(
    [string]$Path,
    [string]$Description
  )

  if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    throw "$Description introuvable : $Path"
  }
}

function Copy-MirroredDirectory {
  param(
    [string]$Source,
    [string]$Destination,
    [string[]]$ExcludedFiles = @()
  )

  $arguments = @(
    $Source,
    $Destination,
    "/MIR",
    "/R:2",
    "/W:1",
    "/NFL",
    "/NDL",
    "/NJH",
    "/NJS",
    "/NP"
  )

  if ($ExcludedFiles.Count -gt 0) {
    $arguments += "/XF"
    $arguments += $ExcludedFiles
  }

  & robocopy @arguments
  if ($LASTEXITCODE -ge 8) {
    throw "La copie a échoué avec le code Robocopy $LASTEXITCODE."
  }
}

Write-Host ""
Write-Host "Publication de Fondamentaux Réseaux" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

Assert-Directory -Path $sourceCourses -Description "Le dossier des cours"
Assert-Directory -Path $sourceImages -Description "Le dossier des images"
Assert-Directory -Path $sourceHtmlAssets -Description "Le dossier des ressources HTML"
Assert-Directory -Path (Join-Path $projectRoot ".git") -Description "Le dépôt Git"
Assert-File -Path $sourceRevisionIndexHtml -Description "L'index de révision HTML"
Assert-File -Path $sourceRevisionIndexMarkdown -Description "L'index de révision Markdown"

if (Test-Path -LiteralPath $stagingRoot) {
  $resolvedStage = (Resolve-Path -LiteralPath $stagingRoot).Path
  $expectedStage = [IO.Path]::GetFullPath($stagingRoot)
  if ($resolvedStage -ne $expectedStage -or -not $resolvedStage.StartsWith($projectRoot, [StringComparison]::OrdinalIgnoreCase)) {
    throw "Le dossier de préparation n'est pas situé dans le projet : $resolvedStage"
  }
  Remove-Item -LiteralPath $resolvedStage -Recurse -Force
}

Write-Host "1/6 - Copie des cours depuis le coffre Obsidian..."
Copy-MirroredDirectory `
  -Source $sourceCourses `
  -Destination $stagingCourses `
  -ExcludedFiles @("*.excalidraw", "*.excalidraw.md")

Write-Host "2/6 - Copie des illustrations et des ressources HTML..."
Copy-MirroredDirectory -Source $sourceImages -Destination $destinationImages
Copy-MirroredDirectory -Source $sourceHtmlAssets -Destination $destinationHtmlAssets
Copy-Item -LiteralPath $sourceRevisionIndexHtml -Destination $destinationRevisionIndexHtml -Force
Copy-Item -LiteralPath $sourceRevisionIndexMarkdown -Destination $destinationResources -Force

Write-Host "3/6 - Adaptation des liens pour le site..."
$imagePattern = '!\[\[([^]|]+\.(?:svg|jpe?g|png|webp))(?:\|[^]]+)?\]\]'
$utf8WithoutBom = [Text.UTF8Encoding]::new($false)

Get-ChildItem -LiteralPath $stagingCourses -Recurse -File -Filter "*.md" | ForEach-Object {
  $markdownFile = $_
  $original = [IO.File]::ReadAllText($markdownFile.FullName)
  $updated = [regex]::Replace(
    $original,
    $imagePattern,
    {
      param($match)
      $imageName = $match.Groups[1].Value
      "![$imageName](Ressources/images/$imageName)"
    },
    [Text.RegularExpressions.RegexOptions]::IgnoreCase
  )
  $updated = $updated.Replace("[[cours/", "[[")

  if ($updated -ne $original) {
    [IO.File]::WriteAllText($markdownFile.FullName, $updated, $utf8WithoutBom)
  }
}

Get-ChildItem -LiteralPath $stagingCourses -Recurse -File -Filter "*.html" | ForEach-Object {
  $htmlFile = $_
  $original = [IO.File]::ReadAllText($htmlFile.FullName)
  $updated = $original.Replace("../../Ressources/html-assets/", "../Ressources/html-assets/")

  if ($updated -ne $original) {
    [IO.File]::WriteAllText($htmlFile.FullName, $updated, $utf8WithoutBom)
  }
}

$publishedRevisionMarkdown = Join-Path $destinationResources "index-protocoles-et-notions.md"
$revisionMarkdown = [IO.File]::ReadAllText($publishedRevisionMarkdown)
$revisionMarkdown = $revisionMarkdown.Replace("../cours/", "../")
$revisionMarkdown = $revisionMarkdown.Replace(
  "index-protocoles-et-notions.html",
  "index-protocoles-et-notions-interactif.html"
)
[IO.File]::WriteAllText($publishedRevisionMarkdown, $revisionMarkdown, $utf8WithoutBom)

$publishedRevisionHtml = $destinationRevisionIndexHtml
$revisionHtml = [IO.File]::ReadAllText($publishedRevisionHtml)
$revisionHtml = $revisionHtml.Replace("../cours/", "../")
$revisionHtml = $revisionHtml.Replace(
  'href="index-protocoles-et-notions.md" download',
  'href="../telechargements/index-protocoles-et-notions.md" download'
)
$revisionHtml = $revisionHtml.Replace(
  'href="index-protocoles-et-notions.md"',
  'href="index-protocoles-et-notions"'
)
[IO.File]::WriteAllText($publishedRevisionHtml, $revisionHtml, $utf8WithoutBom)

Write-Host "4/6 - Masquage des documents privés et des corrections non publiées..."
$hiddenDocuments = 0
Get-ChildItem -LiteralPath $stagingCourses -Recurse -File -Filter "*.md" | ForEach-Object {
  $documentContent = [IO.File]::ReadAllText($_.FullName)
  $isCorrection = $_.Name -like "*correction*.md"
  $isExplicitlyPublic = $documentContent -match '(?m)^publier:\s*true\s*$'
  $isExplicitlyPrivate = $documentContent -match '(?m)^publier:\s*false\s*$'

  if ($isExplicitlyPrivate -or ($isCorrection -and -not $isExplicitlyPublic)) {
    [IO.File]::Delete($_.FullName)
    $hiddenDocuments++
  }
}
Write-Host "$hiddenDocuments document(s) conservé(s) uniquement dans le coffre."

Write-Host "5/6 - Organisation des chapitres à la racine du site..."
$publishedChapterNames = @(
  Get-ChildItem -LiteralPath $stagingCourses -Directory |
    Where-Object { $_.Name -match '^\d{2}-' } |
    Select-Object -ExpandProperty Name
)

Get-ChildItem -LiteralPath $destinationContent -Directory |
  Where-Object { $_.Name -match '^\d{2}-' -and $_.Name -notin $publishedChapterNames } |
  ForEach-Object {
    $resolvedTarget = (Resolve-Path -LiteralPath $_.FullName).Path
    if (-not $resolvedTarget.StartsWith($destinationContent, [StringComparison]::OrdinalIgnoreCase)) {
      throw "Refus de supprimer un dossier hors de content : $resolvedTarget"
    }
    Remove-Item -LiteralPath $resolvedTarget -Recurse -Force
  }

$legacyCourses = Join-Path $destinationContent "cours"
if (Test-Path -LiteralPath $legacyCourses -PathType Container) {
  $resolvedLegacy = (Resolve-Path -LiteralPath $legacyCourses).Path
  if ($resolvedLegacy -ne [IO.Path]::GetFullPath($legacyCourses)) {
    throw "Chemin historique inattendu : $resolvedLegacy"
  }
  Remove-Item -LiteralPath $resolvedLegacy -Recurse -Force
}

foreach ($chapterName in $publishedChapterNames) {
  Copy-MirroredDirectory `
    -Source (Join-Path $stagingCourses $chapterName) `
    -Destination (Join-Path $destinationContent $chapterName)
}

Push-Location $projectRoot
try {
  & git diff --check
  if ($LASTEXITCODE -ne 0) {
    throw "Git a détecté une erreur de format dans les fichiers copiés."
  }

  $changes = @(
    & git status --porcelain -- content
  )

  if ($changes.Count -eq 0) {
    Write-Host ""
    Write-Host "Aucune modification à publier." -ForegroundColor Yellow
    exit 0
  }

  & git add -A -- content
  if ($LASTEXITCODE -ne 0) {
    throw "Impossible de préparer les modifications Git."
  }

  Write-Host ""
  Write-Host "Modifications qui seront publiées :" -ForegroundColor Cyan
  & git diff --cached --stat

  if ([string]::IsNullOrWhiteSpace($Message)) {
    $Message = Read-Host "Message de publication (Entrée pour utiliser le message proposé)"
  }

  if ([string]::IsNullOrWhiteSpace($Message)) {
    $Message = "Mise à jour des cours - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
  }

  $confirmation = Read-Host "Publier maintenant sur GitHub ? [o/N]"
  if (
    [string]::IsNullOrWhiteSpace($confirmation) -or
    $confirmation -notmatch '^(o|oui|y|yes)$'
  ) {
    & git restore --staged -- content
    Write-Host "Publication annulée. Les fichiers copiés restent disponibles localement." -ForegroundColor Yellow
    exit 0
  }

  Write-Host "6/6 - Commit et envoi vers GitHub..."
  & git commit -m $Message
  if ($LASTEXITCODE -ne 0) {
    throw "La création du commit a échoué."
  }

  & git push origin v5
  if ($LASTEXITCODE -ne 0) {
    throw "L'envoi vers GitHub a échoué."
  }

  Write-Host ""
  Write-Host "Publication envoyée avec succès." -ForegroundColor Green
  Write-Host "Le site sera actualisé dans environ une à deux minutes :"
  Write-Host "https://kayasam.github.io/fondamentaux-reseaux/"
}
finally {
  Pop-Location
  if (Test-Path -LiteralPath $stagingRoot) {
    Remove-Item -LiteralPath $stagingRoot -Recurse -Force
  }
}
