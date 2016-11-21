//
//  NSMutableArray+QueueAdditions.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 01.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)object;
@end
