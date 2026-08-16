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
  version "0.1.2"
  sha256 "f52ca25ee72c58c565510a6ac426ae5c8d44e307c849e733456b94166c279c25"

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

  # Notarized, so the first-launch dialog is the benign one with an Open
  # button rather than a block. It cannot be suppressed for a cask, and it is
  # shown once, so this note exists to set the expectation rather than to warn.
  caveats <<~EOS
    The first time you open Orbiter, macOS will ask to confirm because it was
    downloaded from the internet. Click Open. It only asks once.
  EOS

  zap trash: [
    "~/Library/Application Support/Orbiter",
    "~/Library/Caches/com.orbiter.app",
    "~/Library/Preferences/com.orbiter.app.plist",
    "~/Library/Saved Application State/com.orbiter.app.savedState",
  ]
end
