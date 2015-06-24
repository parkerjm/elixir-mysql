# elixir-mysql
Docker container with [Erlang](http://www.erlang.org/), [Elixir](http://www.elixir-lang.org/Elixir) and MySQL client
for use when creating a CI/CD pipeline with Wercker for  Phoenix Framework applications.

# Usage
To use in Wercker yaml file
```
box: jszod/elixir-mysql
```

To run it locally
```
docker pull jszod/elixir-mysql
  docker run -t -i jszod/elixir
```


