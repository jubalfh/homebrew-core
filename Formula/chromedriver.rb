class Chromedriver < Formula
  desc "Tool for automated testing of webapps across many browsers"
  homepage "https://sites.google.com/a/chromium.org/chromedriver/"
  if OS.mac?
    url "https://chromedriver.storage.googleapis.com/2.25/chromedriver_mac64.zip"
    sha256 "e95fb36ab85264e16c51d58dd9766624eca6b6339569da0460088f4c788c67ad"
  elsif OS.linux?
    url "https://chromedriver.storage.googleapis.com/2.25/chromedriver_linux64.zip"
    sha256 "d011749e76305b5591b5500897939b33fac460d705d9815b8c03c53b0e1ecc7c"
  end
  version "2.25"

  bottle :unneeded

  def install
    bin.install "chromedriver"
  end

  plist_options :manual => "chromedriver"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>homebrew.mxcl.chromedriver</string>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <false/>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/chromedriver</string>
      </array>
      <key>ServiceDescription</key>
      <string>Chrome Driver</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/chromedriver-error.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/chromedriver-output.log</string>
    </dict>
    </plist>
    EOS
  end

  test do
    driver = fork do
      exec bin/"chromedriver", "--port=9999", "--log-path=#{testpath}/cd.log"
    end
    sleep 5
    Process.kill("TERM", driver)
    File.exist? testpath/"cd.log"
  end
end
