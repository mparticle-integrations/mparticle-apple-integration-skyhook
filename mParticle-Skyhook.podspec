Pod::Spec.new do |s|
    s.name             = "mParticle-Skyhook"
    s.version          = "7.9.1"
    s.summary          = "Skyhook integration for mParticle"

    s.description      = <<-DESC
                       This is the Skyhook integration for mParticle.
                       DESC

    s.homepage         = "https://www.mparticle.com"
    s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
    s.author           = { "mParticle" => "support@mparticle.com" }
    s.source           = { :git => "https://github.com/mparticle-integrations/mparticle-apple-integration-skyhook.git", :tag => s.version.to_s }
    s.social_media_url = "https://twitter.com/mparticle"

    s.ios.deployment_target = "8.0"
    s.ios.source_files      = 'mParticle-Skyhook/*.{h,m,mm}'
    s.ios.dependency 'mParticle-Apple-SDK/mParticle', '~> 7.9.0'
    s.ios.dependency 'SkyhookContext', '~> 2.0.3'

end
