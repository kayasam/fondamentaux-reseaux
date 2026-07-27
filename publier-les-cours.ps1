param(
  [string]$Message
)

$ErrorActionPreference = "Stop"

$sourceRoot = "C:\Users\kayaw\Nextcloud\Obsidian\CoffreSam\Formations\fondamentaux-reseaux"
$projectRoot = "D:\Projet-git\fondamentaux-reseaux-web"
$sourceCourses = Join-Path $sourceRoot "cours"
$sourceImages = Join-Path $sourceRoot "Ressources\images"
$destinationCourses = Join-Path $projectRoot "content\cours"
$destinationImages = Join-Path $projectRoot "content\Ressources\images"

function Assert-Directory {
  param(
    [string]$Path,
    [string]$Description
  )

  if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
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
Assert-Directory -Path (Join-Path $projectRoot ".git") -Description "Le dépôt Git"

Write-Host "1/4 - Copie des cours depuis le coffre Obsidian..."
Copy-MirroredDirectory `
  -Source $sourceCourses `
  -Destination $destinationCourses `
  -ExcludedFiles @("*.excalidraw", "*.excalidraw.md")

Write-Host "2/4 - Copie des illustrations..."
Copy-MirroredDirectory -Source $sourceImages -Destination $destinationImages

Write-Host "3/4 - Adaptation des liens d'images pour le site..."
$imagePattern = '!\[\[([^]|]+\.(?:svg|jpe?g|png|webp))(?:\|[^]]+)?\]\]'
$utf8WithoutBom = [Text.UTF8Encoding]::new($false)

Get-ChildItem -LiteralPath $destinationCourses -Recurse -File -Filter "*.md" | ForEach-Object {
  $markdownFile = $_
  $relativeImages = [IO.Path]::GetRelativePath(
    $markdownFile.DirectoryName,
    $destinationImages
  ).Replace("\", "/")

  $original = [IO.File]::ReadAllText($markdownFile.FullName)
  $updated = [regex]::Replace(
    $original,
    $imagePattern,
    {
      param($match)
      $imageName = $match.Groups[1].Value
      "![$imageName]($relativeImages/$imageName)"
    },
    [Text.RegularExpressions.RegexOptions]::IgnoreCase
  )

  if ($updated -ne $original) {
    [IO.File]::WriteAllText($markdownFile.FullName, $updated, $utf8WithoutBom)
  }
}

Push-Location $projectRoot
try {
  & git diff --check
  if ($LASTEXITCODE -ne 0) {
    throw "Git a détecté une erreur de format dans les fichiers copiés."
  }

  $changes = @(
    & git status --porcelain -- content/cours content/Ressources/images
  )

  if ($changes.Count -eq 0) {
    Write-Host ""
    Write-Host "Aucune modification à publier." -ForegroundColor Yellow
    exit 0
  }

  & git add -A -- content/cours content/Ressources/images
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

  $confirmation = Read-Host "Publier maintenant sur GitHub ? [O/n]"
  if ($confirmation -notmatch '^(|o|oui|y|yes)$') {
    & git restore --staged -- content/cours content/Ressources/images
    Write-Host "Publication annulée. Les fichiers copiés restent disponibles localement." -ForegroundColor Yellow
    exit 0
  }

  Write-Host "4/4 - Commit et envoi vers GitHub..."
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
}
