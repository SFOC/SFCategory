//
//  ViewController.m
//  SF_ProjectFramework
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 石峰. All rights reserved.
//

#import "ViewController.h"
#import "SFBaseNetworkAccess.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSDictionary *dic = @{@"userid":@"599cd6546219c92e9086099e"};
    [[SFBaseNetworkAccess sharedManager].showHud(YES).useCache(NO) sendGetRequestWithUrl:@"http://zhwy.mengotech.com/1.0/birdpic/getbirdpic" params:dic successBlock:^(id responseObject, NSInteger stateCode) {
        
        NSLog(@"状态吗====%zd",stateCode);
        NSLog(@"请求成功后的数据====%@",responseObject);
        NSLog(@"%@",[NSThread currentThread]);
       
    } failureBlock:^(NSError *error) {
        
        
    }];
    
//    {
//        content = "你也要坚持锻炼自己";
//        userid = 599bb40acb42aa1f69d42231;
//    }
    
//    NSDictionary *dic = @{@"content":@"你也要坚持锻炼自己dasfsa",@"userid":@"599bb40acb42aa1f69d42231"};
//    [[SFBaseNetworkAccess sharedManager] sendPostRequestWithUrl:@"http://zhwy.mengotech.com/1.0/users/addadvice" params:dic successBlock:^(id responseObject, NSInteger stateCode) {
//        
//        NSLog(@"状态吗====%zd",stateCode);
//        NSLog(@"请求成功后的数据====%@",responseObject);
//
//        
//    } failureBlock:^(NSError *error) {
//        
//        
//    }];
}


@end
