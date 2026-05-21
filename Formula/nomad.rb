class Nomad < Formula
  desc "Headless browser engine — extract structured web data 100x faster than Chrome"
  homepage "https://nomad.abdallahzain.dev"
  version "1.2.0"
  license "AGPL-3.0"

  bottle :unneeded

  if Hardware::CPU.arm?
    url "https://github.com/Abdallah4Z/Nomad/releases/download/v1.2.0/nomad-daemon-macos-arm64"
    sha256 "TODO-run-brew-fetch-nomad-to-get-sha"
  else
    url "https://github.com/Abdallah4Z/Nomad/releases/download/v1.2.0/nomad-daemon-macos-x86_64"
    sha256 "TODO-run-brew-fetch-nomad-to-get-sha"
  end

  resource "nom-cli" do
    if Hardware::CPU.arm?
      url "https://github.com/Abdallah4Z/Nomad/releases/download/v1.2.0/nom-macos-arm64"
      sha256 "TODO"
    else
      url "https://github.com/Abdallah4Z/Nomad/releases/download/v1.2.0/nom-macos-x86_64"
      sha256 "TODO"
    end
  end

  def install
    bin.install "nomad-daemon"
    resource("nom-cli").stage { bin.install "nom" }
  end

  def caveats
    <<~EOS
      Start the daemon:
        MALLOC_ARENA_MAX=1 PORT=8000 nomad-daemon &

      Fetch a page:
        nom browse https://example.com

      Get shell completions:
        source <(nom --completions zsh)
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/nomad-daemon --help 2>&1")
  end
end
