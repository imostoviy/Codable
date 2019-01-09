//
//  ViewController.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 09.01.19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBAction func currencyTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let currencyController = storyboard.instantiateViewController(withIdentifier: "Currency Screen") as! CurensyViewController
        currencyController.title = "Currency base: UAH"
        navigationController?.pushViewController(currencyController, animated: true)
    }
}

