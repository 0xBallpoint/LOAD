Get-ADUser -Identity "pippin" | Set-ADAccountControl -DoesNotRequirePreAuth:$true
