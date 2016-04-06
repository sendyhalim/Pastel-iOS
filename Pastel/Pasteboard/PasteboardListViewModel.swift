//
//  PasteboardListViewModel.swift
//  Pastel
//
//  Created by Sendy Halim on 4/6/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import Foundation

struct PasteboardListViewModel {
  let service = PasteboardService()

  subscript(index: Int) -> PasteboardItem {
    return service.pasteboardItems.value[index]
  }
}