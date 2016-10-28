# Docker Host
A tool for quickly switching between your Docker configurations!

## How to build
Use [dub](https://code.dlang.org/getting_started)

Build with dmd
```
# dub build -b release
```

Build with ldc2
```
# dub build -b release --compiler=ldc2
```

## How to use
List configurations
```
# dockerHost list
JoyentEast
HomeWindows
```

Switch to a named configuration
```
# eval $(dockerHost env JoyentEast)
```

## How to configure

### Adding configurations
Edit `configurations` in `source/app.d` to define your environment variables.
Then, rebuild the binary and put it in your path.

### Using fish instead of bash?
Edit `dub.json` and change "BashShell" to "FishShell" and rebuild.