class Cgal < Formula
  desc "Easy Structural Biology Template Library"
  homepage "http://esbtl.sourceforge.net"
  url "https://github.com/danston/cgal-brew/raw/master/esbtl.tar.gz"
  sha256 ""

  def install
    # include.install Dir["include/*"]
  end

  test do
    system "true"
  end
end
