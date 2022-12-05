//
//  RoleSelectionViewController.swift
//  NFCReaderWriter
//
//  Created by GOURAVM on 01/12/22.
//

import UIKit

class RoleSelectionViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var readerButton: UIButton!
    @IBOutlet weak var writerButton: UIButton!
    

    // MARK: UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preparedButtons([readerButton,writerButton], andAddThemToView: view)
    
    }
    
    // MARK: Functions
    
    private func preparedButtons(_ buttons: [UIButton], andAddThemToView view: UIView) {
        for button in buttons {
            button.addTarget(self, action: #selector(RoleSelectionViewController.buttonTapped(_:)), for: UIControl.Event.touchUpInside)
            button.addTarget(self, action: #selector(RoleSelectionViewController.buttonTapped(_:)), for: UIControl.Event.touchUpInside)
        }
    }

    
    // MARK: Target Actions

    @objc private func buttonTapped(_ button: UIButton) {
        
        if button == readerButton {
            let readerViewController = storyboard?.instantiateViewController(withIdentifier: "ReaderViewController") as? ReaderViewController
            navigationController?.pushViewController(readerViewController!, animated: true)
        } else if button == writerButton {
            let writerViewController = storyboard?.instantiateViewController(withIdentifier: "WriterViewController") as? WriterViewController
                navigationController?.pushViewController(writerViewController!, animated: true)
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
