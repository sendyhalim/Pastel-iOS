//
//  PasteboardItem.swift
//  Pastel
//
//  Created by Sendy Halim on 3/3/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit

enum File {
  case Image(NSURL, UIImage)
}

enum PasteboardItemContent {
  case Text(String)
  case URL(NSURL)
  case Image(UIImage)
  case LocalFile(File)
}

struct PasteboardItem {
  let createdAt: NSDate
  let content: PasteboardItemContent

  init(content: PasteboardItemContent) {
    self.init(content: content, createdAt: NSDate())
  }

  init(content: PasteboardItemContent, createdAt: NSDate) {
    self.content = content
    self.createdAt = createdAt
  }
}