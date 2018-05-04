//
//  GateKeeperViewController.swift
//  GateKeeper
//
//  Created by Manish Ahuja on 24/04/18.
//  Copyright © 2018 Manish Ahuja. All rights reserved.
//

import UIKit
import LocalAuthentication

class GateKeeperViewController: UIViewController {

	@IBOutlet private var infoLabel: UILabel!
	@IBOutlet private var infoImageView: UIImageView!
	@IBOutlet private var retryButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.configure()
		self.authenticateWithBiometric()
	}

	private func configure() {
		let bundle = Bundle(for: GateKeeper.self)
		let image: UIImage?
		let info: String
		switch GateKeeper.shared.biometricType {
		case .faceID:
			image = UIImage(named: "faceId", in: bundle, compatibleWith: nil)
			info = "Autheticate using Face ID"
		case .touchID:
			image = UIImage(named: "touchId", in: bundle, compatibleWith: nil)
			info = "Autheticate using Touch ID"
		default:
			image = nil
			info = "Autheticate"
		}
		self.infoImageView.image = image
		self.infoLabel.text = info
	}

	private func authenticateWithBiometric() {
		guard GateKeeper.shared.biometricType != .none else {
			return
		}

		self.retryButton.isHidden = true
		let context = LAContext()
		context.evaluatePolicy(
			LAPolicy.deviceOwnerAuthenticationWithBiometrics,
			localizedReason: "Please authenticate to continue",
			reply: {(success, error) in
				DispatchQueue.main.async {
					if let err = error {
						switch err._code {
						case LAError.Code.systemCancel.rawValue:
							self.handleError(message: "User cancelled Authentication")
						case LAError.Code.userCancel.rawValue:
							self.handleError(message: "User cancelled Authentication")
						case LAError.Code.userFallback.rawValue:
							self.handleError(message: "User opted for Password")
						default:
							self.handleError(message: "User authentication failed")
						}
						self.retryButton.isHidden = false
					} else {
						self.dismiss(animated: true, completion: nil)
					}
				}
		})

	}

	private func handleError(message: String) {
		self.infoLabel.text = message
	}

	@IBAction private func retryTapped() {
		self.authenticateWithBiometric()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

