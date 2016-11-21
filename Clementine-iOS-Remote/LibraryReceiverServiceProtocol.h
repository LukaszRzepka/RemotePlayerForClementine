//
//  LibraryReceiverServiceProtocol.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 07.08.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LibraryReceiverServiceListener <NSObject>
- (void)responseLibraryChunkReceived:(NSString*)version;
@end

@protocol LibraryReceiverServiceProtocol <NSObject>
- (void)receiveFromData:(NSData*)data;
@property (nonatomic, weak, readwrite) id<LibraryReceiverServiceListener> listenerLibraryReceive;
@end
