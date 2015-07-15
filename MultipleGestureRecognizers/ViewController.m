//
//  ViewController.m
//  MultipleGestureRecognizers
//
//  Created by Catalin (iMac) on 13/07/2015.
//  Copyright (c) 2015 corsarus. All rights reserved.
//

#import "ViewController.h"
#import "MobileView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Add a mobile view at the center of the screen
    MobileView *mobileView = [[MobileView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 200.0f)];
    [self.view addSubview:mobileView];
    mobileView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    
}

@end
