//
//  ViewController.swift
//  LayerSample
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let layerController = LayerController()
        layerController.authenticate { (authenticatedUser, error) in
            if error != nil {
                print("Found error: \(error!)")
                return
            }
            print("user: \(authenticatedUser!)")
            let nextViewController = ConversationListViewController(layerClient: layerController.layerClient!)
            let navigationController = UINavigationController(rootViewController: nextViewController)
            DispatchQueue.main.async {
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

