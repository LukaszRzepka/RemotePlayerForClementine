//
//  SocketConnection.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 09.04.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketConnectionProtocol.h"

typedef NS_ENUM(NSUInteger, SocketConnectionStatus)
{
    SocketConnectionStatusInputOpened,
    SocketConnectionStatusInputClosed,
    SocketConnectionStatusInputWaitingForConnection,
    
    SocketConnectionStatusOutputOpened,
    SocketConnectionStatusOutputClosed,
    SocketConnectionStatusOutputWaitingForConnection,
};

@class SocketConnection;
@protocol SocketConnectionDelegate <NSObject>
- (void)socketConnectionDidChange:(SocketConnectionStatus)connectionStatus;
@optional
- (void)socketConnectionHasBytesAvailable:(NSInputStream*)iStream;
@optional
- (void)socketConnectionHasSpaceAvailable:(NSOutputStream*)oStream;
@end

@interface SocketConnection : NSObject <NSStreamDelegate, SocketConnectionProtocol>
- (void)configureConnection:(NSString*)ip andPort:(NSInteger)port;
- (void)close;
- (void)openConnectionWithResult:(void(^)(BOOL result))connectionResult;
- (BOOL)sendData:(NSData*)data;
- (NSData*)readDataFromInputSocketWithLenght:(uint32_t)lenght;

@property (nonatomic, weak) id <SocketConnectionDelegate> delegate;
@property (readonly)BOOL inputStreamIsOpened;
@property (readonly)BOOL outputStreamIsOpened;
@end
