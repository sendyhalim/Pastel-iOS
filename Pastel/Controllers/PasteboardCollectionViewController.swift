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

  private struct Identifier {
    static let ItemTextCell = "PasteboardItemTextCell"
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let nib = UINib(nibName: "PasteboardItemTextCell", bundle: nil)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.registerNib(nib, forCellWithReuseIdentifier: Identifier.ItemTextCell)

    // Do any additional setup after loading the view, typically from a nib.
    pasteboardService
      .pasteboardItems
      .asObservable()
      .subscribeNext {
        print($0)
      } >>> disposeBag
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
    var cell = collectionView.dequeueReusableCellWithReuseIdentifier(
      Identifier.ItemTextCell,
      forIndexPath: indexPath
    ) as? PasteboardItemCell

    if cell == nil {
      cell = PasteboardItemCell()
    }

    cell!.textLabel.text = "hi there"

    return cell!
  }
}
