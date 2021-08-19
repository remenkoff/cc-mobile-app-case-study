final class GamePresenter {
    func getTurnStatusText(_ stone: Stone) -> String {
        "\(stone.rawValue.capitalized)'s Turn"
    }

    func getTurnStatusColor(_ stone: Stone) -> Int {
        switch stone {
            case .white: return 0xFFFFFF
            case .black: return 0x000000
        }
    }
}
