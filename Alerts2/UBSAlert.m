#import "UBSAlert.h"


@interface UBSAlert () <UIAlertViewDelegate>

@property (nonatomic) BOOL isIOS8;
@property (nonatomic, strong) NSMutableArray *handlers;
@property (nonatomic, strong) id keepInMemory;

@end


@implementation UBSAlert

// can you do destructive buttons with UIAlertView?
// can you do multiple destructive buttons with UIAlertController?
// you can only do one cancel button, right?  (in both UIAlertView and UIAlertController)
//   - UIAlertController -- can only have 1
// can the cancel button go before other buttons?
// does the cancel button show up on ipad?
// on iOS8 iPhone, if there's no cancel button, it looks like you can't get out of the modal box
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super init];
    if (self)
    {
        self.isIOS8 = [UIAlertController class] ? YES : NO;
        if (self.isIOS8)
        {
            self.alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        }
        else
        {
            self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            self.handlers = [NSMutableArray array];
            self.keepInMemory = self;
        }
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title style:(UBSAlertActionStyle)style handler:(void(^)())handler
{
    if (self.isIOS8)
    {
        UIAlertActionStyle actionStyle = [self convertActionStyle:style];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:actionStyle handler:^(UIAlertAction *action) {
            handler();
        }];
        [self.alertController addAction:action];
    }
    else
    {
        NSInteger buttonIndex = [self.alertView addButtonWithTitle:title];
        [self.handlers addObject:handler];
        if (style == UBSAlertActionStyleCancel)
        {
            self.alertView.cancelButtonIndex = buttonIndex;
        }
    }
}

- (void)show:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.isIOS8)
    {
        [viewController presentViewController:self.alertController animated:animated completion:nil];
    }
    else
    {
        [self.alertView show];
    }
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0 && buttonIndex < [self.handlers count])
    {
        void (^handler)() = self.handlers[buttonIndex];
        handler();
    }
    self.keepInMemory = nil;
}


#pragma mark - helpers

- (UIAlertActionStyle)convertActionStyle:(UBSAlertActionStyle)style
{
    switch (style)
    {
        case UBSAlertActionStyleDefault:
            return UIAlertActionStyleDefault;
        case UBSAlertActionStyleCancel:
            return UIAlertActionStyleCancel;
        case UBSAlertActionStyleDestructive:
            return UIAlertActionStyleDestructive;
    }
}


@end

