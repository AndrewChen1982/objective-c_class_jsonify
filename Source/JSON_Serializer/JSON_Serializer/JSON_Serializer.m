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

- (JSON_DataBlock *)getDataBlock {
    return self->content;
}

- (JSON_DataBlock *)createDataBlock:(Class)datablock {
    return self->content = [[datablock alloc] init];
}

- (NSString *)toJsonString {
    NSString *_request = [self->content serialize:self->content.class];
    if(_request == NULL || [_request length] == 0) {
        self->request = @"";
        return self->request;
    }
    
    self->request = [NSString stringWithString:_request];
    return self->request;
}

- (JSON_Serializer *)deserialize:(NSString *) jsonStr {
    [self->content deserialize:jsonStr];
    return self;
}

//- (void)preSerialize {
//    NSString *_request = [self->content serialize:self->content.class];
//    if(_request == NULL || [_request length] == 0) {
//        self->request = @"";
//        return;
//    }
//
//    self->request = [NSString stringWithString:_request];
//}

//- (NSString *)toJsonString {
//    [self preSerialize];
//    return [self serialize:self.class];
//}

@end
