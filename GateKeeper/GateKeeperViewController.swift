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
				if error == nil {
					self.dismiss(animated: true, completion: nil)
				}
		})
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

