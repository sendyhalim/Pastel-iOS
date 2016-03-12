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
import Swiftz

///  Transform the given `UIPasteboard` to a PasteboardItem.
///  The content type created will be based on Uniform Type Identifier.
///  Resources:
///  - https://goo.gl/huiIlB
///  - https://goo.gl/WkCVBc
///  - https://goo.gl/giVwKj
///  - https://goo.gl/QSl4wf
///
///  - parameter pasteboard: UIPasteboard
///
///  - returns: PasteboardItem?
func pasteboardItem(pasteboard: UIPasteboard) -> PasteboardItem? {
  if let string = pasteboard.valueForPasteboardType(kUTTypeUTF8PlainText as String) as? String {
    return PasteboardItem(content: .Text(string))
  }

  return .None
}

func pasteboard(notification: NSNotification) -> UIPasteboard? {
  return notification.object as? UIPasteboard
}

struct UIPasteboardEvent {
  static let changed = "UIPasteboardChangedNotification"
}

/// A service for interacting directly with system's pasteboard/clipboard
final class PasteboardService {
  let pasteboardItems = Variable<[PasteboardItem]>([])

  private(set) var running = false
  let pasteboardStream: Observable<Optional<PasteboardItem>> = {
    NSNotificationCenter
      .defaultCenter()
      .rx_notification(UIPasteboardEvent.changed, object: nil)
      .map { $0 >>- pasteboard >>- pasteboardItem }
  }()

  func startPolling() {
    guard running else {
      return
    }

    running = true
    // TODO: create paste board item
  }
}
