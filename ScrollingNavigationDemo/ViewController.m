//
//  ViewController.m
//  ScrollingNavigationDemo
//
//  Created by Loganathan on 04/03/13.
//  Copyright (c) 2013 Loganathan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    //customizing
    [self setLabelFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]];
    [self setNavigationImage:[UIImage imageNamed:@"nav-bar.png"]];
    [self setSelectedLabelColor:[UIColor whiteColor]];
    [self setUnselectedLabelColor:[UIColor lightTextColor]];
    self.delegate = self;
    self.navigationTitles = [[NSMutableArray alloc] initWithObjects:@"Home",@"Personal",@"Office", @"one more", nil];
    _selectedLabel.text = [self.navigationTitles objectAtIndex:self.selectedLabelIndex];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)labelSwitchedAtIndex:(NSUInteger)index{
    
    LogTrace(@"index:%d",index);    
    _selectedLabel.text = [self.navigationTitles objectAtIndex:self.selectedLabelIndex];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end