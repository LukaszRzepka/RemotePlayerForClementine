//
//  LibrarySenderServiceProtocol.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 07.08.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MessageSenderToServer)(ClementineMessage* messageToSend);

@protocol LibrarySenderServiceProtocol <NSObject>
- (instancetype)initWithBlockToSendMessage:(MessageSenderToServer)sendToServer;
- (void)getLibrary;
@end