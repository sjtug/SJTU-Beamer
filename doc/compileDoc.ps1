# PowerShell script for 
# Compiling Documentation of SJTUBeamer

Remove-Item -Path tmp/ -Recurse
New-Item tmp -Type directory

# Preview files
$preview = @(
    @('red','','color=red','\institute[School of Mathematical Sciences]{数学科学学院}'),
    @('redw','aspectratio=169','color=red','\institute[School of Mathematical Sciences]{数学科学学院}'),
    @('blue','','navigation=subsections','\institute[School of Electronic, \\Information and Electrical Engineering]{电子信息与电气工程学院}'),
    @('bluew','aspectratio=169','navigation=subsections','\institute[School of Electronic, \\Information and Electrical Engineering]{电子信息与电气工程学院}')
)

Copy-Item -Path ../src -Destination tmp/ -Recurse

# If PowerShell version < 7,
# please delete -Parallel parameter.
$preview | ForEach-Object -Parallel {
    # Get main part of the slide.
    $main = (Get-Content ../src/main.tex)
    $main = ($main[16..$main.length] -join "`r`n")
    $source = $_[0] + '.tex'
    $target = $_[0] + '.pdf'
    $file = '\documentclass[' + $_[1] + ']{beamer}\mode<presentation>\usetheme[' + $_[2] + ']{SJTUBeamermin}' + $_[3] + $main
    $file | Out-File tmp/src/$source
    Set-Location tmp/src
    latexmk -pdf $source -interaction=nonstopmode
    Copy-Item -Path $target -Destination ../../pdf/$target
    Set-Location ../..
} 

# Compile documentation
pdflatex SJTUBeamertheme.tex -interaction=nonstopmode
pdflatex SJTUBeamertheme.tex -interaction=nonstopmode

# Compile poster
Set-Location img
pdflatex poster.tex -interaction=nonstopmode

Set-Location ..
Remove-Item -Path tmp/ -Recurse