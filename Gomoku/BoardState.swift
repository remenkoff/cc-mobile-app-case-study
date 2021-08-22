protocol BoardState {
    typealias Location = Int
    var numberOfRows: Int { get }
    var numberOfCols: Int { get }
    var whoseTurn: Stone { get }
    var placedStones: [Location: Stone] { get }
    func getStone(_ intersection: Intersection) -> Result<Stone, BoardError>
}
