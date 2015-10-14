//
//  MyModel.m
//  项目二
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "MyModel.h"
#import "RegexKitLite.h"

@implementation MyModel

- (void) setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    
    // 01 微博来源名字的处理
    if (_source != nil) {
        //.匹配除换行符以外的任意字符  +重复一次或更多次
        NSString *regex = @">.+<";
        NSArray *array = [_source componentsMatchedByRegex:regex];
        
        if (array.count != 0) {
            NSString *temp = array[0];
            temp = [temp substringWithRange:NSMakeRange(1, temp.length - 2)];
            _source = [NSString stringWithFormat:@"来源:%@",temp];
        }
    }
    
    //用户信息解析
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
        _userModel = [[UserModel alloc] initWithDataDic:userDic];
    }
    //被转发的微博
    NSDictionary *retweeted_status = [dataDic objectForKey:@"retweeted_status"];
    if (retweeted_status != nil) {
        _reWeiboModel = [[WeiboModel alloc] initWithDataDic:retweeted_status];
        
        //02 转发微博的用户名字处理，拼接字符串
        NSString *name = _reWeiboModel.userModel.name;
        _reWeiboModel.text = [NSString stringWithFormat:@"@%@:%@",name,_reWeiboModel.text];
    }

    //03 表情处理
    
    //    1 找到微博中表示表情的字符串
    NSString *regex = @"\\[\\w+\\]";
    NSArray *faceItems = [_text componentsMatchedByRegex:regex];
    //    NSLog(@"%@",faceItems);
    //2 在plist文件中找到对应的png
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"emoticons.plist" ofType:nil];
    //存有plist的文件
    NSArray *faceConfigArray = [NSArray arrayWithContentsOfFile:configPath];
    
    for (NSString *faceName in faceItems) {
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        //使用谓词过滤
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        
        NSArray *items = [faceConfigArray filteredArrayUsingPredicate:predicate];
        
        if (items.count >0) {
            NSDictionary *faceDic = items[0];
            //取得图片的名字
            NSString *imageName = [faceDic objectForKey:@"png"];
            
            //<image url = '1.png'>
            NSString *replaceString = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            
            //将原微博中的［兔子］替换成<image url = '001.png'>
            self.text = [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceString];
        }
    }
}


@end
