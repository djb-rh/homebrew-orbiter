# djb-rh/homebrew-orbiter

Homebrew tap for [Orbiter](https://github.com/djb-rh/orbiter) — seamlessly
looping turntable videos and GIFs from OpenSCAD models.

```bash
brew tap djb-rh/orbiter
brew trust djb-rh/orbiter        # Homebrew requires this for third-party taps
brew install --cask orbiter
```

Signed and notarized. macOS still asks once, the first time you open it —
a one-time confirmation with an **Open** button, which is what notarization
buys you in place of an outright block.

The cask installs OpenSCAD as a dependency, since Orbiter runs it to turn a
`.scad` into a mesh.

> **Note:** the tap name is `djb-rh/orbiter` but the repository must be called
> `homebrew-orbiter` — Homebrew adds the `homebrew-` prefix implicitly.

## Releasing a new version

From the [Orbiter repo](https://github.com/djb-rh/orbiter):

```bash
./Scripts/make-dmg.sh 0.2.0
./Scripts/update-cask.sh 0.2.0 dist/Orbiter-0.2.0.dmg
```

Then copy `Casks/orbiter.rb` here and push. `update-cask.sh` stamps the version
and the DMG's SHA-256, which Homebrew verifies on download.
