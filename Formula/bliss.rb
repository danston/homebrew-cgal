class Bliss < Formula
  desc "Bliss graph software by TCS"
  homepage "http://www.tcs.hut.fi/Software/bliss/"
  url "https://github.com/danston/cgal-brew/raw/master/bliss.tar.gz"
  version "0.73"
  sha256 "5bc47253666d1b9ce70364d548ed44f0aaf45121eba5eac7fdfff928f515ce41"

  def install
    system "make"

    puts "Installing bliss..."
    (Dir.entries("./") - [".", ".."]).each do |filename|
      next unless File.file?("./#{filename}")

      extension = File.extname("./#{filename}")

      if filename == "COPYING.LESSER"
        bin.install "./#{filename}"
      end

      if extension == "" && filename != "Makefile" && filename != "Doxyfile"
        bin.install "./#{filename}"
      end

      mkdir "#{include}/bliss/"
      if [".hh", ".cc", ".h"].include?(extension)
        cp "./#{filename}", "#{include}/bliss/"
      end

      if extension == ".o"
        include.install "./#{filename}"
      end

      if extension == ".a"
        lib.install "./#{filename}"
      end
    end
  end

  test do
    system "true"
  end
end
