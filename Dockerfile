FROM mcr.microsoft.com/dotnet/framework/sdk:4.8.1

RUN powershell -Command Add-WindowsFeature Web-Server

CMD [ "powershell", "-Command", "Start-Sleep", "-Seconds", "3600" ]

# Add to path Variable temporarily
# RUN $env:Path += ';C:\\foo'
# Permanently add to path variable
RUN [Environment]::SetEnvironmentVariable("PATH", $env:Path + ";C:\\Visual Studio\\Tools", [System.EnvironmentVariableTarget]::Machine)

# Build App
RUN nuget restore OpenShiftTest.NetFramework.sln
RUN msbuild OpenShiftTest.NetFramework.sln
RUN msbuild OpenShiftTest.NetFramework.sln /p:DeployOnBuild=true /p:PublishProfile=FolderProfile.pubxml

# Copy Files
RUN copy app.publish to wwwroot

# Create Web App
RUN New-WebApplication -Site "Default Web Site" -Name "app.publish" -PhysicalPath D:\InetPub\wwwroot\app.publish -ApplicationPool DefaultAppPool