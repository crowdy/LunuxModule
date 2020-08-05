<#
## linux에서 pwsh로 free메모리를 어떻게 구하지?

## 

PS /root> vmstat -Sm
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0   1305    654    209   2424    0    0   363   296  130  892 20 11 67  2  0
 

$DebugPreference = 'Continue'
#>
Function Get-VmstatInfo() {
	Param(
		[string] $Option = "-Sm"
	)
	If ($IsLinux) {
		$cmd = "/usr/bin/vmstat"
		$res = (& $cmd $Option)
		Write-Debug "`n$($res -join "`n")"
		# $record = $res.Split('`n')[2]
		$record = $res[2]
		if ($record -match '^ (?<procs_r>\d+)\s+(?<procs_b>\d+)\s+(?<memory_swpd>\d+)\s+(?<memory_free>\d+)\s+(?<memory_buff>\d+)\s+(?<memory_cache>\d+)\s+(?<swap_si>\d+)\s+(?<swap_so>\d+)\s+(?<io_bi>\d+)\s+(?<io_bo>\d+)\s+(?<system_in>\d+)\s+(?<system_cs>\d+)\s+(?<cpu_us>\d+)\s+(?<cpu_sy>\d+)\s+(?<cpu_id>\d+)\s+(?<cpu_wa>\d+)\s+(?<cpu_st>\d+)\s*$') {
			return $Matches
		}
	}
}


