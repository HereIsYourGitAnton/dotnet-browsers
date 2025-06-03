## Default dotnet/aspnet image with headless browser pre-installed

```Dockerfile
FROM ghcr.io/hereisyourgitanton/chromium-aspnet:8.0 AS base
# default Dockerfile stuff
```

## Images available:
- `ghcr.io/hereisyourgitanton/chromium-aspnet:8.0.1` - `mcr.microsoft.com/dotnet/aspnet:8.0` with chrome and fonts installed
- `ghcr.io/hereisyourgitanton/chromium-aspnet:8.0-alpine` aka `ghcr.io/hereisyourgitanton/chromium-aspnet:latest` - `mcr.microsoft.com/dotnet/aspnet:8.0-alpine` with chrome and fonts installed
