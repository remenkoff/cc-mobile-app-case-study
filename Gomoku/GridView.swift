import UIKit

final class GridView: UIView {
    typealias StoneNeededCompletion = (Int, Int) -> UIColor?
    typealias TapRecognizedCompletion = (Int, Int) -> Void

    private let numberOfRows: Int
    private let numberOfColumns: Int
    private let gridWidth: CGFloat
    private let cellCount: Int
    private let cellSize: CGFloat
    private let stoneSizeFactor: CGFloat = 2.4
    private let onStoneColorNeeded: StoneNeededCompletion?
    private let onTapRecognized: TapRecognizedCompletion?

    init(
        _ numberOfRows: Int,
        _ numberOfColumns: Int,
        _ frame: CGRect,
        _ onStoneColorNeeded: StoneNeededCompletion? = nil,
        _ onTapRecognized: TapRecognizedCompletion? = nil
    ) {
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        self.onStoneColorNeeded = onStoneColorNeeded
        self.onTapRecognized = onTapRecognized
        gridWidth = min(frame.width, frame.height)
        cellCount = numberOfColumns + 1
        cellSize = gridWidth / CGFloat(cellCount)
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
            let toPoint = CGPoint(x: xCoord, y: gridWidth - cellSize)
            path.move(to: fromPoint)
            path.addLine(to: toPoint)
        }

        for hCellIndex in 1..<cellCount {
            let yCoord = CGFloat(hCellIndex) * cellSize
            let fromPoint = CGPoint(x: cellSize, y: yCoord)
            let toPoint = CGPoint(x: gridWidth - cellSize, y: yCoord)
            path.move(to: fromPoint)
            path.addLine(to: toPoint)
        }

        UIColor(red: 0.4, green: 0.2, blue: 0.0, alpha: 1.0).setStroke()
        path.stroke()
    }

    private func drawStones() {
        for column in 0..<numberOfColumns {
            for row in 0..<numberOfRows {
                guard let stoneColor = onStoneColorNeeded?(row, column) else {
                    continue
                }

                stoneColor.setFill()

                let centerX = CGFloat(column) * cellSize + cellSize
                let centerY = CGFloat(row) * cellSize + cellSize
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
        onTapRecognized?(tappedRow, tappedColumn)
        setNeedsDisplay()
    }
}
