//
//  PlayVC.swift
//  AKSwiftSlideMenu
//
//  Created by MAC-186 on 4/8/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PlayVC: BaseViewController,UITableViewDelegate,UITableViewDataSource
{
    var providers = [String]()
    var prov = [Dictionary<String,String>]()
    //var ref: DatabaseReference!
   
    @IBOutlet weak var tblView: UITableView!
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prov.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! serviceTableViewCell
        cell.name.text = prov[indexPath.row]["name"]
        cell.profession.text = prov[indexPath.row]["Number"]
        
        return cell
    }
    
    var service = ""
    var name1: String = ""
  var flag1=false,flag2=false
    var n: String = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(service)
        //addSlideMenuButton()
        tblView.delegate = self
        tblView.dataSource = self
   /*     let  ref = Database.database().reference()
       
        ref.child("providers/name").observe(.value, with: { snapshot in
            self.flag1 = true
            self.name1 = snapshot.value as! String
            
        })
        ref.child("providers/mobile").observe(.value, with: { snapshot in
            self.flag2 = true
            self.n = snapshot.value as! String
            
        })
        if(flag1&&flag2 == true){
            updateProviders()
        }*/
       /* { (error) in
            print(error.localizedDescription)
        }*/
    //self.updateProviders()
       // print(num1+name1)
        // Do any additional setup after loading the view.
    }
    func updateProviders(){
        prov.append(["name":name1, "Number":n])
        
    }
    override func viewWillAppear(_ animated: Bool) {
       // updateProviders()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
