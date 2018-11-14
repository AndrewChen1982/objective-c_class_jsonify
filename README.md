# Objective-C Class object jsonify
It's a jsonify tool for JSON string to class object and Class Object to JSON string.

## How to use

1. Copy libJSON_Serializer.a and JSON_Serializer.h to your library and Header search folder.

2. Set your project build setting's "Other Linker Flags" for "-objC"
![foo](/ScreenShot1.png "set -objC")

3.  Set your project build setting's "Header/Library Search Path" for "your own path"
![foo](/ScreenShot2.png "set path")

4. Let your Class adopts protocol "JSON_DataBlockProtocol"
```objective-c
@interface UserDataBlock : NSObject<JSON_DataBlockProtocol>
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
```
