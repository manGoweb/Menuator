#
# Be sure to run `pod lib lint Menuator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'Menuator'
    s.version          = '0.0.1'
    s.summary          = 'Floating menu & screen management in Swift'

    s.description      = <<-DESC
Screen management framework with floating menu based on UICollectionViews which offer great reusability and memory management.
                       DESC

    s.homepage         = 'https://github.com/manGoweb/Menuator'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Ondrej Rafaj' => 'developers@mangoweb.com' }
    s.source           = { :git => 'https://github.com/manGoweb/Menuator.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/rafiki270'

    s.ios.deployment_target = '10.0'

    s.source_files = 'Menuator/Classes/**/*'

    # s.resource_bundles = {
    #   'Menuator' => ['Menuator/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'SnapKit', '~> 4.0.0'
end
