//
//  MPKitCompanyName.m
//
//  Copyright 2016 mParticle, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "MPKitSkyhook.h"

static NSString* skyhookAPIKey = @"apiKey";

@interface MPKitSkyhook ()

@property (strong, nonatomic) SHXAccelerator* accelerator;

@end

@implementation MPKitSkyhook


+ (NSNumber *)kitCode {
    return @(MPKitInstanceSkyhook);
}

+ (void)load {
    MPKitRegister *kitRegister = [[MPKitRegister alloc] initWithName:@"Skyhook" className:@"MPKitSkyhook" startImmediately:YES];
    [MParticle registerExtension:kitRegister];
}

#pragma mark - MPKitInstanceProtocol methods

#pragma mark Kit instance and lifecycle
- (nonnull instancetype)initWithConfiguration:(nonnull NSDictionary *)configuration startImmediately:(BOOL)startImmediately
{
    self = [super init];
    NSString *appKey = configuration[skyhookAPIKey];

    if (!self || !appKey)
    {
        return nil;
    }

    _configuration = configuration;

    if (startImmediately)
    {
        [self start];
    }

    return self;
}

- (void)start
{
    static dispatch_once_t kitPredicate;

    dispatch_once(&kitPredicate, ^{
        self.accelerator = [[SHXAccelerator alloc] initWithKey:self.configuration[skyhookAPIKey]];
        self.accelerator.delegate = self;
        [self.accelerator startMonitoringForAllCampaigns];
        _started = YES;

        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *userInfo = @{mParticleKitInstanceKey:[[self class] kitCode]};

            [[NSNotificationCenter defaultCenter] postNotificationName:mParticleKitDidBecomeActiveNotification
                                                                object:nil
                                                              userInfo:userInfo];
        });
    });
}

- (id const)providerKitInstance {
    if (![self started]) {
        return nil;
    }
    return self.accelerator;
}

@end
