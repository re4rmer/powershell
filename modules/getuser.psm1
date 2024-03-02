function Get_Username
{
[CmdletBinding()]
Param (
[string]$address = "localhost")
(Get-WmiObject -ComputerName $address win32_computersystem).username
}
