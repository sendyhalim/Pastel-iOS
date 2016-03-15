//
//  PasteboardItem.swift
//  Pastel
//
//  Created by Sendy Halim on 3/15/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import Nimble
import Quick
@testable import Pastel

class PasteboardItemSpec: QuickSpec {
  override func spec() {
    describe("init(content:)") {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "HH:mm"

      it("should set createdAt with default time now") {
        let result = PasteboardItem(content: .Text("wut"))
        let now = NSDate()

        expect(formatter.stringFromDate(result.createdAt)) == formatter.stringFromDate(now)
      }
    }
  }
}
