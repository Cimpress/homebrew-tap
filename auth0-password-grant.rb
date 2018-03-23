Cimpress = {
  "AUTH_URL" => "cimpress.auth0.com",
  "CLIENT_ID" => "ST0wwOc0RavK6P6hhAPZ9Oc2XFD2dGUF",
  "REALM" => "CimpressADFS",
  "AUDIENCE" => "https://api.cimpress.io/"
}

class Auth0PasswordGrant < Formula
  desc "CLI Auth0 access tokens through the Resource Owner Password Grant"
  homepage "https://github.com/Igrom/auth0-password-grant"
  url "https://github.com/Igrom/auth0-password-grant/archive/1.0.7.tar.gz"
  version "1.0.7"
  sha256 "abbbbb77c5bcf2bf38e6bca44530381b404b87953f1e1cbb2a61587fbf6230b9"
  def install
    system "mkdir", "bin"

    main = File.read "auth0-password-grant"
    main.sub! /CONFIG_PATH=[^\n]*\n/, "CONFIG_PATH=#{etc}/auth0-password-grant"
    File.write "bin/auth0-password-grant", main

    bin.install "bin/auth0-password-grant"

    system "mkdir", "-p", "conf/auth0-password-grant"

    config = File.read "config"
    Cimpress.each { |k, v| config.gsub! /#{k}=[^\n]*\n/, "#{k}=#{v}\n" }
    File.write "conf/auth0-password-grant/config", config

    etc.install "conf/auth0-password-grant"
    man.install "doc/man1", "doc/man5"
  end
  test do
    system "#{bin}/auth0-password-grant", "-v"
  end
end
