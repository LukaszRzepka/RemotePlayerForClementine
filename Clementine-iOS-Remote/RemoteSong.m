//
//  Song.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "RemoteSong.h"
#import "ClementineRemoteProtocolBuffer.pb.h"

@implementation RemoteSong
- (instancetype)initWithSongMetadata:(SongMetadata *)songMetadata
{
    self = [super init];
    if (self) {
        self.songId = songMetadata.id;
        self.index = songMetadata.index;
        self.rating = songMetadata.rating;
        self.track = songMetadata.track;
        self.disc = songMetadata.disc;
        self.playCount = songMetadata.playcount;
        self.lenght = songMetadata.length;
        self.title = songMetadata.title;
        self.artist = songMetadata.artist;
        self.album = songMetadata.album;
        self.albumArtist = songMetadata.albumartist;
        self.prettyLenght = songMetadata.prettyLength;
        self.genre = songMetadata.genre;
        self.year = songMetadata.prettyYear;
        self.url = songMetadata.url;
        self.filename = songMetadata.filename;
        self.size = songMetadata.fileSize;
        
        if (songMetadata.hasArt) {
            self.art = [UIImage imageWithData:songMetadata.art];
        }
        
    }
    return self;
}

@end
