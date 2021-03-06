class CgalDemosAT414 < Formula
  desc "Computational Geometry Algorithms Library: Demos v.4.14"
  homepage "https://www.cgal.org/"
  url "https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.14/CGAL-4.14.tar.xz"
  sha256 "59464b1eaee892f2223ba570a7642892c999e29524ab102a6efd7c29c94a29f7"

  bottle do
    root_url "https://dl.bintray.com/danston/bottles-cgal"
    cellar :any
    sha256 "18a941acfe97fd798d4f5e9c74e8d14288f528b0958ee8541de262dcde6969a4" => :mojave
    sha256 "811f72cd8e8e36b1804af8fe22522e7280d0ba5765ff20d5ad15e9bbd510ab92" => :high_sierra
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
      -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
      -DCMAKE_INSTALL_NAME_DIR=#{lib}
      -DCMAKE_BUILD_TYPE=Release
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

    puts "\nInstalling demos for CGAL 4.14..."
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
