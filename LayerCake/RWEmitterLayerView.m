//
//  RWEmitterLayerView.m
//  LayerCake
//
//  Created by Sam Davies on 23/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "RWEmitterLayerView.h"

@interface RWEmitterLayerView ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, strong) CAEmitterCell *emitterCell;

@end


@implementation RWEmitterLayerView

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
        [self createEmitterLayer];
    }
    return self;
}

+ (NSString *)description
{
    return @"CAEmitterLayer";
}

- (void)animate
{
    
}

#pragma mark - Utility methods
- (void)createEmitterLayer
{
    self.emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
    self.emitterLayer.bounds = self.bounds;
    self.emitterLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self.layer addSublayer:self.emitterLayer];
    [self createEmitterCell];
    self.emitterLayer.emitterCells = @[self.emitterCell];
    self.emitterLayer.emitterShape = kCAEmitterLayerLine;
    self.emitterLayer.emitterZPosition = 10;
    self.emitterLayer.emitterSize = CGSizeMake(self.bounds.size.width, 50);
    self.emitterLayer.emitterPosition = CGPointMake(self.bounds.size.width / 2.0, 0);
    
}

- (void)createEmitterCell
{
    self.emitterCell = [CAEmitterCell emitterCell];
    self.emitterCell.scale = 0.4;
    self.emitterCell.scaleRange = 0.6;
    self.emitterCell.emissionRange = M_PI_2;
    self.emitterCell.lifetime = 5.0;
    self.emitterCell.birthRate = 30;
    self.emitterCell.velocity = 100;
    self.emitterCell.velocityRange = 50;
    self.emitterCell.yAcceleration = 250;
    self.emitterCell.contents = (id)[UIImage imageNamed:@"ParticleEmitter"].CGImage;
}

@end
