class Nomad < Formula
  desc "Headless browser engine — extract structured data from web pages"
  homepage "https://github.com/Abdallah4Z/Nomad"
  license "AGPL-3.0"
  version "1.2.0"
  license "AGPL-3.0"

  bottle :unneeded

  if Hardware::CPU.arm?
    url "https://github.com/Abdallah4Z/Nomad/releases/download/v1.2.0/nomad-daemon-macos-arm64"
    sha256 "80e02f23d285551818676dba6c868a6348d965a5d3b38093a202e80201dfd1de"
  else
    url "https://github.com/Abdallah4Z/Nomad/releases/download/v1.2.0/nomad-daemon-macos-x86_64"
    sha256 "4d9947c19f4a15404c9b33e07957562b38c58ad5471cb7da31c25ed076d704dd"
  end

  resource "nom-cli" do
    if Hardware::CPU.arm?
      url "https://github.com/Abdallah4Z/Nomad/releases/download/v1.2.0/nom-macos-arm64"
      sha256 "315e38a6e6b88b79268cdc380113d05f19a1bc7d1a1b529cb68ab644f2681a18"
    else
      url "https://github.com/Abdallah4Z/Nomad/releases/download/v1.2.0/nom-macos-x86_64"
      sha256 "055136942d6b0ff22262e57d3419ef39e480051122427c5e8b1a8657a35cc8f6"
    end
  end

  def install
    bin.install "nomad-daemon"
    # CLI tool
    if Hardware::CPU.arm?
      system "curl", "-fsL", "-o", "#{bin}/nom", "https://github.com/Abdallah4Z/Nomad/releases/latest/download/nom-macos-arm64"
    else
      system "curl", "-fsL", "-o", "#{bin}/nom", "https://github.com/Abdallah4Z/Nomad/releases/latest/download/nom-macos-x86_64"
    end
    chmod "+x", "#{bin}/nom"
  end

  def caveats
    <<~EOS
      Start the daemon:
        MALLOC_ARENA_MAX=1 PORT=8000 nomad-daemon &

      Fetch a page:
        nomad-daemon --oneshot --url https://example.com --format 4

      Or use the CLI:
        nom browse https://example.com
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/nomad-daemon --oneshot 2>&1", 1)
  end
end
