Replacer
===

[![Build Status](https://travis-ci.org/tattn/Replacer.svg?branch=master)](https://travis-ci.org/tattn/Replacer)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/Replacer.svg)](http://cocoapods.org/pods/Replacer)
[![Platform](https://img.shields.io/cocoapods/p/Replacer.svg)](http://cocoapods.org/pods/Replacer)
[![License](https://img.shields.io/cocoapods/l/Replacer.svg)](http://cocoapods.org/pods/Replacer)
[![Swift Version](https://img.shields.io/badge/Swift-5-F16D39.svg)](https://developer.apple.com/swift)


Replacer is an easy-to-use library to stub HTTP requests and to swizzle methods.

Specifically, URLSession's response can be replaced with any JSON, Data, and so on....  
It uses **method chaining** to set stubs up.

# How to use

## Stub HTTP Request

### XCTest

```swift
import Replacer
import TestReplacer 

class SampleTests: XCTestCase {
    func testJSONFile() {
        // register a stub
        self.urlStub.url("echo.jsontest.com").json(["test": "data"])
        
        // load sample.json & register a stub.
        self.urlStub.json(filename: "sample")

        let expectation = self.expectation(description: "")
        
        let url = URL(string: "http://echo.jsontest.com/key/value/one/two")!
        URLSession(configuration: .default).dataTask(with: url) { data, _, _ in
            let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: String]
            XCTAssert(json["test"] == "data")
            expectation.fulfill()
        }.resume()

        self.waitForExpectations(timeout: 0.02, handler: nil)
    }
}
```

### Quick & Alamofire

```swift
class SampleSpecs: QuickSpec {
    override func spec() {
        describe("Quick compatibility test") {
            context("using JSON file") {
                beforeEach() {
                    // wait for 1.5s
                    self.urlStub.url("echo.jsontest.com/[a-z]+/.*")
                        .httpMethod(.post)
                        .json(["test": "data"])
                        .delay(1.5)
                }

                it("returns mock data") {
                    var json: [String: String]?

                    Alamofire.request("http://echo.jsontest.com/key/value/one/two", method: .post).responseJSON { response in
                        json = response.result.value as? [String: String]
                    }

					// SessionManager is also OK.
					// SessionManager.default.request("http://echo.jsontest.com/key/value/one/two").responseJSON { _ in }

                    expect(json?["test"]).toEventually(equal("data"))
                }
            }
        }
    }
}
```

## Method Swizzling

```swift
import UIKit
import Replacer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Replacer.replaceInstance(#selector(UIViewController.viewWillAppear(_:)),
                                 of: UIViewController.self,
                                 with: #selector(UIViewController.orig_viewWillAppear(_:)),
                                 of: UIViewController.self)

        return true
    }
}

extension UIViewController {
    func orig_viewWillAppear(_ animated: Bool) {
        orig_viewWillAppear(animated)

        print("swizzled")
    }
}

```

# Installation

## Carthage

```ruby
github "tattn/Replacer"
```

## CocoaPods

```ruby
pod 'Replacer'
```

# Documentation

- [Stub Reference](https://github.com/tattn/Replacer/blob/master/Documentations/Reference.md)

# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

# License

Replacer is released under the MIT license. See LICENSE for details.
