import UIKit

public extension UITextView {
// MARK: 1. Put Text  ->  2. Set Spacing  ->  3. Set Font
// This Function must be written at the second.
    func setLineAndLetterSpacing(_ lineSpacing: CGFloat, _ color: UIColor.Colors.Colors) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        let attributedString = NSMutableAttributedString(string: self.text)
        attributedString.addAttribute(
            NSAttributedString.Key.kern,
            value: CGFloat(0),
            range: NSRange(location: 0, length: attributedString.length)
        )
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: style,
            range: NSRange(location: 0, length: attributedString.length)
        )
        self.attributedText = attributedString
        self.textColor = .color(.dittoLettoColor(color))
    }
}
