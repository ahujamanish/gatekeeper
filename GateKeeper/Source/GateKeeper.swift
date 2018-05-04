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

open class GateKeeper {

	internal var biometricType: BiometricType {
		get {
			let context = LAContext()
			var error: NSError?

			guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
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

	public static let shared = GateKeeper()

	private init() {
	}

	private var hasLaunchedBefore: Bool {
		get {
			return UserDefaults.standard.bool(forKey: "com.Manish.GateKeeper.hasLaunchedBefore")
		}
		set {
			if newValue == true {
				UserDefaults.standard.set(true, forKey: "com.Manish.GateKeeper.hasLaunchedBefore")
			}
		}
	}

	var enabled: Bool {
		get {
			return UserDefaults.standard.bool(forKey: "com.Manish.GateKeeper.enabled")
		}
		set {
			if newValue == true {
				UserDefaults.standard.set(true, forKey: "com.Manish.GateKeeper.enabled")
			}
		}
	}

	public func configure(enabled: Bool = true) {
		self.enabled = enabled
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

		guard self.hasLaunchedBefore else {
			self.hasLaunchedBefore = true
			return
		}

		guard let topmostViewController = UIApplication.shared.keyWindow?.rootViewController?.topMostViewController,
			(self.enabled && !(topmostViewController is GateKeeperViewController)) else {
			return
		}

		let bundle = Bundle(for: GateKeeper.self)
		let viewController = GateKeeperViewController(nibName: "GateKeeperViewController", bundle: bundle)
		topmostViewController.present(viewController, animated: true, completion: nil)
	}
}
