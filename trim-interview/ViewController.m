//
//  ViewController.m
//  trim-interview
//
//  Created by Ainur on 17/06/2018.
//  Copyright © 2018 merche_o. All rights reserved.
//

#import "ViewController.h"
#import "TimerAreaViewController.h"

@interface ViewController () <UIPageViewControllerDataSource>
@property (strong, nonatomic) IBOutlet UIView *TimerDisplay;
@property(strong) UIPageViewController *pagerViewController;
@property (strong) NSMutableArray<UIButton *> *buttons;
@property (strong) NSMutableArray<TimerAreaViewController *> *timerAreas;
@property (strong) NSMutableDictionary<NSNumber *, NSMutableArray<NSNumber*> *> *countdowns;
@property (strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButtons];
    [self setupPager];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setupPager {
    
    self.pagerViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pagerViewController.dataSource = self;
    [[self.pagerViewController view] setFrame:[self.TimerDisplay frame]];
    int i = 0;
    self.timerAreas= [[NSMutableArray alloc] initWithCapacity:6];
    while (i < 6) {
    TimerAreaViewController *tmp = [self viewControllerAtIndex:i];
        [self.timerAreas addObject:tmp];
        i++;
    }
    NSArray *tmp = [NSArray arrayWithObject:self.timerAreas.firstObject];
    [self.pagerViewController setViewControllers:tmp direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pagerViewController];
    [[self view] addSubview:[self.pagerViewController view]];
    [self.pagerViewController didMoveToParentViewController:self];
}

-(void)setupButtons{
    
    int i = 0;
    self.buttons = [[NSMutableArray<UIButton *> alloc] initWithCapacity:6];
    while (i < 6) {
        UIButton *tmp;
        if (i < 3) {
         tmp =[[UIButton alloc] initWithFrame:CGRectMake(2 + ((i%3) * self.view.frame.size.width /3), self.view.frame.size.height / 10, self.view.frame.size.width / 3 , 70)];
        }
        else
        tmp =[[UIButton alloc] initWithFrame:CGRectMake(2 + ((i%3) * self.view.frame.size.width /3), (self.view.frame.size.height / 10) * 3, self.view.frame.size.width / 3 , 70)];

        [tmp setTitle:[NSString stringWithFormat:@"Button %d", i+1] forState:UIControlStateNormal];
        [tmp setTag:i];
        [tmp addTarget:self action:@selector(startCountDown:)
         forControlEvents:UIControlEventTouchUpInside];
        [tmp setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.view addSubview:tmp];
        [self.buttons addObject:tmp];
        ++i;
    }
    
}

-(void)startCountDown:(id)sender{
    
    UIButton * tmp = sender;
    NSNumber *key = [NSNumber numberWithInteger:tmp.tag];
    [self.timerAreas[key.integerValue] startTimer];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TimerAreaViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    index--;
    return self.timerAreas[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TimerAreaViewController *)viewController index];
    index++;
    if (index == 6) {
        return nil;
    }
    return self.timerAreas[index];
}


- (TimerAreaViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    TimerAreaViewController *childViewController = [[TimerAreaViewController alloc] initWith:index];    
    return childViewController;
    
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 6;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}


@end
