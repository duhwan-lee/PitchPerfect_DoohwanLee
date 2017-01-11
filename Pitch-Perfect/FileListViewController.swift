//
//  FileListViewController.swift
//  Pitch-Perfect
//
//  Created by Tacademy-Mac on 2017. 1. 11..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

class FileListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var fileURL = [URL]()
    var fileName = [String]()
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewWillDisappear(_ animated: Bool) {
        if let indexPathList = tableview.indexPathForSelectedRow {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.filename = fileName[indexPathList.row]
            appDelegate.recordAudioURL = fileURL[indexPathList.row]
        }
    }
    override func viewDidLoad() {
        print("file viewdidload")
        super.viewDidLoad()
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            
            fileURL = directoryContents.filter{ $0.pathExtension == "wav" }
            fileName = fileURL.map{ $0.deletingPathExtension().lastPathComponent }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileURL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell01", for: indexPath)
        cell.textLabel?.text = fileName[indexPath.row]
        
        return cell
    }
    override func viewDidLayoutSubviews() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableview.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
