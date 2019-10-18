//
//  PostsTableViewController.swift
//  fakestagram
//
//  Created by LuisE on 9/24/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {
    static let cellId = "PostCell"
    var posts: [Post]? {
        didSet { self.tableView.reloadData() }
    }
    let client = RestClient<[Post]>(client: Client.fakestagram, basePath: "/api/v1/posts/")

    override func viewDidLoad() {
        super.viewDidLoad()
        client.show { [unowned self] data in
            self.posts = data
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewController.cellId, for: indexPath)
        guard let posts = self.posts else { return cell }
        posts[indexPath.row].load { img in
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.image = img
        }
        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].location

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showPostSegue" {
            let dest = segue.destination as! PostViewController
            let idx = self.tableView.indexPathForSelectedRow?.row ?? 0
            dest.post = posts?[idx]
        }
     }

}
