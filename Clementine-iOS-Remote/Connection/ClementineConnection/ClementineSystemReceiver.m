//
//  ClementineSystemReceiver.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 05.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ClementineSystemReceiver.h"
#import "ClementineRemoteProtocolBuffer.pb.h"

@implementation ClementineSystemReceiver

- (void)receiveFromData:(NSData *)data
{
    Message *message = [Message parseFromData:data];
    
    switch (message.type) {
        case MsgTypeDisconnect:
        {
            [self disconnect:message];
            break;
        }
        case MsgTypeInfo:
        {
            [self info:message];
            break;
        }
        case MsgTypeKeepAlive:
        {
            [self keepAlive:message];
            break;
        }
        default:
            break;
    }
}

- (void)disconnect:(Message*)message
{
    [self.listenerSystemReceive disconnectMessageDidReceive];
}

- (void)info:(Message*)message
{
    NSString *newVersion = message.responseClementineInfo.version;
    
    [self.listenerSystemReceive connectionMessageReceived:newVersion];
}

- (void)keepAlive:(Message*)message
{
    [self.listenerSystemReceive keepAliveMessageDidReceive];
}

@end
