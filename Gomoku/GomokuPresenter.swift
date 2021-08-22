final class GomokuPresenter {
    func getTurnStatusText(_ stone: Stone) -> String {
        "\(stone.rawValue.capitalized)'s Turn"
    }

    func getStatusTextColor(_ stone: Stone) -> Int {
        switch stone {
            case .WHITE: return 0xFFFFFF
            case .BLACK: return 0x000000
        }
    }

    func getWinStatusText(_ stone: Stone) -> String {
        "\(stone.rawValue.capitalized) Wins!"
    }
}
