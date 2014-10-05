//
//  ViewController.h
//  Calculator
//
//  Created by Ray on 10/3/14.
//  Copyright (c) 2014 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operatorPressed:(UIButton *)sender;
- (IBAction)touchStartAnimation:(UIButton *)sender;
- (IBAction)touchEndAnimation:(UIButton *)sender;

@end

