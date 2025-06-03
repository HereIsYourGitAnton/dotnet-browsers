FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build

RUN apk add --no-cache \
    chromium-swiftshader \
    msttcorefonts-installer \
    fontconfig \
    && apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    font-wqy-zenhei && \
    update-ms-fonts && \
    fc-cache -f

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final

COPY --from=build /usr/bin/chromium-browser /usr/bin/chromium-browser
COPY --from=build /usr/share/fonts /usr/share/fonts
COPY --from=build /etc/fonts /etc/fonts

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
