//
//  CardsViewModel.swift
//  CardsTest
//
//  Created by Richard Willis on 09/01/2019.
//  Copyright © 2019 Rich Text Format Ltd. All rights reserved.
//

class CardsViewModel {
	var delegate: ViewControllerDelegate?
	
	var hasCards: Bool {
		return cards.count == Consts.totalCards
	}
	
	var nextCard: PlayingCard? {
		let card = index < Consts.totalCards ? cards[index] : nil
		index += 1
		return card
	}
	
	private let
	api: ApiService,
	cardRanks: [String]

	private var
	cards: [PlayingCard],
	index: Int

	init() {
		api = ApiService()
		cardRanks = ["a", "2", "3", "4", "5", "6", "7", "8", "9", "10", "j", "q", "k"]
		cards = []
		index = 0
	}
	
	func shuffle() {
		cards.shuffle()
		index = 0
	}
}

extension CardsViewModel: ApiResponseDelegate {
	func present(_ response: ApiResponse) {
		guard
			let rawCards = response.result,
			rawCards.count == Consts.totalCards
		else { return }
		let
		valueKey = Consts.jsonValue,
		suitKey = Consts.jsonSuit
		for rawCard in rawCards {
			if	let value = rawCard[valueKey] as? String,
					let suit = rawCard[suitKey] as? String {
				cards.append(PlayingCard(faceValue: value, suit: suit))
			}
		}
		print(cards.count)
		delegate?.reload()
	}
}

extension CardsViewModel: ViewModelProtocol {
	func fetch() {
		_ = api.call(Consts.apiUrl, httpMethod: CallTypes.GET, delegate: self)
	}
}
