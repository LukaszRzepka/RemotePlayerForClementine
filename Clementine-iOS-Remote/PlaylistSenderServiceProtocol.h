//
//  PlaylistSenderServiceProtocol.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 08.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClementineMessage.h"
#import "RemoteSong.h"

typedef void(^MessageSenderToServer)(ClementineMessage* messageToSend);

@protocol PlaylistSenderServiceProtocol <NSObject>
- (instancetype)initWithBlockToSendMessage:(MessageSenderToServer)sendToServer;

- (void)setCurrentSong:(NSInteger)songIndex playlistId:(NSInteger)playlistId;
- (void)addSongs:(NSArray<RemoteSong*>*)songs toPlaylist:(NSInteger)playlistId;
- (void)getPlaylistSongs:(NSInteger)playlistId;
- (void)removeSongs:(NSArray<RemoteSong*>*)songs fromPlaylist:(NSInteger)playlistId;
- (void)closePlaylist:(NSInteger)playlistId;

@end