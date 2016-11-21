//
//  Playlist.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "RemotePlaylist.h"

@implementation RemotePlaylist
- (instancetype)initWithPlaylistMetadata:(Playlist *)playlist
{
    self = [super init];
    if (self) {
        self.active = playlist.active;
        self.closed = playlist.closed;
        self.playlistId = playlist.id;
        self.songsCount = playlist.itemCount;
        self.name = playlist.name;
    }
    return self;
}

@end
