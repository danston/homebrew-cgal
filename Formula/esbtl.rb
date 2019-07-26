class Esbtl < Formula
  desc "Easy Structural Biology Template Library"
  homepage "https://esbtl.sourceforge.io/"
  url "https://github.com/danston/cgal-brew/raw/master/esbtl.tar.gz"
  version "1.0"
  sha256 "9bbb4f3b36f5d51ed2afcbd3143bb0e5e5e035982d6aedc7fe497a36761f45db"

  def install
    include.install Dir["include/*"]
    prefix.install "EXCEPTION.txt"
  end

  test do
    system "true"
  end
end
