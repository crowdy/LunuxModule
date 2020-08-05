Function Test-Ubuntu {
    
    if ($IsWindows) {return $False}
    
    $os_info_file = "/etc/os-release"
    if (Test-Path -Path $os_info_file) {
        $hash = ConvertFrom-StringData(Get-Content -Path $os_info_file -Raw)
        if ($hash.ContainsKey("ID")) {
            If ("ubuntu" -eq $hash.ID) {
                $global:IsUbuntu = $True
                $global:IsCentOS = $False
                return $True
            } ElseIf ("centos" -eq $hash.ID){
                $global:IsUbuntu = $False
                $global:IsCentOS = $True
                return $False
            }
        }
    }
    return $False
}