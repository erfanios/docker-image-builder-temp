FROM python:3.11-alpine

# Install Tini for clean process handling (signal forwarding)
RUN apk add --no-cache tini

# MkDocs und gängige Erweiterungen/Themes installieren
RUN pip install --no-cache-dir \
    mkdocs \
    mkdocs-material

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT ["/sbin/tini", "--", "mkdocs"]

# Start the dev server by default
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
