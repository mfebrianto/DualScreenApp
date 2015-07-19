//
//  ViewController.m
//  DualScreensTest
//
//  Created by michael febrianto on 19/07/2015.
//  Copyright (c) 2015 michael febrianto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkForExistingScreenAndInitializeIfPresent
{
    NSArray *connectedScreens = [UIScreen screens];
    if ([connectedScreens count] > 1) {
        UIScreen *mainScreen = [UIScreen mainScreen];
        for (UIScreen *aScreen in connectedScreens) {
            if (aScreen != mainScreen) {
                _mainLabel.text = @"We've found an external screen !";
                [self setupMirroringForScreen:aScreen];
                self.mirroredWindow.hidden = NO;
                break;
            }
        }
    }else{
        _mainLabel.text = @"no external screen !";
    }
}


- (void)setupMirroringForScreen:(UIScreen *)anExternalScreen
{
    self.mirroredScreen = anExternalScreen;
    
    // Find max resolution
    CGSize max = {0, 0};
    UIScreenMode *maxScreenMode = nil;
    
    for (UIScreenMode *current in self.mirroredScreen.availableModes) {
        if (maxScreenMode == nil || current.size.height > max.height || current.size.width > max.width) {
            max = current.size;
            maxScreenMode = current;
        }
    }
    
    self.mirroredScreen.currentMode = maxScreenMode;
}

- (void)handleScreenDidConnectNotification:(NSNotification*)aNotification
{
    UIScreen *newScreen = [aNotification object];
    CGRect screenBounds = newScreen.bounds;
    
    if (!self.mirroredWindow)
    {
        self.mirroredWindow = [[UIWindow alloc] initWithFrame:screenBounds];
        self.mirroredWindow.screen = newScreen;
        
        // Set the initial UI for the window.
    }
}

- (void)handleScreenDidDisconnectNotification:(NSNotification*)aNotification
{
    if (self.mirroredWindow)
    {
        // Hide and then delete the window.
        self.mirroredWindow.hidden = YES;
        self.mirroredWindow = nil;
        
    }
    
}

- (void)setUpScreenConnectionNotificationHandlers
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(handleScreenDidConnectNotification:)
                   name:UIScreenDidConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:)
                   name:UIScreenDidDisconnectNotification object:nil];
}



- (IBAction)buttonPressed:(UIButton *)mainButton {
    [self checkForExistingScreenAndInitializeIfPresent];
}

@end
