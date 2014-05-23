//
//  RWDetailViewController.m
//  LayerCake
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import "RWDetailViewController.h"
#import "RWLayerView.h"

@interface RWDetailViewController ()

@property (nonatomic, strong) UIView<RWLayerView> *layerView;

@end

@implementation RWDetailViewController

#pragma mark - Managing the detail item

- (void)setLayerViewClassName:(NSString *)layerViewClassName
{
    if(![layerViewClassName isEqualToString:_layerViewClassName]) {
        _layerViewClassName = layerViewClassName;
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if(self.layerViewClassName) {
        Class layerViewClass = NSClassFromString(self.layerViewClassName);
        self.title = [layerViewClass description];
        if(self.layerView) {
            [self.layerView removeFromSuperview];
        }
        self.layerView = [layerViewClass viewWithFrame:self.layerViewContainer.bounds];
        [self.layerViewContainer addSubview:self.layerView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (IBAction)handleAnimateTapped:(id)sender {
    [self.layerView animate];
}

@end
