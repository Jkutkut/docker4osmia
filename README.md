# docker4osmia

This repository contains the logic needed to run [osmia](https://github.com/jkutkut/osmia)
([osmia-cli](https://github.com/jkutkut/osmia-cli)) on a docker container.

This container allows to execute the cli the same was as if you were running it locally.

## Usage
```bash
docker run --rm -t jkutkut/docker4osmia -h
```

### Using a pipe as context
```bash
curl https://pokeapi.co/api/v2/pokemon/pikachu | \
    docker run -i --rm jkutkut/docker4osmia --ctx-in --code-str \
    'The moves of {{ name }} are: {{ moves?map(fn (f) => f.move.name)?join(", ") }}.'
```

### Using files
The docker container runs (by default) in the `/app` directory.
```bash
curl https://pokeapi.co/api/v2/pokemon/pikachu > pikachu.json
echo '{{ name }} moves are: {{ moves?map(fn (f) => f.move.name)?join(", ") }}.' > program.osmia
docker run -t --rm -v $(pwd):/app jkutkut/docker4osmia --code program.osmia --ctx pikachu.json
```
