$key = (2,3,56,34,254,222,1,1,2,23,42,54,33,233,1,34,2,7,6,5,35,43,6,6,6,6,6,6,31,33,60,23)
ConvertTo-SecureString "lsfjsldj034503485034"  -AsPlainText -Force | ConvertFrom-SecureString -key $key | Set-Content E:\pass.txt

$securestring = Get-Content E:\Lability\pass.txt | ConvertTo-SecureString -key $key
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securestring))
$password
