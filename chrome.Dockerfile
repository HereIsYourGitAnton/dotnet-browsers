FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS build

RUN apk add --no-cache \
    chromium-swiftshader \
    ttf-freefont \
    ttf-liberation \
    msttcorefonts-installer \
    fontconfig \
    && apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    font-wqy-zenhei && \
    update-ms-fonts && \
    fc-cache -f

RUN mkdir /chromium-libs && \
    ldd /usr/lib/chromium/chrome | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I '{}' cp -v --parents '{}' /chromium-libs   

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final

COPY --from=build /usr/lib/chromium/ /usr/lib/chromium/
RUN ln -s /usr/lib/chromium/chromium-launcher.sh /usr/bin/chromium-browser && \
    ln -s /usr/bin/chromium-browser /usr/bin/chromium
COPY --from=build /chromium-libs/ /

# Copy fonts
COPY --from=build /usr/share/fonts /usr/share/fonts
COPY --from=build /etc/fonts /etc/fonts

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
