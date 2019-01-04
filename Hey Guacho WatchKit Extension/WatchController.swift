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

    private var numbers = ""

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        WCSession.default.delegate = self
        WCSession.default.activate()
    }
}

extension WatchController: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        guard userInfo["reset"] == nil else {
            messageLabel.setText("Esperando mensaje..")
            numbers = ""
            return
        }

        let number = userInfo["message"] as! String
        numbers = numbers + number
        messageLabel.setText(numbers)
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
}
