//
//  CardsViewController.swift
//  CardsTest
//
//  Created by Richard Willis on 09/01/2019.
//  Copyright © 2019 Rich Text Format Ltd. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
	let viewModel: CardsViewModel

	required init?(coder aDecoder: NSCoder) {
		viewModel = CardsViewModel()
		super.init(coder: aDecoder)
		populate()
	}
	
	private func populate() {
		viewModel.delegate = self
		viewModel.fetch()
	}
}

extension CardsViewController: ViewControllerDelegate {
	func reload() {
	}
}
