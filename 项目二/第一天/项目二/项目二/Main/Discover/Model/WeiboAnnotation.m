//
//  WeiboAnnotation.m
//  项目二
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation


//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
//    _coordinate = newCoordinate;
//}
- (void)setWeiboModel:(WeiboModel *)weiboModel {
    _weiboModel = weiboModel;
    NSDictionary *geo = weiboModel.geo;
    
    NSArray *coordinates = [geo objectForKey:@"coordinates"];
    if (coordinates.count >= 2) {
        NSString *longitude = coordinates[0];
        NSString *latitude = coordinates[1];
        //设置坐标
        _coordinate = CLLocationCoordinate2DMake([longitude floatValue], [latitude floatValue]);
    }
}
@end
