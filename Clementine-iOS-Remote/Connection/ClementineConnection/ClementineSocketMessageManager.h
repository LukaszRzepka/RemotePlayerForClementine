//
//  SocketMessageManager.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 05.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClementineSocketMessageManager : NSObject
+ (NSData*)addBytesWithLenghtInfoToData:(NSData*)data;
+ (uint32_t)readDataLenghtFromStream:(NSInputStream*)iStream;
@end
