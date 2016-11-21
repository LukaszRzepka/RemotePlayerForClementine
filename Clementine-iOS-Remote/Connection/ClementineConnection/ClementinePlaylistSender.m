//
//  ClementinePlaylistSender.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 08.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ClementinePlaylistSender.h"
#import "ClementineMessageFactory.h"

@interface ClementinePlaylistSender()
@property (nonatomic, copy)MessageSenderToServer sendToServer;
@end

@implementation ClementinePlaylistSender

- (instancetype)initWithBlockToSendMessage:(MessageSenderToServer)sendToServer
{
    self = [super init];
    if (self) {
        self.sendToServer = sendToServer;
    }
    return self;
}

- (void)setCurrentSong:(NSInteger)songIndex playlistId:(NSInteger)playlistId
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildRequestChangeSong:songIndex playlistId:playlistId];
    self.sendToServer(cMessage);
}

- (void)addSongs:(NSArray<RemoteSong *> *)songs toPlaylist:(NSInteger)playlistId
{
    //TODO
    ClementineMessage *cMessage = [ClementineMessageFactory buildInsertSongs:playlistId songs:songs];
    self.sendToServer(cMessage);
}

- (void)getPlaylistSongs:(NSInteger)playlistId
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildRequestPlaylistSongs:playlistId];
    self.sendToServer(cMessage);
}

- (void)removeSongs:(NSArray<RemoteSong *> *)songs fromPlaylist:(NSInteger)playlistId
{
    //TODO
    ClementineMessage *cMessage = [ClementineMessageFactory buildRemoveMultipleSongsFromPlaylist:playlistId songs:songs];
    self.sendToServer(cMessage);
}

- (void)closePlaylist:(NSInteger)playlistId
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildClosePlaylist:playlistId];
    self.sendToServer(cMessage);
}

@end
