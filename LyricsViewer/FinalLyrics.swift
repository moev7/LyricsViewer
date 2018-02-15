//
//  FinalLyrics.swift
//  LyricsViewer
//
//  Created by MV on 10/02/2018.
//  Copyright © 2018 velvet. All rights reserved.
//

import UIKit

class FinalLyrics: UIViewController {
    
    var LyricsID: Int!
    @IBOutlet weak var FinalLyrics: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let FinalID: String = String(LyricsID)
        let url = NSURL(string: "http://api.musixmatch.com/ws/1.1/track.lyrics.get?apikey=30fd07ababa3f83f39bf18891ee86a6f&track_id=" + FinalID)
        let data = NSData(contentsOf: url! as URL)
        
        
        do {
            let json = try JSONSerialization.jsonObject(with: data! as Data, options:.allowFragments) as! [String:AnyObject]
            
            if let item = json["message"] as? [String: AnyObject]{
                if let body = item["body"] as? [String: AnyObject] {
                    print(body)
                    if let lyrics = body["lyrics"] as? [String: AnyObject] {
                        print(lyrics["lyrics_body"] as Any)
                        FinalLyrics.text = lyrics["lyrics_body"] as! String?
                    }
                }
            }
            
            
            
            
            
        } catch {
            print("error serializing JSON: \(error)")
        }
        
        
        // Do any additional setup after loading the view.
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
