//
//  ViewController.swift
//  Network
//
//  Created by Laurent Noudohounsi on 25/06/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
//
//    let operation = GetQrCodeOperation(qrcode: "MM10000903")
//    operation.success = { success in print("success : \(success)")}
//    operation.failure = { error in print("error : \(error)")}
//    NetworkQueue.shared.addOperation(operation: operation)

    getConfig(success: { config in
      print("succes: \(config)")
    }, failure: { error in
      print("error : \(error)")
    })
  }

  func getConfig(success: ((Config?) -> Void)? = nil,
                 failure: ((Error) -> Void)? = nil) {
    let operation = GetConfigOperation()

    operation.success = { result in success?(result?.data.first)}
    operation.failure = failure

    NetworkQueue.shared.addOperation(operation: operation)
  }
}

