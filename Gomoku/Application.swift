import UIKit

final class Application: UIApplication {
    static func isTesting() -> Bool {
        ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil
    }
}
