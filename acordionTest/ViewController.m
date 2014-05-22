//
//  ViewController.m
//  acordionTest
//
//  Created by Ryan Quan on 5/21/14.
//  Copyright (c) 2014 rqueue. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic) CALayer *top;
@property (nonatomic) CALayer *bottom;
@property (nonatomic) BOOL open;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    CGSize viewSize = self.containerView.bounds.size;
    self.top = [CALayer layer];
    self.bottom = [CALayer layer];
    self.top.anchorPoint = CGPointMake(0.5, 0.5);
    self.bottom.anchorPoint = CGPointMake(0.5, 0.5);
    self.top.position = CGPointMake(viewSize.width/2.0, viewSize.height/2.0);
    self.bottom.position = CGPointMake(viewSize.width/2.0, viewSize.height/2.0);
    self.top.bounds = CGRectMake(0, 0, viewSize.width, viewSize.height);
    self.bottom.bounds = CGRectMake(0, 0, viewSize.width, viewSize.height);
    self.top.backgroundColor = [UIColor whiteColor].CGColor;
    self.bottom.backgroundColor = [UIColor whiteColor].CGColor;

    self.top.transform = makePerspectiveTransform();
    self.bottom.transform = makePerspectiveTransform();

    [self.containerView.layer addSublayer:self.top];
    [self.containerView.layer addSublayer:self.bottom];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.containerView addGestureRecognizer:tap];

    self.open = NO;
}


- (void)handleTap {
    if (!self.open) {
        UIImage *image = [UIImage imageNamed:@"imageTest.jpg"];

        CGImageRef imgRef = image.CGImage;
        self.top.contents = (__bridge id)imgRef;
        self.bottom.contents = (__bridge id)imgRef;
        self.top.contentsRect = CGRectMake(0.0, 0.0, 1.0, 0.5);
        self.bottom.contentsRect = CGRectMake(0.0, 0.5, 1.0, 0.5);

        self.top.transform = CATransform3DScale(self.top.transform, 0.95, 0.95, 0.95);
        self.bottom.transform = CATransform3DScale(self.bottom.transform, 0.95, 0.95, 0.95);

        self.top.transform = CATransform3DRotate(self.top.transform, M_PI_2, 1.0, 0.0, 0.0);
        self.bottom.transform = CATransform3DRotate(self.bottom.transform, -M_PI_2, 1.0, 0.0, 0.0);

        self.top.transform = CATransform3DTranslate(self.top.transform, 0.0, 0.0, 0.0);
        self.bottom.transform = CATransform3DTranslate(self.bottom.transform, 0.0, 0.0, 0.0);
    } else {
        self.top.transform = CATransform3DIdentity;
        self.bottom.transform = CATransform3DIdentity;
        self.top.transform = makePerspectiveTransform();
        self.bottom.transform = makePerspectiveTransform();
    }
    self.open = !self.open;
}

CATransform3D makePerspectiveTransform()
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -2000;
    return transform;
}

@end
