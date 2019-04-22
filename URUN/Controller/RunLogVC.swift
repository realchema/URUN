//
//  SecondViewController.swift
//  URUN
//
//  Created by Jose M Arguinzzones on 2019-03-09.
//  Copyright © 2019 Jose M Arguinzzones. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource  = self
    }


}

extension RunLogVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell") as? RunLogCell {
            guard let run = Run.getAllRuns()?[indexPath.row] else {
                return RunLogCell()
            }
            cell.configure(run: run)
            
             return cell
        } else {
            return RunLogCell()
        }
       
    }
}

