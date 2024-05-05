//
//  ViewController.swift
//  HandTrackAI
//
//  Created by Rakymzhan Zhabagin on 05.05.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func fingerPosition(_ sender: UIButton) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
}
