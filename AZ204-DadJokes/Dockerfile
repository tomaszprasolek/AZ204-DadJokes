﻿FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["AZ204-DadJokes/AZ204-DadJokes.csproj", "AZ204-DadJokes/"]
RUN dotnet restore "AZ204-DadJokes/AZ204-DadJokes.csproj"
COPY . .
WORKDIR "/src/AZ204-DadJokes"
RUN dotnet build "AZ204-DadJokes.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "AZ204-DadJokes.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AZ204-DadJokes.dll"]
