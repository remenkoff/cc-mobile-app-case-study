import UIKit

final class GridView: UIView {
    private let board: Board
    private let boardWidth: CGFloat
    private let cellCount: Int
    private let cellSize: CGFloat
    private let stoneSizeFactor: CGFloat = 2.4

    init(_ board: Board, _ frame: CGRect) {
        self.board = board
        boardWidth = min(frame.width, frame.height)
        cellCount = board.NUMBER_OF_COLUMNS + 1
        cellSize = boardWidth / CGFloat(cellCount)
        super.init(frame: frame)
        backgroundColor = .init(red: 0.9, green: 0.7, blue: 0.5, alpha: 1.0)
        addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTap(_:))))
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func draw(_ rect: CGRect) {
        drawGrid()
        drawStones()
    }

    private func drawGrid() {
        let path = UIBezierPath()
        path.lineWidth = 1.0

        for vCellIndex in 1..<cellCount {
            let xCoord = CGFloat(vCellIndex) * cellSize
            let fromPoint = CGPoint(x: xCoord, y: cellSize)
            let toPoint = CGPoint(x: xCoord, y: boardWidth - cellSize)
            path.move(to: fromPoint)
            path.addLine(to: toPoint)
        }

        for hCellIndex in 1..<cellCount {
            let yCoord = CGFloat(hCellIndex) * cellSize
            let fromPoint = CGPoint(x: cellSize, y: yCoord)
            let toPoint = CGPoint(x: boardWidth - cellSize, y: yCoord)
            path.move(to: fromPoint)
            path.addLine(to: toPoint)
        }

        UIColor(red: 0.4, green: 0.2, blue: 0.0, alpha: 1.0).setStroke()
        path.stroke()
    }

    private func drawStones() {
        for column in 0..<board.NUMBER_OF_COLUMNS {
            for row in 0..<board.NUMBER_OF_ROWS {
                let intersection = Intersection(row, column)
                guard let stone = try? board.getStone(intersection).get() else {
                    continue
                }

                switch stone {
                    case .white: UIColor.white.setFill()
                    case .black: UIColor.black.setFill()
                }

                let centerX = CGFloat(intersection.column) * cellSize + cellSize
                let centerY = CGFloat(intersection.row) * cellSize + cellSize
                let center = CGPoint(x: centerX, y: centerY)
                let radius = cellSize / stoneSizeFactor

                let path = UIBezierPath()
                path.lineWidth = 1.0
                path.addArc(
                    withCenter: center,
                    radius: radius,
                    startAngle: 0.0,
                    endAngle: .pi * 2,
                    clockwise: true
                )
                path.fill()
            }
        }
    }

    @objc func onTap(_ recognizer: UITapGestureRecognizer) {
        let recognizedLocation = recognizer.location(in: self)
        let tappedRow = Int(round((recognizedLocation.y - cellSize) / cellSize))
        let tappedColumn = Int(round((recognizedLocation.x - cellSize) / cellSize))
        let tappedIntersection = Intersection(tappedRow, tappedColumn)
        board.placeStone(tappedIntersection, .white)
        setNeedsDisplay()
    }
}
