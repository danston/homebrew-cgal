class Esbtl < Formula
  desc "Easy Structural Biology Template Library"
  homepage "http://esbtl.sourceforge.net"
  url "https://github.com/danston/cgal-brew/raw/master/esbtl.tar.gz"
  sha256 "7b728ae51419bc8cda918f4770e68ef08fd6053df2144af1cb052479633af9a9"
  version "1.0"

  def install
    include.install Dir["include/*"]
  end

  test do
    system "true"
  end
end
