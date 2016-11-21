//
//  ConnectionInfo.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 04.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionInfo : NSObject
-(instancetype)initWithIp:(NSString*)ip and:(NSNumber*)port and:(NSNumber*)auth;
@property (nonatomic, strong)NSString *ip;
@property (nonatomic, strong)NSNumber *port;
@property (nonatomic, strong)NSNumber *auth;
@end
