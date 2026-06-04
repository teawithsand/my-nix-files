# My nix file

My configuration of my nixos comptuers.

## How to use it?

Provided you have nixos, run:
```
sudo nixos-rebuild switch --refresh --flake github:teawithsand/my-nix-files/master#develop-pc
```

This will switch your configuration to `develop-pc`; Use any other PC name after `#` to select different configuration.

## License

This "project" is WTFPL licensed.

### Rationale

Quoting from https://www.wtfpl.net/about/
```
There is a long ongoing battle between GPL zealots and BSD fanatics, about which license type is the most free of the two.
In fact, both license types have unacceptable obnoxious clauses (such as reproducing a huge disclaimer that is written in all caps) that severely restrain our freedoms.
The WTFPL can solve this problem.
```

Hence I've used it
