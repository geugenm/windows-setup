$Links = @(
    "https://rsload.net/soft/manager/8313-aida64-extreme-edition1.html",
    "https://rsload.net/soft/manager/23708-ablebits-ultimate-suite-for-excel.html",
    "https://canarymail.io/downloads.html",
    "https://rsload.net/soft/editor/39797-efficient-elements-for-presentations.html",
    "https://rsload.net/repack/kpojiuk/23497-internet-download-manager-repack-kpojiuk.html",
    "https://rsload.net/repack/kpojiuk/23678-adobe-acrobat-repack-kpojiuk.html",
    "https://rsload.net/soft/editor/33771-pvs-studio.html",
    "https://rsload.net/soft/cleaner-disk/11198-ultimatedefrag.html",
    "https://rsload.net/soft/cleaner-disk/12953-partition-assistant.html",
    "https://rsload.net/soft/manager/9407-process-lasso.html",
    "https://rutracker.org/forum/viewtopic.php?t=6183097",
    "https://rutracker.org/forum/viewtopic.php?t=6178172",
    "https://rutracker.org/forum/viewtopic.php?t=6220259",
    "https://rutracker.org/forum/viewtopic.php?t=6454193",
    "https://clonezilla.org/downloads.php",
    "https://key.words.run/en?aid=649af973004a2e5c3821a894",
    "https://browser.yandex.by/"
)

foreach ($Link in $Links) {
    Start-Process $Link
}

if (!(Get-AppxPackage -Name Microsoft.WindowsStore)) {
    Start-Process "https://github.com/m-jishnu/alt-app-installer"
}