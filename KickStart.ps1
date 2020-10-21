function Write-OutputMessage {
	Param(
        [parameter(Mandatory=$true)] $message
    )

    Write-Host $message -ForegroundColor Cyan 
}

Write-OutputMessage ""
Write-OutputMessage "=================================================================================================================================="
Write-OutputMessage "KICKSTART - Chocolatey installations (this may take a while)"
Write-OutputMessage "=================================================================================================================================="

# CHOCOLATEY
choco install 7zip
choco install python2
choco install nvm --version=1.1.5
choco install dotnetcore-sdk --version=3.1.403
choco install azure-functions-core-tools-3
choco install azure-cli
choco install nuget.commandline

RefreshEnv

# NVM
Write-OutputMessage ""
Write-OutputMessage "=================================================================================================================================="
Write-OutputMessage "KICKSTART - NPM version switch"
Write-OutputMessage "=================================================================================================================================="

nvm install 12.18.4
nvm use 12.18.4

# ANGULAR
Write-OutputMessage ""
Write-OutputMessage "=================================================================================================================================="
Write-OutputMessage "KICKSTART - Angular installing (this may take a while)"
Write-OutputMessage "=================================================================================================================================="

Set-Location angular
npm install
Set-Location ..

Write-OutputMessage ""
Write-OutputMessage "=================================================================================================================================="
Write-OutputMessage "KICKSTART - Building API"
Write-OutputMessage "=================================================================================================================================="

Set-Location aspnet-core
dotnet build "NAME_OF_SOLUTION.sln"

Write-OutputMessage ""
Write-OutputMessage "=================================================================================================================================="
Write-OutputMessage "KICKSTART - Running DB Migrator"
Write-OutputMessage "=================================================================================================================================="

Set-Location src
Set-Location NAME_OF_SOLUTION.Migrator
dotnet run --project "NAME_OF_SOLUTION.Migrator.csproj"

Set-Location ..
Set-Location ..
Set-Location ..

Write-OutputMessage ""
Write-OutputMessage "=================================================================================================================================="
Write-OutputMessage "KICKSTART - Finished"
Write-OutputMessage "=================================================================================================================================="
