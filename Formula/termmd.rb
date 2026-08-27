class Termmd < Formula
  desc "Render Markdown and LaTeX formulas in modern terminals"
  homepage "https://github.com/kongtaoxing/homebrew-tap"
  url "https://raw.githubusercontent.com/kongtaoxing/homebrew-tap/main/Artifacts/termmd-0.2.2-macos-arm64.tar.gz"
  mirror "file://#{File.expand_path("../Artifacts/termmd-0.2.2-macos-arm64.tar.gz", __dir__)}"
  sha256 "78dfb891325ff424db329a8b18364200ce216bbbff60e25cdef0e29307bdfa42"
  version "0.2.2"
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
    assert_match "termmd 0.2.2", shell_output("#{bin}/termmd --version")
    assert_match "command = direct:termmd ghostty", shell_output("#{bin}/termmd ghostty-config")
    assert_match '"path": "termmd"', shell_output("#{bin}/termmd vscode-config")
  end
end
