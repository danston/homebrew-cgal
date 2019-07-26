class Lib3mf < Formula
  desc "3D Manufacturing Format file standard"
  homepage "https://github.com/3MFConsortium/lib3mf"
  url "https://github.com/danston/cgal-brew/raw/master/lib3mf.tar.gz"
  version "1.8.1"
  sha256 "55700bf3b6f8890eb2e8b9e379da954c335737271af27a9a194005b2042a83d2"

  depends_on "cmake" => [:build, :test]
  depends_on "ossp-uuid"

  def install
    args = std_cmake_args + %w[
      -DCMAKE_BUILD_TYPE=Release
      -DBUILD_TESTING=OFF
      -DLIB3MF_TESTS=OFF
    ]

    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    system "true"
  end
end
