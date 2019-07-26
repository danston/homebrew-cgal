class Bliss < Formula
  desc "Bliss graph software by TCS"
  homepage "http://www.tcs.hut.fi/Software/bliss/"
  url "https://github.com/danston/cgal-brew/raw/master/bliss.tar.gz"
  version "0.73"
  sha256 ""

  def install
    system "make", "install"
  end

  test do
    system "true"
  end
end
