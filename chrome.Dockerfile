FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get -f install && apt-get -y install wget gnupg2 apt-utils && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list && \
    echo 'deb http://deb.debian.org/debian/ stable main contrib non-free' >> /etc/apt/sources.list
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \ 
    apt-get update \
    && apt-get install -y google-chrome-stable --no-install-recommends --allow-downgrades  \
    fonts-ipafont-gothic  \
    fonts-wqy-zenhei  \
    fonts-thai-tlwg  \
    fonts-kacst  \
    fonts-freefont-ttf \
    ttf-mscorefonts-installer \
    fontconfig 
