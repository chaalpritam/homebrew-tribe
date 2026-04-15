class Tribe < Formula
  desc "TribeEco - Decentralized Social Protocol on Solana"
  homepage "https://github.com/chaalpritam/TribeEco"
  url "https://github.com/chaalpritam/TribeEco.git",
      branch: "master"
  version "0.1.0"
  license "MIT"

  depends_on "node"
  depends_on "pnpm"
  depends_on "docker"
  depends_on "docker-compose"
  depends_on "colima"
  depends_on "solana"

  def install
    libexec.install Dir["*"]
    libexec.install ".gitmodules"
    libexec.install ".gitignore"

    # Wrapper that sets TRIBE_HOME and delegates to the real CLI
    (bin/"tribe").write <<~EOS
      #!/bin/bash
      export TRIBE_HOME="#{libexec}"
      exec "#{libexec}/bin/tribe" "$@"
    EOS
  end

  def post_install
    system "git", "-C", libexec.to_s, "submodule", "update", "--init", "--recursive"
    # Install frontend dependencies
    system "pnpm", "install", "--dir", "#{libexec}/tribe-app"

    # Generate ER server wallet if missing
    wallet = "#{libexec}/tribe-er-server/server-wallet.json"
    unless File.exist?(wallet)
      ohai "Generating ER server wallet..."
      system "solana-keygen", "new", "-o", wallet, "--no-bip39-passphrase"
    end
  end

  def caveats
    <<~EOS
      TribeEco installed! Run 'tribe doctor' to verify your setup.

      Quick start:
        tribe doctor       # verify prerequisites
        tribe start        # boot everything
        tribe status       # check services
        tribe stop         # shut down

      Colima starts automatically when you run 'tribe start'.
    EOS
  end

  test do
    assert_match "tribe #{version}", shell_output("#{bin}/tribe version")
  end
end
