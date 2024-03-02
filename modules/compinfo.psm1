function Comp_info
{Param ()

$a = new-object -comobject excel.application
$b = $a.Workbooks.Add()
$c = $b.Worksheets.Item(1)
$date = get-date -UFormat "%d-%h-%y %H-%M"
$n = 1
$top = "#","ip","Computer","Processor","Chipset","Cores","Memory Gb","User","OS","Architecture", "Version" # массив названий столбцов шапки

While ($n -le $top.length) #формируем шапку
{
	$c.Cells.Item(1,$n) = $top[($n-1)]
	$n++
}
##############################################################################
$q = Get-Content -path iplist.txt
$i = 0
$j = 2 # номер строки
$z = 1 # порядковый номер в первой ячейке
$ErrorActionPreference = "SilentlyContinue"
while ($i -le $q.length)# заполняем таблицу данными
{
	$info = Get-WmiObject -ComputerName $q[$i] win32_computersystem
	
	if ($info)
			{write-host $q[$i] "OK"
	
	$proc = Get-WmiObject -ComputerName $q[$i] Win32_Processor
	$sys = Get-WmiObject -ComputerName $q[$i] Win32_OperatingSystem
		
		
			$c.Cells.Item($j,1) = $z
			$c.Cells.Item($j,2) = $q[$i]
			$c.Cells.Item($j,3) = $info.name
			$c.Cells.Item($j,4) = $proc.name
			$c.Cells.Item($j,5) = $info.model
			$c.Cells.Item($j,6) = $info.numberoflogicalprocessors
			$c.Cells.Item($j,7) = $info.totalphysicalmemory/(1024*1024*1024)
			$c.Cells.Item($j,8) = $info.username
			$c.Cells.Item($j,9) = $sys.Caption
			$c.Cells.Item($j,10) = $sys.OSArchitecture
			$c.Cells.Item($j,11) = $sys.Version
			$j++
			$z++
			}
				else {write-host -ForegroundColor red $q[$i] "ERROR"}
	$i++
	
	
			
 }
 $DesktopPath = [Environment]::GetFolderPath("Desktop")
 $b.SaveAs($DesktopPath+"\comp-info "+$date+".xlsx")
 $a.quit()
 
 }
