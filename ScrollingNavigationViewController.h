//
//  ScrollingNavigationViewController.h
//  ScrollingNavigationDemo
//
//  Created by Loganathan on 04/03/13.
//  Copyright (c) 2013 Loganathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollingNavigationDelegate <NSObject>

-(void) labelSwitchedAtIndex:(NSUInteger)index;

@end

@interface ScrollingNavigationViewController : UIViewController<UIScrollViewDelegate>{
    UIFont *labelFont;
    UIImage *navigationImage;
    UIColor *selectedLabelColor;
    UIColor *unselectedLabelColor;
}

//---for swipeable navigation---
@property (nonatomic, retain) UIView *navigationBackView;
@property (nonatomic, retain) UIScrollView *navigationScrollView;
@property (nonatomic, retain) NSMutableArray *navigationTitles;
@property (nonatomic, retain) NSMutableArray *navigationLabels;
@property (nonatomic, retain) NSMutableArray *centerPoints;
@property (nonatomic) NSUInteger selectedLabelIndex;
@property (nonatomic, retain) id<ScrollingNavigationDelegate> delegate;

-(void)autoPositionAdjustingTo:(UIScrollView *)scrollView;

//---set customozing---
-(void)setLabelFont:(UIFont *)font;
-(void)setNavigationImage:(UIImage *)image;
-(void)setSelectedLabelColor:(UIColor *)color;
-(void)setUnselectedLabelColor:(UIColor *)color;

@end
