struct Intersection {
    let row: Int
    let column: Int

    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }

    static var zero: Intersection {
        .init(0, 0)
    }
}
