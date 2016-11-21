//
//  Clementine.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerSenderServiceProtocol.h"
#import "PlayerReceiverServiceProtocol.h"
#import "Constants.h"

@interface RemotePlayer : NSObject
+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance")));
- (instancetype)init __attribute__((unavailable("init not available, call sharedInstance")));
+ (instancetype)new __attribute__((unavailable("new not available, call sharedInstance")));

+ (instancetype)sharedInstance;

- (void)setPlayerSenderService:(id<PlayerSenderServiceProtocol>)playerSenderService andReceiverService:(id<PlayerReceiverServiceProtocol>)receiverService;

@property (nonatomic, readonly)float trackRate;
@property (nonatomic, readonly)NSInteger volume;
@property (nonatomic, readonly)NSInteger trackPosition;
@property (nonatomic, readonly)ClementineRepeatMode repeat;
@property (nonatomic, readonly)ClementineShuffleMode shuffle;
@property (nonatomic, readonly)RemoteSong *currentSong;
@property (nonatomic, readonly)ClementinePlayerState state;

@property (nonatomic, readonly) id<PlayerSenderServiceProtocol> playerSenderService;
@property (nonatomic, readonly) id<PlayerReceiverServiceProtocol> playerReceiverService;
@end
