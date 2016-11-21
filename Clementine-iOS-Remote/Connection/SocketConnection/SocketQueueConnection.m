//
//  SocketQueueConnection.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 01.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "SocketQueueConnection.h"
#import "NSMutableArray+QueueAdditions.h"

typedef void(^QueueTask)();

@interface SocketQueueConnection()
@property (nonatomic, strong)NSMutableArray *queue;
@end

@implementation SocketQueueConnection
@dynamic delegate;
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.queue = [NSMutableArray new];
    }
    return self;
}

- (void)insertDataAndSend:(NSData*)data;
{
    [self addTaskToQueue:data];
    [self executeQueue];
}

- (void)addTaskToQueue:(NSData*)data;
{
    QueueTask task = ^()
    {
        if (![super sendData:data])
        {
            [self addTaskToQueue:data];
        }
    };
    [self.queue enqueue:task];
}

- (void)executeQueue
{
    QueueTask task = [self.queue dequeue];
    if (task != nil)
    {
        task();
    }
}

- (void)hasSpaceAvailable:(NSOutputStream*)oStream
{
    [self executeQueue];
}

- (void)hasBytesAvailable:(NSInputStream *)iStream
{
    [super hasBytesAvailable: iStream];
}


@end
