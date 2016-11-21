//
//  NSMutableArray+QueueAdditions.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 01.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "NSMutableArray+QueueAdditions.h"

@implementation NSMutableArray (QueueAdditions)
- (id)dequeue
{
    id headObject = nil;
    if ([self count] != 0) {
        headObject = [self objectAtIndex:0];
        if (headObject != nil)
        {
            [self removeObjectAtIndex:0];
        }
    }
    return headObject;
}

- (void)enqueue:(id)object
{
    [self addObject:object];
}
@end
