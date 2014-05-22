//
//  RWDetailViewController.h
//  LayerCake
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
