//
//  CurensyViewController.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 06.01.19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class CurensyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let cell = UINib(nibName: "CellsTableViewCell", bundle: nil)
    private var ccys: [Ccy] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cell, forCellReuseIdentifier: CellsTableViewCell.reuseIdentifyer)
        ccys = Getdata.shared.data
    }

    
    @IBAction func refreshButton(_ sender: UIButton) {
        ccys = Getdata.shared.data
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource ad UITableViewDelegat extention to class
extension CurensyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ccys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsTableViewCell.reuseIdentifyer, for: indexPath) as! CellsTableViewCell
        cell.nameOfCcyLabel?.text = ccys[indexPath.row].ccy
        cell.valueOfBuyLabel?.text = ccys[indexPath.row].buy
        cell.valueOfSaleLabel?.text = ccys[indexPath.row].sale
        return cell
    }
    
    
}

