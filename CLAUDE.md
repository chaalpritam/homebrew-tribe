# homebrew-tap

Homebrew formula for TribeEco (`brew tap chaalpritam/tribe && brew install tribe`).

## Repo

This is the `homebrew-tribe` repo on GitHub, included as a submodule in TribeEco at `homebrew-tap/`.

The tap name is `chaalpritam/tribe` which maps to the GitHub repo `chaalpritam/homebrew-tribe`.

## Formula (Formula/tribe.rb)

- Source: clones `https://github.com/chaalpritam/TribeEco.git` branch `master`
- Dependencies: node, pnpm, docker, docker-compose, colima, solana. Tailscale optional.
- `install`: copies project to libexec, creates a wrapper script at `bin/tribe`
- `post_install`: clones submodules, installs frontend deps, restores wallet from `~/.tribe/`

## Important Notes

- Brew's `post_install` runs in a restricted context — can't write to `~/.colima/` or start services
- Wallet is persisted at `~/.tribe/server-wallet.json` and restored on reinstall
- All submodule URLs in `.gitmodules` must be HTTPS (not SSH) for unauthenticated cloning
- Changes to the formula must be pushed to this repo AND referenced in the main TribeEco repo

## Pushing Changes

The `origin` remote uses HTTPS and can't push without credentials. Use SSH:
```bash
git push git@github.com:chaalpritam/homebrew-tribe.git main
```
Or set the remote to SSH:
```bash
git remote set-url origin git@github.com:chaalpritam/homebrew-tribe.git
```
