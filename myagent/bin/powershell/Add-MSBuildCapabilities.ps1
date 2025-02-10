[CmdletBinding()]
param()

function Get-MSBuildCapabilities {
    param (
        [Parameter(Mandatory = $true)]
        [int]$MajorVersion,

        [switch]$Add_x64
    )

    $vs = Get-VisualStudio -MajorVersion $MajorVersion
    
    $capabilitySuffix = [string]::Empty
    if($Add_x64)
    {
        $msbuildInstallationPath = 'MSBuild\Current\Bin\amd64'
        $capabilitySuffix = "_x64"
    }
    else
    {
        $msbuildInstallationPath = 'MSBuild\Current\Bin'
    }

    if ($vs -and $vs.installationPath) {
        # Add MSBuild_$($MajorVersion).0.
        # End with "\" for consistency with old MSBuildToolsPath value.
        $msbuild = ([System.IO.Path]::Combine($vs.installationPath, $msbuildInstallationPath)) + '\'
        if ((Test-Leaf -LiteralPath "$($msbuild)MSBuild.exe")) {
            Write-Capability -Name "MSBuild_$($MajorVersion).0$($capabilitySuffix)" -Value $msbuild
            $latest = $msbuild
        }
    }
    if ($latest) {
        Write-Capability -Name "MSBuild$($capabilitySuffix)" -Value $latest
    }
}

# Define the key names.
$keyName20 = "Software\Microsoft\MSBuild\ToolsVersions\2.0"
$keyName35 = "Software\Microsoft\MSBuild\ToolsVersions\3.5"
$keyName40 = "Software\Microsoft\MSBuild\ToolsVersions\4.0"
$keyName12 = "Software\Microsoft\MSBuild\ToolsVersions\12.0"
$keyName14 = "Software\Microsoft\MSBuild\ToolsVersions\14.0"

# Add 32-bit.
$latest = $null
$null = Add-CapabilityFromRegistry -Name "MSBuild_2.0" -Hive 'LocalMachine' -View 'Registry32' -KeyName $keyName20 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
$null = Add-CapabilityFromRegistry -Name "MSBuild_3.5" -Hive 'LocalMachine' -View 'Registry32' -KeyName $keyName35 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
$null = Add-CapabilityFromRegistry -Name "MSBuild_4.0" -Hive 'LocalMachine' -View 'Registry32' -KeyName $keyName40 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
$null = Add-CapabilityFromRegistry -Name "MSBuild_12.0" -Hive 'LocalMachine' -View 'Registry32' -KeyName $keyName12 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
$null = Add-CapabilityFromRegistry -Name "MSBuild_14.0" -Hive 'LocalMachine' -View 'Registry32' -KeyName $keyName14 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
$vs15 = Get-VisualStudio -MajorVersion 15
if ($vs15 -and $vs15.installationPath) {
    # Add MSBuild_15.0.
    # End with "\" for consistency with old MSBuildToolsPath value.
    $msbuild15 = ([System.IO.Path]::Combine($vs15.installationPath, 'MSBuild\15.0\Bin')) + '\'
    if ((Test-Leaf -LiteralPath "$($msbuild15)MSBuild.exe")) {
        Write-Capability -Name 'MSBuild_15.0' -Value $msbuild15
        $latest = $msbuild15
    }
}

Get-MSBuildCapabilities -MajorVersion 16

Get-MSBuildCapabilities -MajorVersion 17

# Add 64-bit.
$latest = $null
$null = Add-CapabilityFromRegistry -Name "MSBuild_2.0_x64" -Hive 'LocalMachine' -View 'Registry64' -KeyName $keyName20 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
$null = Add-CapabilityFromRegistry -Name "MSBuild_3.5_x64" -Hive 'LocalMachine' -View 'Registry64' -KeyName $keyName35 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
$null = Add-CapabilityFromRegistry -Name "MSBuild_4.0_x64" -Hive 'LocalMachine' -View 'Registry64' -KeyName $keyName40 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
$null = Add-CapabilityFromRegistry -Name "MSBuild_12.0_x64" -Hive 'LocalMachine' -View 'Registry64' -KeyName $keyName12 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
$null = Add-CapabilityFromRegistry -Name "MSBuild_14.0_x64" -Hive 'LocalMachine' -View 'Registry64' -KeyName $keyName14 -ValueName 'MSBuildToolsPath' -Value ([ref]$latest)
if ($vs15 -and $vs15.installationPath) {
    # Add MSBuild_15.0_x64.
    # End with "\" for consistency with old MSBuildToolsPath value.
    $msbuild15 = ([System.IO.Path]::Combine($vs15.installationPath, 'MSBuild\15.0\Bin\amd64')) + '\'
    if ((Test-Leaf -LiteralPath "$($msbuild15)MSBuild.exe")) {
        Write-Capability -Name 'MSBuild_15.0_x64' -Value $msbuild15
        $latest = $msbuild15
    }
}

Get-MSBuildCapabilities -MajorVersion 16 -Add_x64

Get-MSBuildCapabilities -MajorVersion 17 -Add_x64

# SIG # Begin signature block
# MIIoKQYJKoZIhvcNAQcCoIIoGjCCKBYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCERQsWCn/wZ7Rg
# 0a2g3mqXfwAY6KOuNQVPte9+XZTS+KCCDXYwggX0MIID3KADAgECAhMzAAAEBGx0
# Bv9XKydyAAAAAAQEMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjQwOTEyMjAxMTE0WhcNMjUwOTExMjAxMTE0WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQC0KDfaY50MDqsEGdlIzDHBd6CqIMRQWW9Af1LHDDTuFjfDsvna0nEuDSYJmNyz
# NB10jpbg0lhvkT1AzfX2TLITSXwS8D+mBzGCWMM/wTpciWBV/pbjSazbzoKvRrNo
# DV/u9omOM2Eawyo5JJJdNkM2d8qzkQ0bRuRd4HarmGunSouyb9NY7egWN5E5lUc3
# a2AROzAdHdYpObpCOdeAY2P5XqtJkk79aROpzw16wCjdSn8qMzCBzR7rvH2WVkvF
# HLIxZQET1yhPb6lRmpgBQNnzidHV2Ocxjc8wNiIDzgbDkmlx54QPfw7RwQi8p1fy
# 4byhBrTjv568x8NGv3gwb0RbAgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQU8huhNbETDU+ZWllL4DNMPCijEU4w
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzUwMjkyMzAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAIjmD9IpQVvfB1QehvpC
# Ge7QeTQkKQ7j3bmDMjwSqFL4ri6ae9IFTdpywn5smmtSIyKYDn3/nHtaEn0X1NBj
# L5oP0BjAy1sqxD+uy35B+V8wv5GrxhMDJP8l2QjLtH/UglSTIhLqyt8bUAqVfyfp
# h4COMRvwwjTvChtCnUXXACuCXYHWalOoc0OU2oGN+mPJIJJxaNQc1sjBsMbGIWv3
# cmgSHkCEmrMv7yaidpePt6V+yPMik+eXw3IfZ5eNOiNgL1rZzgSJfTnvUqiaEQ0X
# dG1HbkDv9fv6CTq6m4Ty3IzLiwGSXYxRIXTxT4TYs5VxHy2uFjFXWVSL0J2ARTYL
# E4Oyl1wXDF1PX4bxg1yDMfKPHcE1Ijic5lx1KdK1SkaEJdto4hd++05J9Bf9TAmi
# u6EK6C9Oe5vRadroJCK26uCUI4zIjL/qG7mswW+qT0CW0gnR9JHkXCWNbo8ccMk1
# sJatmRoSAifbgzaYbUz8+lv+IXy5GFuAmLnNbGjacB3IMGpa+lbFgih57/fIhamq
# 5VhxgaEmn/UjWyr+cPiAFWuTVIpfsOjbEAww75wURNM1Imp9NJKye1O24EspEHmb
# DmqCUcq7NqkOKIG4PVm3hDDED/WQpzJDkvu4FrIbvyTGVU01vKsg4UfcdiZ0fQ+/
# V0hf8yrtq9CkB8iIuk5bBxuPMIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
# hkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
# IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEwOTA5WjB+MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQg
# Q29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+laUKq4BjgaBEm6f8MMHt03
# a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc6Whe0t+bU7IKLMOv2akr
# rnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4Ddato88tt8zpcoRb0Rrrg
# OGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+lD3v++MrWhAfTVYoonpy
# 4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nkkDstrjNYxbc+/jLTswM9
# sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6A4aN91/w0FK/jJSHvMAh
# dCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmdX4jiJV3TIUs+UsS1Vz8k
# A/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL5zmhD+kjSbwYuER8ReTB
# w3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zdsGbiwZeBe+3W7UvnSSmn
# Eyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3T8HhhUSJxAlMxdSlQy90
# lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS4NaIjAsCAwEAAaOCAe0w
# ggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRIbmTlUAXTgqoXNzcitW2o
# ynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYD
# VR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBDuRQFTuHqp8cx0SOJNDBa
# BgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
# bC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3JsMF4GCCsG
# AQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3J0MIGfBgNV
# HSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1hcnljcHMuaHRtMEAGCCsG
# AQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkAYwB5AF8AcwB0AGEAdABl
# AG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn8oalmOBUeRou09h0ZyKb
# C5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7v0epo/Np22O/IjWll11l
# hJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0bpdS1HXeUOeLpZMlEPXh6
# I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/KmtYSWMfCWluWpiW5IP0
# wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvyCInWH8MyGOLwxS3OW560
# STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBpmLJZiWhub6e3dMNABQam
# ASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJihsMdYzaXht/a8/jyFqGa
# J+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYbBL7fQccOKO7eZS/sl/ah
# XJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbSoqKfenoi+kiVH6v7RyOA
# 9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sLgOppO6/8MO0ETI7f33Vt
# Y5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtXcVZOSEXAQsmbdlsKgEhr
# /Xmfwb1tbWrJUnMTDXpQzTGCGgkwghoFAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAAQEbHQG/1crJ3IAAAAABAQwDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEICJHvFN4W9RbPdSCMRDrtRnj
# AO6JHM+vIJngjPUDk0N+MEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAPKXsnSI4OgyUj3vgn4C+sfySRtMsqwsuUJT06K6mldVSBT8Ov5wylSD0
# H113oAC1SZwnE9YBkTCnSHYgwgmjQqhjY1xbOeUy//gdXtb0lgmONrbCQXRce4uZ
# UthvhorBVhy+NCh6eUNMxD16sV8l78II7KF2HLCg/Igrg9iJuDqrjOUjFHy4imfN
# JBaXObPcqLbJ+6UBHqKUvlFYkSJNM+XhB470EaaQ0kU6ySQpm8AhxAdz5uZ51Kea
# BScfNBad9DpJ7kI3cRrC4zCpfIwNYK+icPUCrf9PIZRekOgqVXlIDOswMc3L3q+M
# WotXgFL7J3cHgBBCNHO62tNomEivHqGCF5MwghePBgorBgEEAYI3AwMBMYIXfzCC
# F3sGCSqGSIb3DQEHAqCCF2wwghdoAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFRBgsq
# hkiG9w0BCRABBKCCAUAEggE8MIIBOAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCB6vIgUfz6P+f8M8jgHXNw78/aK6v+ATnKfq/wwWWPzUwIGZ1rYYKLi
# GBIyMDI1MDExMzExNDM0Ni45MlowBIACAfSggdGkgc4wgcsxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVy
# aWNhIE9wZXJhdGlvbnMxJzAlBgNVBAsTHm5TaGllbGQgVFNTIEVTTjpBMDAwLTA1
# RTAtRDk0NzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaCC
# EeowggcgMIIFCKADAgECAhMzAAAB6+AYbLW27zjtAAEAAAHrMA0GCSqGSIb3DQEB
# CwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMB4XDTIzMTIwNjE4NDUz
# NFoXDTI1MDMwNTE4NDUzNFowgcsxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVyaWNhIE9wZXJhdGlvbnMx
# JzAlBgNVBAsTHm5TaGllbGQgVFNTIEVTTjpBMDAwLTA1RTAtRDk0NzElMCMGA1UE
# AxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBAMEVaCHaVuBXd4mnTWiqJoUG5hs1zuFIqaS28nXk2sH8
# MFuhSjDxY85M/FufuByYg4abAmR35PIXHso6fOvGegHeG6+/3V9m5S6AiwpOcC+D
# YFT+d83tnOf0qTWam4nbtLrFQMfih0WJfnUgJwqXoQbhzEqBwMCKeKFPzGuglZUB
# Mvunxtt+fCxzWmKFmZy8i5gadvVNj22el0KFav0QBG4KjdOJEaMzYunimJPaUPmG
# d3dVoZN6k2rJqSmQIZXT5wrxW78eQhl2/L7PkQveiNN0Usvm8n0gCiBZ/dcC7d3t
# KkVpqh6LHR7WrnkAP3hnAM/6LOotp2wFHe3OOrZF+sI0v5OaL+NqVG2j8npuHh8+
# EcROcMLvxPXJ9dRB0a2Yn+60j8A3GLsdXyAA/OJ31NiMw9tiobzLnHP6Aj9IXKP5
# oq0cdaYrMRc+21fMBx7EnUQfvBu6JWTewSs8r0wuDVdvqEzkchYDSMQBmEoTJ3mE
# fZcyJvNqRunazYQlBZqxBzgMxoXUSxDULOAKUNghgbqtSG518juTwv0ooIS59Fsr
# mV1Fg0Cp12v/JIl+5m/c9Lf6+0PpfqrUfhQ6aMMp2OhbeqzslExmYf1+QWQzNvph
# LOvp5fUuhibc+s7Ul5rjdJjOUHdPPzg6+5VJXs1yJ1W02qJl5ZalWN9q9H4mP8k5
# AgMBAAGjggFJMIIBRTAdBgNVHQ4EFgQUdJ4FrNZVzG7ipP07mNPYH6oB6uEwHwYD
# VR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYDVR0fBFgwVjBUoFKgUIZO
# aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jcmwvTWljcm9zb2Z0JTIw
# VGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwGCCsGAQUFBwEBBGAwXjBc
# BggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0
# cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcnQwDAYD
# VR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAOBgNVHQ8BAf8EBAMC
# B4AwDQYJKoZIhvcNAQELBQADggIBAIN03y+g93wL5VZk/f5bztz9Bt1tYrSw631n
# iQQ5aeDsqaH5YPYuc8lMkogRrGeI5y33AyAnzJDLBHxYeAM69vCp2qwtRozg2t6u
# 0joUj2uGOF5orE02cFnMdksPCWQv28IQN71FzR0ZJV3kGDcJaSdXe69Vq7XgXnkR
# JNYgE1pBL0KmjY6nPdxGABhV9osUZsCs1xG9Ja9JRt4jYgOpHELjEFtGI1D7Wodc
# MI+fSEaxd8v7KcNmdwJ+zM2uWBlPbheCG9PNgwdxeKgtVij/YeTKjDp0ju5Qslsr
# EtfzAeGyLCuJcgMKeMtWwbQTltHzZCByx4SHFtTZ3VFUdxC2RQTtb3PFmpnr+M+Z
# qiNmBdA7fdePE4dhhVr8Fdwi67xIzM+OMABu6PBNrClrMsG/33stEHRk5s1yQljJ
# BCkRNJ+U3fqNb7PtH+cbImpFnce1nWVdbV/rMQIB4/713LqeZwKtVw6ptAdftmvx
# Y9yCEckAAOWbkTE+HnGLW01GT6LoXZr1KlN5Cdlc/nTD4mhPEhJCru8GKPaeK0Cx
# ItpV4yqg+L41eVNQ1nY121sWvoiKv1kr259rPcXF+8Nmjfrm8s6jOZA579n6m7i9
# jnM+a02JUhxCcXLslk6JlUMjlsh3BBFqLaq4conqW1R2yLceM2eJ64TvZ9Ph5aHG
# 2ac3kdgIMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJmQAAAAAAFTANBgkqhkiG
# 9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEy
# MDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIw
# MTAwHhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1WjB8MQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGlt
# ZS1TdGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
# AOThpkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjKNVf2AX9sSuDivbk+F2Az
# /1xPx2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhgfWpSg0S3po5GawcU88V2
# 9YZQ3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJprx2rrPY2vjUmZNqYO7oa
# ezOtgFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/dvI2k45GPsjksUZzpcGkN
# yjYtcI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka97aSueik3rMvrg0XnRm7K
# MtXAhjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKRHh09/SDPc31BmkZ1zcRf
# NN0Sidb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9ituqBJR6L8FA6PRc6ZNN3SU
# HDSCD/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyOArxCaC4Q6oRRRuLRvWoY
# WmEBc8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItboKaDIV1fMHSRlJTYuVD5
# C4lh8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6bMURHXLvjflSxIUXk8A8
# FdsaN8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6tAgMBAAGjggHdMIIB2TAS
# BgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQWBBQqp1L+ZMSavoKRPEY1
# Kc8Q/y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXAYDVR0gBFUw
# UzBRBgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYzaHR0cDovL3d3dy5taWNy
# b3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnkuaHRtMBMGA1UdJQQMMAoG
# CCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIB
# hjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQW9fO
# mhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9w
# a2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNybDBaBggr
# BgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNv
# bS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3J0MA0GCSqGSIb3
# DQEBCwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/qXBS2Pk5HZHixBpOXPTEz
# tTnXwnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6U03dmLq2HnjYNi6cqYJW
# AAOwBb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVtI1TkeFN1JFe53Z/zjj3G
# 82jfZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis9/kpicO8F7BUhUKz/Aye
# ixmJ5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTpkbKpW99Jo3QMvOyRgNI9
# 5ko+ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0sHrYUP4KWN1APMdUbZ1j
# dEgssU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138eW0QBjloZkWsNn6Qo3GcZ
# KCS6OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJsWkBRH58oWFsc/4Ku+xB
# Zj1p/cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7Fx0ViY1w/ue10CgaiQuP
# Ntq6TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0dFtq0Z4+7X6gMTN9vMvp
# e784cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQtB1VM1izoXBm8qGCA00w
# ggI1AgEBMIH5oYHRpIHOMIHLMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25zMScw
# JQYDVQQLEx5uU2hpZWxkIFRTUyBFU046QTAwMC0wNUUwLUQ5NDcxJTAjBgNVBAMT
# HE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2WiIwoBATAHBgUrDgMCGgMVAIAG
# iXW7XDDBiBS1SjAyepi9u6XeoIGDMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAg
# UENBIDIwMTAwDQYJKoZIhvcNAQELBQACBQDrLtw1MCIYDzIwMjUwMTEzMDAyNjI5
# WhgPMjAyNTAxMTQwMDI2MjlaMHQwOgYKKwYBBAGEWQoEATEsMCowCgIFAOsu3DUC
# AQAwBwIBAAICHj8wBwIBAAICE2cwCgIFAOswLbUCAQAwNgYKKwYBBAGEWQoEAjEo
# MCYwDAYKKwYBBAGEWQoDAqAKMAgCAQACAwehIKEKMAgCAQACAwGGoDANBgkqhkiG
# 9w0BAQsFAAOCAQEAR5ynReTE3ywmdvSW0fj6IfOIRWAYH+l2pvTyL/fSAxjTBCfb
# ZpaaMO5b+wv0FxMhWgTSLdMrcAkxtysIAlO9cQeZfDXRf95ePsDod8N1YdgI/qTT
# 7teOgsDIEMxR0NkFwnxeFHClheQX8kgTEHGMeAPQokUxnc2nyNgFQ5WgsYKEnbp4
# 3+V7/MwMlApueCDVY0sz+SlinBoL/NFVwzMjgmj4QZI/yGBURht7dLnrbfEmOg/a
# jZ5YdCig2VH4GDA7zj7EB9uHTdckhQSlG1Wx05CGV+rx35syMHM8YT3k/NXCbi1T
# c58e+dmY83zrsmonuaR1xzPxbeo2DblPFZ4qJzGCBA0wggQJAgEBMIGTMHwxCzAJ
# BgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25k
# MR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jv
# c29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB6+AYbLW27zjtAAEAAAHrMA0G
# CWCGSAFlAwQCAQUAoIIBSjAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwLwYJ
# KoZIhvcNAQkEMSIEIF2plfLpCgbcsGE6nyfNa2OH+Y4e7hziUryfDLf0QGaEMIH6
# BgsqhkiG9w0BCRACLzGB6jCB5zCB5DCBvQQgzrdrvl9pA+F/xIENO2TYNJSAht2L
# NezPvqHUl2EsLPgwgZgwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAx
# MAITMwAAAevgGGy1tu847QABAAAB6zAiBCCToURgsI2urqvRHC/4AU0d8SBjoCOf
# QXddjmJvDKAaBjANBgkqhkiG9w0BAQsFAASCAgCfCUnJIdYvkXCDrwVvthv4M9KE
# JOKy0S3AYFFAgBYS52GZxOKyOkpS8x/U+wSpe7kW5pLhkpbH9WzURawjEXY4pyqu
# v7rGX4JSy+AW1cq/aepgZgjHsRzyaTQFG8EB/HM821Q//XsRlfvHDfamBKgm5pCQ
# XJUI+Vt5ME4s+WrtxsRSGeYoxvz0t5DdlLDsHl/u2lqTc1X1L6n45dXH9rhb2GNZ
# mrQUpqogwVTNLftU8czQx+0EgLPwxHiyRazQuEKbPD5gJBqfrEZcyZHuWUykJ1kZ
# WkS+Pv7g3EAaS6xbtcYCKi3DopFAVqFsbv2G9AQMLEoXLjN9cJSS4MF0yRBg1HO4
# n2+At2dodeU2qLLq82e65uC1AupNX+FgZhWL7zaMGN5HRxwWOuCU/sflMIEB/nx6
# qeKmR/GTSAdY1MCC5tcGF6fxhPJuN1P/7B701hLEN6RUN+n0hpuXGKjOxwQgFSTA
# vUuU2ZwUEOv1JotXPdgck3AVJGTHz6Nv/1DDuVEKFNoEY9gU2xRGEsAqPOt7A4Jt
# 4xMjrJECXguGeR7gL0k1A0wlX7bfiQxMXoTObkonsK72DFQl45KrBn2fuuUdVYHB
# WiNNHZcDDRQbez4EJA+BNNl75Ih6emwWR779tsfda6VlJqvtZzAP3Ygh4R3mnbtC
# NGAwmoTwUooa1/53Dw==
# SIG # End signature block
