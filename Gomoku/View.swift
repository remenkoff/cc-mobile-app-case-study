import UIKit

final class View: UIView {
    private lazy var gridView: UIView = {
        let board = Board()
        board.placeStone(intersection: Intersection(row: 1, column: 5), player: .white)
        board.placeStone(intersection: Intersection(row: 3, column: 3), player: .black)
        board.placeStone(intersection: Intersection(row: 4, column: 5), player: .white)
        board.placeStone(intersection: Intersection(row: 5, column: 5), player: .black)
        let minSideLength = min(frame.width, frame.height)
        let frame = CGRect(x: 0.0, y: 200.0, width: minSideLength, height: minSideLength)
        let gridView = GridView(board: board, frame: frame)
        return gridView
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
