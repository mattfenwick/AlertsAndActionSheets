#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


// does it matter, which view you use to display a UIActionSheet on an iphone?  (guess: no)

typedef NS_ENUM(NSInteger, UBSActionSheetActionStyle)
{
    UBSActionSheetActionStyleDefault,
    UBSActionSheetActionStyleCancel,
    UBSActionSheetActionStyleDestructive
};


@interface UBSActionSheet : NSObject

@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIAlertController *alertController;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (void)addButtonWithTitle:(NSString *)title style:(UBSActionSheetActionStyle)style handler:(void(^)())handler;
- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated viewController:(UIViewController *)viewController;
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated viewController:(UIViewController *)viewController;

@end
