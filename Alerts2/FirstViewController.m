//
//  FirstViewController.m
//  Alerts2
//
//  Created by MattF on 2/2/15.
//  Copyright (c) 2015 MattF. All rights reserved.
//

#import "FirstViewController.h"
#import "UBSActionSheet.h"
#import "UBSAlert.h"


@interface FirstViewController () <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UITabBarItem *myTabBarItem;
@property (nonatomic, weak) IBOutlet UIButton *actionSheet;
@property (nonatomic, weak) IBOutlet UIButton *alertControllerActionSheetSource;
@property (nonatomic) NSInteger count;

@property (nonatomic, weak) IBOutlet UIButton *ubsAlert;
@property (nonatomic, weak) IBOutlet UIButton *ubsActionSheet;

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
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"The title" message:@"And the message" delegate:self cancelButtonTitle:@"Cancel this" otherButtonTitles:@"Button1", @"Button2", nil];
    [view show];
}

- (IBAction)tapActionSheet:(id)sender
{
    NSLog(@"actionsheet");
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"The title" delegate:self cancelButtonTitle:@"Cancel this" destructiveButtonTitle:@"Destructive button1" otherButtonTitles:@"D-button 2", @"D-button 3", nil];
    switch (_count % 4)
    {
        // rotate among the various display possibilities
        case 0:
            [sheet showInView:self.view];
            break;
        case 1:
            [sheet showFromBarButtonItem:self.myTabBarItem animated:YES];
            break;
        case 2:
            [sheet showFromTabBar:self.myTabBar];
            break;
        default:
            [sheet showFromRect:self.actionSheet.bounds inView:self.actionSheet animated:YES];
    }
    _count++;
//    [sheet showFromToolbar:toolBar]; // not sure how to do this one
}

- (IBAction)tapAlertControllerAlert:(id)sender
{
    NSLog(@"alertcontroller alert");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"This is the title" message:@"Here's the message" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Action 1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"action1");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Destructive 1" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"Destructive 1");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel 1" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cacnel 1");
    }]];
    [self presentViewController:alert animated:YES completion:^() {
        NSLog(@"done with alertcontroller");
    }];
}

- (IBAction)tapAlertControllerActionSheetBarButton:(id)sender
{
    NSLog(@"alertcontroller actionsheet barbutton");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"This is the title" message:@"Here's the message" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Action 1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"action1");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Destructive 1" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"Destructive 1");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Destructive 2" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"Destructive 2");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel 1" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancel 1");
    }]];
    // NOPE - 'UIAlertController can only have one action with a style of UIAlertActionStyleCancel'
//    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel 2" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        NSLog(@"Cancel 2");
//    }]];
    UIPopoverPresentationController *popover = alert.popoverPresentationController;
    // I hope this is okay to do
    popover.barButtonItem = self.myTabBarItem;
    [self presentViewController:alert animated:YES completion:^() {
        NSLog(@"done with alertcontroller");
    }];
}

- (IBAction)tapAlertControllerActionSheetSourceView:(id)sender
{
    NSLog(@"alertcontroller actionsheet sourceview");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"This is the title" message:@"Here's the message" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Action 1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"action1");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Destructive 1" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"Destructive 1");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Destructive 2" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"Destructive 2");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel 1" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancel 1");
    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel 2" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        NSLog(@"Cancel 2");
//    }]];
    UIPopoverPresentationController *popover = alert.popoverPresentationController;
//    popover.sourceView = self.view;
    // TODO should I use something different?
//    popover.sourceRect = self.view.bounds;
//    [self.alertControllerActionSheetSource ]
//    popover.sourceRect = self.alertControllerActionSheetSource.bounds;
//    popover.sourceView = self.alertControllerActionSheetSource.viewForBaselineLayout;
    popover.sourceView = self.alertControllerActionSheetSource;
    popover.sourceRect = self.alertControllerActionSheetSource.bounds;
//    popover.sourceRect = [sender bounds];
    [self presentViewController:alert animated:YES completion:^() {
        NSLog(@"done with alertcontroller");
    }];
}

- (IBAction)tapUBSAlert:(id)sender
{
    NSLog(@"UBSAlert");
    UBSAlert *alert = [[UBSAlert alloc] initWithTitle:@"My title" message:@"And my message"];
    [alert addButtonWithTitle:@"Normal button 1" style:UBSAlertActionStyleDefault handler:^() {
        NSLog(@"UBSAlert -- normal button 1");
    }];
    [alert addButtonWithTitle:@"Destroy 1" style:UBSAlertActionStyleDestructive handler:^() {
        NSLog(@"UBSAlert -- destroy 1");
    }];
    [alert addButtonWithTitle:@"Destroy 2" style:UBSAlertActionStyleDestructive handler:^() {
        NSLog(@"UBSAlert -- destroy 2");
    }];
    [alert addButtonWithTitle:@"Cancel 1" style:UBSAlertActionStyleCancel handler:^() {
        NSLog(@"UBSAlert -- cancel 1");
    }];
/*    [alert addButtonWithTitle:@"Cancel 2" style:UBSAlertActionStyleCancel handler:^() {
        NSLog(@"UBSAlert -- cancel 2");
    }];*/
    [alert show:self animated:YES];
}

- (IBAction)tapUBSActionSheet:(id)sender
{
    NSLog(@"UBSActionSheet");
    UBSActionSheet *actionSheet = [[UBSActionSheet alloc] initWithTitle:@"My title" message:@"And my message"];
    [actionSheet addButtonWithTitle:@"Normal button 1" style:UBSActionSheetActionStyleDefault handler:^() {
        NSLog(@"UBSActionSheet -- normal button 1");
    }];
    [actionSheet addButtonWithTitle:@"Destroy 1" style:UBSActionSheetActionStyleDestructive handler:^() {
        NSLog(@"UBSActionSheet -- destroy 1");
    }];
    [actionSheet addButtonWithTitle:@"Destroy 2" style:UBSActionSheetActionStyleDestructive handler:^() {
        NSLog(@"UBSActionSheet -- destroy 2");
    }];
    [actionSheet addButtonWithTitle:@"Cancel 1" style:UBSActionSheetActionStyleCancel handler:^() {
        NSLog(@"UBSActionSheet -- cancel 1");
    }];
    /*    [alert addButtonWithTitle:@"Cancel 2" style:UBSAlertActionStyleCancel handler:^() {
     NSLog(@"UBSAlert -- cancel 2");
     }];*/
    [actionSheet showFromRect:self.ubsActionSheet.bounds inView:self.ubsActionSheet animated:YES viewController:self];
}


#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"alertView didDismiss");
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"alertView willDismiss");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alertView clickedButton");
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    NSLog(@"alertView cancel");
}


#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheet clickedButton");
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheet willDismiss");
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheet didDismiss");
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    NSLog(@"actionSheet cancel");
}

@end
