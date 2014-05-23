//
//  RWGradientLayerView.m
//  LayerCake
//
//  Created by Sam Davies on 23/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "RWGradientLayerView.h"

@interface RWGradientLayerView ()

@property (nonatomic, assign) BOOL animationStatus;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *stops;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation RWGradientLayerView

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
        self.animationStatus = NO;
        [self prepareColorsAndStops];
        [self createGradientLayer];
    }
    return self;
}

+ (NSString *)description
{
    return @"CAGradientLayer";
}

- (void)animate
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:2];
    
    NSArray *newStops;
    NSArray *newColors;
    CGPoint endPoint;
    if(self.animationStatus) {
        newStops = self.stops[0];
        newColors = self.colors[0];
        endPoint = CGPointMake(0.5, 1);
    } else {
        newStops = self.stops[1];
        newColors = self.colors[1];
        endPoint = CGPointMake(0, 1);
    }
    self.animationStatus = !self.animationStatus;

    // Using implicit animation
    self.gradientLayer.colors = newColors;
    self.gradientLayer.locations = newStops;
    self.gradientLayer.endPoint = endPoint;

    [CATransaction commit];
}

#pragma mark - Utility Methods
- (void)prepareColorsAndStops
{
    self.colors = @[
                    @[
                       (id)[UIColor blackColor].CGColor,
                       (id)[UIColor redColor].CGColor,
                       (id)[UIColor orangeColor].CGColor,
                       (id)[UIColor yellowColor].CGColor,
                       (id)[UIColor whiteColor].CGColor,
                       (id)[UIColor whiteColor].CGColor
                     ],
                    @[
                       (id)[UIColor redColor].CGColor,
                       (id)[UIColor orangeColor].CGColor,
                       (id)[UIColor yellowColor].CGColor,
                       (id)[UIColor greenColor].CGColor,
                       (id)[UIColor blueColor].CGColor,
                       (id)[UIColor purpleColor].CGColor
                     ]
                   ];
    
    self.stops = @[
                   @[@0, @0.1, @0.15, @0.2, @0.5, @1],
                   @[@0, @0.2, @0.4, @0.6, @0.8, @1]
                  ];
}

- (void)createGradientLayer
{
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.bounds = self.bounds;
    self.gradientLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    self.gradientLayer.locations = self.stops[0];
    self.gradientLayer.colors = self.colors[0];
    [self.layer addSublayer:self.gradientLayer];
}


@end
