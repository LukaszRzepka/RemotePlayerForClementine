//
//  ClementineMessage.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 09.04.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClementineRemoteProtocolBuffer.pb.h"

typedef NS_ENUM(NSUInteger, ErrorMessage)
{
    ErrorMessageNone,
    ErrorMessageInvalidData,
    ErrorMessageOldProto,
    ErrorMessageKeepAliveTimeout,
    ErrorMessageNoConnection,
    ErrorMessageTimeout
};

@interface ClementineMessage : NSObject
@property (nonatomic, strong, readonly)Message *message;
@property (nonatomic, readonly)ErrorMessage errorMessage;
@property (nonatomic, strong)NSString *ip;
@property (nonatomic)NSInteger port;

- (instancetype)initWithMessage:(Message*)message;
- (instancetype)initWithMessageBuilder:(MessageBuilder*)builder;
- (instancetype)initMessageWithError:(ErrorMessage)errorMessage;

+ (MessageBuilder*)messageBuilder:(MsgType)msgType;

@end
