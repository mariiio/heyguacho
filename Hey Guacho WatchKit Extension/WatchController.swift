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

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        session.delegate = self
        session.activate()
    }

    @IBAction func sendMessage() {
        let url = Bundle.main.url(forResource: "free", withExtension: "jpg")!

        session.transferFile(url, metadata: nil)
    }
}

extension WatchController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
}
