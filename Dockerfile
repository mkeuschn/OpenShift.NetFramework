FROM mcr.microsoft.com/dotnet/framework/sdk:4.8.1

RUN powershell -Command Add-WindowsFeature Web-Server

CMD [ "powershell", "-Command", "Start-Sleep", "-Seconds", "3600" ]

# Add to Path Variable



# Build App
#RUN nuget restore OpenShiftTest.NetFramework.sln
#RUN msbuild OpenShiftTest.NetFramework.sln
#RUN msbuild OpenShiftTest.NetFramework.sln /p:DeployOnBuild=true /p:PublishProfile=FolderProfile.pubxml


# Copy Files