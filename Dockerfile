######################################################################################################################
#For development
# https://hub.docker.com/_/microsoft-dotnet
#Base image
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine-amd64

#Setting working directory
WORKDIR /gasimp-api

# copy everything else and build app. The output directory will be output and de full path for .dll
#will be ./output/gasimp-api.dll
COPY source/. .
RUN dotnet build gasimp.sln -o ./output

#Setting https
RUN dotnet dev-certs https
ENV ASPNETCORE_URLS=https://+:5001

#Command to run de application. 
CMD [ "dotnet", "./output/gasimp.api.dll"]
#######################################################################################################################
#######################################################################################################################
#For project initialization
#FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine-amd64

#WORKDIR /gasimp

#Creating web api project
#RUN dotnet new webapi -f net6.0 -n gasimp.api

#Creating the application layer project
#RUN dotnet new classlib -f net6.0 -n gasimp.application

#Creating domain models layer project
#RUN dotnet new classlib -f net6.0 -n gasimp.domain

#Creating infrastructure layer project
#RUN dotnet new classlib -f net6.0 -n gasimp.infrastructure

#Creating solution file
#RUN dotnet new sln --name gasimp

#Adding projects to sln file
#RUN dotnet sln add ./gasimp.api/gasimp.api.csproj
#RUN dotnet sln add ./gasimp.application/gasimp.application.csproj
#RUN dotnet sln add ./gasimp.domain/gasimp.domain.csproj
#RUN dotnet sln add ./gasimp.infrastructure/gasimp.infrastructure.csproj

#Building solution, just to ensure all projects were created successfully
#RUN dotnet build gasimp.sln

#Keeping the container running allowing us to copy solution structure
#CMD ["tail", "-f", "/dev/null"]



#######################################################################################################################
#######################################################################################################################
#For container interaction
# ENTRYPOINT ["tail", "-f", "/dev/null"]
#CMD ["tail", "-f", "/dev/null"]




# final stage/image
#FROM mcr.microsoft.com/dotnet/aspnet:7.0-jammy-amd64
#WORKDIR /app
#COPY --from=build /app .
#ENTRYPOINT ["./aspnetapp"]

# copy csproj and restore as distinct layers
#COPY source/*.csproj .
#RUN dotnet restore

#ENV ASPNETCORE_URLS=https://+:7277

# Ensure we listen on any IP Address 
#ENV DOTNET_URLS=http://+:5262
#ENV DOTNET_URLS=https://+:7277
#ENV ASPNETCORE_URLS=https://*:7277
#EXPOSE 7277

#RUN dotnet publish -c Release -o /api -r linux-x64 --self-contained false --no-restore
#RUN dotnet publish -c Release