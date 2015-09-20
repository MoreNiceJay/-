//
//  MainHomeTVC.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/3/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MainHomeTVC: UITableViewController {

    var imageFiles = [PFFile]()
    var imageText = [String]()
    var objectArray = [String]()
    var objectId = String()
    var userId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let query = PFQuery(className: "Posts")
        query.orderByDescending("createdAt")
       
        query.findObjectsInBackgroundWithBlock { (posts :[AnyObject]?, error : NSError?) -> Void in
            if error == nil {
                //에러없는 경우
              
                for post in posts! {
                    
                    self.imageText.append(post["imageText"] as! String)
                    self.imageFiles.append(post["imageFile"] as! PFFile)
                    self.objectArray.append((post.objectId)! as String!)
                    self.userId.append(post["username"] as! String)
                    
                    self.tableView.reloadData()
                   }
            }
        
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return imageText.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainHomeTVCELL

       // 제목
        cell.labelTitle.text = imageText[indexPath.row]
       
       // 이미지
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (imageData : NSData?, error : NSError?) -> Void in
            let image = UIImage(data : imageData!)
           cell.imagePreview.image = image
        }

        //아이디
          cell.labelId.text = "Id: " + self.userId[indexPath.row]

        
        return cell
   
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "commentPage") {
            
            let selectedRowIndex = self.tableView.indexPathForSelectedRow
            let destViewController : comment = segue.destinationViewController as! comment
            destViewController.parentObjectID = objectArray[selectedRowIndex!.row]
            
            }
         }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
