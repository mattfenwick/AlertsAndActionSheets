//
//  RootViewController.m
//  Alerts2
//
//  Created by MattF on 2/2/15.
//  Copyright (c) 2015 MattF. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"

@interface RootViewController ()

@property (nonatomic, weak) IBOutlet UITabBar *myTabBar;
@property (nonatomic, weak) IBOutlet UIViewController *myThird;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (UIViewController *vc in self.viewControllers)
    {
        if ([vc respondsToSelector:@selector(setMyTabBar:)])
        {
            FirstViewController *fvc = (FirstViewController *)vc;
            NSLog(@"setting myTabBar");
            fvc.myTabBar = self.myTabBar;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
