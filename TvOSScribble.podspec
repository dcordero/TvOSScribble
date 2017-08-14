Pod::Spec.new do |s|
  s.name = 'TvOSScribble'
  s.authors = { 'David Cordero' => 'dcorderoramirez@gmail.com'}
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'Gesture recognizer for handwritten numbers in Siri Remote'
  s.homepage = 'https://github.com/dcordero/TvOSScribble'
  s.source = { :git => 'https://github.com/dcordero/TvOSScribble.git', :tag => s.version }
  s.tvos.deployment_target = '11.0'
  s.source_files = 'TvOSScribble/*.{swift,mlmodel}'
end
