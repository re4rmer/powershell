Make-TreeSimple -InputFile .\myTree.txt

<# Example of InputFile content:
Projects;godot;_art
Projects;docker
Projects;asp.net
Projects;c#
temp;_gc
test #>
function Make-Tree #delimitters in InputFile must be ';'
{
    [CmdletBinding(SupportsShouldProcess)]
    
    param (
        [string]$Root = $PWD,
        [Parameter(Mandatory=$true)] [string]$InputFile
        )

$branches = (Get-Content -Path $InputFile)

foreach ($branch in $branches)
    {
    sl $root
    $split_branch = $branch.Split(";")
    
    foreach ($dir in $split_branch)
        {
        if ((Get-ItemProperty $dir -erroraction 'silentlycontinue').Exists) {sl $dir }
        else {mkdir $dir; sl $dir}
        }
    }
sl $root
}

<# Example of InputFile content:
Projects\godot\_art
Projects\docker
Projects\asp.net
Projects\c#
temp\_gc
test #>
function Make-TreeSimple #delimitters in InputFile must be '\'
{
    [CmdletBinding(SupportsShouldProcess)]
    
    param (
        [string]$Root = $PWD,
        [Parameter(Mandatory=$true)] [string]$InputFile
        )

    $branches = (Get-Content -Path $InputFile)
    foreach ($branch in $branches) {mkdir $root\$branch}
}
