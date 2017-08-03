$key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($key)
Set-Content E:\lability\test.txt $key
$key = get-Content e:\lability\test.txt
ConvertTo-SecureString "lsfjsldj034503485034"  -AsPlainText -Force | ConvertFrom-SecureString -key $key | Set-Content E:\lability\pass.txt

$key = get-Content e:\lability\test.txt
$securestring = Get-Content E:\lability\pass.txt | ConvertTo-SecureString -key $key
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securestring))
$password
