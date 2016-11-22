//
//  ViewController.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 09.04.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "VCRoot.h"
#import "ClementineConnection.h"
#import "Constants.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#include <arpa/inet.h>



@interface VCRoot () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiConnecting;
@property (weak, nonatomic) IBOutlet UITextField *tfIP;
@property (weak, nonatomic) IBOutlet UITextField *tfPort;
@property (weak, nonatomic) IBOutlet UITextField *tfAuth;
@property (nonatomic, copy)void(^connectionBlock)();

@end

@implementation VCRoot

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionStatusDidChange:) name:ClementineConnectionStatusChangeNotification object:nil];
    [self.tfIP setDelegate:self];
    [self.tfPort setDelegate:self];
    [self.tfAuth setDelegate:self];
    
    ConnectionInfo *connectionInfo = [[ClementineConnection sharedInstance] loadPreviousConnectionState];
    if (connectionInfo)
    {
        if (connectionInfo.ip)
        {
            self.tfIP.text = connectionInfo.ip;
        }
        
        if (connectionInfo.port)
        {
            self.tfPort.text = [connectionInfo.port stringValue];
        }
        
        if (connectionInfo.auth)
        {
            self.tfAuth.text = [connectionInfo.auth stringValue];
        }
        [self connectWithServer];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonConnectTouchUpInside:(id)sender
{
    [self connectWithServer];
}

- (void)connectWithServer {
    if (![self checkIfConnectionDataIsCorrect:self.tfIP.text andPort:self.tfPort.text andAuth:self.tfAuth.text]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Incorrect login data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    [self.aiConnecting startAnimating];
    if ([self.tfAuth.text isEqualToString: @""])
    {
        [[ClementineConnection sharedInstance] setConnectionData:self.tfIP.text andPort:[self.tfPort.text integerValue]];
    }
    else
    {
        [[ClementineConnection sharedInstance] setConnectionData:self.tfIP.text andPort:[self.tfPort.text integerValue] andAuth:[self.tfAuth.text integerValue]];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[ClementineConnection sharedInstance] connect];
    });
    
    __weak typeof(self) weakSelf = self;
    self.connectionBlock = ^(void){
        typeof(self) strongSelf = weakSelf;
        [strongSelf checkIfIsConnected];
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), self.connectionBlock);
}

- (void)checkIfIsConnected
{
    if (![[ClementineConnection sharedInstance] isConnected]) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can't connect, please check login data and network status" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [strongSelf.aiConnecting stopAnimating];
        });
        [[ClementineConnection sharedInstance] disconnect];
    }
}

- (void)showConnectedViewController
{
//    SWRevealViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"RevealViewController"];
//    [self presentViewController:rvc animated:YES completion:nil];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController *viewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)connectionStatusDidChange:(NSNotification*)note
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.connectionBlock = nil;
        BOOL isConnected = [[ClementineConnection sharedInstance] isConnected];
        if (isConnected)
        {
            [self.aiConnecting stopAnimating];
            [self showConnectedViewController];
        }
        else
        {
            [self.aiConnecting stopAnimating];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

- (BOOL)checkIfConnectionDataIsCorrect:(NSString*)ip andPort:(NSString*)port andAuth:(NSString*)auth
{
    return [self isValidIPAddress:ip] && [self isValidAuth:auth] && [self isValidPort:port];
}

- (BOOL)isValidIPAddress:(NSString*)ip
{
    const char *utf8 = [ip UTF8String];
    int success;
    
    struct in_addr dst;
    success = inet_pton(AF_INET, utf8, &dst);
    
    return success == 1;
}

- (BOOL)isValidPort:(NSString*)port
{
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [port rangeOfCharacterFromSet:notDigits].location == NSNotFound;
}

- (BOOL)isValidAuth:(NSString*)auth
{
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [auth rangeOfCharacterFromSet:notDigits].location == NSNotFound;
}

@end
