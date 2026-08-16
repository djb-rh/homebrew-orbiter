# Homebrew cask for Orbiter.
#
# Lives in the personal tap first:
#   brew tap djb-rh/orbiter && brew install --cask orbiter
#
# Note the tap naming convention: `brew tap djb-rh/orbiter` looks for a repo
# called github.com/djb-rh/homebrew-orbiter — the "homebrew-" prefix is
# mandatory and implicit. This file belongs at Casks/orbiter.rb in THAT repo,
# not in the app repo; the copy here is the source of truth to publish from.
#
# Graduating to homebrew-cask proper requires the repo to clear their
# notability bar (roughly 75 stars / 30 forks / 75 watchers) and the .app to
# be signed and notarized. Until then the tap is the supported route.
#

cask "orbiter" do
  version "0.1.0"
  sha256 "8a6058c7fe339f8f2e29055277b1e9afa911a2c1e623ac2402b40eeea2e45bfb"

  url "https://github.com/djb-rh/orbiter/releases/download/v#{version}/Orbiter-#{version}.dmg",
      verified: "github.com/djb-rh/orbiter/"
  name "Orbiter"
  desc "Records seamlessly looping turntable videos and GIFs of OpenSCAD models"
  homepage "https://github.com/djb-rh/orbiter"

  depends_on macos: :sonoma

  # Orbiter shells out to the openscad binary; it does not bundle or link it.
  #
  # This must be openscad@snapshot, NOT openscad. The plain `openscad` cask is
  # pinned to 2021.01, fails the macOS Gatekeeper check, and is scheduled for
  # removal on 2026-09-01. It also predates the Manifold backend, which Orbiter
  # requires — Manifold renders CSG-heavy models orders of magnitude faster
  # than the old CGAL backend (measured: 0.9s vs 384s on a lattice test part).
  depends_on cask: "openscad@snapshot"

  app "Orbiter.app"

  # v0.1.0 is signed ad-hoc, not with a Developer ID, so macOS quarantines it
  # on download. Until releases are notarized, first launch needs one of:
  #
  #   xattr -dr com.apple.quarantine /Applications/Orbiter.app
  #
  # or right-click the app and choose Open. Saying so here beats letting people
  # discover it as a mysterious "damaged app" dialog.
  caveats <<~EOS
    Orbiter #{version} is not yet notarized. On first launch macOS will refuse
    to open it. Either right-click Orbiter and choose Open, or run:

      xattr -dr com.apple.quarantine /Applications/Orbiter.app

    Orbiter also needs OpenSCAD, which this cask installs for you.
  EOS

  zap trash: [
    "~/Library/Application Support/Orbiter",
    "~/Library/Caches/com.orbiter.app",
    "~/Library/Preferences/com.orbiter.app.plist",
    "~/Library/Saved Application State/com.orbiter.app.savedState",
  ]
end
