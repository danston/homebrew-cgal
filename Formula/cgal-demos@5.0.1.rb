class CgalDemosAT501 < Formula
  desc "Computational Geometry Algorithms Library: Demos v.5.0.1"
  homepage "https://www.cgal.org/"
  url "https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-5.0.1/CGAL-5.0.1.tar.xz"
  sha256 "66021111fe536268d044e5e01bd26e691d7b493c217a1ca4d9427284dd4b2a02"

  bottle do
    cellar :any
  end

  keg_only :versioned_formula

  depends_on "cmake" => [:build, :test]
  depends_on "boost"
  depends_on "cimg"
  depends_on "danston/cgal/lastools"
  depends_on "eigen"
  depends_on "gmp"
  depends_on "metis"
  depends_on "mpfr"
  depends_on "opencv@2"
  depends_on "qt"
  depends_on "tbb"
  depends_on "vtk"
  depends_on "zlib"

  def install
    args = std_cmake_args + %W[
      -DCMAKE_INSTALL_NAME_DIR=#{lib}
      -DCMAKE_CXX_FLAGS='-std=c++14'
      -DCMAKE_CXX_FLAGS='-DCGAL_DO_NOT_USE_BOOST_MP'
      -DWITH_Eigen3=ON
      -DWITH_demos=ON
      -DBUILD_TESTING=ON
      -DQt5_DIR=#{HOMEBREW_PREFIX}/opt/qt/lib/cmake/Qt5
      -DOpenCV_DIR=#{HOMEBREW_PREFIX}/opt/opencv@2/share/OpenCV
    ]

    cp_r "demo/.", "#{prefix}/"
    system "cmake", ".", *args
    system "make", "install"
    system "ctest", "--timeout", "30000", "-E", "execution___of__"

    puts "\nInstalling demos for CGAL 5.01..."
    (Dir.entries("demo/") - [".", ".."]).each do |dirname|
      next unless File.directory?("demo/#{dirname}/")

      (Dir.entries("demo/#{dirname}/") - [".", ".."]).each do |filename|
        next unless File.file?("demo/#{dirname}/#{filename}")

        extension = File.extname("demo/#{dirname}/#{filename}")

        if extension == "" && filename != "Makefile" && filename != "skip_vcproj_auto_generation"
          puts "demo/#{dirname}/#{filename}"
          cp "demo/#{dirname}/#{filename}", "#{prefix}/#{dirname}/"
        end

        if extension == ".dylib"
          puts "demo/#{dirname}/#{filename}"
          cp "demo/#{dirname}/#{filename}", "#{lib}/"
        end

        if [".cpp", ".h"].include?(extension)
          puts "demo/#{dirname}/#{filename}"
          cp "demo/#{dirname}/#{filename}", "#{prefix}/#{dirname}/"
        end
      end

      next unless dirname == "Polyhedron"

      (Dir.entries("demo/#{dirname}/Plugins/") - [".", ".."]).each do |plugin|
        (Dir.entries("demo/#{dirname}/Plugins/#{plugin}/") - [".", ".."]).each do |filename|
          next unless File.file?("demo/#{dirname}/Plugins/#{plugin}/#{filename}")

          extension = File.extname("demo/#{dirname}/Plugins/#{plugin}/#{filename}")

          if [".so", ".cpp", ".h"].include?(extension)
            puts "demo/#{dirname}/Plugins/#{plugin}/#{filename}"
            cp "demo/#{dirname}/Plugins/#{plugin}/#{filename}", "#{prefix}/#{dirname}/Plugins/#{plugin}/"
          end

          if extension == ".dylib"
            puts "demo/#{dirname}/Plugins/#{plugin}/#{filename}"
            cp "demo/#{dirname}/Plugins/#{plugin}/#{filename}", "#{lib}/"
          end
        end
      end

      (Dir.entries("demo/#{dirname}/implicit_functions/") - [".", ".."]).each do |filename|
        next unless File.file?("demo/#{dirname}/implicit_functions/#{filename}")

        extension = File.extname("demo/#{dirname}/implicit_functions/#{filename}")

        if extension == ".so"
          puts "demo/#{dirname}/implicit_functions/#{filename}"
          cp "demo/#{dirname}/implicit_functions/#{filename}", "#{prefix}/#{dirname}/implicit_functions/"
        end
      end
    end
  end

  test do
    system "true"
  end
end
