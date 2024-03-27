import UIKit

public class ContentWrappingTableView: UITableView {
    public override var intrinsicContentSize: CGSize {
        return self.contentSize
    }

    public override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
}
