//
//  ViewController.m
//  JSON_SerializerTester
//
//  Created by Andrew Chen on 2018/11/13.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import "ViewController.h"
#import "TestForJSON_Serializer.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestForJSON_Serializer *jszer = [[TestForJSON_Serializer alloc] init];
    //DO serialize
    NSString *jsonStr = [jszer jsonify];
    
    //Do deserialize
    [jszer deserialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
