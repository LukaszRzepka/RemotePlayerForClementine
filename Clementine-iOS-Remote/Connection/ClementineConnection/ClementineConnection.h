//
//  ClementineConnection.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 30.04.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClementineMessage.h"
#import "RemoteConnectionDelegate.h"
#import "ConnectionInfo.h"

@interface ClementineConnection : NSObject
+ (instancetype)sharedInstance;

+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance")));
- (instancetype)init __attribute__((unavailable("init not available, call sharedInstance")));
+ (instancetype)new __attribute__((unavailable("new not available, call sharedInstance")));

- (void)setConnectionData:(NSString*)ip andPort:(NSInteger)port;
- (void)setConnectionData:(NSString *)ip andPort:(NSInteger)port andAuth:(NSInteger)auth;
- (void)connect;
- (void)disconnect;
- (void)sendClementineMessage:(ClementineMessage*)message;
- (ConnectionInfo*)loadPreviousConnectionState;

@property (nonatomic, weak)id <RemoteConnectionDelegate> delegate;
@property (nonatomic, readonly)BOOL isConnected;
@end
