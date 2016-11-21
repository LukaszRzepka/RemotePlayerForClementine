//
//  ClementineMessage.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 09.04.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ClementineMessage.h"

@interface ClementineMessage()

@property (nonatomic, strong)Message *message;
@property (nonatomic)ErrorMessage errorMessage;

@end

@implementation ClementineMessage

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.errorMessage = ErrorMessageNone;
    }
    return self;
}

- (instancetype)initWithMessage:(Message*)message
{
    self = [super init];
    if (self)
    {
        self.errorMessage = ErrorMessageNone;
        self.message = message;
    }
    return self;
}

- (instancetype)initWithMessageBuilder:(MessageBuilder*)builder
{
    self = [super init];
    if (self)
    {
        self.errorMessage = ErrorMessageNone;
        self.message = [builder build];
    }
    return self;
}

- (instancetype)initMessageWithError:(ErrorMessage)errorMessage
{
    self = [super init];
    if (self)
    {
        self.errorMessage = errorMessage;
    }
    return self;
}

+ (MessageBuilder*)messageBuilder:(MsgType)msgType
{
    MessageBuilder *builder = [Message builder];
    builder.version = builder.defaultInstance.version;
    builder.type = msgType;
    
    return builder;
}

@end
