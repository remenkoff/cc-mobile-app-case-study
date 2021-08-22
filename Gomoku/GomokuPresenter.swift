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

    func getErrorMessage(_ error: BoardError) -> String {
        switch error {
            case .BAD_LOCATION:
                return "You can't place it here"
            case .PLACE_OCCUPIED:
                return "Place is already occupied"
            case .STONE_NOT_FOUND:
                return "Stone not found"
        }
    }

    func getErrorMessageColor() -> Int {
        0x71F4F1
    }
}
