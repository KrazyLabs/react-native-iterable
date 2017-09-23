//
//  RCTConvert+IterablePushPlatform.m
//  dealsmobile
//
//  Created by Nick Martin on 9/18/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RCTConvert+IterablePushPlatform.h"
#import <IterableSDK/IterableAPI.h>

@implementation RCTConvert (IterablePushPlatform)
RCT_ENUM_CONVERTER(PushServicePlatform, (@{
                                           @"APNS" : @(APNS),
                                           @"APNS_SANDBOX": @(APNS_SANDBOX)
                                           }), APNS, integerValue)

@end

