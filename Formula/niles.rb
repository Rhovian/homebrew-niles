class Niles < Formula
  desc "Coordinate coding agents from different model families in tmux."
  homepage "https://github.com/Rhovian/niles"
  version "1.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.15.0/niles-aarch64-apple-darwin.tar.xz"
      sha256 "dfca994e9a3a27805c792bc39f493d8858d1ff6062e310d79989abe51c205818"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.15.0/niles-x86_64-apple-darwin.tar.xz"
      sha256 "aa5b35660aeffe976013ea35313cfcdda8d068633c4d3a2d6e1c226c3cec2fb1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Rhovian/niles/releases/download/v1.15.0/niles-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "069c4c6dfe0b98edd545c5c3437d91f1837c79c9186c1e02fcbac547470cfdda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Rhovian/niles/releases/download/v1.15.0/niles-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fdb3a9c0072c3fa27e1484244bff77d9f4fa618afc760ad00aedbe3988c800d6"
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
