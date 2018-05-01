//
//  GateKeeper.swift
//  GateKeeper
//
//  Created by Manish Ahuja on 01/05/18.
//  Copyright © 2018 Manish Ahuja. All rights reserved.
//

import UIKit
import LocalAuthentication

internal enum BiometricType {
	case none
	case touchID
	case faceID
}

internal class GateKeeper {

	var biometricType: BiometricType {
		get {
			let context = LAContext()
			var error: NSError?

			guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
				print(error?.localizedDescription ?? "")
				return .none
			}

			if #available(iOS 11.0, *) {
				switch context.biometryType {
				case .none:
					return .none
				case .touchID:
					return .touchID
				case .faceID:
					return .faceID
				}
			} else {
				return .touchID
			}
		}
	}

	static let shared = GateKeeper()

	private init() {
		self.setupNotificationObserver()
	}

	private func setupNotificationObserver() {
		NotificationCenter.default.addObserver(
			forName: .UIApplicationWillEnterForeground,
			object: nil,
			queue: .main,
			using: { [weak self] _ in
				self?.displayGateKeeperIfRequired()
		})

		NotificationCenter.default.addObserver(
			forName: .UIApplicationDidFinishLaunching,
			object: nil,
			queue: .main,
			using: { [weak self] _ in
				self?.displayGateKeeperIfRequired()
		})
	}

	private func displayGateKeeperIfRequired() {
		let bundle = Bundle(for: GateKeeper.self)
		let storyboard = UIStoryboard(name: "GateKeeper", bundle: bundle)
		let viewController = storyboard.instantiateInitialViewController()
		let topMostViewController = UIApplication.shared.keyWindow?.rootViewController?.topMostViewController
		topMostViewController?.present(viewController!, animated: true, completion: nil)
	}
}
