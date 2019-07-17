class CgalExamples < Formula
  desc "Precompiled CGAL examples with the sources."
  homepage ""
  url ""
  sha256 ""
  version "4.14"

  bottle do
    cellar :any
    sha256 "" => :mojave
  end

  depends_on "boost"
  depends_on "eigen"
  depends_on "gmp"
  depends_on "mpfr"

  def install
  end

  test do
    system "true"
  end
end
