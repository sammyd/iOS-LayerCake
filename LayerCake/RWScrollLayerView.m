//
//  RWScrollLayerView.m
//  LayerCake
//
//  Created by Sam Davies on 23/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "RWScrollLayerView.h"

@interface RWScrollLayerView ()

@property (nonatomic, strong) CAScrollLayer *scrollLayer;

@end

@implementation RWScrollLayerView

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
        [self createScrollLayer];
        srand48(time(0));
    }
    return self;
}

+ (NSString *)description
{
    return @"CAScrollLayer";
}

- (void)animate
{
    double r = drand48();
    CGPoint newPoint = CGPointMake(0, r * 800);
    [self.scrollLayer scrollToPoint:newPoint];
}

#pragma mark - Utility methods
- (void)createScrollLayer
{
    self.scrollLayer = [CAScrollLayer layer];
    self.scrollLayer.bounds = self.bounds;
    self.scrollLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self.layer addSublayer:self.scrollLayer];
    [self addContentToScrollLayer:self.scrollLayer];
}

- (void)addContentToScrollLayer:(CAScrollLayer *)layer
{
    NSArray *colors = @[
                        [UIColor redColor],
                        [UIColor grayColor],
                        [UIColor greenColor],
                        [UIColor orangeColor],
                        [UIColor purpleColor],
                        [UIColor brownColor],
                        [UIColor yellowColor],
                        [UIColor blueColor]
                        ];
    
    
    CGFloat currentY = 50;
    for (UIColor *color in colors) {
        CALayer *colorLayer = [CALayer layer];
        colorLayer.bounds = CGRectMake(0, 0, layer.bounds.size.width, 100);
        colorLayer.position = CGPointMake(layer.bounds.size.width / 2, currentY);
        colorLayer.backgroundColor = color.CGColor;
        currentY += 100;
        [layer addSublayer:colorLayer];
    }
}

@end
