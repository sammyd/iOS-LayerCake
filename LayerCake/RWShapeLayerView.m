//
//  RWShapeLayerView.m
//  LayerCake
//
//  Created by Sam Davies on 23/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "RWShapeLayerView.h"

@interface RWShapeLayerView ()

@property (nonatomic, strong) CAShapeLayer *faceLayer;
@property (nonatomic, strong) CAShapeLayer *leftEyeLayer;
@property (nonatomic, strong) CAShapeLayer *rightEyeLayer;
@property (nonatomic, strong) CAShapeLayer *tacheLayer;
@property (nonatomic, strong) CAShapeLayer *mouthLayer;

@property (nonatomic, assign) BOOL animationState;

@end

@implementation RWShapeLayerView

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
        [self prepareLayers];
        self.animationState = NO;
    }
    return self;
}

- (void)animate
{
    // Bundle all of the animations into a transaction
    [CATransaction begin];
    [CATransaction setAnimationDuration:2];
    
    // Draw the tache
    CABasicAnimation *tacheAnimationStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    tacheAnimationStart.fromValue = @0.5;
    tacheAnimationStart.toValue = @0;
    CABasicAnimation *tacheAnimationEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tacheAnimationEnd.fromValue = @0.5;
    tacheAnimationEnd.toValue = @1;
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[tacheAnimationStart, tacheAnimationEnd];
    [self.tacheLayer addAnimation:groupAnimation forKey:@"tacheAppearance"];
    
    // Toggle Colours of face and smile
    CABasicAnimation *faceAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    faceAnimation.toValue = (id)self.leftEyeLayer.fillColor;
    faceAnimation.fromValue = (id)self.faceLayer.fillColor;
    [self.faceLayer addAnimation:faceAnimation forKey:@"faceColor"];
    CABasicAnimation *leftEyeAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    leftEyeAnimation.toValue = (id)self.faceLayer.fillColor;
    leftEyeAnimation.fromValue = (id)self.leftEyeLayer.fillColor;
    [self.leftEyeLayer addAnimation:leftEyeAnimation forKey:@"eyeColor"];
    CABasicAnimation *rightEyeAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    rightEyeAnimation.toValue = (id)self.faceLayer.fillColor;
    rightEyeAnimation.fromValue = (id)self.rightEyeLayer.fillColor;
    [self.rightEyeLayer addAnimation:rightEyeAnimation forKey:@"eyeColor"];
    
    // Commit the color changes to the model tree
    self.rightEyeLayer.fillColor = self.faceLayer.fillColor;
    self.faceLayer.fillColor = self.leftEyeLayer.fillColor;
    self.leftEyeLayer.fillColor = self.rightEyeLayer.fillColor;
    
    // Animate the path of the mouth
    UIBezierPath *newMouthPath;
    CABasicAnimation *mouthAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    if(self.animationState) {
        newMouthPath = [self smilePath];
    } else {
        newMouthPath = [self sadMouthPath];
    }
    mouthAnimation.fromValue = (id)self.mouthLayer.path;
    mouthAnimation.toValue = (id)newMouthPath.CGPath;
    self.animationState = !self.animationState;
    [self.mouthLayer addAnimation:mouthAnimation forKey:@"mouthPath"];
    
    self.mouthLayer.path = newMouthPath.CGPath;
    
    
    [CATransaction commit];
}

+ (NSString *)description
{
    return @"CAShapeLayer";
}

- (void)prepareLayers
{
    self.faceLayer = [self newShapeLayer];
    self.leftEyeLayer = [self newShapeLayer];
    self.rightEyeLayer = [self newShapeLayer];
    self.tacheLayer = [self newShapeLayer];
    self.mouthLayer = [self newShapeLayer];
    
    self.faceLayer.path = [self facePath].CGPath;
    self.faceLayer.strokeColor = [UIColor colorWithRed: 0.429 green: 0 blue: 0 alpha: 1].CGColor;
    self.faceLayer.lineWidth = 5.0;
    self.faceLayer.fillColor = [UIColor yellowColor].CGColor;
    
    self.leftEyeLayer.path = [self leftEyePath].CGPath;
    [self configureEyeLayer:self.leftEyeLayer];
    
    self.rightEyeLayer.path = [self rightEyePath].CGPath;
    [self configureEyeLayer:self.rightEyeLayer];
    
    self.tacheLayer.path = [self tachePath].CGPath;
    self.tacheLayer.strokeColor = [UIColor blackColor].CGColor;
    self.tacheLayer.lineWidth = 28.0;
    
    self.mouthLayer.path = [self smilePath].CGPath;
    self.mouthLayer.strokeColor = [UIColor colorWithRed: 0.429 green: 0 blue: 0 alpha: 1].CGColor;
    self.mouthLayer.lineWidth = 25.0;

}

- (CAShapeLayer *)newShapeLayer
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.bounds = self.bounds;
    layer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
    return layer;
}

- (void)configureEyeLayer:(CAShapeLayer *)eyeLayer
{
    eyeLayer.strokeColor = [UIColor colorWithRed: 0.886 green: 0.59 blue: 0 alpha: 1].CGColor;
    eyeLayer.fillColor = [UIColor greenColor].CGColor;
    eyeLayer.lineWidth = 5.0;
}

#pragma mark - Drawing Utility Methods
- (UIBezierPath *)facePath
{
    return [UIBezierPath bezierPathWithOvalInRect: CGRectMake(10.5, 9.5, 300, 300)];
}

- (UIBezierPath *)leftEyePath
{
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint: CGPointMake(96.5, 49.5)];
    [starPath addLineToPoint: CGPointMake(113.78, 73.17)];
    [starPath addLineToPoint: CGPointMake(143.1, 81.29)];
    [starPath addLineToPoint: CGPointMake(124.46, 104.03)];
    [starPath addLineToPoint: CGPointMake(125.3, 132.71)];
    [starPath addLineToPoint: CGPointMake(96.5, 123.1)];
    [starPath addLineToPoint: CGPointMake(67.7, 132.71)];
    [starPath addLineToPoint: CGPointMake(68.54, 104.03)];
    [starPath addLineToPoint: CGPointMake(49.9, 81.29)];
    [starPath addLineToPoint: CGPointMake(79.22, 73.17)];
    [starPath closePath];

    return starPath;
}

- (UIBezierPath *)rightEyePath
{
    UIBezierPath* star2Path = [UIBezierPath bezierPath];
    [star2Path moveToPoint: CGPointMake(226.5, 49.5)];
    [star2Path addLineToPoint: CGPointMake(243.78, 73.17)];
    [star2Path addLineToPoint: CGPointMake(273.1, 81.29)];
    [star2Path addLineToPoint: CGPointMake(254.46, 104.03)];
    [star2Path addLineToPoint: CGPointMake(255.3, 132.71)];
    [star2Path addLineToPoint: CGPointMake(226.5, 123.1)];
    [star2Path addLineToPoint: CGPointMake(197.7, 132.71)];
    [star2Path addLineToPoint: CGPointMake(198.54, 104.03)];
    [star2Path addLineToPoint: CGPointMake(179.9, 81.29)];
    [star2Path addLineToPoint: CGPointMake(209.22, 73.17)];
    [star2Path closePath];

    return star2Path;
}

- (UIBezierPath *)tachePath
{
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(68.85, 168.88)];
    [bezier2Path addCurveToPoint: CGPointMake(108.73, 186.12) controlPoint1: CGPointMake(68.85, 168.88) controlPoint2: CGPointMake(75.03, 196.93)];
    [bezier2Path addCurveToPoint: CGPointMake(160, 168.88) controlPoint1: CGPointMake(142.43, 175.32) controlPoint2: CGPointMake(121.64, 160.95)];
    [bezier2Path addCurveToPoint:CGPointMake(211.27, 186.12) controlPoint1:CGPointMake(198.36, 160.95) controlPoint2:CGPointMake(177.57, 175.32)];
    [bezier2Path addCurveToPoint:CGPointMake(251.15, 168.88) controlPoint1:CGPointMake(244.97, 196.93) controlPoint2:CGPointMake(251.15, 168.88)];
    
    return bezier2Path;
}

- (UIBezierPath *)smilePath
{
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(46.5, 199.5)];
    [bezierPath addCurveToPoint: CGPointMake(273.5, 199.5) controlPoint1: CGPointMake(46.5, 199.5) controlPoint2: CGPointMake(153.28, 370.64)];
    return bezierPath;
}

- (UIBezierPath *)sadMouthPath
{
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(55.5, 252.56)];
    [bezierPath addCurveToPoint: CGPointMake(264.5, 252.56) controlPoint1: CGPointMake(55.5, 252.56) controlPoint2: CGPointMake(153.81, 146.67)];
    return bezierPath;
}

@end
