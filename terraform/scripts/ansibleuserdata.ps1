<powershell>
# use AWS Secret Manager to get password
#Import-Module AWSPowerShell
#$SecretAD = "admin_pwd"
#$SecretObj = (Get-SECSecretValue -SecretId $SecretAD)
#$Secret = ($SecretObj.SecretString  | ConvertFrom-Json)
#$password   = $Secret.Password | ConvertTo-SecureString -asPlainText -Force
#
#$UserAccount = Get-LocalUser -Name "administrator"
#$UserAccount | Set-LocalUser -Password $Password

# Temporary : disable password complexity 
#secedit /export /cfg c:\secpol.cfg
#(gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
#secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
#rm -force c:\secpol.cfg -confirm:$false

# Add ansible user for remote tasks
net user ansible AFMZCQAaukS5Wt44hbUF /add /expires:never /y
net localgroup "Administrators" ansible /add
net localgroup "Remote Desktop Users" ansible /add

# Fix TLS error on Windows 2016
# Set strong cryptography on 64 bit .Net Framework (version 4 and above)
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
#set strong cryptography on 32 bit .Net Framework (version 4 and above)
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord

# Configure winrm
Invoke-Expression ((New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'))

</powershell>
