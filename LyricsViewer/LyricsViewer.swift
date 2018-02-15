//
//  LyricsViewerViewController.swift
//  LyricsViewer
//
//  Created by MV on 29/01/2018.
//  Copyright © 2018 velvet. All rights reserved.
//

import UIKit

class LyricsViewer: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var ResultView: UITableView!
    @IBOutlet weak var LyricsText: UITextView!
 
    
    var ReceivedPhrase: [String]?
    var Lyrics_ID: [Int]!
    var ID_temp: Int!
    override func viewDidLoad() {
        //LyricsTextBox.text
        super.viewDidLoad()
            ResultView.delegate = self
            ResultView.dataSource = self
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ReceivedPhrase?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ResultView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = ReceivedPhrase?[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ID_temp = tableView.indexPathForSelectedRow?.row
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FinalLyrics {
            destination.LyricsID = Lyrics_ID![ID_temp!]
            print(Lyrics_ID)
        }
    }
}
