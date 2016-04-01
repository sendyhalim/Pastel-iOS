//
//  PasteboardService.swift
//  Pastel
//
//  Created by Sendy Halim on 3/7/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import MobileCoreServices
import RxSwift
import RxCocoa
import RxOptional
import Swiftz

///  Transform the given `AnyObject` to a `PasteboardItem`.
///
///  - parameter pasteboard: `AnyObject`
///
///  - returns: `PasteboardItem?`
func pasteboardItem(content: AnyObject) -> PasteboardItem? {
  if let string = content as? String {
    if let url = NSURL(string: string) {
      return PasteboardItem(content: .URL(url))
    }

    return PasteboardItem(content: .Text(string))
  }

  if let image = content as? UIImage {
    return PasteboardItem(content: .Image(image))
  }

  return .None
}

///  Extract the content of `UIPasteboard`.
///  The content type created will be based on Uniform Type Identifier.
///  Resources:
///  - https://goo.gl/huiIlB
///  - https://goo.gl/WkCVBc
///  - https://goo.gl/giVwKj
///  - https://goo.gl/QSl4wf
///
///  - parameter pasteboard: `UIPasteboard`
///
///  - returns: `AnyObject?`
func pasteboardContent(pasteboard: UIPasteboard) -> AnyObject? {
  let types = [
    kUTTypeUTF8PlainText,
    kUTTypeImage
  ]

  for type in types {
    if let content = pasteboard.valueForPasteboardType(type as String) {
      return content
    }
  }

  return .None
}

///  Get the `UIPasteboard` from the given `NSNotification`
///
///  - parameter notification: `NSNotification`
///
///  - returns: `UIPasteboard?`
func pasteboard(notification: NSNotification) -> UIPasteboard? {
  return notification.object as? UIPasteboard
}

struct UIPasteboardEvent {
  static let changed = "UIPasteboardChangedNotification"
}

/// A service for interacting directly with system's pasteboard/clipboard
final class PasteboardService {
  let pasteboardItems = Variable<Array<PasteboardItem>>([])
  let disposeBag = DisposeBag()

  init() {
    NSNotificationCenter
      .defaultCenter()
      .rx_notification(UIPasteboardEvent.changed, object: nil)
      .map {
        $0 >>- pasteboard >>- pasteboardContent >>- pasteboardItem
      }
      .filterNil()
      .subscribeNext { [weak self] in
        guard let `self` = self else { return }

        self.pasteboardItems.value = self.pasteboardItems.value.cons($0)
      } >>> disposeBag
  }
}
