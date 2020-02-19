class CgalExamplesAT501 < Formula
  desc "Computational Geometry Algorithms Library: Examples v.5.0.1"
  homepage "https://www.cgal.org/"
  url "https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-5.0.1/CGAL-5.0.1.tar.xz"
  sha256 "66021111fe536268d044e5e01bd26e691d7b493c217a1ca4d9427284dd4b2a02"

  bottle do
    root_url "https://dl.bintray.com/danston/bottles-cgal"
    cellar :any
    sha256 "85a9d9b8838973b73d5f4bdfc8f62c772848cde9b6abc04842f62c1ffcb976cd" => :catalina
    sha256 "247f24ce0070871266cd3016abacad2dcbdd1b7c667aa63822c300a544a43392" => :mojave
  end

  keg_only :versioned_formula

  depends_on "cmake" => [:build, :test]
  depends_on "boost"
  depends_on "danston/cgal/esbtl"
  depends_on "danston/cgal/lastools"
  depends_on "eigen"
  depends_on "gmp"
  depends_on "metis"
  depends_on "mpfi"
  depends_on "mpfr"
  depends_on "opencv@2"
  depends_on "qt"
  depends_on "suite-sparse"
  depends_on "tbb"
  depends_on "vtk"
  depends_on "zlib"

  def install
    args = std_cmake_args + %W[
      -DCMAKE_CXX_FLAGS='-std=c++14'
      -DCMAKE_CXX_FLAGS='-DCGAL_DO_NOT_USE_BOOST_MP'
      -DWITH_Eigen3=ON
      -DWITH_examples=ON
      -DBUILD_TESTING=ON
      -DQt5_DIR=#{HOMEBREW_PREFIX}/opt/qt/lib/cmake/Qt5
      -DOpenCV_DIR=#{HOMEBREW_PREFIX}/opt/opencv@2/share/OpenCV
    ]

    cp_r "examples/.", "#{prefix}/"
    system "cmake", ".", *args
    system "make", "install"
    system "ctest", "--timeout", "60000", "-E", "execution___of__"

    puts "\nInstalling examples for CGAL 5.0.1..."
    (Dir.entries("examples/") - [".", ".."]).each do |dirname|
      next unless File.directory?("examples/#{dirname}/")

      (Dir.entries("examples/#{dirname}/") - [".", ".."]).each do |filename|
        next unless File.file?("examples/#{dirname}/#{filename}")

        extension = File.extname("examples/#{dirname}/#{filename}")
        if extension == "" && filename != "Makefile" && filename != "skip_vcproj_auto_generation"
          puts "examples/#{dirname}/#{filename}"
          cp "examples/#{dirname}/#{filename}", "#{prefix}/#{dirname}/"
        end
      end
    end
  end

  test do
    # https://doc.cgal.org/latest/AABB_tree/AABB_tree_2AABB_insertion_example_8cpp-example.html
    system "#{prefix}/AABB_tree/AABB_insertion_example"
  end
end
