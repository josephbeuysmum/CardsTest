//
//  CardsViewController.swift
//  CardsTest
//
//  Created by Richard Willis on 09/01/2019.
//  Copyright © 2019 Rich Text Format Ltd. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
	@IBOutlet weak var cardView: UIView!
	@IBOutlet weak var correctView: UIView!
	@IBOutlet weak var incorrectView: UIView!
	@IBOutlet weak var feedbackLabel: UILabel!
	@IBOutlet weak var upperFaceValueLabel: UILabel!
	@IBOutlet weak var lowerFaceValueLabel: UILabel!
	@IBOutlet weak var higherButton: UIButton!
	@IBOutlet weak var lowerButton: UIButton!
	@IBOutlet weak var playAgainButton: UIButton!

	let viewModel: CardsViewModel

	required init?(coder aDecoder: NSCoder) {
		viewModel = CardsViewModel()
		super.init(coder: aDecoder)
		populate()
	}
	
	override func viewDidLoad() {
		// normally would have some sort of waiting, spinny wotsit whilst the API responsed
		cardView.layer.cornerRadius = 16;
		cardView.layer.masksToBounds = true
		cardView.layer.backgroundColor = UIColor.white.cgColor
		cardView.layer.borderWidth = 1
		cardView.layer.borderColor = UIColor.darkGray.cgColor
		
		let lowerFaceValueLabelFrame = lowerFaceValueLabel.frame
		lowerFaceValueLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
		lowerFaceValueLabel.frame = lowerFaceValueLabelFrame
		
		reset()
	}
	
	private func populate() {
		viewModel.delegate = self
		viewModel.fetch()
	}
	
	private func reset() {
		DispatchQueue.main.async {
			self.incorrectView.isHidden = true
			self.feedbackLabel.text = "Is the next card:"
		}
	}
}

extension CardsViewController: ViewControllerDelegate {
	func reload() {
		reset()
	}
}
