//: Playground - noun: a place where people can play

import Cocoa

enum CommonArrayError: Error {
    case arrayLength
    var description: String {
        return "Needs more at least 1 cell to calculate a perimeter"
    }
}

class SquareBox: NSObject {
    var top: Int = 0
    var bottom: Int = 0
    var left: Int = 0
    var right: Int = 0
    
    override init() {
        top = 0
        bottom = 0
        left = 0
        right = 0
    }
    
    subscript(index: Int) -> Int {
        return index
    }
    
    override var description: String {
        return "top: \(top)  bottom: \(bottom)  left: \(left)  right: \(right)"
    }
}

func calculatePerimeter(_ board: [[Int]]) throws -> Int {
    guard board.count > 0 else {
        throw CommonArrayError.arrayLength
    }
    var result = 0
    var boardFences = [[SquareBox]]()
    for i in 0..<board.count {
        boardFences.append([])
        for _ in 0..<board[0].count {
            let tmpSquare = SquareBox()
            boardFences[i].append(tmpSquare)
        }
    }
    
    for i in 0..<board.count {
        for j in 0..<board[0].count {
            if board[i][j] == 1 {
                if boardFences[i][j].top == 1 {
                    if i > 0 {
                        if boardFences[i-1][j].bottom == 1 {
                            boardFences[i-1][j].bottom = 0
                            result -= 1
                        } else {
                            boardFences[i][j].top = 1
                            result += 1
                        }
                    } else {
                        boardFences[i][j].top = 0
                        result -= 1
                    }
                } else {
                    if i > 0 {
                        if boardFences[i-1][j].bottom == 1 {
                            boardFences[i-1][j].bottom = 0
                            result -= 1
                        } else {
                            boardFences[i][j].top = 1
                            result += 1
                        }
                    } else {
                        boardFences[i][j].top = 1
                        result += 1
                    }
                }
                if boardFences[i][j].bottom == 1 {
                    if i < board.count-1 {
                        if boardFences[i+1][j].top == 1 {
                            boardFences[i+1][j].top = 0
                            result -= 1
                        } else {
                            boardFences[i][j].bottom = 1
                            result += 1
                        }
                    } else {
                        boardFences[i][j].bottom = 0
                        result -= 1
                    }
                } else {
                    if i < board.count-1 {
                        if boardFences[i+1][j].top == 1 {
                            boardFences[i+1][j].top = 0
                            result -= 1
                        } else {
                            boardFences[i][j].bottom = 1
                            result += 1
                        }
                    } else {
                        boardFences[i][j].bottom = 1
                        result += 1
                    }
                }
                if boardFences[i][j].left == 1 {
                    if j > 0 {
                        if boardFences[i][j-1].right == 1 {
                            boardFences[i][j-1].right = 0
                            result -= 1
                        } else {
                            boardFences[i][j].left = 1
                            result += 1
                        }
                    } else {
                        boardFences[i][j].left = 0
                        result -= 1
                    }
                } else {
                    if j > 0 {
                        if boardFences[i][j-1].right == 1 {
                            boardFences[i][j-1].right = 0
                            result -= 1
                        } else {
                            boardFences[i][j].left = 1
                            result += 1
                        }
                    } else {
                        boardFences[i][j].left = 1
                        result += 1
                    }
                }
                if boardFences[i][j].right == 1 {
                    if j < board[0].count-1 {
                        if boardFences[i][j+1].left == 1 {
                            boardFences[i][j+1].left = 0
                            result -= 1
                        } else {
                            boardFences[i][j].right = 1
                            result += 1
                        }
                    } else {
                        boardFences[i][j].right = 0
                        result -= 1
                    }
                } else {
                    if j < board[0].count-1 {
                        if boardFences[i][j+1].left == 1 {
                            boardFences[i][j+1].left = 0
                            result -= 1
                        } else {
                            boardFences[i][j].right = 1
                            result += 1
                        }
                    } else {
                        boardFences[i][j].right = 1
                        result += 1
                    }
                }
            }
        }
    }
    //print(boardFences)
    return result
}

func calcPerm(_ board: [[Int]]) {
    do {
        print(try calculatePerimeter(board))
    }
    catch {
        print(CommonArrayError.arrayLength.description)
    }
}

calcPerm([[0]])
calcPerm([[1]])
calcPerm([[0, 1]])
calcPerm([[1, 0]])
calcPerm([[0, 1, 0, 1]])
calcPerm([[0, 1, 1, 0]])
calcPerm([[0, 1], [1, 0]])
calcPerm([[1, 0], [1, 0]])
calcPerm([[1, 0, 1], [0, 1, 0], [1, 0, 1]])
calcPerm([[1, 1, 1], [1, 0, 1], [1, 1, 1]])
calcPerm([[1, 1, 1], [0, 0, 0], [1, 1, 1]])
