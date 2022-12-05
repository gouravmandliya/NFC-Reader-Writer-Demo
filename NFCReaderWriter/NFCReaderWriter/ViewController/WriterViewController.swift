//
//  WriterViewController.swift
//  NFCReaderWriter
//
//  Created by GOURAVM on 01/12/22.
//

import UIKit
import CoreNFC

class WriterViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var txtView: UITextView!
    
    let nfcManager = NFCManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtView.delegate = self
        txtView.layer.borderColor = UIColor.black.cgColor
        txtView.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }
    
    @IBAction func scanButtonAction(_ sender: Any) {
        
        guard self.txtView.hasText else {
            IHProgressHUD.showError(withStatus: "Please enter any text message")
            return
        }
        
        guard let payload = (self.txtView.text ?? "").data(using: .utf8) else {
            return
        }

        let record = NFCNDEFPayload(format: .nfcWellKnown, type: Data(), identifier: Data(), payload: payload)

        let myMessage = NFCNDEFMessage.init(records: [record])
        
       
        nfcManager.write(message: myMessage) { manager in
            // Session did become active
            manager.setMessage("👀 Place iPhone near the tag to be written on")
        } didDetect: { manager, result in
            switch result {
            case .failure:
                manager.setMessage("👎 Failed to write tag")
            case .success:
                manager.setMessage("🙌 Tag successfully written")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WriterViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
