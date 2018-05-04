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

	@IBOutlet private var errorLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.authenticateWithBiometric()
	}

	private func authenticateWithBiometric() {
		guard GateKeeper.shared.biometricType != .none else {
			return
		}

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
					} else {
						self.dismiss(animated: true, completion: nil)
					}
				}
		})

	}

	private func handleError(message: String) {
		self.errorLabel.text = message
	}

	@IBAction private func retryTapped() {
		self.authenticateWithBiometric()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

