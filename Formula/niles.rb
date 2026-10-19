class Niles < Formula
  desc "Coordinate coding agents from different model families in tmux."
  homepage "https://github.com/Rhovian/niles"
  version "1.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.8.0/niles-aarch64-apple-darwin.tar.xz"
      sha256 "a0e24593ad82b9d1f7361ef4a34cbe4df58ef62eba3fa6b6bcd85d645f43aa29"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.8.0/niles-x86_64-apple-darwin.tar.xz"
      sha256 "20df1d67e9bf6b2a380babdd24cdf0a85426676abe16c38a3e8d526f607f16fd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.8.0/niles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6cf1ba303ad650e9cb5d48ce984e9b2ba60d4ea54ed3409744d0a6aea762fe61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.8.0/niles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "43dfb7f0004d8e5fe5c669be64d30d513d2c17522dead33f07ee6eee797980de"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "niles"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "niles"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "niles"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "niles"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
