//
//  ViewController.swift
//  Pastel
//
//  Created by Sendy Halim on 2/28/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import RxSwift

class RootViewController: UIViewController {
  let pasteboardCollectionViewController = {
    return PasteboardCollectionViewController(
      nibName: "PasteboardCollectionViewController",
      bundle: nil
    )
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(pasteboardCollectionViewController.view)
  }
}
