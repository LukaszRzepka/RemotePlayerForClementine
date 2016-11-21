//
//  ClementineMessageParser.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteSong.h"
#import "RemotePlaylist.h"
#import "Constants.h"
#import "PlayerReceiverServiceProtocol.h"

@interface ClementinePlayerReceiver : NSObject <PlayerReceiverServiceProtocol>
@property (nonatomic, weak) id<PlayerReceiverServiceListener> listenerPlayerReceive;
@end
