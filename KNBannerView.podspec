Pod::Spec.new do |s|

s.name         = "KNBannerView"
s.version      = "1.0.0"
s.summary      = "A lightweight cycle bannerView by OC,dependency 'SDWebImage 4.0.0' "

s.description  = <<-DESC
A lightweight cycle bannerView by OC,dependency 'SDWebImage 4.0.0'.It provides three types include location , network and blend  "

DESC

s.homepage     = "https://github.com/LuKane/KNBannerView"
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


#s.license      = "MIT"
#s.license      = { :type => "MIT", :file => "LICENSE" }

s.author             = { "LuKane" => "1169604556@qq.com" }
# s.social_media_url   = "https://www.jianshu.com/u/335eb27959ed"

s.platform     = :ios, "8.0"

s.source       = { :git => "https://github.com/LuKane/KNBannerView.git", :tag => s.version }

s.source_files  = "KNBannerView/KNBannerView/*.{h,m}"


# s.exclude_files = "Classes/Exclude"

# s.public_header_files = "Classes/**/*.h"


s.requires_arc = true
s.dependency 'SDWebImage'

end



