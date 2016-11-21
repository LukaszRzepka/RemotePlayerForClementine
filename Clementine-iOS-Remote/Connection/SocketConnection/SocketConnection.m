//
//  SocketConnection.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 09.04.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "SocketConnection.h"
#import "NSMutableArray+QueueAdditions.h"

@interface SocketConnection()

@property (nonatomic, strong)NSInputStream *inputStream;
@property (nonatomic, strong)NSOutputStream *outputStream;
@property (nonatomic, copy)void (^inputStreamConnectionResult)(BOOL result);
@property (nonatomic, copy)void (^outputStreamConnectionResult)(BOOL result);
@property (nonatomic, readwrite)SocketConnectionStatus connectionStatus;

@end

@implementation SocketConnection

- (instancetype)init
{
    self = [super init];
    if (self) {}
    return self;
}

- (void)configureConnection:(NSString*)ip andPort:(NSInteger)port
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)ip, (uint32_t)port, &readStream, &writeStream);
    self.inputStream = (__bridge NSInputStream*)readStream;
    self.outputStream = (__bridge NSOutputStream*)writeStream;
}

- (void)openConnectionWithResult:(void (^)(BOOL))connectionResult
{
    __block BOOL inputConnectionSuccess = NO;
    __block BOOL outputConnectionSuccess = NO;
    
    [self openInputStreamWithResult:^(BOOL result)
    {
        inputConnectionSuccess = result;
        if (result)
        {
            if (outputConnectionSuccess)
            {
                connectionResult(YES);
            }
        }
        else
        {
            connectionResult(NO);
        }
    }];
    
    [self openOutputStreamWithResult:^(BOOL result)
    {
        outputConnectionSuccess = result;
        if (result)
        {
            if (inputConnectionSuccess)
            {
                connectionResult(YES);
            }
        }
        else
        {
            connectionResult(NO);
        }
    }];
    [[NSRunLoop currentRunLoop] run];
}

- (void)openInputStreamWithResult:(void(^)(BOOL result))connectionResult
{
    self.inputStreamConnectionResult = connectionResult;
    if (!self.inputStreamIsOpened)
    {
        [self.delegate socketConnectionDidChange:SocketConnectionStatusInputWaitingForConnection];
        self.inputStream.delegate = self;
        [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.inputStream open];
    }
    else
    {
        self.inputStreamConnectionResult(NO);
        self.inputStreamConnectionResult = nil;
    }
}

- (void)openOutputStreamWithResult:(void(^)(BOOL result))connectionResult
{
    self.outputStreamConnectionResult = connectionResult;
    if (!self.outputStreamIsOpened)
    {
        [self.delegate socketConnectionDidChange:SocketConnectionStatusOutputWaitingForConnection];
        self.outputStream.delegate = self;
        [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.outputStream open];
    }
    else
    {
        self.outputStreamConnectionResult(NO);
        self.outputStreamConnectionResult = nil;
    }
}

- (void)close
{
    [self closeInputStream];
    [self closeOutputStream];
}

- (void)closeInputStream
{
    if (self.inputStreamIsOpened)
    {
        [self.inputStream close];
        [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.inputStream.delegate = nil;
        self.inputStream = nil;
    }
}

- (void)closeOutputStream
{
    if (self.outputStreamIsOpened)
    {
        [self.outputStream close];
        [self.outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.outputStream.delegate = nil;
        self.outputStream = nil;
    }
}

- (BOOL)inputStreamIsOpened
{
    switch (self.inputStream.streamStatus) {
        case NSStreamStatusOpen:
        case NSStreamStatusReading:
        case NSStreamStatusWriting:
            return YES;
            break;
        default:
            return NO;
            break;
    }
}

- (BOOL)outputStreamIsOpened
{
    switch (self.outputStream.streamStatus) {
        case NSStreamStatusOpen:
        case NSStreamStatusReading:
        case NSStreamStatusWriting:
            return YES;
            break;
        default:
            return NO;
            break;
    }
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventNone:
            NSLog(@"NSStreamEventNone");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"NSStreamEventEndEncountered");
            if (aStream == self.inputStream)
            {
                [self.delegate socketConnectionDidChange:SocketConnectionStatusInputClosed];
            }
            if (aStream == self.outputStream)
            {
                [self.delegate socketConnectionDidChange:SocketConnectionStatusOutputClosed];
            }
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"NSStreamEventErrorOccurred");
            if (aStream == self.inputStream)
            {
                if (self.inputStreamConnectionResult)
                {
                    self.inputStreamConnectionResult(NO);
                    self.inputStreamConnectionResult = nil;
                }
                [self.delegate socketConnectionDidChange:SocketConnectionStatusInputClosed];
            }
            if (aStream == self.outputStream)
            {
                if (self.outputStreamConnectionResult)
                {
                    self.outputStreamConnectionResult(NO);
                    self.outputStreamConnectionResult = nil;
                }
                [self.delegate socketConnectionDidChange:SocketConnectionStatusOutputClosed];
            }
            break;
        case NSStreamEventHasBytesAvailable:
        {
            NSLog(@"NSStreamEventHasBytesAvailable");
            if (aStream == self.inputStream)
            {
                [self hasBytesAvailable:self.inputStream];
            }
            break;
            
        }
        case NSStreamEventOpenCompleted:
            NSLog(@"NSStreamEventOpenCompleted");
            if (self.inputStreamConnectionResult && aStream == self.inputStream)
            {
                if(self.inputStreamConnectionResult)
                {
                    self.inputStreamConnectionResult(YES);
                    self.inputStreamConnectionResult = nil;
                }
                [self.delegate socketConnectionDidChange:SocketConnectionStatusInputOpened];
            }
            if(self.outputStreamConnectionResult && aStream == self.outputStream)
            {
                if(self.outputStreamConnectionResult)
                {
                    self.outputStreamConnectionResult(YES);
                    self.outputStreamConnectionResult = nil;
                }
                [self.delegate socketConnectionDidChange:SocketConnectionStatusOutputOpened];
            }
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"NSStreamEventHasSpaceAvailable");
            if (aStream == self.outputStream)
            {
                [self hasSpaceAvailable:self.outputStream];
            }
            break;
        default:
            break;
    }
}

- (BOOL)sendData:(NSData*)data
{
    if(![self.outputStream hasSpaceAvailable])
    {
        NSLog(@"No available space to send data");
        return NO;
    }
    
    long dataLen = [data length];
    uint8_t *readBytes = (uint8_t *)[data bytes];
    long byteIndex = 0;
    long len = ((dataLen - byteIndex >= 1024) ? 1024 : (dataLen - byteIndex));;
    while (len > 0)
    {
        uint8_t buf[len];
        (void)memcpy(buf, readBytes, len);
        len = [self.outputStream write:(const uint8_t *)buf maxLength:len];
        byteIndex += len;
        readBytes += len;
        len = ((dataLen - byteIndex >= 1024) ? 1024 : (dataLen - byteIndex));
    }
    return YES;
}

- (NSData*)readDataFromInputSocketWithLenght:(uint32_t)lenght
{
    NSMutableData *data = [NSMutableData new];
    NSLog(@"Bytes to read from socket: %ldi", (long)lenght);
    while (lenght != 0)
    {
        NSInteger bufferSize = 1024;
        if (lenght < 1024)
        {
            bufferSize = lenght;
        }
//        NSLog(@"Readed bytes from socket: %ldi", (long)bufferSize);
        uint8_t buffer[bufferSize];
        NSInteger len = [self.inputStream read:buffer maxLength:sizeof(buffer)];
        [data appendBytes:buffer length:len];
        lenght -= len;
    }
    return [data copy];
}

- (void)hasSpaceAvailable:(NSOutputStream*)oStream
{
    [self.delegate socketConnectionHasSpaceAvailable:oStream];
}

- (void)hasBytesAvailable:(NSInputStream *)iStream
{
    [self.delegate socketConnectionHasBytesAvailable:iStream];
}

@end
