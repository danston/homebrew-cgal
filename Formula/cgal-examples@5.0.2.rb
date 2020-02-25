class CgalExamplesAT502 < Formula
  desc "Computational Geometry Algorithms Library: Examples v.5.0.2"
  homepage "https://www.cgal.org/"
  url "https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-5.0.2/CGAL-5.0.2.tar.xz"
  sha256 "bb3594ba390735404f0972ece301f369b1ff12646ad25e48056b4d49c976e1fa"

  bottle do
    cellar :any
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

    puts "\nInstalling examples for CGAL 5.0.2..."
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
