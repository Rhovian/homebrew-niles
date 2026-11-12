class Niles < Formula
  desc "Coordinate coding agents from different model families in tmux."
  homepage "https://github.com/Rhovian/niles"
  version "1.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.14.0/niles-aarch64-apple-darwin.tar.xz"
      sha256 "cac86c78a763963aaee4ed61c7f8f35beebba61910cdd35d3f14e1a1eabbd1a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.14.0/niles-x86_64-apple-darwin.tar.xz"
      sha256 "50f382a6804dbbb2d0c3e7292db317670c98d97e588083c098d670a80807763a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.14.0/niles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d8c4b620e82e0818c9892cb4cfc7e97675f6e6b8467e27e004edb07928c78a42"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.14.0/niles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "228fd514c17dba203cb5fb3d957b68e0b58261e80ac1ce318f65a97e0bc97b93"
    end
  end
  license "MIT"

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
