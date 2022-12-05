//
//  ReaderViewController.swift
//  NFCReaderWriter
//
//  Created by GOURAVM on 01/12/22.
//

import UIKit

class ReaderViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var txtView: UITextView!
    
    let nfcManager = NFCManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func scanButtonAction(_ sender: Any) {
          
        nfcManager.read { manager in
            // Session did become active
            manager.setMessage("👀 Place iPhone near the tag to read")
        } didDetect: { manager, result in
            switch result {
            case .failure:
                manager.setMessage("👎 Failed to read tag")
            case .success(let message):
                manager.setMessage("🙌 Tag read successfully")
                
                guard let record = message?.records.first else {

                    return
                }

                let payload: String

                payload = "\(String(data: record.payload, encoding: .utf8)?.dropFirst(3) ?? "<UNK>")"
               

                print("\"\(payload)\"")
                
                DispatchQueue.main.async {
                    self.txtView.text = payload
                }
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
