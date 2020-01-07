//
//  QuotesViewController.swift
//  FrasesChaves
//
//  Created by Danilo Requena on 06/01/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {

    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var ivPhotoBg: UIImageView!
    @IBOutlet weak var lbQuote: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var ltTop: NSLayoutConstraint!
    
    var quotesManager = QuotesManager()
    var timer: Timer?
    
    var config = Configuration.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
    
    func formatView() {
        view.backgroundColor = config.colorScheme == 0 ? .white : UIColor(red: 156.0/255.0, green: 68.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        lbQuote.textColor = config.colorScheme == 0 ? .black : .white
        lbAuthor.textColor = config.colorScheme == 0 ? UIColor(red: 192.0/255.0, green: 96.0/255.0, blue: 49.0/255.0, alpha: 1.0) : .yellow
        
        prepareQuote()
    }
    
    func prepareQuote() {
        timer?.invalidate()
        
        if config.autorefresh{
            timer = Timer.scheduledTimer(withTimeInterval: config.timeInterval, repeats: true, block: { (timer) in
                self.showRandomQuote()
            })
        }
        showRandomQuote()
    }
    
    func showRandomQuote() {
        let quote = quotesManager.getRandomQuote()
        ivPhoto.image = UIImage(named: "\(quote.image)")
        ivPhotoBg.image = ivPhoto.image
        lbQuote.text = quote.quote
        lbAuthor.text = quote.author
        
        ivPhoto.alpha = 0.0
        ivPhotoBg.alpha = 0.0
        lbQuote.alpha = 0.0
        lbAuthor.alpha = 0.0
        ltTop.constant = 50
        
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.5) {
            self.ivPhoto.alpha = 1.0
            self.ivPhotoBg.alpha = 0.25
            self.lbQuote.alpha = 1.0
            self.lbAuthor.alpha = 1.0
            self.ltTop.constant = 10
            
            self.view.layoutIfNeeded()
        }
        
    }


}
