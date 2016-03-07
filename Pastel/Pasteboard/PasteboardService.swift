//
//  PasteboardService.swift
//  Pastel
//
//  Created by Sendy Halim on 3/7/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import RxSwift
import Swiftz

/// A service for interacting directly with system's pasteboard/clipboard
final class PasteboardService {
  let pasteboard = UIPasteboard.generalPasteboard()
  let pasteboardItems = Variable<[PasteboardItem]>([])
}
