//
//  PhoneViewController.swift
//  Hey Guacho
//
//  Created by Mario Saul on 1/3/19.
//  Copyright © 2019 Mario Saul. All rights reserved.
//

import UIKit
import WatchConnectivity

class PhoneViewController: UIViewController {
    @IBOutlet weak var messageTextField: UITextField!

    private let session = WCSession.default

    override func viewDidLoad() {
        super.viewDidLoad()

        session.delegate = self
        session.activate()
    }

    @IBAction func reset(_ sender: Any) {
        do {
            try session.updateApplicationContext(["reset": true])
            messageTextField.text = ""
        } catch {}
    }

    @IBAction func sendMessage(_ sender: Any) {
        guard let lastChar = messageTextField.text?.last else { return }
        do {
            try session.updateApplicationContext(["message": String(lastChar)])
        } catch {}
    }
}

extension PhoneViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) { }
    func sessionDidDeactivate(_ session: WCSession) { }
}
