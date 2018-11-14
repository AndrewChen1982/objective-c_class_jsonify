//
//  DataPackage.m
//  CE_SDK_Framework
//
//  Created by Andrew Chen on 2018/4/20.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import "JSON_Serializer.h"
#import "JSON_SerializerUtility.h"


@implementation JSON_Serializer

- (instancetype)init {
    self = [super init];
    
    if(self) {
        [self onInit];
    }
    
    return self;
}

- (instancetype)initWithDataBlock:(Class<JSON_DataBlockProtocol>)datablock {
    self = [super init];
    
    if(self) {
        [self onInit];
        [self createDataBlock:datablock];
    }
    
    return self;
}

- (void) onInit {
    [self addIgnoreSerializeVar:GetiVarName(self->content)];
    [self addIgnoreSerializeVar:GetiVarName(self->code)];
    [self addIgnoreDeserializeVar:GetiVarName(self->request)];
}

- (id<JSON_DataBlockProtocol>)getDataBlock {
    return self->content;
}

- (id<JSON_DataBlockProtocol>)createDataBlock:(Class)datablock {
    return self->content = [[datablock alloc] init];
}

- (NSString *)toJsonString {
    NSString *_request = [self serialize:self->content metaClass:self->content.class];
    if(_request == NULL || [_request length] == 0) {
        self->jsonString = @"";
        return self->jsonString;
    }
    
    return self->jsonString = [NSString stringWithString:_request];
}

- (id<JSON_DataBlockProtocol>)toClassObject:(NSString*)jsonStr {
    [self deserialize:self->content metaClass:[self->content class] jsonStr:jsonStr];
    return [self getDataBlock];
}

@end
