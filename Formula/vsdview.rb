class Vsdview < Formula
  desc "Read-only viewer for Microsoft Visio files (.vsdx/.vsd)"
  homepage "https://github.com/yeager/vsdview"
  url "https://github.com/yeager/vsdview/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "826042285f0960e5646f9ce1538725d9d09e77dd7faccc2dffeef1733e59bb81"
  license "GPL-3.0-or-later"

  depends_on "gtk4"
  depends_on "libadwaita"
  depends_on "pygobject3"
  depends_on "librsvg"
  depends_on "python@3.13"

  def install
    libexec.install Dir["vsdview"]
    libexec.install Dir["po"] if Dir.exist?("po")
    libexec.install Dir["locale"] if Dir.exist?("locale")

    python = Formula["python@3.13"].opt_bin/"python3.13"

    (bin/"vsdview").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}"
      exec "#{python}" -m vsdview "$@"
    EOS
    (bin/"vsdview").chmod 0755
  end

  test do
    system Formula["python@3.13"].opt_bin/"python3.13", "-c",
      "import sys; sys.path.insert(0, '#{libexec}'); from vsdview import __version__; print(__version__)"
  end
end
