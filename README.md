# Homebrew Tap for TribeEco

Decentralized Social Protocol on Solana.

## Install

```bash
brew tap chaalpritam/tribe
brew install tribe
```

This auto-installs all dependencies: Docker, Docker Compose, Colima, Node.js, pnpm, Solana CLI, Cloudflare Tunnel.

## Usage

```bash
tribe start          # boot all services (auto-starts Colima if needed)
tribe stop           # shut everything down
tribe status         # check what's running
tribe doctor         # verify prerequisites
tribe logs [svc]     # tail logs (hub, er-server, app, all)
tribe network        # show all access URLs (local, LAN, tunnel)
tribe reset          # wipe data and start fresh
```

## Network & Peers

```bash
tribe tunnel         # start Cloudflare tunnels for public access
tribe seed set <url> # connect to a seed node for peer discovery
tribe peers          # show connected hub peers
tribe peer add <url> # connect to another hub directly
tribe peer sync      # show sync status with peers
```

## What gets installed

| Dependency | Purpose |
|---|---|
| node | Runtime for hub, ER server, frontend |
| pnpm | Package manager |
| docker | Container runtime (CLI) |
| docker-compose | Multi-container orchestration |
| colima | Lightweight Docker runtime for macOS |
| solana | Server wallet generation |
| cloudflared | Cloudflare tunnels for public access |

## Uninstall

```bash
brew uninstall tribe
brew untap chaalpritam/tribe
```

Server wallet is preserved at `~/.tribe/server-wallet.json` across reinstalls.
