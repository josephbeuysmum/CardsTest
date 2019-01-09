//
//  CardsViewModel.swift
//  CardsTest
//
//  Created by Richard Willis on 09/01/2019.
//  Copyright © 2019 Rich Text Format Ltd. All rights reserved.
//

class CardsViewModel {
	var delegate: ViewControllerDelegate?
	
	private let api: ApiService
	
	init() {
		api = ApiService()
	}
}

extension CardsViewModel: ApiResponseDelegate {
	func present(_ response: ApiResponse) {
		print(response.result)
	}
}

extension CardsViewModel: ViewModelProtocol {
	func fetch() {
		_ = api.call(Consts.apiUrl, httpMethod: CallTypes.GET, delegate: self)
	}
}
