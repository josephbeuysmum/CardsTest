//
//  Protocols.swift
//  CardsTest
//
//  Created by Richard Willis on 09/01/2019.
//  Copyright © 2019 Rich Text Format Ltd. All rights reserved.
//

protocol ApiResponseDelegate {
	func present(_ response: ApiResponse)
}

protocol Fetchable {
	func fetch()
}

protocol ViewControllerDelegate {
	func reload()
}

protocol ViewModelProtocol: Fetchable {
	var delegate: ViewControllerDelegate? { get set }
}
