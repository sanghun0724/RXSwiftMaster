//
//  TableViewController.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/15.
//

import UIKit
import AVFoundation

class TimelineTableViewCell:UITableViewCell,MediaContainer {/// MediaContainer 채택함으로써 contentChanged() 사용가능 
    //MARK: Properties
    var note: UILabel = UILabel()
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    var mediaImageView: UIImageView = UIImageView()
    
    var content: Content? {
        didSet {
            self.contentChanged()
        }
    }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?,content:Content) {
        self.content = content
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentChanged() //init 되면서 발생
        
        let cellHeight:CGFloat = 80
        
        let mediaRect:CGRect = CGRect(x: 5, y: 5, width: cellHeight - 10, height: cellHeight - 10)
        mediaImageView.layout(in: mediaRect)
        videoLayer.layout(in: mediaRect)
        
        mediaImageView.contentMode = .scaleAspectFit
        
        self.addSubview(mediaImageView)
        self.layer.addSublayer(videoLayer)
        
        var noteRect:CGRect = self.bounds
        noteRect.origin.x = mediaRect.width + 10 // 10만큼 오른쪽에 배치
        noteRect.size.width -= noteRect.origin.x
        noteRect.size.height = cellHeight
        
        note.layout(in:noteRect)
        
        self.addSubview(note)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
