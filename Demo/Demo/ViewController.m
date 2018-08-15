//
//  ViewController.m
//  Demo
//
//  Created by wangpo on 2018/8/14.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "ViewController.h"
#import "SGNetworkService+Discovery.h"
#import "BFCNetworkService+User.h"
#import "SGDiscoveryListEnvelop.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.
    [[SGNetworkService defaultService] getDiscoveryList:@"" successCallback:^(id data) {
        SGDiscoveryListEnvelop *envelop = data;
       
    } failureCallback:^(NSError *error) {
        
    }];
    
    //2.
    [[SGNetworkService defaultService] bfc_postFeedBack:@"1880000000" text:@"没有意见" successCallback:^(id data) {
        
    } failureCallback:^(NSError *error) {
        
    }];
    
    //3.
    [[SGNetworkService defaultService] bfc_uploadImage:[UIImage imageNamed:@""] successCallback:^(id data) {
        
    } failureCallback:^(NSError *error) {
        
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
