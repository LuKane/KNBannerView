Pod::Spec.new do |s|

  s.name         = "KNBannerView"
  s.version      = "1.0.4"
  s.summary      = "A lightweight and beautiful banner for recycle and adapt rotate screen  "

  s.description  = <<-DESC
                   A lightweight and beautiful banner for recycle and adapt rotate screen
                   DESC
  s.homepage     = "https://github.com/LuKane/KNBannerView"
  s.license      = "MIT"
  s.author       = { "LuKane" => "1169604556@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/LuKane/KNBannerView.git", :tag =>"1.0.4" }
  s.source_files  = "KNBannerView/KNBannerView/KNBannerView/**/*.{h,m}"

  s.requires_arc = true
  s.dependency 'SDWebImage',"~> 4.0.0"


end
