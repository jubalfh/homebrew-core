class Docutils < Formula
  desc "Text processing system for reStructuredText"
  homepage "http://docutils.sourceforge.net"
  url "https://downloads.sourceforge.net/project/docutils/docutils/0.12/docutils-0.12.tar.gz"
  sha256 "c7db717810ab6965f66c8cf0398a98c9d8df982da39b4cd7f162911eb89596fa"

  bottle do
    cellar :any_skip_relocation
    sha256 "6254928e32d119dbce4fc37f0a84306942f760696ecae02f8db4654934a238e6" => :sierra
    sha256 "ee05c025462c3a5cb0ffd524e8fa146c1b3918eb4f4c6fd1006ea4bf4ae5db96" => :el_capitan
    sha256 "a0cb7ec024d31a9f6f3bbcde7f07249e966bf9000008f7aee46a0978dcda9cb9" => :yosemite
    sha256 "61fe1f390fdef3c130f46d66123a483ab0d15994420c89884fb0e99143ff8c19" => :mavericks
    sha256 "566de01b11bf38b9f357be753be451e30de86eb739d1fda3f7e753efc96f4c64" => :x86_64_linux
  end

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    ENV.prepend_create_path "PYTHONPATH", HOMEBREW_PREFIX/"lib/python2.7/site-packages" unless OS.mac?
    system "#{bin}/rst2man.py", "#{prefix}/HISTORY.txt"
  end
end
