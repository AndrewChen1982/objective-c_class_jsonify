# Objective-C Class object jsonify
It's a jsonify tool for JSON string to class object and Class Object to JSON string.

## How to use:

1. Copy libJSON_Serializer.a and JSON_Serializer.h to your library and Header search folder.

2. Set your project build setting's "Other Linker Flags" for "-objC"
![foo](/ScreenShot1.png "set -objC")

3.  Set your project build setting's "Header/Library Search Path" for "your own path"
![foo](/ScreenShot2.png "set path")

## Code implement:
* Let your Class adopts protocol "JSON_DataBlockProtocol". - [Code Link][bar]

[bar]: /Source/JSON_SerializerTester/JSON_SerializerTester/TestForJSON_Serializer.h#L12-L28
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

* Call "toJsonString" to make jsonify happen. - [Code Link][bar]

[bar]: /Source/JSON_SerializerTester/JSON_SerializerTester/TestForJSON_Serializer.m#L44-L54
```objective-c
- (NSString *)jsonify { 
    
    JSON_Serializer<UserDataBlock *> *package = [[JSON_Serializer alloc] initWithDataBlock:[UserDataBlock class]];
    UserDataBlock *db = [package getDataBlock];
    db->userID = @"9876543";
    db->phoneNumber = @"0987654321";
    
    NSString *jsonStr =[package toJsonString];   
    return jsonStr;
}
```

* Call "toClassObject" to restore JSON string to Class object. - [Code Link][bar]

[bar]: /Source/JSON_SerializerTester/JSON_SerializerTester/TestForJSON_Serializer.m#L56-L63
```objective-c
- (void)deserialize {
    
    JSON_Serializer<UserDataBlock *> *package = [[JSON_Serializer alloc] initWithDataBlock:[UserDataBlock class]];
    NSString *jsonStr = @"{\"userID\":\"5551236\",\"phoneNumber\":\"02222667222\",\"birthday\":\"2018.01.01\"}";
    [package toClassObject:jsonStr];
    
    UserDataBlock *db = [package getDataBlock];
}
```
## If any variable you don't to jsonify or deserialize
* call addIgnoreSerializeVar:iVarName
* call addIgnoreDeserializeVar:iVarName

## End.
