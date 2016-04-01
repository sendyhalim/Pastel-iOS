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
  @IBOutlet weak var collectionView: UICollectionView!

  let pasteboardService = PasteboardService()
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self

    // Do any additional setup after loading the view, typically from a nib.
    pasteboardService
      .pasteboardItems
      .asObservable()
      .subscribeNext {
        print($0)
      } >>> disposeBag
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension PasteboardCollectionViewController: UICollectionViewDelegate {

}

extension PasteboardCollectionViewController: UICollectionViewDataSource {
  func collectionView(
    collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return pasteboardService.pasteboardItems.value.count
  }

  func collectionView(
    collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath
  ) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}