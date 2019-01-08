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
    @IBOutlet weak var queueCount: WKInterfaceLabel!
    @IBOutlet weak var queueHead: WKInterfaceLabel!

    private let session = WCSession.default
    private let memes = ["william wallace",
                         "frozen",
                         "dobby",
                         "squirrel"]

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        session.delegate = self
        session.activate()
    }

    @IBAction func sendMessage() {
        let meme = memes.randomElement()
        let url = Bundle.main.url(forResource: meme, withExtension: "jpg")!

        session.transferFile(url, metadata: nil)

        queueCount.setText(String(session.outstandingFileTransfers.count))
        queueHead.setText(meme)
    }
}

extension WatchController: WCSessionDelegate {
    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        let count = session.outstandingFileTransfers.count - 1
        
        queueCount.setText(String(count))
        if count == 0 {
            queueHead.setText("-")
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
}
