//
//  ScrollingNavigationViewController.m
//  ScrollingNavigationDemo
//
//  Created by Loganathan on 04/03/13.
//  Copyright (c) 2013 Loganathan. All rights reserved.
//

#import "ScrollingNavigationViewController.h"
#import "Logging.h"

#define LABEL_SPACING 50.0f

@interface ScrollingNavigationViewController ()

@end

@implementation ScrollingNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //---for swipeable navigation---
    _navigationBackView = [[UIView alloc] init];
    _navigationBackView.frame = CGRectMake(0, 0, 320, 44);
    
    _navigationBackView.backgroundColor = [UIColor colorWithPatternImage:navigationImage];
    
    if (navigationImage == NULL) {
        LogTrace(@"navigationImage = %@", navigationImage);
        _navigationBackView.backgroundColor = [UIColor grayColor];
    }
    
    [self.view addSubview:_navigationBackView];
    
    _navigationScrollView = [[UIScrollView alloc] init];
    _navigationScrollView.delegate = self;
    _navigationScrollView.frame = CGRectMake(0, 0, 320, 44);
    _navigationScrollView.showsHorizontalScrollIndicator = NO;
    _navigationScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_navigationScrollView];
    
    _navigationScrollView.backgroundColor = [UIColor clearColor];
        _navigationScrollView.clipsToBounds = YES;
    
    LogTrace(@"_navigationTitles count = %i",[_navigationTitles count]);
    [self setupNavigationWithTitles:_navigationTitles];
    _selectedLabelIndex = 0;
}

//---setup navigationSwipeView---
-(void) setupNavigationWithTitles:(NSMutableArray*)titles{
    
    if (_navigationLabels == nil) {
        _navigationLabels = [[NSMutableArray alloc] init];
    } else {
        for (UILabel *label in _navigationLabels) {
            [label removeFromSuperview];
        }
        [_navigationLabels removeAllObjects];
    }
    
    [_navigationScrollView setContentSize:CGSizeMake(320, 44)];
    
    int i = 0;
    
    for (NSString *accountName in titles) {
        UILabel *label = [self getLabelForNavigationScrollViewWithName:accountName];
        label.tag = i;
        UITapGestureRecognizer *tapGestureForLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnLabel:)];
        
        [label addGestureRecognizer:tapGestureForLabel];
        [_navigationLabels addObject:label];
        i++;
    }
    
    UILabel *firstLabel = [_navigationLabels objectAtIndex:0];
    CGFloat firstLabelWidth = firstLabel.frame.size.width;
    CGFloat xPosition = 160.0f - (firstLabelWidth/(2.0f));
    CGFloat previousLabelWidth = firstLabelWidth;
    
    if (_centerPoints == nil) {
        _centerPoints = [[NSMutableArray alloc] init];
    } else {
        [_centerPoints removeAllObjects];
    }
    
    for (UILabel *label in _navigationLabels) {
        
        [self.navigationScrollView setContentSize:CGSizeMake(xPosition+160.0f+(label.frame.size.width/(2.0f)), 44)];
        label.frame = CGRectMake(xPosition, 10, label.frame.size.width, label.frame.size.height);        
        NSNumber *centerPoint = [NSNumber numberWithDouble:xPosition+(label.frame.size.width/(2.0f))];        
        previousLabelWidth = label.frame.size.width;
        xPosition = previousLabelWidth + LABEL_SPACING + xPosition;
        [_centerPoints addObject:centerPoint];
        [_navigationScrollView addSubview:label];
    }    
    [self switchToLabelWithNumber:_selectedLabelIndex];
    
}

//---switchAccount---
-(void) switchToLabelWithNumber:(int)activeLabelNo{
    LogTrace(@"switchToAccountWithNumber");
    if (activeLabelNo != _selectedLabelIndex) {
        UILabel *oldCenterLabel = [_navigationLabels objectAtIndex:_selectedLabelIndex];
        oldCenterLabel.textColor = unselectedLabelColor;
    }
    UILabel *centerLabel = [_navigationLabels objectAtIndex:activeLabelNo];
    centerLabel.textColor = selectedLabelColor;
    
    CGFloat centerPoint = [[_centerPoints objectAtIndex:activeLabelNo] floatValue];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [_navigationScrollView setContentOffset:CGPointMake((centerPoint - 160.0f), _navigationScrollView.frame.origin.y) animated:NO];
    
    [UIView commitAnimations];
    _selectedLabelIndex = activeLabelNo;
    [self.delegate labelSwitchedAtIndex:_selectedLabelIndex];    
}

-(void)setLabelFont:(UIFont *)font{
    labelFont = font;
}
-(void)setNavigationImage:(UIImage *)image{
    navigationImage = image;
}

-(void)setSelectedLabelColor:(UIColor *)color{
    selectedLabelColor = color;
}

-(void)setUnselectedLabelColor:(UIColor *)color{
    unselectedLabelColor = color;
}

//---get Label for _navigationScrollView---
-(UILabel *) getLabelForNavigationScrollViewWithName:(NSString *)name{
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:labelFont];
    label.text = name;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = unselectedLabelColor;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    
    CGFloat labelWidth = label.frame.size.width;
    CGFloat mod = fmodf(labelWidth, 2.0f);
    
    LogTrace(@"label width and mod = %f & %f", labelWidth, mod);
    
    if (mod > 0.0f) {
        labelWidth = labelWidth + 1.0f;
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, labelWidth, label.frame.size.height);
    }
    [label setUserInteractionEnabled:YES];
    
    return label;
}

//---for swipeable navigation---
-(void)autoPositionAdjustingTo:(UIScrollView *)scrollView{
    
    LogTrace(@"autoPositionAdjustingTo");
    CGFloat positionOfX = _navigationScrollView.contentOffset.x;
    CGFloat centerPoint = positionOfX + 160.0f;
    
    CGFloat endPosition = [[_centerPoints lastObject] floatValue];
    
    if (centerPoint <= 160.0f) {
        [self switchToLabelWithNumber:0];
    } else if (centerPoint >= endPosition){
        [self switchToLabelWithNumber:([_navigationLabels count]-1)];
    } else{
        for (int i = 0; i < ([_centerPoints count]-1); i++) {
            CGFloat point = [[_centerPoints objectAtIndex:i] floatValue];
            CGFloat nextPoint = [[_centerPoints objectAtIndex:i+1] floatValue];
            
            if (point <= centerPoint && centerPoint <= nextPoint) {
            CGFloat l = centerPoint - point;
            CGFloat r = nextPoint - centerPoint;
            int centerAccount;
            
            if (l < r) {
                centerAccount = i;
            } else {
                centerAccount = i+1;
            }
            [self switchToLabelWithNumber:centerAccount];
            break;
            }
        }
    }
    
}

//---for swipeable navigation---
-(void)tappedOnLabel:(UITapGestureRecognizer *)tapGesture{
    
    UIView *labelView = tapGesture.view;
    int tag = labelView.tag;
    LogTrace(@"tappedOnLabel tag = %i", tag);
    [self switchToLabelWithNumber:tag];    
}

//---Delegete for UIScrollView---
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    LogTrace(@"scrollViewDidEndDragging:willDecelerate");
    if(scrollView == _navigationScrollView){
        UILabel *centerLabel = [_navigationLabels objectAtIndex:_selectedLabelIndex];
        centerLabel.textColor = unselectedLabelColor;
    }
}

//---Delegete for UIScrollView---
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    LogTrace(@"scrollViewDidEndDragging:willDecelerate");
    if (scrollView == _navigationScrollView) {
        if (!decelerate) {
            [self autoPositionAdjustingTo:scrollView];
        } 
    }
}

//---Delegete for UIScrollView---
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    LogTrace(@"scrollViewDidEndDecelerating");
    if (scrollView == _navigationScrollView) {
        [self autoPositionAdjustingTo:scrollView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
