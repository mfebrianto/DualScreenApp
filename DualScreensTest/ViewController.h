//
//  ViewController.h
//  DualScreensTest
//
//  Created by michael febrianto on 19/07/2015.
//  Copyright (c) 2015 michael febrianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIButton *mainButton;

@property (nonatomic, strong) UIWindow *mirroredWindow;
@property (nonatomic, strong) UIScreen *mirroredScreen;

@end

