//
//  ViewController.h
//  ScrollingNavigationDemo
//
//  Created by Loganathan on 04/03/13.
//  Copyright (c) 2013 Loganathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollingNavigationViewController.h"
#import "Logging.h"


@interface ViewController : ScrollingNavigationViewController<ScrollingNavigationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;

@end
