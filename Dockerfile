FROM ubuntu:trusty

RUN apt-get update && apt-get -y upgrade && apt-get -y install wget

# Ensure locale for Elixir
RUN dpkg-reconfigure locales && \
  locale-gen en_US.UTF-8 && \
  /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install Erlang
RUN cd /tmp; wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    sudo dpkg -i erlang-solutions_1.0_all.deb

# Install Elixir
RUN apt-get update && apt-get install -y git elixir
RUN mix local.hex --force

# Insall MySQL client
RUN apt-get install -y mysql-client
