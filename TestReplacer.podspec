Pod::Spec.new do |s|
  s.name = 'TestReplacer'
  s.version = '0.1.0'
  s.summary = 'An easy-to-use library to stub HTTP requests using URLSession and to swizzle methods'
  s.homepage = 'https://github.com/tattn/Replacer'
  s.social_media_url = 'https://github.com/tattn/Replacer'
  s.authors = { 'Tatsuya Tanaka (tattn)' => 'tanakasan2525@gmail.com' }
  s.source = { :git => 'https://github.com/tattn/Replacer.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  if s.respond_to?(:tvos)
    s.tvos.deployment_target = '9.0'
  end
  s.framework = 'XCTest', 'Replacer'
  s.dependency 'Replacer', "= #{s.version}"
  s.source_files = 'Sources/TestReplacer/*.swift'
  s.license = {
    :type => "MIT",
    :text => <<-LICENSE
                    Copyright (c) 2019 Tatsuya Tanaka
                        Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
                          The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
                              THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    LICENSE
  }
end
