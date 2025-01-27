//
//  PreKeyRecord.m
//  AxolotlKit
//
//  Created by Frederic Jacobs on 26/07/14.
//  Copyright (c) 2014 Frederic Jacobs. All rights reserved.
//

#import "PreKeyRecord.h"

static NSString* const kCoderPreKeyId        = @"kCoderPreKeyId";
static NSString* const kCoderPreKeyPair      = @"kCoderPreKeyPair";
static NSString* const kCoderCreatedAt       = @"kCoderCreatedAt";

@implementation PreKeyRecord

+ (BOOL)supportsSecureCoding{
    return YES;
}

- (instancetype)initWithId:(int)identifier
                   keyPair:(ECKeyPair*)keyPair
                 createdAt:(NSDate *)createdAt
{
    OWSAssert(keyPair);

    self = [super init];
    
    if (self) {
        _Id      = identifier;
        _keyPair = keyPair;
        _createdAt = createdAt;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithId:[aDecoder decodeIntForKey:kCoderPreKeyId]
                    keyPair:[aDecoder decodeObjectOfClass:[ECKeyPair class] forKey:kCoderPreKeyPair]
                  createdAt:[aDecoder decodeObjectOfClass:[NSDate class] forKey:kCoderCreatedAt]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_Id forKey:kCoderPreKeyId];
    [aCoder encodeObject:_keyPair forKey:kCoderPreKeyPair];
    if (_createdAt != nil) {
        [aCoder encodeObject:_createdAt forKey:kCoderCreatedAt];
    }
}

- (void)setCreatedAtToNow {
    _createdAt = [NSDate date];
}

@end
