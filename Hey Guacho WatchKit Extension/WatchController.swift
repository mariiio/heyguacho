//
//  WatchController.swift
//  Hey Guacho
//
//  Created by Mario Saul on 1/3/19.
//  Copyright © 2019 Mario Saul. All rights reserved.
//

import Foundation
import WatchKit
import WatchConnectivity

class WatchController: WKInterfaceController {
    @IBOutlet weak var messageLabel: WKInterfaceLabel!

    private let session = WCSession.default
    private var numbers = ""

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        session.delegate = self
        session.activate()
    }
}

extension WatchController: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        guard message["reset"] == nil else {
            messageLabel.setText("Esperando mensaje..")
            numbers = ""
            return
        }

        let number = message["message"] as! String
        numbers = numbers + number
        messageLabel.setText(numbers)

        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)

        replyHandler(["read": "\(hour):\(minute):\(second)"])
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
}
