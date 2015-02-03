#import "UBSActionSheet.h"


@interface UBSActionSheet () <UIActionSheetDelegate>

@property (nonatomic) BOOL isIOS8;
@property (nonatomic, strong) NSMutableArray *handlers;

@end


@implementation UBSActionSheet

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super init];
    if (self)
    {
        self.isIOS8 = [UIAlertController class] ? YES : NO;
        if (self.isIOS8)
        {
            self.alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        }
        else
        {
            self.actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
            self.handlers = [NSMutableArray array];
        }
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title style:(UBSActionSheetActionStyle)style handler:(void(^)())handler
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
        NSInteger buttonIndex = [self.actionSheet addButtonWithTitle:title];
        [self.handlers addObject:handler];
        if (style == UBSActionSheetActionStyleCancel)
        {
            self.actionSheet.cancelButtonIndex = buttonIndex;
        }
        else if (style == UBSActionSheetActionStyleDestructive)
        {
            self.actionSheet.destructiveButtonIndex = buttonIndex;
        }
    }
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated viewController:(UIViewController *)viewController
{
    if (self.isIOS8)
    {
        UIPopoverPresentationController *popover = self.alertController.popoverPresentationController;
        if (popover)
        {
            popover.barButtonItem = item;
        }
        [viewController presentViewController:self.alertController animated:animated completion:nil];
    }
    else
    {
        [self.actionSheet showFromBarButtonItem:item animated:animated];
    }
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated viewController:(UIViewController *)viewController
{
    if (self.isIOS8)
    {
        UIPopoverPresentationController *popover = self.alertController.popoverPresentationController;
        if (popover)
        {
            popover.sourceRect = rect;
            popover.sourceView = view;
        }
        [viewController presentViewController:self.alertController animated:animated completion:nil];
    }
    else
    {
        [self.actionSheet showFromRect:rect inView:view animated:animated];
    }
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0 && buttonIndex < [self.handlers count])
    {
        void (^handler)() = self.handlers[buttonIndex];
        handler();
    }
}


#pragma mark - helpers

- (UIAlertActionStyle)convertActionStyle:(UBSActionSheetActionStyle)style
{
    switch (style)
    {
        case UBSActionSheetActionStyleDefault:
            return UIAlertActionStyleDefault;
        case UBSActionSheetActionStyleCancel:
            return UIAlertActionStyleCancel;
        case UBSActionSheetActionStyleDestructive:
            return UIAlertActionStyleDestructive;
    }
}

@end
