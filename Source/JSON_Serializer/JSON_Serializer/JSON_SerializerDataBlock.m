//
//  JSON_Serializer.m
//  JSON_Serializer
//
//  Created by Andrew Chen on 2018/11/13.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import <objc/runtime.h>
#import "JSON_SerializerCategories.h"
#import "JSON_Serializer.h"
#import "JSON_SerializerUtility.h"

@implementation JSON_DataBlock
const static NSDictionary *InternalIgnoreTab;

- (instancetype)init {
    self = [super init];
    InternalIgnoreTab = @{GetiVarName(self->iVarCollection):@(true),
                          GetiVarName(self->ignoreSerializeTab):@(true),
                          GetiVarName(self->ignoreDeserializeTab):@(true)
                          };
    self->iVarCollection = [[NSMutableDictionary alloc] init];
    self->ignoreSerializeTab = [[NSMutableDictionary alloc] init];
    self->ignoreDeserializeTab = [[NSMutableDictionary alloc] init];
    return self;
}

- (JSON_DataBlock *)addIgnoreSerializeVar:(NSString *)iVarName {
    [self->ignoreSerializeTab setObject:@(true) forKey:iVarName];
    return self;
}

- (JSON_DataBlock *)addIgnoreDeserializeVar:(NSString *)iVarName {
    [self->ignoreDeserializeTab setObject:@(true) forKey:iVarName];
    return self;
}

- (NSString *const)serialize:(Class)metaClass {
    static unsigned int count;
    Ivar* ivars = class_copyIvarList(metaClass, &count);
    for(unsigned int i = 0; i < count; ++i)
    {
        Ivar ivar = ivars[i];
        const char *ivarType = ivar_getTypeEncoding(ivar);
        const char *varName = ivar_getName(ivar);
        
        if(InternalIgnoreTab[@(varName)]) {
            continue;
        }
        
        if(self->ignoreSerializeTab[@(varName)]) {
            continue;
        }
        
        if(strcmp(ivarType, "i") == 0) {
            int varVal = ((int (*)(id, Ivar))object_getIvar)(self, ivar);
            [self->iVarCollection setObject:@(varVal) forKey:@(varName)];
            continue;
        }
        
        NSString *varVal = object_getIvar(self, ivar);
        
        [self->iVarCollection setObject:varVal forKey:@(varName)];
    }
    free(ivars);
    
    Class superClazz = class_getSuperclass(metaClass);
    SEL selector = @selector(serialize:);
    
    if(class_respondsToSelector(superClazz, selector)) {
        return [self performSelector:selector withObject:superClazz];
    }
    
    return [self->iVarCollection toJSONString:0];
}

- (void)assignData:(id)currentObj itemOfJson:(id)item forKey:(NSString *)key {
    
    static char const Iter = -1;
    static char const Skip = 0;
    static char const Exec = 1;
    
    static void (^onSetValue)(void);
    static char (^isValidType)(__weak id, NSString *, __weak id, Ivar);
    
    if(!isValidType) {
        isValidType = ^char(__weak JSON_DataBlock *tarObj, __weak NSString *tarKey, __weak id elementOfJson, __weak Ivar tarIvar) {
            if(!elementOfJson) {
                return Skip;
            }
            
            __block __weak id item4set = elementOfJson;
            __block __weak id object4set = tarObj;
            __block __weak NSString *key4set = tarKey;
            
            onSetValue = ^void () {
                [object4set setValue:item4set forKey:key4set];
            };
            
            const char *typeString = ivar_getTypeEncoding(tarIvar);
            if(!typeString) {
                return Skip;
            }
            
            NSString *iVarType = [NSString stringWithUTF8String:typeString];
            
            if([iVarType containsString:@"NSObject"]) {
                
                if ([elementOfJson isKindOfClass:NSDictionary.class]) {
                    //                    onSetValue = something;
                    return Iter;
                }
                
                if ([elementOfJson isKindOfClass:NSString.class] ||
                    [elementOfJson isKindOfClass:NSArray.class]) {
                    //                    onSetValue = something;
                    return Exec;
                }
            }
            
            if([iVarType containsString:@"Dictionary"]) {
                if([elementOfJson isKindOfClass:NSDictionary.class]) {
                    //                    onSetValue = something;
                    return Exec;
                }
            }
            
            if([iVarType containsString:@"Array"]) {
                if([elementOfJson isKindOfClass:NSArray.class]) {
                    //                    onSetValue = something;
                    return Exec;
                }
            }
            
            if([iVarType containsString:@"String"]) {
                if([elementOfJson isKindOfClass:NSString.class]) {
                    //                    onSetValue = something;
                    return Exec;
                }
            }
            
            if([iVarType isEqualToString: [NSString stringWithFormat:@"%c", _C_INT]]) {
                if([elementOfJson isKindOfClass:NSNumber.class]) {
                    return Exec;
                }
            }
            
            if([iVarType isEqualToString: [NSString stringWithFormat:@"%c", _C_FLT]]) {
                if( [elementOfJson isKindOfClass:NSNumber.class]) {
                    return Exec;
                }
            }
            
            if([iVarType isEqualToString: [NSString stringWithFormat:@"%c", _C_BOOL]]) {
                if([elementOfJson isKindOfClass:NSNumber.class]) {
                    return Exec;
                }
            }
            
            return Skip;
        };
    }
    
    Ivar tarIvar = class_getInstanceVariable([currentObj class], [key UTF8String]);
    if(!tarIvar) {
        return;
    }
    
    char result = isValidType(currentObj, key, item, tarIvar);
    if(result == Skip) {
        return;
    }
    
    if(result == Iter) {
        id fetchedObj = object_getIvar(currentObj, tarIvar);
        if(!fetchedObj) {
            return;
        }
        
        for (NSString* nextKey in item) {
            Ivar iVarNext = class_getInstanceVariable([fetchedObj class], [nextKey UTF8String]);
            if(!iVarNext) {
                continue;
            }
            
            id nextItem = [item objectForKey:nextKey];
            [self assignData:fetchedObj itemOfJson:nextItem forKey:nextKey];
        }
        return;
    }
    
    if(!onSetValue) {
        return;
    }
    
    onSetValue();
}

- (id<JSON_DataBlockProtocol>)deserialize:(NSString *)jsonStr {
    NSDictionary *jsonObj = [jsonStr toJsonObject];
    
    if (!jsonObj) {
        return self;
    }
    
    for (NSString* key in jsonObj) {
        
        if(InternalIgnoreTab[key]) {
            continue;
        }
        
        if(self->ignoreDeserializeTab[key]) {
            continue;
        }
        
        id item = [jsonObj objectForKey:key];
        
        [self assignData:self itemOfJson:item forKey:key];
    }
    
    return self;
}

@end
