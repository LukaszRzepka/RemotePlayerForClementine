//
//  ClementineSystemReceiver.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 05.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemReceiverServiceProtocol.h"

@interface ClementineSystemReceiver : NSObject <SystemReceiverServiceProtocol>
@property (nonatomic, weak) id<RemoteSystemListener> listenerSystemReceive;
@end
