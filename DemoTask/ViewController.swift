//
//  ViewController.swift
//  DemoTask
//
//  Created by pradeep maretha on 08/06/21.
//  Copyright © 2021 pradeep maretha. All rights reserved.
//

import UIKit


class HeaderCell: UITableViewCell {
    
    var headerPlusCallback:(()->Void)? = nil
    
    @IBOutlet weak var LabelHeaderName: UILabel!
    
    
    @IBAction func headerPlusAct(_ sender: Any) {

        headerPlusCallback?()
        
    }
    
    
}

class countCell: UITableViewCell {
    
    var cellPlusCallback :(()->Void)? = nil
    var cellMinusCallback :(()->Void)? = nil
    
    @IBOutlet weak var labelCellName:UILabel!
    @IBOutlet weak var labelCount:UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBAction func cellPlusTapped(_ sender: Any){
        cellPlusCallback?()
    }
    
    @IBAction func cellMinusTapped(_ sender: Any){
        cellMinusCallback?()
    }
    
}


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableViewDemo: UITableView!
    
    private var dataArray = [SectionData]()
    
    var headerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func AddHeaderButtonAct(_ sender: Any) {
        
        var data = SectionData()
        headerCount += 1
        data.header_name = "Header \(headerCount)"
        data.data = [CellData]()
        
        dataArray.append(data)
        
        tableViewDemo.reloadData()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count // returns section counts
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rowData = dataArray[section]
        let rowArray = rowData.data as [CellData]
    
        return rowArray.count // returns rows counts
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! countCell
        
        var sectionArrData = dataArray[indexPath.section]
        var rowArray = sectionArrData.data as [CellData]
        
        var data = rowArray[indexPath.row] as CellData
        
        cell.labelCellName.text = data.cell_name
        cell.labelCount.text = "\(data.count)"
        
        if rowArray.count - 1 == indexPath.row{
            cell.bottomView.isHidden = false
            
        }else{
            cell.bottomView.isHidden = true
        }
        
        
        // increase count
        cell.cellPlusCallback = {
            
            print("plus")
            
            data.count += 1
            
            cell.labelCount.text = "\(data.count)"
            
            rowArray[indexPath.row] = data
            
            sectionArrData.data = rowArray
            self.dataArray[indexPath.section] = sectionArrData
            self.tableViewDemo.reloadData()
            print(self.dataArray[indexPath.section])
            
        }
        
        // decrease count
        cell.cellMinusCallback = {
            
            print("minus")
            
            if data.count > 1 {
                
                data.count -= 1
                cell.labelCount.text = "\(data.count)"
                rowArray[indexPath.row] = data
                sectionArrData.data = rowArray
                self.dataArray[indexPath.section] = sectionArrData
                self.tableViewDemo.reloadData()

            }
            
        }
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCell(withIdentifier:"header") as! HeaderCell // custom header
        
        var headerData = dataArray[section] // sectionData
        
        header.LabelHeaderName.text = headerData.header_name // setting header name
        
        
        // header plus action block
        header.headerPlusCallback = {
        
            print(section)
            
            headerData.count += 1 // updating section cell count
            
            var cellArr = headerData.data // cellDataArray
            
            print(cellArr)
            
            var data = CellData()
            
            data.count = 1
            data.cell_name = "cell \(headerData.count)"
            
            cellArr.append(data)
            headerData.data = cellArr
            
            self.dataArray[section] = headerData
            
            self.reload(tableView: self.tableViewDemo)
           // self.tableViewDemo.reloadData()
            
        }
        
        return header
        
    }
    
   
    
}

extension ViewController{
    
    func reload(tableView: UITableView) {

        let contentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.setContentOffset(contentOffset, animated: false)

    }

}
