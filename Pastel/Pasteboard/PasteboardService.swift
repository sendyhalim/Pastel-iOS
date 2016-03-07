//
//  PasteboardService.swift
//  Pastel
//
//  Created by Sendy Halim on 3/7/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// A service for interacting directly with system's pasteboard/clipboard
final class PasteboardService {
  private struct PasteboardEvent {
    static let changed = "UIPasteboardChangedNotification"
  }

  let pasteboardItems = Variable<[PasteboardItem]>([])

  private(set) var running = false
  private let pasteboardChanged: Observable<NSNotification> = {
    NSNotificationCenter.defaultCenter().rx_notification(PasteboardEvent.changed, object: nil)
  }()

  func startPolling() {
    guard running else {
      return
    }

    running = true

    // TODO: create paste board item
  }
}
