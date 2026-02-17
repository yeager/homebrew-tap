class Vsdview < Formula
  desc "Read-only viewer for Microsoft Visio files (.vsdx/.vsd)"
  homepage "https://github.com/yeager/vsdview"
  url "https://github.com/yeager/vsdview/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "c96a0d7b597e9d3a7237941f8c033dd06f68a015df28678f6bb41ce60c553ac6"
  license "GPL-3.0-or-later"

  depends_on "gtk4"
  depends_on "libadwaita"
  depends_on "pygobject3"
  depends_on "librsvg"
  depends_on "python@3.13"

  def install
    # Install Python package
    libexec.install Dir["vsdview"]
    libexec.install Dir["po"] if Dir.exist?("po")
    libexec.install Dir["locale"] if Dir.exist?("locale")

    # Create wrapper script
    (bin/"vsdview").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}:$PYTHONPATH"
      exec "#{Formula["python@3.13"].opt_bin}/python3.13" -m vsdview "$@"
    EOS
  end

  test do
    system bin/"vsdview", "--help"
  end
end
