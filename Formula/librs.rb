class Librs < Formula
  desc "Real Solutions Software"
  homepage "http://vegas.loria.fr/rs/"
  url "https://github.com/danston/cgal-brew/raw/master/librs.tar.gz"
  version "3.1.0"
  sha256 "fcf56baad24d3ab78e630b8d9571a3b2665b5564f75cd568e04442e76eb8a2d4"

  keg_only :versioned_formula

  depends_on "mpfi"

  def install
    include.install Dir["include/*"]
    lib.install Dir["UNIVERSAL_Darwin/lib/*"]
    bin.install Dir["UNIVERSAL_Darwin/bin/*"]
  end

  test do
    system "true"
  end
end
