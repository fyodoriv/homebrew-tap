class Taskgrind < Formula
  desc "Autonomous multi-session grind — runs sequential AI coding sessions until a deadline"
  homepage "https://github.com/cbrwizard/taskgrind"
  url "https://github.com/cbrwizard/taskgrind/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "26752e3ed6824b67bc2d2f99918bbbf831bc588eb8d8c5a0b33294edeb202614"
  license "MIT"
  head "https://github.com/cbrwizard/taskgrind.git", branch: "main"

  depends_on "bats-core" => :test
  depends_on "shellcheck" => :test

  def install
    bin.install "bin/taskgrind"
    lib.install Dir["lib/*"]
    man1.install "man/taskgrind.1"

    # Rewrite TASKGRIND_DIR fallback so the installed copy finds lib/ in the
    # Homebrew prefix instead of relative to the git checkout.
    inreplace bin/"taskgrind",
      'TASKGRIND_DIR="${TASKGRIND_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"',
      "TASKGRIND_DIR=\"${TASKGRIND_DIR:-#{prefix}}\""
  end

  test do
    assert_match "taskgrind", shell_output("#{bin}/taskgrind --help")
    assert_match(/[0-9a-f]+/, shell_output("#{bin}/taskgrind --version"))
  end
end
