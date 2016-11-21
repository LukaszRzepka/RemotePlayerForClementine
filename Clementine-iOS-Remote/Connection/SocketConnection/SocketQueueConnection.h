//
//  SocketQueueConnection.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 01.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "SocketConnection.h"
@interface SocketQueueConnection : SocketConnection
- (void)insertDataAndSend:(NSData*)data;
- (void)executeQueue;
- (void)sendData:(NSData *)data withResult:(void (^)(BOOL))result __attribute__((unavailable("sendData not available, call insertDataAndSend")));
@end
