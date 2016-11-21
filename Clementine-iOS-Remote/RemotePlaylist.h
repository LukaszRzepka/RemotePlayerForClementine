//
//  Playlist.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteSong.h"
#import "ClementineRemoteProtocolBuffer.pb.h"

@interface RemotePlaylist : NSObject
-(instancetype)initWithPlaylistMetadata:(Playlist*)playlist;
@property (nonatomic)BOOL active;
@property (nonatomic)BOOL closed;
@property (nonatomic)NSInteger playlistId;
@property (nonatomic)NSInteger songsCount;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray<RemoteSong*> *songs;
@end
