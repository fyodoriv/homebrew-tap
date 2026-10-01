class Taskgrind < Formula
  desc "Autonomous multi-session grind — runs sequential AI coding sessions until a deadline"
  homepage "https://github.com/fyodoriv/taskgrind"
  url "https://github.com/fyodoriv/taskgrind/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "95dae48d400ddbd863a7da0177dc17e945a2d96d004378fd478b86588342279f"
  license "MIT"
  head "https://github.com/fyodoriv/taskgrind.git", branch: "main"

  depends_on "bats-core" => :test
  depends_on "shellcheck" => :test

  def install
    bin.install "bin/taskgrind"
    lib.install Dir["lib/*"]
    man1.install "man/taskgrind.1"
  end

  test do
    assert_match "taskgrind", shell_output("#{bin}/taskgrind --help")
    assert_match(/[0-9a-f]+/, shell_output("#{bin}/taskgrind --version"))
  end
end
