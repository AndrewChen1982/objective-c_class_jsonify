//
//  TestForJSON_Serializer.m
//  JSON_SerializerTester
//
//  Created by Andrew Chen on 2018/11/13.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import "TestForJSON_Serializer.h"


@implementation UserDataBlock
static NSString *_userID;
static NSString *_phoneNumber;

//
+ (NSString *)userID {
    return _userID;
}
- (NSString *)userID {
    return _userID;
}

- (void)setUserID:(NSString *)newValue {
    self->userID = _userID = [NSString stringWithString: newValue];
}

+ (NSString *)phoneNumber {
    return _phoneNumber;
}

- (NSString *)phoneNumber {
    return _phoneNumber;
}

- (void)setPhoneNumber:(NSString *)newValue {
    self->phoneNumber = _phoneNumber = [NSString stringWithString: newValue];
}

@end

@implementation TestForJSON_Serializer

- (NSString *)jsonify { 
    JSON_Serializer<UserDataBlock *> *package = [[JSON_Serializer alloc] initWithDataBlock:[UserDataBlock class]];
    UserDataBlock *db = [package getDataBlock];
    db->userID = @"9876543";
    db->phoneNumber = @"0987654321";
    
    NSString *jsonStr =[package toJsonString];
    NSLog(@"Serialize:\n\tDatablock Jsonify: %@\n\n%@", jsonStr, @"_");
    
    return jsonStr;
}

- (void)deserialize {
    JSON_Serializer<UserDataBlock *> *package = [[JSON_Serializer alloc] initWithDataBlock:[UserDataBlock class]];
    [package deserialize:@"{\"userID\":\"5551236\",\"phoneNumber\":\"02222667222\"}"];
    
    NSLog(@"Deserialize:\n\tUserDataBlock.UserID: %@, UserDataBlock.PhoneNumber: %@",
          [UserDataBlock userID], [UserDataBlock phoneNumber]);
}

@end
