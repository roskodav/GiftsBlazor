FROM buildpack-deps:stretch-scm


# Install .NET CLI dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu57 \
        libssl1.1 \
        libstdc++6 \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Install .NET Core SDK
ENV DOTNET_SDK_VERSION 3.0.100-preview3-010431

RUN curl -SL --output dotnet.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/Sdk/3.0.100-preview3-010431/dotnet-sdk-3.0.100-preview3-010431-linux-x64.tar.gz \
    && dotnet_sha512='eaa1208590e60a793caa8a35e9a26722a4e3bcd8733ea1f79d18c7a777e1a5a8e9d82eddabbd18b82d8795838e6dfc3b5ec7c4504e58c0c852f2d69d40131cfe' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

RUN curl -SL --output dotnet.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/Sdk/2.1.602/dotnet-sdk-2.1.602-linux-x64.tar.gz \
    && dotnet_sha512='f920c3d3d6794e94596b499366210007aced019b34f7eb39768ebc3ff75fc16f161eece98095f719c3608721eada9411da4d2c4b30414000bef78c14b4aec408' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet20

RUN dotnet new -i Microsoft.AspNetCore.Blazor.Templates

# Configure web servers to bind to port 80 when present
ENV ASPNETCORE_URLS=http://+:80 \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true \
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps performance
    NUGET_XMLDOC_MODE=skip

# Trigger first run experience by running arbitrary cmd
RUN dotnet help