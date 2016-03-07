//
//  PasteboardItem.swift
//  Pastel
//
//  Created by Sendy Halim on 3/3/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit

///  A data structure that represents a file, the file could be
///  a remote or local file.
///
///  - Image: Image File
enum File {
  case Image(NSURL, UIImage)
}

///  A data structure that represents the content of a PasteboardItem.
///
///  - Text:      Represents plain text.
///  - URL:       Represents a url.
///  - Image:     Represents an image.
///  - LocalFile: Represents a local file.
enum PasteboardItemContent {
  case Text(String)
  case URL(NSURL)
  case Image(UIImage)
  case LocalFile(File)
}

///  A data structure that represent an item that has been (or currently available)
///  in the system pasteboard/clipboard.
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