import UIKit

final class View: UIView {
    private lazy var gridView: UIView = {
        let minSideLength = min(frame.width, frame.height)
        let frame = CGRect(x: 0.0, y: 200.0, width: minSideLength, height: minSideLength)
        return GridView(Board(), frame)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        addSubview(gridView)
    }

    required init?(coder: NSCoder) {
        nil
    }
}
