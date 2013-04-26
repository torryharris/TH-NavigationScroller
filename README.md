Navigation-Scroller-Framework
============
A Navigation Bar scroller like on the Amazon Kindle iOS application.

![alt text](https://raw.github.com/torryharris/Navigation-Scroller-Framework/master/screenshot.png "Logo Title Text 1")


##How to use:
1. Deployment target should be 5.0 or later
2. Download  ScrollingNavigationDemo
3. Copy ScrollingNavigationViewController.h and ScrollingNavigationViewController.m (It incorporates ARC)
4. Copy Logging.h (since LogTrace has been used in this framework)

4. Subclass ScrollingNavigationViewController and implement ScrollingNavigationDelegate.
                       
        @interface ViewController : ScrollingNavigationViewController<ScrollingNavigationDelegate>

5. Call setLabelFont to set the font of labels at navigation bar.
      
        [self setLabelFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]];

6. Call setNavigationImage to set an image at navigation bar.
        
        [self setNavigationImage:[UIImage imageNamed:@"nav-bar.png"]];

7. Call setSelectedLabelColor to set the color of selected label.

        [self setSelectedLabelColor:[UIColor whiteColor]];
        
8. Call setUnselectedLabelColor to set the color of unselected label.
         
        [self setUnselectedLabelColor:[UIColor lightTextColor]];

9. Set delegate to self.

        self.delegate = self;
        
10. Intialize navigationTitles (property of ScrollingNavigationViewController of type NSMutableArray) to set the titles at navigation bar.

        self.navigationTitles = [[NSMutableArray alloc] initWithObjects:@"Home",@"Personal",@"Office", @"one more", nil];
         
11. Implement delegate method labelSwitchedAtIndex to know the highlighted option and take appropriate action in your View Controller.This method receives the current index value of the highlighted option.

        -(void)labelSwitchedAtIndex:(NSUInteger)index{
          _selectedLabel.text = [self.navigationTitles objectAtIndex:self.selectedLabelIndex];
        }
        
12. 


#####Steps 6,7,8,9 are optional.
##License
SliderSwitch is licensed under the terms of the MIT License. Please see the [License](https://github.com/torryharris/Navigation-Scroller-Framework/blob/master/License) file for full details.

