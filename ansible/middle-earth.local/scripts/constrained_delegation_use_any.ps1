# https://www.thehacker.recipes/ad/movement/kerberos/delegations/constrained#with-protocol-transition
Set-ADUser -Identity "merry" -ServicePrincipalNames @{Add='CIFS/rivendell.eriador.middle-earth.local'}
Get-ADUser -Identity "merry" | Set-ADAccountControl -TrustedToAuthForDelegation $true
Set-ADUser -Identity "merry" -Add @{'msDS-AllowedToDelegateTo'=@('CIFS/rivendell.eriador.middle-earth.local','CIFS/rivendell')}
