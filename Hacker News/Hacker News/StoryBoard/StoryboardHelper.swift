//
//  FlickerAPIManager.swift
//  FlickerApp
//
//  Created by Happlabs Software LLP MAC1 on 15/03/19.
//  Copyright © 2019 Flicker. All rights reserved.
//
import UIKit

extension UIStoryboard {
  
  enum Storyboard : String {
    case Main
    case NewsSource
  }
  
  convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
    self.init(name: storyboard.rawValue, bundle: bundle)
  }
  
  class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
    return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
  }
  
  func instantiateViewController<T: UIViewController>() -> T where T : StoryboardIdentifiable {
    guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
      fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
    }
    
    return viewController
  }
}

extension UIViewController : StoryboardIdentifiable { }

// MARK: identifiable

protocol StoryboardIdentifiable {
  static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
  static var storyboardIdentifier: String {
    return String(describing: self)
  }
}
