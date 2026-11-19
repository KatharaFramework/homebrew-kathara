cask "kathara" do
  version "3.8.4"
  name "Kathara"
  desc "Lightweight network emulation tool."
  homepage "https://github.com/KatharaFramework/Kathara"

  if Hardware::CPU.arm?
    url "https://github.com/KatharaFramework/Kathara/releases/download/#{version}/Kathara-macos-installer-arm64-#{version}-signed.pkg"
    sha256 "7f8b11cc9e14e032542b0952bae2fb059fcbfab009e5626c6404fa6a7a30bf8d"

    pkg "Kathara-macos-installer-arm64-#{version}-signed.pkg"
  end

  if Hardware::CPU.intel?
    url "https://github.com/KatharaFramework/Kathara/releases/download/#{version}/Kathara-macos-installer-x86_64-#{version}-signed.pkg"
    sha256 "805892169f4229db618bd2e2935d20f5e22c276f235d03683cc5db815af1021d"

    pkg "Kathara-macos-installer-x86_64-#{version}-signed.pkg"
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
