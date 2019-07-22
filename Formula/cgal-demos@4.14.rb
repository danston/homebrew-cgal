class CgalExamplesAT414 < Formula
  desc "Computational Geometry Algorithms Library: Demos Version 4.14"
  homepage "https://www.cgal.org/"
  url "https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.14/CGAL-4.14.tar.xz"
  sha256 "59464b1eaee892f2223ba570a7642892c999e29524ab102a6efd7c29c94a29f7"
  version "4.14"

  keg_only :versioned_formula

  depends_on "cmake" => [:build, :test]
  depends_on "boost"
  depends_on "eigen"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "qt"
  depends_on "tbb"
  depends_on "metis"
  depends_on "zlib"
  depends_on "vtk"
  depends_on "cimg"
  depends_on "opencv@2"
  depends_on "danston/cgal/lastools"

  def install
    args = std_cmake_args + %W[
      -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
      -DCMAKE_INSTALL_NAME_DIR=#{prefix}/lib
      -DCMAKE_BUILD_TYPE=Release
      -DWITH_Eigen3=ON
      -DWITH_demos=ON
      -DBUILD_TESTING=ON
      -DQt5_DIR=/usr/local/opt/qt/lib/cmake/Qt5
      -DOpenCV_DIR=/usr/local/opt/opencv@2/share/OpenCV
    ]

    FileUtils.cp_r "demos/.", "#{prefix}/"
    system "cmake", ".", *args
    system "make", "install"
    system "ctest", "-L", "AABB_tree", "-E", "execution___of__"
    
    puts "\nInstalling demos for CGAL 4.14..."
    (Dir.entries("demos/") - [".", ".."]).each{|dirname| 
      
      if File.directory?("demos/#{dirname}/") then
        (Dir.entries("demos/#{dirname}/") - [".", ".."]).each{|filename| 

          if File.file?("demos/#{dirname}/#{filename}") then
            extension = File.extname("demos/#{dirname}/#{filename}")

            if extension == "" && filename != "Makefile" && filename != "skip_vcproj_auto_generation"
              puts "demos/#{dirname}/#{filename}"
              FileUtils.cp "demos/#{dirname}/#{filename}", "#{prefix}/#{dirname}/"
            end
          end
        }
      end
    }
  end

  test do
    system "true"
  end
end
