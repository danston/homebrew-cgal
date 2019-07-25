class CgalDemosAT413 < Formula
  desc "Computational Geometry Algorithms Library: Demos v.4.13"
  homepage "https://www.cgal.org/"
  url "https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.13/CGAL-4.13.tar.xz"
  sha256 "3e3dd7a64febda58be54c3cbeba329ab6a73b72d4d7647ba4931ecd1fad0e3bc"

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
      -DQt5_DIR=/usr/local/opt/qt/lib/cmake/Qt5
      -DOpenCV_DIR=/usr/local/opt/opencv@2/share/OpenCV
    ]

    cp_r "demo/.", "#{prefix}/"
    system "cmake", ".", *args
    system "make", "install"
    system "ctest", "-L", "AABB_tree", "--timeout", "30000", "-E", "execution___of__"

    puts "\nInstalling demos for CGAL 4.13..."
    (Dir.entries("demo/") - [".", ".."]).each do |dirname|
      next unless File.directory?("demo/#{dirname}/")

      (Dir.entries("demo/#{dirname}/") - [".", ".."]).each do |filename|
        next unless File.file?("demo/#{dirname}/#{filename}") do
          extension = File.extname("demo/#{dirname}/#{filename}")
          # if extension == "" && filename != "Makefile" && filename != "skip_vcproj_auto_generation"
          #   puts "demo/#{dirname}/#{filename}"
          #   cp "demo/#{dirname}/#{filename}", "#{prefix}/#{dirname}/"
          # end

          if extension == ""
            puts "debug"
            puts "demo/#{dirname}/#{filename}"
            lib.cp "demo/#{dirname}/#{filename}"
          end
        end
      end
    end
  end

  test do
    system "true"
  end
end
