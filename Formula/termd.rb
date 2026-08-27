class Termd < Formula
  desc "Render Markdown and LaTeX in terminal AI clients"
  homepage "https://github.com/kongtaoxing/termd"
  url "https://github.com/kongtaoxing/termd/releases/download/v0.0.1/termd-0.0.1-macos-arm64.tar.gz"
  version "0.0.1"
  sha256 "1f89d19dbd4514852109028aedf4c70dd1347c7e7cf4dc4037bf00eddca8041a"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "termd"
  end

  def caveats
    <<~EOS
      Print terminal configuration snippets with:
        termd ghostty-config
        termd vscode-config

      Both configurations resolve termd from PATH, so upgrades do not require
      changing an absolute binary path.
    EOS
  end

  test do
    assert_match "termd 0.0.1", shell_output("#{bin}/termd --version")
    assert_match "command = direct:termd ghostty", shell_output("#{bin}/termd ghostty-config")
    assert_match '"path": "termd"', shell_output("#{bin}/termd vscode-config")
  end
end
