import UIKit

public extension UITextView {
    func setTextViewFont(_ isPrivate: Bool) {
        if isPrivate {
            self.font = .ramche(.headline)
        } else {
            self.font = .yoondongju(.headline)
        }
    }
}
