//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@class ISAuthenticationContext, ISAuthenticationResponse, ISStoreAccount, NSDictionary, NSNumber, NSString, NSURL;

@protocol ISAccountService <ISServiceRemoteObject>
//- (void)completeSetupWithResponse:(NSDictionary *)arg1 withReply:(void (^)(BOOL, NSError *))arg2;
//- (void)handlePushNotificationMessage:(NSDictionary *)arg1;
//- (void)isRegisteredForAccount:(NSNumber *)arg1 andMask:(long long)arg2 withReply:(void (^)(BOOL, NSError *, BOOL))arg3;
//- (void)disableAutoDownloadWithReply:(void (^)(BOOL, NSError *))arg1;
//- (void)enableAutoDownloadForEnvironmentNamed:(NSString *)arg1 withReply:(void (^)(BOOL, NSError *))arg2;
//- (void)getEnabledMediaTypesWithReply:(void (^)(BOOL, NSError *, long long))arg1;
//- (void)registerDeviceTokenForEnvironmentNamed:(NSString *)arg1 withReply:(void (^)(BOOL, NSError *))arg2;
//- (void)recommendedAppleIDForAccountSignIn:(void (^)(NSString *))arg1;
//- (void)iCloudDSIDReplyBlock:(void (^)(NSString *))arg1;
//- (void)setStoreFrontID:(NSString *)arg1;
//- (void)storeFrontWithReplyBlock:(void (^)(NSString *))arg1;
//- (void)shouldSendGUIDWithRequestForURL:(NSURL *)arg1 withReplyBlock:(void (^)(BOOL))arg2;
//- (void)consumeCookiesWithHTTPHeaders:(NSDictionary *)arg1 fromURL:(NSURL *)arg2;
//- (void)httpHeadersForURL:(NSURL *)arg1 forDSID:(NSNumber *)arg2 includeADIHeaders:(BOOL)arg3 withReplyBlock:(void (^)(NSDictionary *))arg4;
//- (void)removeURLBagObserver:(id <ISURLBagObserver>)arg1;
//- (void)addURLBagObserver:(id <ISURLBagObserver>)arg1;
//- (void)dictionaryWithReplyBlock:(void (^)(NSDictionary *))arg1;
//- (void)isValidWithReplyBlock:(void (^)(BOOL))arg1;
//- (void)regexWithKey:(NSString *)arg1 matchesString:(NSString *)arg2 replyBlock:(void (^)(BOOL))arg3;
//- (void)invalidateAllBags;
//- (void)loadURLBagWithType:(unsigned long long)arg1 replyBlock:(void (^)(BOOL, BOOL, NSError *))arg2;
//- (void)needsSilentADIActionForURL:(NSURL *)arg1 withReplyBlock:(void (^)(BOOL))arg2;
//- (void)urlIsTrustedByURLBag:(NSURL *)arg1 withReplyBlock:(void (^)(BOOL))arg2;
//- (void)valueForURLBagKey:(NSString *)arg1 withReplyBlock:(void (^)(id))arg2;
//- (void)updatePasswordSettings:(NSDictionary *)arg1 replyBlock:(void (^)(BOOL, NSError *))arg2;
//- (void)getPasswordSettingsWithReplyBlock:(void (^)(NSDictionary *, NSError *))arg1;
//- (void)getEligibilityForService:(NSNumber *)arg1 replyBlock:(void (^)(NSNumber *, NSError *))arg2;
//- (void)eligibilityForService:(NSNumber *)arg1 replyBlock:(void (^)(NSNumber *))arg2;
//- (void)retailStoreDemoModeReplyBlock:(void (^)(BOOL, NSString *, NSString *, BOOL))arg1;
//- (void)removeAccountStoreObserver:(id <ISAccountStoreObserver>)arg1;
//- (void)addAccountStoreObserver:(id <ISAccountStoreObserver>)arg1;
//- (void)parseCreditStringForProtocol:(NSDictionary *)arg1;
- (void)signOut;
- (void)signInWithContext:(ISAuthenticationContext * __nonnull)arg1 replyBlock:(void (^ __nonnull)(BOOL, ISStoreAccount * __nullable, NSError * __nullable))arg2;
//- (void)addAccount:(ISStoreAccount *)arg1;
//- (void)addAccountWithAuthenticationResponse:(ISAuthenticationResponse *)arg1 makePrimary:(BOOL)arg2 replyBlock:(void (^)(ISStoreAccount *))arg3;
//- (void)accountWithAppleID:(NSString *)arg1 replyBlock:(void (^)(ISStoreAccount *))arg2;
//- (void)accountWithDSID:(NSNumber *)arg1 replyBlock:(void (^)(ISStoreAccount *))arg2;
//- (void)primaryAccountWithReplyBlock:(void (^)(ISStoreAccount *))arg1;
//- (void)authIsExpiredWithReplyBlock:(void (^)(BOOL))arg1;
//- (void)strongTokenForAccount:(ISStoreAccount *)arg1 withReplyBlock:(void (^)(NSString *))arg2;
//- (void)accountsWithReplyBlock:(void (^)(NSArray *))arg1;
@end

