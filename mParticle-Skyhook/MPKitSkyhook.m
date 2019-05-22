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
    MPKitRegister *kitRegister = [[MPKitRegister alloc] initWithName:@"Skyhook" className:@"MPKitSkyhook"];
    [MParticle registerExtension:kitRegister];
}

#pragma mark - MPKitInstanceProtocol methods

#pragma mark Kit instance and lifecycle
- (MPKitExecStatus *)didFinishLaunchingWithConfiguration:(NSDictionary *)configuration {
    MPKitExecStatus *execStatus = nil;
    
    NSString *appKey = configuration[skyhookAPIKey];
    
    if (!appKey)
    {
        execStatus = [[MPKitExecStatus alloc] initWithSDKCode:[[self class] kitCode] returnCode:MPKitReturnCodeRequirementsNotMet];
        return execStatus;
    }
    
    _configuration = configuration;
    
    [self start];
    
    execStatus = [[MPKitExecStatus alloc] initWithSDKCode:[[self class] kitCode] returnCode:MPKitReturnCodeSuccess];
    return execStatus;
}

- (void)start
{
    static dispatch_once_t kitPredicate;
    
    dispatch_once(&kitPredicate, ^{
        self.accelerator = [[SHXAccelerator alloc] initWithKey:self.configuration[skyhookAPIKey]];
        self.accelerator.delegate = self;
        [self.accelerator startMonitoringForAllCampaigns];
        self->_started = YES;
        
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
