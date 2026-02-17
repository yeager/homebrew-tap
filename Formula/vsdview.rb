class Vsdview < Formula
  desc "Read-only viewer for Microsoft Visio files (.vsdx/.vsd)"
  homepage "https://github.com/yeager/vsdview"
  url "https://api.github.com/repos/yeager/vsdview/tarball/v0.3.1"
  sha256 "edc05cb59c85d3276fd674d9781970a41390c927088ccd414d2b8b44306401f1"
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
