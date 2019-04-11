#import <Foundation/Foundation.h>
#if defined(__has_include) && __has_include(<mParticle_Apple_SDK/mParticle.h>)
#import <mParticle_Apple_SDK/mParticle.h>
#else
#import "mParticle.h"
#endif

#if defined(__has_include) && __has_include(<SkyhookContext/SHXAccelerator.h>)
#import <SkyhookContext/SHXAccelerator.h>
#else
#import "SHXAccelerator.h"
#endif

@interface MPKitSkyhook : NSObject <MPKitProtocol, SHXAcceleratorDelegate>

@property (nonatomic, strong, nonnull) NSDictionary *configuration;
@property (nonatomic, strong, nullable) NSDictionary *launchOptions;
@property (nonatomic, unsafe_unretained, readonly) BOOL started;
@property (nonatomic, strong, nullable) NSDictionary<NSString *, id> *userAttributes;
@property (nonatomic, strong, nullable) NSArray<NSDictionary<NSString *, id> *> *userIdentities;

@end
