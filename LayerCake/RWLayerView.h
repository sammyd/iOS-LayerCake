//
//  RWLayerView.h
//  LayerCake
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWLayerView <NSObject>

+ (instancetype)viewWithFrame:(CGRect)frame;

- (void)animate;

@end
