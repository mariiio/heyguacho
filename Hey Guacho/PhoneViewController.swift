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
    @IBOutlet weak var imageView: UIImageView!

    private let session = WCSession.default

    override func viewDidLoad() {
        super.viewDidLoad()

        session.delegate = self
        session.activate()
    }
}

extension PhoneViewController: WCSessionDelegate {
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        let imageData = NSData.init(contentsOf: file.fileURL)! as Data
        imageView.image = UIImage(data: imageData)
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) { }
    func sessionDidDeactivate(_ session: WCSession) { }
}
