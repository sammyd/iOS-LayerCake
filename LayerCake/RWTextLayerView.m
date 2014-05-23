//
//  RWTextLayerView.m
//  LayerCake
//
//  Created by Sam Davies on 23/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "RWTextLayerView.h"

@interface RWTextLayerView ()

@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, assign) BOOL animationState;

@end

@implementation RWTextLayerView

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
        [self createTextLayer];
    }
    return self;
}

+ (NSString *)description
{
    return @"CATextLayer";
}

- (void)animate
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:2];
    
    if(self.animationState) {
        self.textLayer.foregroundColor = [UIColor brownColor].CGColor;
        self.textLayer.fontSize = 16.0;
    } else {
        self.textLayer.foregroundColor = [UIColor purpleColor].CGColor;
        self.textLayer.fontSize = 42.0;
    }
    self.animationState = !self.animationState;
    
    [CATransaction commit];
}


#pragma mark - Utility methods
- (void)createTextLayer
{
    self.textLayer = [CATextLayer layer];
    self.textLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) - 20, CGRectGetHeight(self.bounds) - 20);
    self.textLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self.layer addSublayer:self.textLayer];
    
    self.textLayer.string = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent aliquet leo sed ullamcorper vehicula. Donec porttitor nulla nisl, a gravida augue scelerisque non. Aenean massa neque, tincidunt ut purus ac, sollicitudin consectetur leo. Fusce blandit, felis in dignissim tempus, eros felis ullamcorper arcu, varius consectetur diam risus a eros. Pellentesque consequat leo quis eros volutpat luctus a sit amet odio. Maecenas ut euismod libero. Mauris ut ipsum ac justo posuere tristique eu vel arcu. In aliquet justo elit, vitae imperdiet erat aliquam ac. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum sit amet turpis quis elit venenatis lobortis sit amet at sapien. Sed venenatis nisi magna, condimentum volutpat nisl sodales non.";
    
    self.textLayer.wrapped = YES;
    self.textLayer.fontSize = 16.0;
    self.textLayer.foregroundColor = [UIColor brownColor].CGColor;
    CGFontRef font = CGFontCreateWithFontName((__bridge CFStringRef)@"Georgia-Bold");
    self.textLayer.font = font;
    CGFontRelease(font);
}


@end
