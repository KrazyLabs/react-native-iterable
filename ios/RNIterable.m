//
//  RNIterable.m
//  dealsmobile
//
//  Created by Nick Martin on 9/18/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNIterable.h"
#import <React/RCTConvert.h>
#import <IterableSDK/IterableAPI.h>

@implementation RNIterable

RCT_EXPORT_MODULE(RNIterable)

RCT_EXPORT_METHOD(sharedInstanceWithApiKey:(NSString *)apiKey andEmail:(NSString *) email)
{
    [IterableAPI sharedInstanceWithApiKey:apiKey andEmail:email launchOptions:nil];
}

RCT_EXPORT_METHOD(registerToken:(NSString *)token appName:(NSString *)appName pushServicePlatform:(PushServicePlatform)pushServicePlatform)
{
    NSData *tokenData = [self dataFromHexString:token];
    [[IterableAPI sharedInstance]registerToken:tokenData appName:appName pushServicePlatform:pushServicePlatform];
}

// export enum constants
- (NSDictionary *)constantsToExport
{
    return @{ @"apns" : @(APNS), @"apnsSandbox" : @(APNS_SANDBOX)};
}

- (NSData *)dataFromHexString:(NSString *)string
{
    NSMutableData *stringData = [NSMutableData new];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [string length] / 2; i++) {
        byte_chars[0] = [string characterAtIndex:i*2];
        byte_chars[1] = [string characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1];
    }
    return stringData;
}

@end
