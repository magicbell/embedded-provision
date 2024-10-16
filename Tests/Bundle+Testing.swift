import Foundation

private class BundleFinder {}

extension Bundle {
    static func fixturesBaseURL() -> URL {
        // Swift Package Manager provides `Bundle.module` which is not available in Foundation by default
        // Also See https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
#if NOT_SPM
        return Bundle(for: BundleFinder.self).bundleURL
#else
        let resourceBundle = Bundle(url: Bundle.module.resourceURL!)!
        return resourceBundle.resourceURL!
#endif
    }

}
