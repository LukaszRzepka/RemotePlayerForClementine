//
//  ClementinePlaylistManager.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteSong.h"
#import "RemotePlaylist.h"
#import "PlaylistSenderServiceProtocol.h"
#import "PlaylistReceiverServiceProtocol.h"

@interface RemotePlaylistManager : NSObject
+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance")));
- (instancetype)init __attribute__((unavailable("init not available, call sharedInstance")));
+ (instancetype)new __attribute__((unavailable("new not available, call sharedInstance")));

+ (instancetype)sharedInstance;

- (void)setSenderService:(id<PlaylistSenderServiceProtocol>)sender andReceiverService:(id<PlaylistReceiverServiceProtocol>)receiver;

@property (nonatomic, readonly)RemotePlaylist *currentPlaylist;
@property (nonatomic, readonly) id<PlaylistSenderServiceProtocol> playlistSenderService;
@property (nonatomic, readonly) id<PlaylistReceiverServiceProtocol> playlistReceiverService;
@end
