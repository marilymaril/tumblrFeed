//
//  DetailViewController.swift
//  tumblrFeed
//
//  Created by Marilyn Florek on 9/7/18.
//  Copyright © 2018 Marilyn Florek. All rights reserved.
//

import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}



class DetailViewController: UIViewController {

    var index: Int!
    var post: [String: Any] = [:]
    
    @IBOutlet weak var postPhoto: UIImageView!
    @IBOutlet weak var postCaption: UITextView!
    @IBOutlet weak var postSource: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = post["caption"] as! String!
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            postPhoto.af_setImage(withURL: url!)
            postCaption.text = ("\(content?.htmlToString ?? "unknown")")
            
            postPhoto.isUserInteractionEnabled = true
        }
        
        if let trail = post["trail"] as? [[String:Any]] {
            let source = trail[0]
            let blog = source["blog"] as! [String: Any]
            let name = blog["name"] as! String
            postSource.text = name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let fullScreenViewController = segue.destination as! FullScreenPhotoViewController
        
        fullScreenViewController.image = postPhoto.image!
    }

}
