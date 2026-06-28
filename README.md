# Homebrew Tap for TribeEco

Decentralized Social Protocol on Solana.

Two formulas ship in this tap:

| Formula | What it installs |
|---------|-----------------|
| `tribe` | Hub + ER server + CLI (`tribe` command) |
| `tribe-app` | Next.js demo frontend (`tribe-app` command) |

## Install

```bash
brew tap chaalpritam/tribe

# Hub + ER stack (the protocol node):
brew install tribe

# Demo frontend (optional, separate):
brew install tribe-app
```

Both auto-install their dependencies (Docker, Colima, Node.js, pnpm, Solana CLI for `tribe`; Node.js and pnpm for `tribe-app`).

## tribe — Hub + ER Stack

```bash
tribe start          # boot all services (auto-starts Colima if needed)
tribe stop           # shut everything down
tribe status         # check what's running
tribe doctor         # verify prerequisites; auto-generates server wallet if missing
tribe logs [svc]     # tail logs (hub, er-server, all)
tribe network        # show all access URLs (local, LAN, seed)
tribe share          # print copy-paste hub/ER URLs + reachability self-check
tribe backup [file]  # snapshot DBs + wallet + seed + media to a tar.gz
tribe restore <file> # restore from a backup
tribe reset          # wipe data and start fresh
tribe version        # print version
```

### Network & Peers

```bash
tribe seed set <url>        # connect to a seed node (ws:// or wss://)
tribe peers                 # show connected hub peers
tribe peer add <url>        # connect to another hub directly
tribe sync                  # show sync coverage per peer
tribe sync --peer <hub-id>  # force a hard catch-up from one peer
tribe sync --peer all       # force catch-up from every connected peer
```

### Hub Identity

```bash
tribe hub-id              # show this hub's gossip ID
tribe hub-id set <name>   # set a custom hub ID
tribe hub-id reset        # reset to a random unique ID
```

## tribe-app — Demo Frontend

```bash
tribe-app                    # start Next.js dev server on port 3002
tribe-app link <hub-url>     # point the UI at a specific hub (saves to ~/.tribe/tribe-app.env)
```

## What gets installed by `brew install tribe`

| Dependency | Purpose |
|---|---|
| node | Runtime for hub, ER server |
| pnpm | Package manager |
| docker | Container runtime (CLI) |
| docker-compose | Multi-container orchestration |
| colima | Lightweight Docker runtime for macOS |
| solana | Server wallet generation |

## What `brew install` actually does

The formula does the bare minimum to get the CLI on your `$PATH`:

1. Copies the TribeEco project into `libexec` and exposes `bin/tribe`.
2. `post_install` initialises submodules (excluding `tribe-app`, which has its own formula) and installs dependencies.
3. Restores `~/.tribe/server-wallet.json` if a previous install left one behind.

It does **not** start Colima, run `tribe doctor`, or generate a wallet. After install:

```bash
tribe doctor   # verify prerequisites and (if needed) generate the server wallet
tribe start    # boot the stack
```

## Persistent state (`~/.tribe/`)

| File | Contents |
|------|----------|
| `server-wallet.json` | ER server Solana keypair — survives reinstalls |
| `hub-id` | This hub's gossip identifier (auto-generated on first `tribe start`) |
| `seed` | Seed node WebSocket URL (set via `tribe seed set <url>`) |
| `tribe-app.env` | `NEXT_PUBLIC_HUB_URL` + `NEXT_PUBLIC_ER_SERVER_URL` for the demo UI |

## Uninstall

```bash
brew uninstall tribe
brew uninstall tribe-app   # if installed
brew untap chaalpritam/tribe
```

Server wallet is preserved at `~/.tribe/server-wallet.json` across reinstalls.

## Related Repos

| Repo | Description |
|------|-------------|
| [tribe-protocol](../tribe-protocol) | Solana programs (Anchor) — 12 programs: tid-registry, app-key-registry, username-registry, social-graph w/ ER delegation, hub-registry, tip-registry, crowdfund-registry, task-registry, channel-registry, karma-registry, poll-registry, event-registry |
| [tribe-sdk](../tribe-sdk) | TypeScript SDK — DirectSolana and EphemeralRollup providers; clients for identity, tweets, DMs, profiles, channels, bookmarks, polls, events, tasks, crowdfunds, tips, search |
| [tribe-hub](../tribe-hub) | Decentralized hub — signed-message storage + Solana indexer + gossip peer sync; REST + WebSocket APIs |
| [tribe-er-server](../tribe-er-server) | Ephemeral Rollup sequencer — instant follows, batched L1 settlement every 10s |
| [tribe-app](../tribe-app) | Next.js frontend — protocol-first reference client with multi-node failover |
| [tribeapp.wtf](../tribeapp.wtf) | Consumer-facing web app + landing page at tribeapp.wtf — hyperlocal social built entirely on the protocol |
| [tribe-ios](../tribe-ios) | Native SwiftUI iOS client (Twitter-shaped) — full read/write against hub + ER, NaCl-box DMs, BLAKE3 + ed25519 signing via Apple CryptoKit |
| [tribe-insta](../tribe-insta) | Native SwiftUI iOS client (Instagram-shaped) — photo grid, stories, reels; same hub + envelope format as tribe-ios. Scaffolding stage — see `tribe-insta/PLAN.md` |
| [tribe-core-swift](../tribe-core-swift) | Shared Swift package consumed by tribe-ios + tribe-insta — crypto (BLAKE3, NaCl box, ed25519 signing, BIP39, SolanaHD), backup file format, envelope signer. See `tribe-core-swift/MIGRATION.md` |
| [homebrew-tap](../homebrew-tap) | Homebrew formulas: `brew install tribe` (hub + ER) and `brew install tribe-app` (demo UI) |
