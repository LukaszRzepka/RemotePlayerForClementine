//
//  ClementineConnection.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 30.04.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ClementineConnection.h"
#import "SocketQueueConnection.h"
#import "ClementineSocketMessageManager.h"
#import "ClementineSystemReceiver.h"
#import "ClementineMessageFactory.h"

NSString *const SERVER_IP_KEY = @"server_ip_key";
NSString *const PORT_KEY = @"port_key";
NSString *const AUTH_KEY = @"auth_key";
NSString *const CONNECTION_INFO_KEY = @"connection_info_key";

@interface ClementineConnection() <SocketConnectionDelegate, RemoteSystemListener>
@property (nonatomic, strong)ConnectionInfo *connectionInfo;
@property (nonatomic, strong)SocketQueueConnection *socketQueueConnection;
@property (nonatomic, readwrite)BOOL isConnected;
@property (nonatomic)NSUInteger connectionAttempts;
@property (nonatomic, strong)ClementineSystemReceiver *systemReceiver;
@end

@implementation ClementineConnection

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super alloc] initInstance];
    });
    return sharedInstance;
}

- (instancetype)initInstance
{
    self = [super init];
    if (self)
    {
        self.socketQueueConnection = [SocketQueueConnection new];
        self.socketQueueConnection.delegate = self;
        self.connectionAttempts = 10;
        self.systemReceiver = [[ClementineSystemReceiver alloc] init];
        self.systemReceiver.listenerSystemReceive = self;
        self.isConnected = NO;
    }
    return self;
}

- (void)setConnectionData:(NSString*)ip andPort:(NSInteger)port
{
    self.connectionInfo = [[ConnectionInfo alloc] init];
    self.connectionInfo.ip = ip;
    self.connectionInfo.port = [NSNumber numberWithInteger:port];
    [self.socketQueueConnection configureConnection:self.connectionInfo.ip andPort:[self.connectionInfo.port integerValue]];
    [self saveCurrentConnectionInfo];
}

- (void)setConnectionData:(NSString *)ip andPort:(NSInteger)port andAuth:(NSInteger)auth
{
    self.connectionInfo = [[ConnectionInfo alloc] init];
    self.connectionInfo.ip = ip;
    self.connectionInfo.port = [NSNumber numberWithInteger:port];
    self.connectionInfo.auth = [NSNumber numberWithInteger:auth];
    [self.socketQueueConnection configureConnection:self.connectionInfo.ip andPort:[self.connectionInfo.port integerValue]];
    [self saveCurrentConnectionInfo];
}

- (void)saveCurrentConnectionInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:self.connectionInfo.ip forKey:SERVER_IP_KEY];
    [dict setObject:self.connectionInfo.port forKey:PORT_KEY];
    [dict setObject:self.connectionInfo.auth forKey:AUTH_KEY];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:CONNECTION_INFO_KEY];
}

- (ConnectionInfo*)loadPreviousConnectionState
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:CONNECTION_INFO_KEY];
    self.connectionInfo = [[ConnectionInfo alloc] init];
    self.connectionInfo.ip = [dict objectForKey:SERVER_IP_KEY];
    self.connectionInfo.port = [dict objectForKey:PORT_KEY];
    self.connectionInfo.auth = [dict objectForKey:AUTH_KEY];
    return self.connectionInfo;
}

- (void)connect
{
    [self disconnect];
    [self.socketQueueConnection openConnectionWithResult:^(BOOL result)
    {
        if (result)
        {
            [self sendClementineConnectionMessage];
        }
        else
        {
            NSLog(@"Unsuccessful try to open streams");
            //TODO: We need notification with that
        }
    }];
}

- (void)disconnect
{
    [self.socketQueueConnection close];
}

- (void)sendClementineConnectionMessage
{
    ClementineMessage *clMessage;
    if (self.connectionInfo.auth)
    {
        clMessage = [ClementineMessageFactory buildConnectMessage:self.connectionInfo.ip port:[self.connectionInfo.port integerValue] authCode:self.connectionInfo.auth getPlaylist:YES isDownloader:NO];
    }
    else
    {
        clMessage = [ClementineMessageFactory buildConnectMessage:self.connectionInfo.ip port:[self.connectionInfo.port integerValue] authCode:nil getPlaylist:YES isDownloader:NO];
    }
    [self sendClementineMessage:clMessage];
}

- (void)sendClementineMessage:(ClementineMessage*)message
{
    NSData *data = [[NSData alloc] initWithData:[message.message data]];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [message.message storeInDictionary:dict];
    NSLog(@"Message send to clementine server: %@", [dict description]);
    NSData *packet = [ClementineSocketMessageManager addBytesWithLenghtInfoToData:data];
    [self.socketQueueConnection insertDataAndSend:packet];
}

- (void)socketConnectionHasBytesAvailable:(NSInputStream *)iStream
{
    uint32_t dataLenghtToRead = [ClementineSocketMessageManager readDataLenghtFromStream:iStream];
    if (dataLenghtToRead > 15000000)
    {
        NSLog(@"Something with packet is wrong, message lenght to big");
    }
    else
    {
        NSData *data = [self.socketQueueConnection readDataFromInputSocketWithLenght:dataLenghtToRead];
        [self.delegate clementineHaveDataToRead:data];
        [self.systemReceiver receiveFromData:data];
        NSMutableDictionary *dict = [NSMutableDictionary new];
        Message *message = [Message parseFromData:data];
        [message storeInDictionary:dict];
        NSLog(@"Message received from clementine server: %@", dict);
    }
}

- (void)socketConnectionDidChange:(SocketConnectionStatus)connectionStatus
{
    switch (connectionStatus) {
        case SocketConnectionStatusInputClosed:
            [self.delegate clementineConnectionDidChage:ClementineConnectionStatusClosed];
            NSLog(@"closed");
            self.isConnected = NO;
            break;
        case SocketConnectionStatusInputOpened:
            if (self.socketQueueConnection.outputStreamIsOpened)
            {
                NSLog(@"Input stream connected");
            }
            break;
        case SocketConnectionStatusOutputClosed:
            [self.delegate clementineConnectionDidChage:ClementineConnectionStatusClosed];
            NSLog(@"closed");
            self.isConnected = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:ClementineConnectionStatusChangeNotification object:nil userInfo:nil];
            break;
        case SocketConnectionStatusOutputOpened:
            if (self.socketQueueConnection.inputStreamIsOpened)
            {
                NSLog(@"Output stream connected");
            }
            break;
        case SocketConnectionStatusInputWaitingForConnection:
            [self.delegate clementineConnectionDidChage:ClementineConnectionStatusConnecting];
            NSLog(@"connecting");
            break;
        case SocketConnectionStatusOutputWaitingForConnection:
            [self.delegate clementineConnectionDidChage:ClementineConnectionStatusConnecting];
            NSLog(@"connecting");
            break;
        default:
            break;
    }
}

- (void)disconnectMessageDidReceive
{
    if (self.isConnected)
    {
        [self.delegate clementineConnectionDidChage:ClementineConnectionStatusClosed];
        self.isConnected = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:ClementineConnectionStatusChangeNotification object:nil userInfo:nil];
    }
}

- (void)keepAliveMessageDidReceive
{
    
}

- (void)connectionMessageReceived:(NSString *)version
{
        //TODO: trzeba to zamienic na ladniejszy sposob
    if (!self.isConnected) {
        [self.delegate clementineConnectionDidChage:ClementineConnectionStatusConnected];
        NSLog(@"connected");
        self.isConnected = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:ClementineConnectionStatusChangeNotification object:nil userInfo:nil];
    }
}
@end
