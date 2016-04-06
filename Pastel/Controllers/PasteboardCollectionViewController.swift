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

  let disposeBag = DisposeBag()
  let vm = PasteboardListViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.registerNib(
      R.nib.pasteboardItemTextCell(),
      forCellWithReuseIdentifier: R.nib.pasteboardItemTextCell.name
    )

    // Do any additional setup after loading the view, typically from a nib.
    vm.service
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
    return vm.service.pasteboardItems.value.count
  }

  func cellForItemContent(
    content: PasteboardItemContent,
    indexPath: NSIndexPath
  ) -> PasteboardItemCell {
    let cell = (collectionView.dequeueReusableCellWithReuseIdentifier(
      R.nib.pasteboardItemTextCell.name,
      forIndexPath: indexPath
    ) as? PasteboardItemCell) ?? PasteboardItemCell()

    switch (content) {
    case .Text(let str):
      cell.textLabel.text = str

    case .URL(let url):
      cell.textLabel.text = url.description

    default:
      cell.textLabel.text = "Not implemented yet"
    }

    return cell
  }

  func collectionView(
    collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath
  ) -> UICollectionViewCell {
    let item = vm[indexPath.row]

    return cellForItemContent(item.content, indexPath: indexPath)
  }
}
