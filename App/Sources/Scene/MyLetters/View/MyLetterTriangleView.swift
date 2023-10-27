import UIKit

class MyLetterTriangleView: UIView {
    override func draw(_ rect: CGRect) {
        drawTriangle()
    }
    private func drawTriangle() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        self.backgroundColor = .clear
        let path = UIBezierPath()
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        // top
        path.move(to: CGPoint(x: width/2, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()
        DittoLettoAsset.Color.gray2.color.setFill()
        path.fill()
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        self.layer.masksToBounds = true
    }
}

class MyLetterReverseTriangleView: UIView {
    override func draw(_ rect: CGRect) {
        drawTriangle()
    }
    private func drawTriangle() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        self.backgroundColor = .clear
        let path = UIBezierPath()
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        // down
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width/2, y: height))
        path.close()
        DittoLettoAsset.Color.gray2.color.setFill()
        path.fill()
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        self.layer.masksToBounds = true
    }
}
