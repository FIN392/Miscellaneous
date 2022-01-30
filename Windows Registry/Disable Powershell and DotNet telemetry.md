_How to disable Powershell and DotNet telemetry:_

[System.Environment]::SetEnvironmentVariable('POWERSHELL_CLI_TELEMETRY_OPTOUT',1,'User')
[System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT',1,'User')
[System.Environment]::SetEnvironmentVariable('DOTNET_CLI_TELEMETRY_OPTOUT',1,'User')
[System.Environment]::SetEnvironmentVariable('DOTNET_TELEMETRY_OPTOUT',1,'User')
[System.Environment]::SetEnvironmentVariable('POWERSHELL_CLI_TELEMETRY_OPTOUT',1,'Machine')
[System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT',1,'Machine')
[System.Environment]::SetEnvironmentVariable('DOTNET_CLI_TELEMETRY_OPTOUT',1,'Machine')
[System.Environment]::SetEnvironmentVariable('DOTNET_TELEMETRY_OPTOUT',1,'Machine')
