//
//  FirstViewController.swift
//  LyricsViewer
//
//  Created by MV on 29/01/2018.
//  Copyright © 2018 velvet. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {


    var lyrics1: [String]?
    var IDs_array: [Int]!
    @IBOutlet weak var SongName1: UITextField!
    @IBOutlet weak var ArtistName: UITextField!
    
    @IBAction func Search_lyrics(_ sender: Any) {
        let song: String?
        let artist: String?
        song = SongName1.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        artist = ArtistName.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: "http://api.musixmatch.com/ws/1.1/track.search?apikey=30fd07ababa3f83f39bf18891ee86a6f&matcher.lyrics.get?q_track=" + song! + "&q_artist=" + artist!)
        do {
        let data = NSData(contentsOf: url! as URL)
        var names = [String]()
        var IDs = [Int]()
            let json = try JSONSerialization.jsonObject(with: data! as Data, options:.allowFragments) as! [String:AnyObject]
            if let item = json["message"] as? [String: AnyObject] {
                if let body = item["body"] as? [String: AnyObject] {
                    if let track_list = body["track_list"] as? [[String: AnyObject]] {
                            for track_detail in track_list {
                                if let track_detail2 = track_detail["track"] as? [String: AnyObject]{
                                    let tracknames = track_detail2["track_name"]  as? String
                                    let trackartists = track_detail2["artist_name"] as? String
                                    let trackID = track_detail2["track_id"] as! Int
                                    let songs = trackartists! + " - " + tracknames!
                                    names.append(songs)
                                    IDs.append(trackID)
                                    lyrics1 = names
                                    IDs_array = IDs                                    
                                }
                            }
                    }
                }
            }
        
        } catch {
            print("error serializing JSON: \(error)")
        }
            
        
    //}
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let LyricsViewer1 = segue.destination as? LyricsViewer else { return}
        LyricsViewer1.ReceivedPhrase = lyrics1
        LyricsViewer1.Lyrics_ID = IDs_array
    }

    }

