//
//  RWReplicatorLayerView.m
//  LayerCake
//
//  Created by Sam Davies on 23/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "RWReplicatorLayerView.h"

@interface RWReplicatorLayerView ()

@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, assign) BOOL animationState;

@end

@implementation RWReplicatorLayerView

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
        self.animationState = NO;
        [self createReplicatorLayer];
    }
    return self;
}

+ (NSString *)description
{
    return @"CAReplicatorLayer";
}

- (void)animate
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:2];
    
    if(self.animationState) {
        [self configureReplicationLayerLinearLayout:self.replicatorLayer];
    } else {
        [self configureReplicationLayerRadialLayout:self.replicatorLayer];
    }
    self.animationState = !self.animationState;
    
    self.replicatorLayer.instanceDelay = 0.1;
    
    [CATransaction commit];
}


#pragma mark - Utility methods
- (void)createReplicatorLayer
{
    self.replicatorLayer = [CAReplicatorLayer layer];
    self.replicatorLayer.bounds = self.bounds;
    self.replicatorLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self.layer addSublayer:self.replicatorLayer];
    
    CALayer *replicationSample = [self replicationSample];
    replicationSample.position = CGPointMake(100, 100);
    [self.replicatorLayer addSublayer:replicationSample];
    
    // Set up the replication
    [self configureReplicationLayerLinearLayout:self.replicatorLayer];
}

- (void)configureReplicationLayerLinearLayout:(CAReplicatorLayer *)layer
{
    self.replicatorLayer.instanceCount = 20;
    self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(5, 10, 1);
    self.replicatorLayer.instanceAlphaOffset = -0.03;
    self.replicatorLayer.instanceGreenOffset = -0.05;
    self.replicatorLayer.instanceRedOffset = -0.02;
}

- (void)configureReplicationLayerRadialLayout:(CAReplicatorLayer *)layer
{
    self.replicatorLayer.instanceCount = 20;
    CATransform3D transform = CATransform3DMakeRotation(M_PI / 10, 0, 1, 1);
    self.replicatorLayer.instanceTransform = transform;
    self.replicatorLayer.instanceAlphaOffset = -0.01;
    self.replicatorLayer.instanceRedOffset = -0.1;
    self.replicatorLayer.instanceGreenOffset = 0;
}


- (CALayer *)replicationSample
{
    CALayer *replicationSample = [CALayer layer];
    replicationSample.bounds = CGRectMake(0, 0, 100, 100);
    replicationSample.borderWidth = 3.0;
    replicationSample.borderColor = [UIColor redColor].CGColor;
    replicationSample.backgroundColor = [UIColor colorWithRed:0.7 green:0.2 blue:0.4 alpha:0.4].CGColor;
    
    return replicationSample;
}

@end
