class Lastools < Formula
  desc "LAS tools"
  homepage "https://rapidlasso.com/LAStools"
  url "https://github.com/danston/cgal-brew/raw/master/lastools.tar.gz"
  sha256 "74849f068573825ba98e293f03985447130e824b2a7c8f1c6f8e2eddabf0a6db"
  version "1.0"

  def install
    include.install Dir["LASlib/inc/*"]
    lib.install "LASlib/lib/liblas.a"
    include.install Dir["LASzip/src/*"]
  end

  test do
    system "true"
  end
end
