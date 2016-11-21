//
//  SocketConnectionProtocol.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 01.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

@protocol SocketConnectionProtocol
- (void)hasSpaceAvailable:(NSOutputStream*)oStream;
- (void)hasBytesAvailable:(NSInputStream*)iStream;
@end
