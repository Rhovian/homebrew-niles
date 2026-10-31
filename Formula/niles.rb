class Niles < Formula
  desc "Coordinate coding agents from different model families in tmux."
  homepage "https://github.com/Rhovian/niles"
  version "1.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.11.0/niles-aarch64-apple-darwin.tar.xz"
      sha256 "43fdf49603d90b652f727fc3197b47113d0272a7404c1e277ec0d66331e057b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.11.0/niles-x86_64-apple-darwin.tar.xz"
      sha256 "fb045616cc08a96874bdb282de2881628dc9859bf4bd883a3090abf279508524"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.11.0/niles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7ca93636bdd52d82746a684d54f76cebb1be6a266b5f27a204d26fd6a2c3431"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.11.0/niles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b829ca13caa6bdab450d1aec65bf0be223c1464e63d50f81fc52b305db481372"
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
