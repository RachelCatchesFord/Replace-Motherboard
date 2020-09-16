<#
    Author: Rachel Catches-Ford
    Date: 2020.09.16
    Purpose: When the vendor replaces a MotherBoard, this script will re-configure
    Bitlocker appropriately.

#>

# enable-bitlocker -mountpoint "C:" -EncryptionMethod xts256aes -skiphardwaretest -recoverypasswordprotector

$blv = Get-BitlockerVolume -MountPoint "C:" 
$TPMID = $blv.keyprotector | where-object{$_.keyprotectortype -eq 'Tpm'} | Select-object -expandproperty keyprotectorid

# Remove current TPM Protector
Remove-BitLockerKeyProtector -mountpoint c: -KeyProtectorId $TPMID


# Add new TPM Protector
Add-BitLockerKeyProtector -MountPoint c: -TpmProtector
