//
//  TestForJSON_Serializer.h
//  JSON_SerializerTester
//
//  Created by Andrew Chen on 2018/11/13.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON_Serializer/JSON_Serializer.h"

@interface UserDataBlock : JSON_DataBlock
{
@public
    NSString *userID;
    NSString *phoneNumber;
}

//
+ (NSString *)userID;
- (NSString *)userID;
- (void)setUserID:(NSString *)value;

//
+ (NSString *)phoneNumber;
- (NSString *)phoneNumber;
- (void)setPhoneNumber:(NSString *)value;
@end

@interface TestForJSON_Serializer : NSObject

- (NSString *)jsonify;
- (void)deserialize;

@end
