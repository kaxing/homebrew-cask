cask 'origin' do
  version '10.5.48.31055'
  sha256 'c59608c07b4f4c7bc4ec9681087f5b8775bb877dff4b73b2115465a0c3e19084'

  # origin-a.akamaihd.net was verified as official when first introduced to the cask
  url "https://origin-a.akamaihd.net/Origin-Client-Download/origin/mac/live/OriginUpdate_#{version.dots_to_underscores}.zip"
  appcast "https://api1.origin.com/autopatch/2/upgradeFrom/#{version}/en_US/PROD?platform=MAC&osVersion=10.14.0"
  name 'Origin'
  homepage 'https://www.origin.com/'

  app 'Origin.app'

  preflight do
    # There is no enclosing .app folder, just the 'Contents' of the app in the appcast download
    FileUtils.mv(staged_path.children, staged_path.join('Origin.app').tap(&:mkpath))
  end

  zap trash: [
               '~/Library/Application Support/Origin',
               '~/Library/Saved Application State/com.ea.Origin.savedState',
               '~/Library/LaunchAgents/com.ea.origin.WebHelper.plist',
               '~/Library/Caches/com.ea.Origin',
               '~/Library/Caches/Origin',
             ]
end
