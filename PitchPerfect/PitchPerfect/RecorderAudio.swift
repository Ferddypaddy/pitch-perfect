//
//  RecorderAudio.swift
//  PitchPerfect
//
//  Created by ferddy on 3/24/15.
//  Copyright (c) 2015 ferddy. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    init(filePathUrl: NSURL, title: String)
    {
        self.filePathUrl = filePathUrl;
        self.title = title;
    }
}



