class CgalExamples < Formula
  desc "Precompiled CGAL examples."
  homepage "https://github.com/CGAL/cgal"
  url "https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.14/CGAL-4.14.tar.xz"
  sha256 "59464b1eaee892f2223ba570a7642892c999e29524ab102a6efd7c29c94a29f7"
  version "4.14"

  depends_on "cmake" => [:build]
  depends_on "cgal"
  depends_on "boost"
  depends_on "eigen"
  depends_on "gmp"
  depends_on "mpfr"

  def install
    args = std_cmake_args + %W[
      -DCMAKE_BUILD_TYPE=Release
    ]
    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    system "true"
  end
end
