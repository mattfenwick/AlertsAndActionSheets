//
//  FirstViewController.m
//  Alerts2
//
//  Created by MattF on 2/2/15.
//  Copyright (c) 2015 MattF. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapAlertView:(id)sender
{
    NSLog(@"alertview");
}

- (IBAction)tapActionSheet:(id)sender
{
    NSLog(@"actionsheet");
}

- (IBAction)tapAlertControllerAlert:(id)sender
{
    NSLog(@"alertcontroller alert");
}

- (IBAction)tapAlertControllerActionSheetBarButton:(id)sender
{
    NSLog(@"alertcontroller actionsheet barbutton");
}

- (IBAction)tapAlertControllerActionSheetSourceView:(id)sender
{
    NSLog(@"alertcontroller actionsheet sourceview");
}

@end
