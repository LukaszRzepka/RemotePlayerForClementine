//
//  ClementineDelegate.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 29.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RemoteSystemListener <NSObject>
- (void)connectionMessageReceived:(NSString*)version;
- (void)keepAliveMessageDidReceive;
- (void)disconnectMessageDidReceive;
@end

@protocol SystemReceiverServiceProtocol <NSObject>
- (void)receiveFromData:(NSData*)data;
@property (nonatomic, weak, readwrite) id<RemoteSystemListener> listenerSystemReceive;
@end
