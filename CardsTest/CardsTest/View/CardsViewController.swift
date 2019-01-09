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
	@IBOutlet weak var suitLabel: UILabel!
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
		correctView.layer.backgroundColor = UIColor.white.cgColor
		incorrectView.layer.backgroundColor = UIColor.white.cgColor
		
		let lowerFaceValueLabelFrame = lowerFaceValueLabel.frame
		lowerFaceValueLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
		lowerFaceValueLabel.frame = lowerFaceValueLabelFrame
		
		higherButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
		lowerButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
		playAgainButton.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
	}
	
	private func populate() {
		viewModel.delegate = self
		viewModel.fetch()
	}
	
	@objc private func buttonReleased(sender: UIButton) {
		let result: Bool
		
		if sender == playAgainButton {
			startGame()
		} else {
			switch sender {
			case higherButton:				result = viewModel.nextCardIsHigher
			case lowerButton: 				result = viewModel.nextCardIsLower
			default: result = false
			}
			showNextCard()
			result ? showSuccess() : showFailure()
		}
	}
	
	private func showFailure() {
		DispatchQueue.main.async {
			self.feedbackLabel.text = "Wrong!"
			self.correctView.isHidden = true
			self.incorrectView.isHidden = false
		}
	}
	
	private func showNextCard() {
		guard let nextCard = viewModel.nextCard else { return }
		DispatchQueue.main.async {
			self.incorrectView.isHidden = true
			self.upperFaceValueLabel.text = nextCard.faceValue
			self.lowerFaceValueLabel.text = nextCard.faceValue
			self.suitLabel.text = nextCard.suit
		}
	}
	
	private func showSuccess() {
		DispatchQueue.main.async {
			// there are some bits of text copy scattered throughout the app. It's only a short test. Normally they would be elsewhere. Localised one imagines
			let question = "Is the next card:"
			self.feedbackLabel.text = self.viewModel.currentCardIsFirstCard ? question : "Correct! \(question)"
			self.correctView.isHidden = false
		}
	}
	
	private func startGame() {
		viewModel.shuffle()
		showNextCard()
		showSuccess()
	}
}

extension CardsViewController: ViewControllerDelegate {
	func reload() {
		startGame()
	}
}
