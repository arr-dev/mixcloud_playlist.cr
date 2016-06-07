# mixcloud_playlist

Adds Mixcloud cloudcasts to "Listen Later" list.

## Installation

```sh
# build
make build
# install
make install
# build and install
make all
```
## Usage

Configure app with `YAML` file containing keys:
- `access_token` - Mixcloud API Access Token,
- `links_path` - path to lists of cloudcasts links

Call with `mixcloud_playlist ./filename.yml`

## Development

```sh
crystal spec
```

## Contributing

1. Fork it ( https://github.com/arr-dev/mixcloud_playlist.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[arr-dev]](https://github.com/arr-dev) nenadpet - creator, maintainer
