//
//  ChessTacticsManager+ChessLogic.swift
//  Chess Tactics
//
//  Created by Rovera, Julien Anthony on 11/10/21.
//

import Foundation

extension ChessTacticsManager{
    
    func findLegalMoves(square: ChessSquare){
        game.shortCastlingSquare = nil
        game.longCastlingSquare = nil
        setAllIllegal()
        if game.selectedSquare != nil{
            if square.number == game.selectedSquare!.number{
                game.selectedSquare = nil
                return
            }
        }
        //print(square.name)
        //print(square.piece!.type)
        //print(square.number)
        game.selectedPiece = square.piece
        game.selectedSquare = square
        //print(square.name)
        //print(square.piece!.type)
        switch(square.piece!.type){
        case .queen: return findQueenMoves(square: square, maxMoves: 8)
        case .rook: return findRookMoves(square: square)
        case .bishop: return findDiagonalMoves(square: square, maxMoves: 8)
        case .pawn: return findPawnMoves(square: square)
        case .king: return findKingMoves(square: square)
        case .knight: return findKnightMoves(square: square)
        }
    }
    
    func findQueenMoves(square: ChessSquare, maxMoves: Int){
        findVerticalMoves(square: square, maxMoves: maxMoves)
        findHorizontalMoves(square: square, maxMoves: maxMoves)
        findDiagonalMoves(square: square, maxMoves: maxMoves)
    }
    
    func findKingMoves(square: ChessSquare){
        findQueenMoves(square: square, maxMoves: 1)
        if square.piece!.color == .white{
            //check if the king hasn't moved
            if !game.whiteKingMoved{
                if game.chessSquareList[61].piece == nil && game.chessSquareList[62].piece == nil{
                    //check if short side rock has moved
                    if !game.shortWhiteRookMoved{
                        //print("short castling will work")
                        game.shortCastlingSquare = game.chessSquareList[62]
                        game.chessSquareList[62].legalSquare = true
                    }
                }
                if game.chessSquareList[59].piece == nil && game.chessSquareList[58].piece == nil && game.chessSquareList[57].piece == nil{
                    if !game.longWhiteRookMoved{
                        //print("long casteling will work")
                        game.longCastlingSquare = game.chessSquareList[58]
                        game.chessSquareList[58].legalSquare = true
                    }
                }
            }
        }
        else{
            if !game.blackKingMoved{
                if game.chessSquareList[5].piece == nil && game.chessSquareList[6].piece == nil{
                    if !game.shortblackRookMoved{
                        game.shortCastlingSquare = game.chessSquareList[6]
                        game.chessSquareList[6].legalSquare = true
                    }
                }
                if game.chessSquareList[3].piece == nil && game.chessSquareList[2].piece == nil && game.chessSquareList[1].piece == nil{
                    if !game.longblackRookMoved{
                        game.longCastlingSquare = game.chessSquareList[2]
                        game.chessSquareList[2].legalSquare = true
                    }
                }
            }
        }
    }
    
    func findRookMoves(square: ChessSquare){
        findVerticalMoves(square: square, maxMoves: 8)
        findHorizontalMoves(square: square, maxMoves: 8)
    }
    
    func checkSameColorPiece(square: ChessSquare, piece: ChessPiece) -> Bool{
        if let checkPiece = square.piece{
            return checkPiece.color != piece.color
        }
        return true
    }
    
    func findKnightMoves(square: ChessSquare){
        if let upRight = findDiagonalSquares(number: square.number, offset: -7){
            if let up = findVerticalSquares(number: upRight.number, offset: -1){
                if(checkSameColorPiece(square: game.chessSquareList[up.number], piece: square.piece!)){
                    game.chessSquareList[up.number].legalSquare = true
                }
            }
            if let right = findHorizontalSquares(number: upRight.number, offset: 1){
                if(checkSameColorPiece(square: game.chessSquareList[right.number], piece: square.piece!)){
                    game.chessSquareList[right.number].legalSquare = true
                }
            }
        }
        if let upLeft = findDiagonalSquares(number: square.number, offset: -9){
            if let up = findVerticalSquares(number: upLeft.number, offset: -1){
                if(checkSameColorPiece(square: game.chessSquareList[up.number], piece: square.piece!)){
                    game.chessSquareList[up.number].legalSquare = true
                }
            }
            if let left = findHorizontalSquares(number: upLeft.number, offset: -1){
                if(checkSameColorPiece(square: game.chessSquareList[left.number], piece: square.piece!)){
                    game.chessSquareList[left.number].legalSquare = true
                }
            }
        }
        if let downRight = findDiagonalSquares(number: square.number, offset: 9){
            if let down = findVerticalSquares(number: downRight.number, offset: 1){
                if(checkSameColorPiece(square: game.chessSquareList[down.number], piece: square.piece!)){
                    game.chessSquareList[down.number].legalSquare = true
                }
            }
            if let right = findHorizontalSquares(number: downRight.number, offset: 1){
                if(checkSameColorPiece(square: game.chessSquareList[right.number], piece: square.piece!)){
                    game.chessSquareList[right.number].legalSquare = true
                }
            }
        }
        if let downLeft = findDiagonalSquares(number: square.number, offset: 7){
            if let down = findVerticalSquares(number: downLeft.number, offset: 1){
                if(checkSameColorPiece(square: game.chessSquareList[down.number], piece: square.piece!)){
                    game.chessSquareList[down.number].legalSquare = true
                }
            }
            if let left = findHorizontalSquares(number: downLeft.number, offset: -1){
                if(checkSameColorPiece(square: game.chessSquareList[left.number], piece: square.piece!)){
                    game.chessSquareList[left.number].legalSquare = true
                }
            }
        }
    }
    
    func findPawnMoves(square: ChessSquare){
        var movementCoefficient = 1
        if square.piece!.color == .white{
            movementCoefficient = -1
            if ChessConstants.whitePawnStartingPos.contains(square.number){
                if game.chessSquareList[square.number - 16].piece == nil && game.chessSquareList[square.number - 8].piece == nil{
                    game.chessSquareList[square.number - 16].legalSquare = true
                    //game.enPassantSquare = game.chessSquareList[square.number - 8]
                }
            }
        }
        else{
            if ChessConstants.blackPawnStartingPos.contains(square.number){
                if game.chessSquareList[square.number + 16].piece == nil && game.chessSquareList[square.number + 8].piece == nil{
                    game.chessSquareList[square.number + 16].legalSquare = true
                    //game.enPassantSquare = game.chessSquareList[square.number + 8]
                }
            }
        }
        if game.chessSquareList[square.number + (movementCoefficient * 8)].piece == nil{
            game.chessSquareList[square.number + (movementCoefficient * 8)].legalSquare = true
        }
        if let upLeft = findDiagonalSquares(number: square.number, offset: (movementCoefficient*9)){
            if upLeft.piece?.color != square.piece!.color && (upLeft.piece != nil || upLeft.number == game.enPassantSquare?.number){
                game.chessSquareList[upLeft.number].legalSquare = true
            }
        }
        if let upRight = findDiagonalSquares(number: square.number, offset: (movementCoefficient*7)){
            if upRight.piece?.color != square.piece!.color && (upRight.piece != nil || upRight.number == game.enPassantSquare?.number){
                game.chessSquareList[upRight.number].legalSquare = true
            }
        }
    }
    
    func findVerticalSquares(number: Int, offset: Int) -> ChessSquare?{
        let newNumber = number + (8*offset)
        if (newNumber >= 0) && (newNumber <= 63){
            return game.chessSquareList[newNumber]
        }
        return nil
    }
    
    func findHorizontalSquares(number: Int, offset: Int) -> ChessSquare?{
        let newNumber = number + offset
        if newNumber >= 0 && newNumber <= 63{
            if game.chessSquareList[newNumber].rank == game.chessSquareList[number].rank{
                return game.chessSquareList[newNumber]
            }
        }
        return nil
    }
    
    func findDiagonalSquares(number: Int, offset: Int) -> ChessSquare?{
        let newNumber = number + offset
        if newNumber >= 0 && newNumber <= 63{
            if offset < 0{
                let absOffset = offset * -1
                if absOffset % 7 == 0 && newNumber % 8 == 0 && absOffset != 63{
                    return nil
                }
                if absOffset % 9 == 0 && newNumber % 8 == 7{
                    return nil
                }
            }
            else{
                if offset % 7 == 0 && newNumber % 8 == 7 && offset != 63{
                    return nil
                }
                if offset % 9 == 0 && newNumber % 8 == 0{
                    return nil
                }
            }
            return game.chessSquareList[newNumber]
        }
        return nil
    }
    
    func findAllSquares(square: ChessSquare, initialOffset: Int, increment: Int, findSquareFunction: (Int, Int)-> ChessSquare?, maxMoves: Int){
        var newSquare = findSquareFunction(square.number, initialOffset)
        var offset = initialOffset
        var movesFound = 0
        while newSquare != nil && movesFound < maxMoves{
            if let newPiece = newSquare!.piece{
                if newPiece.color == square.piece!.color{
                    newSquare = nil
                }
                else{
                    game.chessSquareList[newSquare!.number].legalSquare = true
                    newSquare = nil
                }
            }
            else{
                game.chessSquareList[newSquare!.number].legalSquare = true
                offset += increment
                newSquare = findSquareFunction(square.number, offset)
            }
            movesFound += 1
        }
    }
    
    func findVerticalMoves(square: ChessSquare, maxMoves: Int){
        findAllSquares(square: square, initialOffset: -1, increment: -1, findSquareFunction: findVerticalSquares, maxMoves: maxMoves)
        findAllSquares(square: square, initialOffset: 1, increment: 1, findSquareFunction: findVerticalSquares, maxMoves: maxMoves)
    }
    
    func findHorizontalMoves(square: ChessSquare, maxMoves: Int){
        findAllSquares(square: square, initialOffset: 1, increment: 1, findSquareFunction: findHorizontalSquares, maxMoves: maxMoves)
        findAllSquares(square: square, initialOffset: -1, increment: -1, findSquareFunction: findHorizontalSquares, maxMoves: maxMoves)
    }
    
    func findDiagonalMoves(square: ChessSquare, maxMoves: Int){
        findAllSquares(square: square, initialOffset: -7, increment: -7, findSquareFunction: findDiagonalSquares, maxMoves: maxMoves)
        findAllSquares(square: square, initialOffset: -9, increment: -9, findSquareFunction: findDiagonalSquares, maxMoves: maxMoves)
        findAllSquares(square: square, initialOffset: 7, increment: 7, findSquareFunction: findDiagonalSquares, maxMoves: maxMoves)
        findAllSquares(square: square, initialOffset: 9, increment: 9, findSquareFunction: findDiagonalSquares, maxMoves: maxMoves)
    }
    
    func checkUniqueMove(square: ChessSquare){
        var numPieces = 0
        var otherRank = 0
        var otherFile = "a"
        for index in game.chessSquareList.indices{
            if game.chessSquareList[index].piece?.type == game.selectedPiece!.type && game.chessSquareList[index].piece?.color == game.selectedPiece!.color && index != game.selectedSquare!.number{
                let selectedSquareIndex = game.selectedSquare!.number
                game.selectedSquare = nil
                findLegalMoves(square: game.chessSquareList[index])
                game.selectedSquare = game.chessSquareList[selectedSquareIndex]
                if game.chessSquareList[square.number].legalSquare == true{
                    numPieces += 1
                    if numPieces == 1{
                        otherRank = game.chessSquareList[index].rank
                        otherFile = game.chessSquareList[index].file
                    }
                }
            }
        }
        setAllIllegal()
        if numPieces == 1{
            if otherFile != game.selectedSquare!.file{
                game.currentHalfMove.updateDepartureFile(to: game.selectedSquare!.file)
                return
            }
            if otherRank != game.selectedSquare!.rank{
                game.currentHalfMove.updateDepartureRank(to: game.selectedSquare!.rank)
                return
            }
            print("error both the rank and file equaled")
            return
        }
        if numPieces > 1{
            game.currentHalfMove.updateDepartureFile(to: game.selectedSquare!.file)
            game.currentHalfMove.updateDepartureRank(to: game.selectedSquare!.rank)
        }
    }
    
    /*func checkIfCheck(){
        var kingPosition = whiteKingPosition
        var kingColor = pieceColor.white
        
        if currentTurn == .white{
            kingColor = .black
            kingPosition = blackKingPosition
        }
        
        findVerticalMoves(square: chessSquareList[kingPosition], maxMoves: 8)
        findDiagonalMoves(square: chessSquareList[kingPosition], maxMoves: 8)
        findHorizontalMoves(square: chessSquareList[kingPosition], maxMoves: 8)
        findKnightMoves(square: chessSquareList[kingPosition])
        
    }*/
}
