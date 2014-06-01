//
//  RWBasicLayerView.m
//  LayerCake
//
//  Created by Sam Davies on 01/06/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "RWBasicLayerView.h"

@interface RWBasicLayerView ()

@property (nonatomic, strong) CALayer *basicLayer;
@property (nonatomic, assign) BOOL animationStatus;

@end

@implementation RWBasicLayerView

+ (instancetype)viewWithFrame:(CGRect)frame
{
    return [[[self class] alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self createLayer];
        self.animationStatus = NO;
        CATransform3D slt = CATransform3DIdentity;
        slt.m34 = -0.002;
        self.layer.sublayerTransform = slt;
    }
    return self;
}

+ (NSString *)description
{
    return @"CALayer";
}

- (void)animate
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:2];
    [self setLayerPropertiesForState:self.animationStatus];
    [CATransaction commit];
    
    self.animationStatus = !self.animationStatus;
}

#pragma mark - Utility methods
- (void)createLayer
{
    self.basicLayer = [CALayer layer];
    [self.layer addSublayer:self.basicLayer];
    [self setLayerPropertiesForState:YES];
}

- (void)setLayerPropertiesForState:(BOOL)state
{
    if(state) {
        self.basicLayer.cornerRadius = 20;
        self.basicLayer.borderWidth = 5;
        self.basicLayer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.4].CGColor;
        self.basicLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
        self.basicLayer.bounds = CGRectMake(0, 0, self.bounds.size.width / 4 * 3, self.bounds.size.height / 2.0);
        self.basicLayer.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.6].CGColor;
        self.basicLayer.transform = CATransform3DIdentity;
        self.basicLayer.shadowOpacity = 0.8;
        self.basicLayer.shadowOffset = CGSizeMake(20, 15);
        self.basicLayer.shadowColor = [UIColor grayColor].CGColor;
    } else {
        self.basicLayer.cornerRadius = 5;
        self.basicLayer.borderWidth = 1;
        self.basicLayer.borderColor = [UIColor grayColor].CGColor;
        self.basicLayer.position = CGPointMake(self.bounds.size.width / 4.0, self.bounds.size.height / 4.0);
        self.basicLayer.bounds = CGRectMake(0, 0, self.bounds.size.width / 6.0, self.bounds.size.height / 6.0);
        self.basicLayer.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3].CGColor;
        self.basicLayer.transform = CATransform3DMakeRotation(M_PI/6, 0.5, 1, 0);
        self.basicLayer.shadowOpacity = 0.6;
        self.basicLayer.shadowColor = [UIColor greenColor].CGColor;
        self.basicLayer.shadowOffset = CGSizeMake(-5, -10);
    }
}


@end
