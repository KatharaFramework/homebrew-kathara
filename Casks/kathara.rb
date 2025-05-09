cask "kathara" do
  version "3.7.9"
  name "Kathara"
  desc "Lightweight network emulation tool."
  homepage "https://github.com/KatharaFramework/Kathara"

  if Hardware::CPU.arm?
    url "https://github.com/KatharaFramework/Kathara/releases/download/#{version}/Kathara-macos-installer-arm64-#{version}.pkg"
    sha256 :no_check

    pkg "Kathara-macos-installer-arm64-#{version}.pkg", allow_untrusted: true
  end

  if Hardware::CPU.intel?
    url "https://github.com/KatharaFramework/Kathara/releases/download/#{version}/Kathara-macos-installer-x86_64-#{version}.pkg"
    sha256 :no_check

    pkg "Kathara-macos-installer-x86_64-#{version}.pkg", allow_untrusted: true
  end

  livecheck do
    url :homepage
    regex(/^((\d+)\.(\d+)\.(\d+))$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]
  
        match = json[0]["tag_name"]&.match(regex)
        next if match.blank?
  
        match[1]
      end
    end
  end

  uninstall script:  {
    executable: "/Library/Kathara/uninstall.sh",
    sudo:       true,
  },
  pkgutil: "org.kathara.kathara"
end
