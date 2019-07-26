class Esbtl < Formula
  desc "Easy Structural Biology Template Library"
  homepage "https://esbtl.sourceforge.io/"
  url "https://github.com/danston/cgal-brew/raw/master/esbtl.tar.gz"
  version "1.0"
  sha256 ""

  def install
    include.install Dir["include/*"]
  end

  test do
    system "true"
  end
end
