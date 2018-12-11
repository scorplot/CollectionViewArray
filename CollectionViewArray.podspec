#
# Be sure to run `pod lib lint CollectionViewArray.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CollectionViewArray'
  s.version          = '0.1.2'
  s.summary          = 'A usefull library make UICollectionView listener a array'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A usefull library make UICollectionView listener a array.
                       DESC

  s.homepage         = 'https://github.com/scorplot/CollectionViewArray'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'scorplot' => '1@1.com' }
  s.source           = { :git => 'https://github.com/scorplot/CollectionViewArray.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # s.source_files = 'CollectionViewArray/Classes/**/*'

  s.subspec 'Category' do |category|
      category.source_files = 'CollectionViewArray/Classes/Category/**/*'
      category.dependency 'CCUIModel'
  end

  s.subspec 'CollectionViewArray' do |collectionViewArray|
      collectionViewArray.source_files = 'CollectionViewArray/Classes/CollectionViewArray/**/*'
      collectionViewArray.dependency 'MutableArrayListener'
  end

  # s.resource_bundles = {
  #   'CollectionViewArray' => ['CollectionViewArray/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'MutableArrayListener'
end
