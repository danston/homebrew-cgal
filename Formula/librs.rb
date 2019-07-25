class Librs < Formula
  desc "Real Solutions Software"
  homepage "http://vegas.loria.fr/rs/"
  url "https://github.com/danston/cgal-brew/raw/master/librs.tar.gz"
  version "3.1.0"
  sha256 "ddbaef00f6a54805d8decfc7c4532bae6df4ac52d014d386703c92bcfee554e7"

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
