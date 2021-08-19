import UIKit

final class ViewController: UIViewController {
    private let game = Game(Board(), GomokuRules())
    private let presenter = GamePresenter()

    private lazy var gridView: GridView = {
        let minSideLength = min(view.frame.width, view.frame.height)
        let frame = CGRect(x: 0.0, y: 200.0, width: minSideLength, height: minSideLength)

        let onStoneColorNeeded: GridView.StoneNeededCompletion = { [weak self] intersection in
            guard let stone = try? self?.game.board.getStone(intersection).get() else { return nil }
            switch stone {
                case .white: return .white
                case .black: return .black
            }
        }

        let onIntersectionTapRecognized: GridView.TapRecognizedCompletion = { [weak self] intersection in
            guard let self = self else { return }
            self.game.board.placeStone(intersection, self.game.whoseTurn)
            self.game.takeTurn(intersection)
            self.updateStatusLabel()
        }

        let gridView = GridView(
            game.board.NUMBER_OF_ROWS,
            game.board.NUMBER_OF_COLUMNS,
            frame,
            onStoneColorNeeded,
            onIntersectionTapRecognized
        )

        return gridView
    }()

    private lazy var statusLabel: UILabel = {
        UILabel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
    }

    private func setupView() {
        view.backgroundColor = .brown
        updateStatusLabel()
    }

    private func updateStatusLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.statusLabel.textColor = .from(hex: self.presenter.getTurnStatusColor(self.game.whoseTurn))
            self.statusLabel.text = self.presenter.getTurnStatusText(self.game.whoseTurn)
        }
    }

    private func addSubviews() {
        view.addSubview(gridView)
        view.addSubview(statusLabel)
    }

    private func setupConstraints() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            statusLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

private extension UIColor {
    static func from(hex: Int) -> UIColor {
        UIColor(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1.0
        )
    }
}
