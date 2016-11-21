//
//  PlayerReceiverService.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 29.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlayerReceiverServiceListener <NSObject>
- (void)currentPlayerStateDidChange:(ClementinePlayerState)state;

- (void)currentSongDidChange:(RemoteSong*)song;
- (void)currentSongPositionDidChange:(NSInteger)position;

- (void)currentVolumeDidChange:(NSInteger)volume;

- (void)currentRepeatModeDidChange:(ClementineRepeatMode)mode;
- (void)currentShuffleModeDidChange:(ClementineShuffleMode)mode;
@end

@protocol PlayerReceiverServiceProtocol <NSObject>
- (void)receiveFromData:(NSData*)data;
@property (nonatomic, weak, readwrite) id<PlayerReceiverServiceListener> listenerPlayerReceive;
@end


