//
//  UIViewController+GateKeeper
//  GateKeeper
//
//  Created by Manish Ahuja on 01/05/2018.
//  Copyright © 2018 Manish Ahuja. All rights reserved.
//

import UIKit

// MARK: - ViewControllerContainer
/**
*  Allows a controller to declare what is his topmost child view controller.
*	 When there is no children too return, controllers are expected to return self
*/
internal protocol ViewControllerContainer {
	var topMostViewController: UIViewController { get }
}

// MARK: UIViewController. Default for all controllers.
extension UIViewController: ViewControllerContainer {
	@objc internal var topMostViewController: UIViewController {
		if let presented = presentedViewController {
			return presented.topMostViewController
		}
		return childViewControllers.last?.topMostViewController ?? self
	}
}

// MARK: UITabBarController
extension UITabBarController {
	internal override var topMostViewController: UIViewController {
		return selectedViewController?.topMostViewController ?? self
	}
}

// MARK: UINavigationController
extension UINavigationController {
	internal override var topMostViewController: UIViewController {
		return (presentedViewController ?? topViewController)?.topMostViewController ?? self
	}
}
