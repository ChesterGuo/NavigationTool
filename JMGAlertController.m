//
//  JMGAlertController.m
//  jmg_merchant
//
//  Created by ChesterGuo on 2017/2/22.
//  Copyright © 2017年 xinyuantec. All rights reserved.
//

#import "JMGAlertController.h"

@interface JMGAlertController ()

@end

@implementation JMGAlertController
{
    UITapGestureRecognizer * _tap;
}
+ (instancetype)alertWithTitle:(NSString *)title
                   message:(NSString *)message
                 leftStyle:(UIAlertActionStyle)lStyle
                 leftTitle:(NSString *)lTitle
                rightStyle:(UIAlertActionStyle)rStyle
                rightTitle:(NSString *)rTitle
               leftHandler:(void (^)(UIAlertAction *action))lHandler
              rightHandler:(void (^)(UIAlertAction *action))rHandler{
    JMGAlertController *alertController = [JMGAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:lTitle style:lStyle handler:lHandler];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rTitle style:rStyle handler:rHandler];

    [alertController addAction:leftAction];
    [alertController addAction:rightAction];
    return alertController;
}
+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message{
    JMGAlertController *alertController = [JMGAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    return alertController;
}
+ (instancetype)cancleAlertWithTitle:(NSString *)title
                  handler:(void (^)(UIAlertAction *action))handler{
    JMGAlertController *alertController = [JMGAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];

    [alertController addAction:leftAction];
    [alertController addAction:rightAction];
    return alertController;
}
+ (instancetype)deleteAlertWithTitle:(NSString *)title
                             handler:(void (^)(UIAlertAction *action))handler{
    JMGAlertController *alertController = [JMGAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:handler];

    [alertController addAction:leftAction];
    [alertController addAction:rightAction];
    return alertController;
}
+ (instancetype)optionAlertWithOptions:(NSArray *)options
                                 title:(NSString *)title
                               message:(NSString *)message
                      selectedCallback:(void (^)(NSUInteger selectedIndex))callback{
    JMGAlertController *alertController = [JMGAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString * option in options) {
        if (option.hasValue) {
            UIAlertAction *optionAction = [UIAlertAction actionWithTitle:option style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (callback) {
                    callback([options indexOfObject:option]);
                }
            }];
            [alertController addAction:optionAction];
        }
    }
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancleAction];

    return alertController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showInViewController:(UIViewController *)con{
    [con presentViewController:self animated:YES completion:nil];
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancle)];
    }
    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:_tap];
}
- (void)cancle{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication].keyWindow removeGestureRecognizer:_tap];
}
- (void)dealloc{
    if (_tap) {
        [[UIApplication sharedApplication].keyWindow removeGestureRecognizer:_tap];
        _tap = nil;
    }
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
