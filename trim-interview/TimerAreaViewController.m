//
//  TimerAreaViewController.m
//  trim-interview
//
//  Created by Ainur on 19/06/2018.
//  Copyright © 2018 merche_o. All rights reserved.
//

#import "TimerAreaViewController.h"

@interface TimerAreaViewController ()
@property (strong) NSTimer *timer;
@property int countdown;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation TimerAreaViewController

-(instancetype)initWith:(NSInteger)index{
    self = [super init];
    if (self) {
        self.index = index;
        _countdown = 10;
     
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d", _countdown];
    self.nameLabel.text = [NSString stringWithFormat:@"%ld", _index + 1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(countdownTimer:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)countdownTimer:(NSTimer *)timer
{
    if (_countdown > 0) {
        _countdown--;
        self.timeLabel.text = [NSString stringWithFormat:@"%d", _countdown];
    }
}

@end
