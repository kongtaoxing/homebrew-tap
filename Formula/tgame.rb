class Tgame < Formula
  desc "A Terminal game collection"
  homepage "https://github.com/kongtaoxing/terminal-games"
  license "MIT"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kongtaoxing/terminal-games/releases/download/v0.3.1/tgame-macos-arm64.tar.gz"
      sha256 "d1d554975c8d86e7a5c66fad40a61ed756f71d01717f25febff67aa00fe3863c"
    else
      url "https://github.com/kongtaoxing/terminal-games/releases/download/v0.3.0/tgame-macos-x86_64.tar.gz"
      sha256 "29458fe04996dabec8a4575a803a5c3ce6be728a2d9d8d49f497b12b83d6f577"
    end
  end

  on_linux do
    url "https://github.com/kongtaoxing/terminal-games/releases/download/v0.3.0/tgame-linux-x86_64.tar.gz"
    sha256 "54a37f52046a3eecb7b1c341790e083ee319f5a93fa226edffff86b986ab5521"
  end

  def install
    bin.install "tgame"
  end

  test do
    return if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"]

    # This is difficult to test because:
    # - There are no command line switches that make the process exit
    # - The output is a constant stream of terminal control codes
    # - Testing only if the binary exists can still result in failure

    # The test process is as follows:
    # - Spawn the process capturing stdout and the pid
    # - Kill the process after there is some output
    # - Ensure the start of the output matches what is expected

    require "pty"
    ENV["TERM"] = "xterm"
    PTY.spawn(bin/"tgame") do |stdout, stdin, _pid|
      sleep 5
      stdin.write "q"
      output = begin
        stdout.gets
      rescue Errno::EIO
        nil
      end
      assert_match "\e[?10", output[0..4]
    end
  end
end