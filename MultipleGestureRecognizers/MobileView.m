//
//  MobileView.m
//  MultipleGestureRecognizers
//
//  Created by Catalin (iMac) on 13/07/2015.
//  Copyright (c) 2015 corsarus. All rights reserved.
//

#import "MobileView.h"

@interface MobileView () <UIGestureRecognizerDelegate>

@property (nonatomic) BOOL isCaptured;
@property (nonatomic) BOOL isViewPanned;

@property (nonatomic) CGFloat xTranslation;
@property (nonatomic) CGFloat yTranslation;
@property (nonatomic) CGFloat rotationAngle;

@end

@implementation MobileView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blueColor];
        
        // Add the long press gesture recognizer
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(captureView:)];
        longPressGestureRecognizer.numberOfTouchesRequired = 2;
        longPressGestureRecognizer.delegate = self;
        [self addGestureRecognizer:longPressGestureRecognizer];
        
        // Add the pan gesture recognizer
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)];
        panGestureRecognizer.delegate = self;
        [self addGestureRecognizer:panGestureRecognizer];
        
        // Add the rotation gesture recognizer
        UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
        rotationGestureRecognizer.delegate = self;
        [self addGestureRecognizer:rotationGestureRecognizer];
        
    }
    
    return self;
}

#pragma mark - Gesture handlers

- (void)captureView:(UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    if (longPressGestureRecognizer.state == UIGestureRecognizerStateEnded || longPressGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        
        self.isCaptured = NO;
        self.backgroundColor = [UIColor blueColor];
        
    } else {
    
        self.isCaptured = YES;
        self.backgroundColor = [UIColor redColor];
        
    }
}

- (void)dragView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan)
        self.isViewPanned = YES;
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded || panGestureRecognizer.state == UIGestureRecognizerStateCancelled)
        self.isViewPanned = NO;
    
    if (self.isCaptured && panGestureRecognizer.numberOfTouches == 2) {
        CGPoint translationPoint = [panGestureRecognizer translationInView:self.superview];
        self.transform = CGAffineTransformMakeTranslation(self.xTranslation + translationPoint.x, self.yTranslation + translationPoint.y);
        self.transform = CGAffineTransformRotate(self.transform, self.rotationAngle);
    }
    
}

- (void)rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    if (self.isCaptured && rotationGestureRecognizer.numberOfTouches == 2) {
        if (!self.isViewPanned)
            self.transform = CGAffineTransformRotate(self.transform, rotationGestureRecognizer.rotation);
        
        self.rotationAngle = rotationGestureRecognizer.rotation;
    }
}


# pragma mark - Touches handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.xTranslation = self.transform.tx;
    self.yTranslation = self.transform.ty;
}

#pragma mark - UIGestureRecognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end
