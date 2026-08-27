class Termmd < Formula
  desc "Render Markdown and LaTeX formulas in modern terminals"
  homepage "https://github.com/kongtaoxing/homebrew-tap"
  url "https://raw.githubusercontent.com/kongtaoxing/homebrew-tap/main/Artifacts/termmd-0.2.0-macos-arm64.tar.gz"
  mirror "file://#{File.expand_path("../Artifacts/termmd-0.2.0-macos-arm64.tar.gz", __dir__)}"
  sha256 "8ac5311bc91425a87a6f28af0f7a3cc1a642f9fe73ba1ac896d17ca0353a71b9"
  version "0.2.0"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "termmd"
  end

  def caveats
    <<~EOS
      Print terminal configuration snippets with:
        termmd ghostty-config
        termmd vscode-config

      Both configurations resolve termmd from PATH, so upgrades do not require
      changing an absolute binary path.
    EOS
  end

  test do
    assert_match "termmd 0.2.0", shell_output("#{bin}/termmd --version")
    assert_match "command = direct:termmd ghostty", shell_output("#{bin}/termmd ghostty-config")
    assert_match '"path": "termmd"', shell_output("#{bin}/termmd vscode-config")
  end
end
