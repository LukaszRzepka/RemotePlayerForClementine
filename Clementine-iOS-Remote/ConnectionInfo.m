//
//  ConnectionInfo.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 04.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ConnectionInfo.h"

@implementation ConnectionInfo
- (instancetype)initWithIp:(NSString*)ip and:(NSNumber*)port and:(NSNumber*)auth
{
    self = [super init];
    if (self) {
        self.ip = ip;
        self.port = port;
        self.auth = auth;
    }
    return self;
}
@end
