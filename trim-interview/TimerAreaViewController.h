//
//  TimerAreaViewController.h
//  trim-interview
//
//  Created by Ainur on 19/06/2018.
//  Copyright © 2018 merche_o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerAreaViewController : UIViewController
@property (assign, nonatomic) NSInteger index;
- (void)startTimer;
-(instancetype)initWith:(NSInteger)index;

@end
