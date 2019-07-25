class Esbtl < Formula
  desc "Easy Structural Biology Template Library"
  homepage "https://esbtl.sourceforge.io/"
  url "https://github.com/danston/cgal-brew/raw/master/esbtl.tar.gz"
  version "1.0"
  sha256 "7b728ae51419bc8cda918f4770e68ef08fd6053df2144af1cb052479633af9a9"

  def install
    include.install Dir["include/*"]
  end

  test do
    system "true"
  end
end
