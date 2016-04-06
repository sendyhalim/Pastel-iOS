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
    collectionView.registerNib(
      R.nib.pasteboardItemTextCell(),
      forCellWithReuseIdentifier: R.nib.pasteboardItemTextCell.name
    )

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

  func getCellForItemAtIndexPath(indexPath: NSIndexPath) -> PasteboardItemCell {
    if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
        R.nib.pasteboardItemTextCell.name,
        forIndexPath: indexPath
      ) as? PasteboardItemCell {
        return cell
    }

    return PasteboardItemCell()
  }

  func collectionView(
    collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath
  ) -> UICollectionViewCell {
    let cell = getCellForItemAtIndexPath(indexPath)

    cell.textLabel.text = "hi there"

    return cell
  }
}
