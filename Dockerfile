FROM erlang:18-slim

# elixir expects utf8.
ENV ELIXIR_VERSION=v1.2.3 \
  LANG=C.UTF-8

# Install depencies
RUN set -xe \
  && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/releases/download/${ELIXIR_VERSION#*@}/Precompiled.zip" \
  && ELIXIR_DOWNLOAD_SHA256="948483f0b14630851b9cee3332fdb3467943ed4881672ac41dc562e77cd3c785" \
  && buildDeps=' \
    ca-certificates \
    curl \
    unzip \
    wget \
    debconf-utils
  ' \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \

# Install elixir
RUN curl -fSL -o elixir-precompiled.zip $ELIXIR_DOWNLOAD_URL \
  && echo "$ELIXIR_DOWNLOAD_SHA256 elixir-precompiled.zip" | sha256sum -c - \
  && unzip -d /usr/local elixir-precompiled.zip \
  && rm elixir-precompiled.zip

CMD ["iex"]

# Insall MySQL client
RUN debconf-set-selections <<< 'mysql-server mysql-server/root_password password'
    && debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password'
    && apt-get install -y mysql-server

# Cleanup
RUN apt-get purge -y --auto-remove $buildDeps \
  && rm -rf /var/lib/apt/lists/*
