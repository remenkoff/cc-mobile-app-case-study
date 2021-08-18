import UIKit

final class GridView: UIView {
    private let board: Board
    private let boardWidth: CGFloat
    private let cellCount: Int
    private let cellSize: CGFloat
    private let stoneSizeFactor: CGFloat = 2.4

    init(board: Board, frame: CGRect) {
        self.board = board
        boardWidth = min(frame.width, frame.height)
        cellCount = board.NUMBER_OF_COLUMNS + 1
        cellSize = boardWidth / CGFloat(cellCount)
        super.init(frame: frame)
        backgroundColor = Color(hex: 0xFFE29A)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(recognizer:))))
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

        path.stroke()
    }

    private func drawStones() {
        for column in 0..<board.NUMBER_OF_COLUMNS {
            for row in 0..<board.NUMBER_OF_ROWS {
                let loc = Intersection(row: row, column: column)
                let tryStone = try? board.getStone(intersection: loc)
                guard let stone = tryStone, stone != .nothing else {
                    continue
                }

                switch stone {
                    case .white: UIColor.white.setFill()
                    case .black: UIColor.black.setFill()
                    case .nothing: Void()
                }

                let centerX = CGFloat(loc.column) * cellSize + cellSize
                let centerY = CGFloat(loc.row) * cellSize + cellSize
                let center = CGPoint(x: centerX, y: centerY)
                let radius = cellSize / stoneSizeFactor

                let path = UIBezierPath()
                path.lineWidth = 1.0
                path.addArc(withCenter: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2, clockwise: true)
                path.fill()
            }
        }
    }

    @objc func onTap(recognizer: UITapGestureRecognizer) {
        let tappedLocation = recognizer.location(in: self)
        let tappedRow = Int(round((tappedLocation.y - cellSize) / cellSize))
        let tappedColumn = Int(round((tappedLocation.x - cellSize) / cellSize))
        let stoneLocation = Intersection(row: tappedRow, column: tappedColumn)
        do {
            try board.placeStone(intersection: stoneLocation, player: .white)
        } catch(BoardError.BadLocation) {
            print(BoardError.BadLocation)
        } catch(BoardError.PlaceOccupied) {
            print(BoardError.PlaceOccupied)
        } catch {
            print("\(#function): Unknown error caught.")
        }
        setNeedsDisplay()
    }
}
