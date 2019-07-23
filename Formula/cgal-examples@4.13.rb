class CgalExamplesAT413 < Formula
  desc "Computational Geometry Algorithms Library: Examples Version 4.13"
  homepage "https://www.cgal.org/"
  url "https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.13/CGAL-4.13.tar.xz"
  sha256 "3e3dd7a64febda58be54c3cbeba329ab6a73b72d4d7647ba4931ecd1fad0e3bc"
  version "4.13"

  keg_only :versioned_formula

  depends_on "cmake" => [:build, :test]
  depends_on "boost"
  depends_on "eigen"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "qt"
  depends_on "tbb"
  depends_on "zlib"
  depends_on "suite-sparse"
  depends_on "open-mesh"
  depends_on "mpfi"
  depends_on "metis"
  depends_on "vtk"
  depends_on "opencv@2"
  depends_on "danston/cgal/esbtl"
  depends_on "danston/cgal/lastools"

  def install
    args = std_cmake_args + %W[
      -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
      -DCMAKE_INSTALL_NAME_DIR=#{prefix}/lib
      -DCMAKE_BUILD_TYPE=Release
      -DWITH_Eigen3=ON
      -DWITH_examples=ON
      -DBUILD_TESTING=ON
      -DQt5_DIR=/usr/local/opt/qt/lib/cmake/Qt5
      -DOpenCV_DIR=/usr/local/opt/opencv@2/share/OpenCV
    ]

    FileUtils.cp_r "examples/.", "#{prefix}/"
    system "cmake", ".", *args
    system "make", "install"
    system "ctest", "-E", "execution___of__"
    
    puts "\nInstalling examples for CGAL 4.13..."
    (Dir.entries("examples/") - [".", ".."]).each{|dirname| 
      
      if File.directory?("examples/#{dirname}/") then
        (Dir.entries("examples/#{dirname}/") - [".", ".."]).each{|filename| 

          if File.file?("examples/#{dirname}/#{filename}") then
            extension = File.extname("examples/#{dirname}/#{filename}")

            if extension == "" && filename != "Makefile" && filename != "skip_vcproj_auto_generation"
              puts "examples/#{dirname}/#{filename}"
              FileUtils.cp "examples/#{dirname}/#{filename}", "#{prefix}/#{dirname}/"
            end
          end
        }
      end
    }
  end

  test do
    # https://doc.cgal.org/latest/AABB_tree/AABB_tree_2AABB_insertion_example_8cpp-example.html
    system "#{prefix}/AABB_tree/AABB_insertion_example"
  end
end
