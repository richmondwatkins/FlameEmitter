//
//  BNRViewController.m
//  FeelTheBurn
//
//  Copyright (c) 2013 Big Nerd Ranch, LLC. All rights reserved.
//

#import "BNRViewController.h"
#import "BNRFireView.h"
@import CoreMotion;

@interface BNRViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numStepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (weak, nonatomic) IBOutlet BNRFireView *fireView;
@property (weak, nonatomic) IBOutlet UIView *stairView;

@property (nonatomic, strong) CMStepCounter *stepCounter;

@end

@implementation BNRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"graynoise.jpg"].CGImage;

    self.startButton.layer.cornerRadius = 10;
    self.resetButton.layer.cornerRadius = 10;

    UIInterpolatingMotionEffect *buttonMove = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    buttonMove.minimumRelativeValue = @-20.0;
    buttonMove.maximumRelativeValue = @20.0;

    [self.startButton addMotionEffect:buttonMove];
    [self.resetButton addMotionEffect:buttonMove];

    CABasicAnimation *stepAdmin = [CABasicAnimation animationWithKeyPath:@"dottedStepIndex"];
    stepAdmin.fromValue = @0;
    stepAdmin.toValue = @10;
    stepAdmin.duration = 3.0;
    [self.stairView.layer addAnimation:stepAdmin forKey:@"climb"];

    UIInterpolatingMotionEffect *stairMove = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"dottedStepIndex" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    stairMove.minimumRelativeValue = @0;
    stairMove.maximumRelativeValue = @12;
    [self.stairView addMotionEffect:stairMove];
}


- (IBAction)startCounterTouch:(id)sender {
    [self.fireView startBurn];
    if ([CMStepCounter isStepCountingAvailable]) {
        self.stepCounter = [[CMStepCounter alloc] init];
        [self.stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:1 withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
            self.numStepsLabel.text = [NSString stringWithFormat:@"%05d", (int)numberOfSteps];
        }];
    }else{
        self.numStepsLabel.text = @": (";
        self.stepsLabel.text = @"No Counter";
    }
}



@end
