$PSDefaultParameterValues['*:Encoding'] = 'utf8'

Function Get-RControllerVersion() {
    Return $Version
}

Function uuidgen() {
    Return [Guid]::NewGuid()
}

Function ConvertReplace($cmd) {
$changecmd = ""
    $escmd = [RegEx]::Escape($cmd)
    $changecmd = $escmd.Replace("&","""&""")

    return $changecmd
}


# -----------------------------------------------------------------------------------------------------# 

# . ("$PSScriptRoot\LibDatabase.ps1")
# Export-ModuleMember -Function Invoke-Sqlcmd2

$exclude = @("*.Tests.ps1")
# Write-Debug "PSScriptRoot: $PSScriptRoot "
$functionFileList = Get-ChildItem -Path "$PSScriptRoot/Functions" -Name "*.ps1" -Recurse -Exclude $exclude
foreach ($functionFile in $functionFileList) {
    # Write-Debug "$PSScriptRoot/Functions/$functionFile"
    try {

        # this causes UTF8 encoding problem.
        # . ("$PSScriptRoot/Functions/$functionFile")
        
        . (
            [scriptblock]::Create(
                [io.file]::ReadAllText(
                    "$PSScriptRoot/Functions/$functionFile",
                    [Text.Encoding]::UTF8
                )
            )
        )

	} catch {
		Write-Error -Message "Failed to import function $PSScriptRoot/functions/$functionFile : $_"
	}
}

$functions = ($functionFileList -replace '.ps1', '') | Split-Path -Leaf

$exportModuleMemberParams = @{
    Alias       = '*'
    'Function'  = $functions 
    Variable    = @(
        'Version'
    )
}

$DebugPreference = "Continue"
Write-Debug "$($exportModuleMemberParams.Function)"

# we suppress warning of invalid verb
Export-ModuleMember @exportModuleMemberParams -WarningVariable warn 3> $null

Write-Host "$($MyInvocation.MyCommand.Name) loaded"
