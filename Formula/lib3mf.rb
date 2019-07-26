class Lib3mf < Formula
  desc "3D Manufacturing Format file standard"
  homepage "https://github.com/3MFConsortium/lib3mf"
  url "https://github.com/danston/cgal-brew/raw/master/lib3mf.tar.gz"
  version "1.8.1"
  sha256 ""

  depends_on "ossp-uuid"

  def install
    args = std_cmake_args + %W[
      -DCMAKE_BUILD_TYPE=Release
    ]

    system "cmake", "."
    system "make", "install"
  end

  test do
    system "true"
  end
end
