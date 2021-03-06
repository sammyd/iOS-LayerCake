//
//  RWLayerViewList.m
//  LayerCake
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "RWLayerViewList.h"
#import "RWLayerView.h"
#import <objc/runtime.h>

@interface RWLayerViewList ()

@property (nonatomic, strong, readwrite) NSArray *viewClasses;

@end

@implementation RWLayerViewList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewClasses = [self classesWhichAdoptProtocol:@protocol(RWLayerView)];
    }
    return self;
}

#pragma mark - Utility methods
- (NSArray *)classesWhichAdoptProtocol:(Protocol *)protocol
{
    int numberOfClasses;
    numberOfClasses = objc_getClassList(NULL, 0);
    
    if(numberOfClasses > 0) {
        NSMutableData *data = [NSMutableData dataWithLength:sizeof(Class) * numberOfClasses];
        Class *classes = (Class *)[data mutableBytes];
        numberOfClasses = objc_getClassList(classes, numberOfClasses);
        
        Class *currentClass = classes;
        NSMutableArray *classNames = [NSMutableArray array];
        for (int i=0; i<numberOfClasses; i++) {
            if(class_conformsToProtocol(*currentClass, protocol)) {
                NSLog(@"This class does: %@", NSStringFromClass(*currentClass));
                [classNames addObject:NSStringFromClass(*currentClass)];
            }
            currentClass++;
        }
        return [classNames copy];
    }
    return nil;
}

@end
