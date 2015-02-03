#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, UBSAlertActionStyle)
{
    UBSAlertActionStyleDefault,
    UBSAlertActionStyleCancel,
    UBSAlertActionStyleDestructive
};


@interface UBSAlert : NSObject

@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIAlertController *alertController;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (void)addButtonWithTitle:(NSString *)title style:(UBSAlertActionStyle)style handler:(void(^)())handler;
- (void)show:(UIViewController *)viewController animated:(BOOL)animated;

@end

