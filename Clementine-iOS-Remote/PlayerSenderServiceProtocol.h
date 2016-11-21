//
//  ClementineSender.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 28.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "RemoteSong.h"
#import "RemotePlaylist.h"
#import "ClementineMessage.h"

typedef void(^MessageSenderToServer)(ClementineMessage* messageToSend);

@protocol PlayerSenderServiceProtocol <NSObject>
- (instancetype)initWithBlockToSendMessage:(MessageSenderToServer)sendToServer;

- (void)setPlay;
- (void)setPause;
- (void)setNext;
- (void)setPrevious;

- (void)setVolume:(NSInteger)volume;
- (void)setShuffle:(ClementineShuffleMode)mode;
- (void)setRepeat:(ClementineRepeatMode)repeat;
- (void)setTrackPosition:(NSInteger)position;
- (void)setTrackRate:(float)rating;

- (void)searchFor:(NSString*)query;
@end
