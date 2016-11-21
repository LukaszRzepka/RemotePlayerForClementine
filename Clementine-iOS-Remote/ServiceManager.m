//
//  ConnectionManager.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 06.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ServiceManager.h"
#import "ClementineConnection.h"
#import "ClementinePlayerReceiver.h"
#import "ClementinePlayerSender.h"
#import "RemotePlayer.h"
#import "RemotePlaylistManager.h"
#import "ClementinePlaylistReceiver.h"
#import "ClementinePlaylistSender.h"

@interface ServiceManager() <RemoteConnectionDelegate>
@property (nonatomic, strong)ClementineConnection *clementineConnection;
@property (nonatomic, strong)RemotePlayer *player;
@property (nonatomic, strong)RemotePlaylistManager *playlist;
@end

@implementation ServiceManager

- (void)prepareConnection
{
    self.clementineConnection = [ClementineConnection sharedInstance];
    
    ClementinePlayerReceiver *receiver = [[ClementinePlayerReceiver alloc] init];
    ClementinePlaylistReceiver *receiverPlaylist = [[ClementinePlaylistReceiver alloc] init];
    
    ClementinePlayerSender *sender = [[ClementinePlayerSender alloc] initWithBlockToSendMessage:^(ClementineMessage *messageToSend)
    {
        [[ClementineConnection sharedInstance] sendClementineMessage:messageToSend];
    }];
    
    ClementinePlaylistSender *senderPlaylist = [[ClementinePlaylistSender alloc] initWithBlockToSendMessage:^(ClementineMessage *messageToSend)
    {
        [[ClementineConnection sharedInstance] sendClementineMessage:messageToSend];
    }];
    
    self.player = [RemotePlayer sharedInstance];
    self.playlist = [RemotePlaylistManager sharedInstance];
    
    [self.player setPlayerSenderService:sender andReceiverService:receiver];
    [self.playlist setSenderService:senderPlaylist andReceiverService:receiverPlaylist];
    
    [ClementineConnection sharedInstance].delegate = self;
}

- (void)clementineHaveDataToRead:(NSData *)data
{
    [self.player.playerReceiverService receiveFromData:data];
    [self.playlist.playlistReceiverService receiveFromData:data];
}

- (void)clementineConnectionDidChage:(ClementineConnectionStatus)status
{
    switch (status) {
        case ClementineConnectionStatusConnected:
            break;
        case ClementineConnectionStatusConnecting:
            break;
        case ClementineConnectionStatusClosed:
            break;
        default:
            break;
    }
}

@end
