class Niles < Formula
  desc "Coordinate coding agents from different model families in tmux."
  homepage "https://github.com/Rhovian/niles"
  version "1.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.9.0/niles-aarch64-apple-darwin.tar.xz"
      sha256 "eee58e37c14658e68115972c0af468a8a4ec62181a774398967fe4770039282f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.9.0/niles-x86_64-apple-darwin.tar.xz"
      sha256 "db4ed54f8a01c06fa81763b31281eb728efec9a8679ddd4165e5c49fcdeecef0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.9.0/niles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cfb4f9c65b921ca422300085d6be8d580ac94e105a7df7d7335043a387222eec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.9.0/niles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3449caeb2e3425f42caf735043b21af034cff3c182948ab98862bd727d7cda16"
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
