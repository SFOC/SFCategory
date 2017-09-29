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
    [[SFBaseNetworkAccess sharedManager] sendGetRequestWithUrl:@"http://zhwy.mengotech.com/1.0/birdpic/getbirdpic" params:dic successBlock:^(id responseObject, NSInteger stateCode) {
        
        NSLog(@"状态吗====%zd",stateCode);
        NSLog(@"请求成功后的数据====%@",responseObject);
    } failureBlock:^(NSError *error) {
        
        
    }];
}


@end
