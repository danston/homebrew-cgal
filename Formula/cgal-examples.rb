class CgalExamples < Formula
  desc "Computational Geometry Algorithms Library: Examples"
  homepage "https://www.cgal.org/"
  url "https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.14/CGAL-4.14.tar.xz"
  sha256 "59464b1eaee892f2223ba570a7642892c999e29524ab102a6efd7c29c94a29f7"
  version "4.14"

  depends_on "cmake" => [:build, :test]
  depends_on "boost"
  depends_on "eigen"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "qt"
  depends_on "tbb"
  depends_on "suite-sparse"
  depends_on "open-mesh"
  depends_on "mpfi"
  depends_on "metis"
  depends_on "opencv@2"
  depends_on "danston/cgal/esbtl"
  depends_on "danston/cgal/lastools"

  def install
    args = std_cmake_args + %W[
      -DCMAKE_BUILD_TYPE="Release"
      -DWITH_Eigen3=ON
      -DWITH_examples=ON
      -DBUILD_TESTING=ON
      -DQt5_DIR="/usr/local/opt/qt/lib/cmake/Qt5"
      -DOpenCV_DIR="/usr/local/opt/opencv@2/share/OpenCV"
    ]

    system "cmake", ".", *args
    system "ctest", "examples/AABB_tree/", "-E", "execution___of__"

    include.install Dir["examples/AABB_tree/*"]
  end

  test do
    system "true"
  end
end
