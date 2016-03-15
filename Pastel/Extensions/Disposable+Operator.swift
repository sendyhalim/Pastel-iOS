//
//  Observable+DisposeBag.swift
//  Pastel
//
//  Created by Sendy Halim on 3/16/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import RxSwift

infix operator >>> { associativity left precedence 10 }

func >>> (disposable: Disposable, disposeBag: DisposeBag) {
  return disposable.addDisposableTo(disposeBag)
}
