//
//  RWLayerView.h
//  LayerCake
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWLayerView <NSObject>

// Class method to create a view
+ (instancetype)viewWithFrame:(CGRect)frame;

// This should perform any animations you'd like to demonstrate
- (void)animate;

@end
