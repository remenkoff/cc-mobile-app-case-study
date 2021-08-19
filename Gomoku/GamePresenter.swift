final class GamePresenter {
    func getTurnStatus(_ stone: Stone) -> String {
        "\(stone.rawValue.capitalized)'s Turn"
    }
}
