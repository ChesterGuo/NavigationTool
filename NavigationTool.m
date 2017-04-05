//
//  NavigationTool.m
//  jmg
//
//  Created by ChesterGuo on 2017/4/1.
//  Copyright © 2017年 xinyuantec. All rights reserved.
//

#import "NavigationTool.h"
#import <MapKit/MKMapItem.h>
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CLLocation.h>
#import "JMGAlertController.h"
@implementation NavigationTool
+ (instancetype)defaultNavigationTool{
    static NavigationTool *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NavigationTool alloc] init];
    });
    return shareInstance;
}
- (void)startNavigationOnViewController:(UIViewController *)con WithLatitude:(double)latitude Longitude:(double)longitude{
    self.latitude = latitude;
    self.longitude = longitude;
    [self detectionNavigationWayWithViewController:con];
}
- (void)detectionNavigationWayWithViewController:(UIViewController *)con{
    BOOL aMapCanOpen=[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]];
    BOOL baiduMapCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]];
    BOOL qqMapCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]];
    if (aMapCanOpen || baiduMapCanOpen || qqMapCanOpen) {
        NSMutableArray * mutaOptions = [NSMutableArray array];
        [mutaOptions addObject:@"内置苹果地图"];
        if (aMapCanOpen) {
            [mutaOptions addObject:@"高德地图"];
        }
        if (baiduMapCanOpen) {
            [mutaOptions addObject:@"百度地图"];
        }
        if (qqMapCanOpen) {
            [mutaOptions addObject:@"腾讯地图"];
        }
        NSArray * options = [mutaOptions copy];
        NSArray * defualtOptions = @[@"内置苹果地图",@"高德地图",@"百度地图",@"腾讯地图"];
        kWeakSelf(weakSelf);
        JMGAlertController * alert =[JMGAlertController optionAlertWithOptions:options title:@"请选择导航软件" message:nil selectedCallback:^(NSUInteger selectedIndex) {
            NSString * option = options[selectedIndex];
            NSInteger optionIndex = [defualtOptions indexOfObject:option];
            switch (optionIndex) {
                case 0:
                {
                    [weakSelf appleMapNaviHandle];
                }
                    break;
                case 1:
                {
                    [weakSelf aMapNaviHandle];
                }
                    break;
                case 2:
                {
                    [weakSelf baiduMapNaviHandle];
                }
                    break;
                case 3:
                {
                    [weakSelf qqMapNaviHandle];
                }
                    break;
                    
                default:
                {
                    [weakSelf appleMapNaviHandle];
                }
                    break;
            }

        }];
        [alert showInViewController:con];
    }else{
        [self appleMapNaviHandle];
    }
}
- (void)baiduMapNaviHandle{
    NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.latitude,self.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
}
- (void)qqMapNaviHandle{
    NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",self.latitude, self.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
- (void)aMapNaviHandle{
    NSString *urlString =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.latitude,self.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
- (void)appleMapNaviHandle{
    //使用自带地图导航
    MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];

    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.latitude,self.longitude) addressDictionary:nil]];

    [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
}
@end
