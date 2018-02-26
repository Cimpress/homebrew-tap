class Auth0PasswordGrant < Formula
  desc "CLI Auth0 access tokens through the Resource Owner Password Grant"
  homepage "https://github.com/Igrom/auth0-password-grant"
  url "https://github.com/Igrom/auth0-password-grant/archive/1.0.6.tar.gz"
  version "1.0.6"
  sha256 "feefa494505220fcae2ed9e1a905a704ec56baacb63d077257cbf1fbfe5e0785"
   def install
     system "make", "CONFIG_PATH=#{etc}/auth0-password-grant"
     bin.install "bin/auth0-password-grant"

     system "mkdir", "-p", "conf/auth0-password-grant"
     system "cp", "config", "conf/auth0-password-grant"
     system "sed", "-i", 's/AUTH_URL=.*/AUTH_URL="cimpress.auth0.com"/', "conf/auth0-password-grant/config"
     system "sed", "-i", 's/CLIENT_ID=.*/CLIENT_ID="ST0wwOc0RavK6P6hhAPZ9Oc2XFD2dGUF"/', "conf/auth0-password-grant/config"
     system "sed", "-i", 's/REALM=.*/REALM="CimpressADFS"/', "conf/auth0-password-grant/config"
     system "sed", "-i", 's#AUDIENCE=.*#AUDIENCE="https://api.cimpress.io/"#', "conf/auth0-password-grant/config"
     etc.install "conf/auth0-password-grant"

     man.install "doc/man1", "doc/man5"
  end
   test do
    system "#{bin}/auth0-password-grant", "-v"
  end
end
