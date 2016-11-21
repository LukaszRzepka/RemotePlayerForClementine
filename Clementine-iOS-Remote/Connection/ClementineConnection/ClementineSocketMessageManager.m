//
//  SocketMessageManager.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 05.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ClementineSocketMessageManager.h"

@implementation ClementineSocketMessageManager
+ (NSData*)addBytesWithLenghtInfoToData:(NSData *)data
{
    uint32_t len = CFSwapInt32HostToBig((uint32_t)[data length]);
    NSMutableData *mutableData = [NSMutableData new];
    NSData *dataLen = [NSData dataWithBytes:&len length:sizeof(len)];
    
    [mutableData appendBytes:[dataLen bytes] length:[dataLen length]];
    [mutableData appendData:data];
    
    return mutableData;
}

+ (uint32_t)readDataLenghtFromStream:(NSInputStream*)iStream
{
    uint8_t bytes[4];
    [iStream read:bytes maxLength:sizeof(bytes)];
    NSMutableData *dataLenght = [NSMutableData new];
    [dataLenght appendBytes:bytes length:sizeof(bytes)];
    
    uint32_t lenght;
    [dataLenght getBytes:&lenght length:sizeof(lenght)];
    lenght = CFSwapInt32BigToHost(lenght);
    
    return lenght;
}
@end
