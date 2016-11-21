//
//  ClementinePlaylistReceiver.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 08.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaylistReceiverServiceProtocol.h"

@interface ClementinePlaylistReceiver : NSObject <PlaylistReceiverServiceProtocol>
@property (nonatomic, weak) id<PlaylistReceiverServiceListener> listenerPlaylistReceive;
@end
