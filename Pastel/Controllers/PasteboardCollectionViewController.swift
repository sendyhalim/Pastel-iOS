//
//  PasteboardCollectionViewController.swift
//  Pastel
//
//  Created by Sendy Halim on 4/1/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import RxSwift

class PasteboardCollectionViewController: UIViewController {
  let pasteboardService = PasteboardService()
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    pasteboardService
      .pasteboardItems
      .subscribeNext {
        print($0)
      } >>> disposeBag
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
