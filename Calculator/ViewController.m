//
//  ViewController.m
//  Calculator
//
//  Created by Ray on 10/3/14.
//  Copyright (c) 2014 Ray. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

{
    BOOL isOperatorPressed;
}


@property (weak, nonatomic) IBOutlet UILabel *firstNumber;
@property (weak, nonatomic) IBOutlet UILabel *secondNumber;
@property (weak, nonatomic) IBOutlet UILabel *resultNumber;
@property (weak, nonatomic) IBOutlet UILabel *operator;


@property (weak, nonatomic) IBOutlet UIView *keypad;

@property (nonatomic) double dFirstNumber;
@property (nonatomic) double dSecondNumber;
@property (nonatomic) double dResultNumber;

@end

@implementation ViewController

- (IBAction)digitPressed:(UIButton *)sender {
    [self touchEndAnimation:sender];
    [self playSound:@"number"];
    
    if (!isOperatorPressed) {
        if ([self.firstNumber.text isEqualToString: @"0"]) {
            self.firstNumber.text = @"";
        }
        self.firstNumber.text = [self.firstNumber.text
                                 stringByAppendingString:sender.titleLabel.text];
    } else {
        self.secondNumber.text = [self.secondNumber.text
                                  stringByAppendingString:sender.titleLabel.text];
    }

}


- (IBAction)operatorPressed:(UIButton *)sender {
    [self touchEndAnimation:sender];
    
    isOperatorPressed = YES;
    
    if ([sender.titleLabel.text isEqualToString: @"="]) {
        
        [self playSound:@"result"];
        
        if (![self.operator.text isEqualToString: @""]) {
            
            self.dFirstNumber = self.firstNumber.text.intValue;
            self.dSecondNumber = self.secondNumber.text.intValue;
            self.dResultNumber = self.resultNumber.text.doubleValue;
            
            if (![self.secondNumber.text isEqualToString: @""]) {
                [self calcWithOperator:self.operator.text];
            }
        } else {
            isOperatorPressed = NO;
        }
        

        
        
    } else if ([sender.titleLabel.text isEqualToString: @"C"]) {
        [self playSound:@"cancel"];
        [self clear];
    } else {
        [self playSound:@"operator"];
        self.operator.text = sender.titleLabel.text;
    }
    
}

- (void)clear {
    self.firstNumber.text = @"0";
    self.secondNumber.text = [NSString string];
    self.operator.text = [NSString string];
    isOperatorPressed = NO;
}

- (void)calcWithOperator:(NSString *)operator {
    if ([operator isEqualToString:@"+"]) {
        self.dResultNumber = self.dFirstNumber + self.dSecondNumber;
    } else if ([operator isEqualToString:@"-"]){
        self.dResultNumber = self.dFirstNumber - self.dSecondNumber;
    } else if ([operator isEqualToString:@"*"]){
        self.dResultNumber = self.dFirstNumber * self.dSecondNumber;
    } else if ([operator isEqualToString:@"/"]){
        self.dResultNumber = self.dFirstNumber / self.dSecondNumber;
    }
    
    
    self.firstNumber.text = [NSString stringWithFormat:@"%0.2f",self.dResultNumber];
    self.secondNumber.text = [NSString string];
}


- (IBAction)touchStartAnimation:(UIButton *)sender {
    [UIView animateWithDuration:0.1
                     animations:^{
                         sender.transform = CGAffineTransformMakeScale(0.8, 0.8);
                     }
                     completion:NULL];
}

- (IBAction)touchEndAnimation:(UIButton *)sender {
    [UIView animateWithDuration:0.05
                     animations:^{
                         sender.transform = CGAffineTransformMakeScale(1, 1);
                     }
                     completion:NULL];
}


-(void) playSound:(NSString *)sender {
    SystemSoundID soundID;
    NSURL *soundPath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:sender ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundPath, &soundID);
    AudioServicesPlaySystemSound (soundID);
    //[soundPath
//    NSLog(@"soundpath retain count: %lu", (unsigned long)[soundPath retainCount]);
}











- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
