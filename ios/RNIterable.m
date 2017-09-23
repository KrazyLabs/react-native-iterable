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

@implementation RNIterable {
    IterableAPI *_sharedInstance;
}

NSString *ERROR_NO_SHARED_INSTANCE = @"ERROR_NO_SHARED_INSTANCE";


RCT_EXPORT_MODULE(RNIterable)

RCT_REMAP_METHOD(sharedInstanceWithApiKey,
                 sharedInstanceWithApiKey:(NSString *)apiKey
                 andEmail:(NSString *) email
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    if(apiKey == nil){
        reject(@"ERROR_API_KEY_NULL", @"Iterable API key must be provided.", nil);
        return;
    }
    
    if(email == nil){
        reject(@"ERROR_EMAIL_NULL", @"User email must be provided.", nil);
        return;
    }
    
    if(_sharedInstance == nil){
        _sharedInstance = [IterableAPI sharedInstanceWithApiKey:apiKey andEmail:email launchOptions:nil];
    }else{
        [IterableAPI clearSharedInstance];
        _sharedInstance = [IterableAPI sharedInstanceWithApiKey:apiKey andEmail:email launchOptions:nil];
    }
    
    if(_sharedInstance){
        resolve([self createSuccessMessage:@"success"]);
    }else{
        reject(ERROR_NO_SHARED_INSTANCE, @"Error creating shared IterableApi instance.", nil);
    }
}


RCT_EXPORT_METHOD(clearSharedInstance)
{
    if(_sharedInstance){
        [IterableAPI clearSharedInstance];
    }
}

RCT_REMAP_METHOD(registerToken,
                 registerToken:(NSString *)token
                 appName:(NSString *)appName
                 pushServicePlatform:(PushServicePlatform)pushServicePlatform
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    if(_sharedInstance){
        NSData *tokenData = [self dataFromHexString:token];
        [[IterableAPI sharedInstance]registerToken:tokenData appName:appName pushServicePlatform:pushServicePlatform onSuccess:^(NSDictionary * _Nonnull data) {
            resolve([self createSuccessMessage:@"success"]);
        } onFailure:^(NSString * _Nonnull reason, NSData * _Nonnull data) {
            reject(@"ERROR_REGISTER_DEVICE", reason, nil);
        }];
    }else{
        reject(ERROR_NO_SHARED_INSTANCE, @"Attempted to called 'registerToken' before 'sharedInstanceWithApiKey'.", nil);
    }
}

RCT_REMAP_METHOD(disableDeviceForCurrentUser,
                 disableDeviceForCurrentUserWithResolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    if(_sharedInstance){
        [[IterableAPI sharedInstance]disableDeviceForCurrentUserWithOnSuccess:^(NSDictionary * _Nonnull data) {
            resolve([self createSuccessMessage:@"success"]);
        } onFailure:^(NSString * _Nonnull reason, NSData * _Nonnull data) {
            reject(@"ERROR_DISABLE_USER_DEVICE", reason, nil);
        }];
    }else{
        reject(ERROR_NO_SHARED_INSTANCE, @"Attempted to called 'disableDeviceForCurrentUser' before 'sharedInstanceWithApiKey'.", nil);
    }
}

RCT_REMAP_METHOD(disableDeviceForAllUsers,
                 disableDeviceForAllUsersWithResolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    if(_sharedInstance){
        [[IterableAPI sharedInstance]disableDeviceForAllUsersWithOnSuccess:^(NSDictionary * _Nonnull data) {
            resolve([self createSuccessMessage:@"success"]);
        } onFailure:^(NSString * _Nonnull reason, NSData * _Nonnull data) {
            reject(@"ERROR_DISABLE_ALL_USER_DEVICE", reason, nil);
        }];
    }else{
        reject(ERROR_NO_SHARED_INSTANCE, @"Attempted to called 'disableDeviceForAllUsers' before 'sharedInstanceWithApiKey'.", nil);
    }
}

RCT_REMAP_METHOD(trackPushOpenWithNotification,
                 trackPushOpenWithNotification:(NSDictionary *)userInfo
                 dataFields:(NSDictionary *)dataFields
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    if(_sharedInstance){
        [[IterableAPI sharedInstance]trackPushOpen:userInfo dataFields:dataFields onSuccess:^(NSDictionary * _Nonnull data) {
            resolve([self createSuccessMessage:@"success"]);
        } onFailure:^(NSString * _Nonnull reason, NSData * _Nonnull data) {
            reject(@"ERROR_TRACK_PUSH_OPEN", reason, nil);
        }];
    }else{
        reject(ERROR_NO_SHARED_INSTANCE, @"Attempted to called 'trackPushOpenWithNotification' before 'sharedInstanceWithApiKey'.", nil);
    }
}


RCT_REMAP_METHOD(trackPushOpenWithCampaignId,
                 trackPushOpenWithCampaignId:(NSNumber * _Nonnull)campaignId
                 templateId:(NSNumber * _Nonnull)templateId
                 messageId:(NSString *)messageId
                 appAlreadyRunning:(BOOL)appRunning
                 dataFields:(NSDictionary * _Nullable)dataFields
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    
    if(_sharedInstance) {
        [[IterableAPI sharedInstance]trackPushOpen:campaignId templateId:templateId messageId:messageId appAlreadyRunning:appRunning dataFields:dataFields onSuccess:^(NSDictionary * _Nonnull data) {
            resolve([self createSuccessMessage:@"success"]);
        } onFailure:^(NSString * _Nonnull reason, NSData * _Nonnull data) {
            reject(@"ERROR_TRACK_PUSH_OPEN", reason, nil);
        }];
    }else{
        reject(ERROR_NO_SHARED_INSTANCE, @"Attempted to called 'trackPushOpenWithCampaignId' before 'sharedInstanceWithApiKey'.", nil);
    }
}


// export enum constants
- (NSDictionary *)constantsToExport
{
    return @{ @"APNS" : @(APNS), @"APNS_SANDBOX" : @(APNS_SANDBOX)};
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

- (NSDictionary *)createSuccessMessage:(NSString *)message {
    return @{@"msg" : message};
}



@end

