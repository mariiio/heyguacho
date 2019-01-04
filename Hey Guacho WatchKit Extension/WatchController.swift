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

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        WCSession.default.delegate = self
        WCSession.default.activate()
    }
}

extension WatchController: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        messageLabel.setText(message["message"] as? String)

        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)

        replyHandler(["read": "\(hour):\(minute):\(second)"])
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
}
