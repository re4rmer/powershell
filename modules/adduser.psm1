function Add_Aduser{

Import-Module ActiveDirectory
$users = import-CSV users.csv -delimiter ";"
$date = get-date -format dd-MM-yy--hms

Foreach($CurrentUser in $Users) 
{
$template = Get-AdUser ad-user-pattern #шаблон для создания учетки
$Name = $CurrentUser.Name
$Surname = $CurrentUser.Surname
$Password = $CurrentUser.Password
$SecurePwd = ConvertTo-SecureString -AsPlainText -Force -String $Password

$Login = $Name.tolower()[0] + "." + $Surname.tolower()
$Displayname = $Name + " " + $Surname
$UserPrincipalName = $Login + "@mydomain.local"

new-aduser $Displayname -GivenName $name -Surname $Surname -instance $template -SamAccountName $Login -UserPrincipalName $UserPrincipalName -DisplayName $DisplayName -AccountPassword $SecurePwd -ChangePasswordAtLogon 0 -CannotChangePassword 0 -PasswordNeverExpires 0 -Path 'OU=New,DC=mydomain,DC=local'

$gr = Get-ADPrincipalGroupMembership $template
Add-ADPrincipalGroupMembership -Identity $Login -MemberOf $gr

Enable-ADAccount $Login
}
Remove-Module ActiveDirectory
}