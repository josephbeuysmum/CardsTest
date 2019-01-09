//
//  ValueObjects.swift
//  CardsTest
//
//  Created by Richard Willis on 09/01/2019.
//  Copyright © 2019 Rich Text Format Ltd. All rights reserved.
//

typealias Jsonary = [[String: Any]]

struct ApiResponse {
	let url: String, result: Jsonary?
}

struct PlayingCard {
	let faceValue: String, suit: String
}
