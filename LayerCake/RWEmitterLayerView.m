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
@property (nonatomic, assign) NSUInteger animationStatus;
@property (nonatomic, strong) NSArray *animationStates;

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
        [self prepareAnimationStates];
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
    self.animationStatus = (self.animationStatus + 1) % [self.animationStates count];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:2];
    
    NSDictionary *valueUpdates = self.animationStates[self.animationStatus];
    [valueUpdates enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *object, BOOL *stop) {
        [self.emitterLayer setValue:object forKeyPath:key];
    }];
    
    [CATransaction commit];
}

#pragma mark - Utility methods
- (void)createEmitterLayer
{
    self.emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
    self.emitterLayer.bounds = self.bounds;
    self.emitterLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    self.emitterLayer.emitterPosition = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height);
    self.emitterLayer.renderMode = kCAEmitterLayerAdditive;
    [self.layer addSublayer:self.emitterLayer];
    
    UIImage *contentImage = [UIImage imageNamed:@"ParticleEmitter"];
    
    // Loads of example code from Apple
    
    //Invisible particle representing the rocket before the explosion
    CAEmitterCell *rocket = [CAEmitterCell emitterCell];
    rocket.emissionLongitude = M_PI / 2;
    rocket.emissionLatitude = 0;
    rocket.lifetime = 1.6;
    rocket.birthRate = 0.5;
    rocket.velocity = -400;
    rocket.velocityRange = 100;
    rocket.yAcceleration = 250;
    rocket.emissionRange = M_PI / 4;
    rocket.color = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5].CGColor;
    rocket.redRange = 0.5;
    rocket.greenRange = 0.5;
    rocket.blueRange = 0.5;
    
    //Name the cell so that it can be animated later using keypath
    [rocket setName:@"rocket"];
    
    //Flare particles emitted from the rocket as it flys
    CAEmitterCell *flare = [CAEmitterCell emitterCell];
    flare.contents = (id)contentImage.CGImage;
    flare.emissionLongitude = (4 * M_PI) / 2;
    flare.scale = 0.4;
    flare.velocity = 100;
    flare.birthRate = 45;
    flare.lifetime = 1.5;
    flare.yAcceleration = 350;
    flare.emissionRange = M_PI / 7;
    flare.alphaSpeed = -0.7;
    flare.scaleSpeed = -0.1;
    flare.scaleRange = 0.1;
    flare.beginTime = 0.01;
    flare.duration = 0.7;
    
    //The particles that make up the explosion
    CAEmitterCell *firework = [CAEmitterCell emitterCell];
    firework.contents = (id)contentImage.CGImage;
    firework.birthRate = 9999;
    firework.scale = 0.6;
    firework.velocity = -130;
    firework.lifetime = 2;
    firework.alphaSpeed = -0.2;
    firework.yAcceleration = 80;
    firework.beginTime = 1.5;
    firework.duration = 0.1;
    firework.emissionRange = 2 * M_PI;
    firework.scaleSpeed = -0.1;
    firework.spin = 2;
    
    //Name the cell so that it can be animated later using keypath
    [firework setName:@"firework"];
    
    //preSpark is an invisible particle used to later emit the spark
    CAEmitterCell *preSpark = [CAEmitterCell emitterCell];
    preSpark.birthRate = 80;
    preSpark.velocity = firework.velocity * 0.70;
    preSpark.lifetime = 1.7;
    preSpark.yAcceleration = firework.yAcceleration * 0.85;
    preSpark.beginTime = firework.beginTime - 0.2;
    preSpark.emissionRange = firework.emissionRange;
    preSpark.greenSpeed = 100;
    preSpark.blueSpeed = 100;
    preSpark.redSpeed = 100;
    
    //Name the cell so that it can be animated later using keypath
    [preSpark setName:@"preSpark"];
    
    //The 'sparkle' at the end of a firework
    CAEmitterCell *spark = [CAEmitterCell emitterCell];
    spark.contents = (id)contentImage.CGImage;
    spark.lifetime = 0.05;
    spark.yAcceleration = 250;
    spark.beginTime = 0.8;
    spark.scale = 0.4;
    spark.birthRate = 10;
    
    preSpark.emitterCells = @[spark];
    rocket.emitterCells = @[flare, firework, preSpark];
    self.emitterLayer.emitterCells = @[rocket];
}

- (void)prepareAnimationStates
{
    self.animationStatus = 0;
    self.animationStates = @[
                             @{
                                 @"emitterCells.rocket.birthRate" : @0.5,
                                 @"emitterCells.rocket.emissionRange" : @(M_PI_4),
                                 @"emitterCells.rocket.velocity" : @(-400),
                                 @"emitterCells.rocket.velocityRange" : @(100),
                                 @"emitterCells.rocket.yAcceleration" : @(250),
                                 @"emitterCells.rocket.emitterCells.firework.emissionRange" : @(2 * M_PI),
                                 @"emitterCells.rocket.emitterCells.firework.velocity" : @(-130),
                                 @"emitterCells.rocket.emitterCells.firework.velocityRange" : @(30),
                                 @"emitterCells.rocket.emitterCells.firework.yAcceleration" : @(80),
                                 @"emitterCells.rocket.emitterCells.preSpark.velocity" : @(-80),
                                 @"emitterCells.rocket.emitterCells.preSpark.yAcceleration" : @(65),
                                 @"emitterCells.rocket.emitterCells.preSpark.emissionRange" : @(2*M_PI)
                                 },
                             @{
                                 @"emitterCells.rocket.birthRate" : @10,
                                 @"emitterCells.rocket.emissionRange" : @(M_PI_2),
                                 @"emitterCells.rocket.velocity" : @(-800),
                                 @"emitterCells.rocket.velocityRange" : @(100),
                                 @"emitterCells.rocket.yAcceleration" : @(500),
                                 @"emitterCells.rocket.emitterCells.firework.emissionRange" : @(2 * M_PI),
                                 @"emitterCells.rocket.emitterCells.firework.velocity" : @(-200),
                                 @"emitterCells.rocket.emitterCells.firework.velocityRange" : @(30),
                                 @"emitterCells.rocket.emitterCells.firework.yAcceleration" : @(40),
                                 @"emitterCells.rocket.emitterCells.preSpark.velocity" : @(-200),
                                 @"emitterCells.rocket.emitterCells.preSpark.yAcceleration" : @(165),
                                 @"emitterCells.rocket.emitterCells.preSpark.emissionRange" : @(2*M_PI)
                                 },
                             @{}
                             ];

}


@end
