//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//
@import Foundation;

#import "NSUserNotification_Private.h"

#import "ISStoreAccount.h"

#import "CKAccountStore.h"
#import "CKDownloadQueue.h"
#import "CKPurchaseController.h"
#import "CKSoftwareMap.h"
#import "CKUpdateController.h"

#import "CKUpdate.h"
#import "SSDownload.h"
#import "SSDownloadMetadata.h"
#import "SSDownloadPhase.h"
#import "SSDownloadStatus.h"
#import "SSPurchaseResponse.h"
#import "ISStoreClient.h"
#import "ISAuthenticationContext.h"
#import "ISServiceRemoteObject-Protocol.h"
#import "ISAccountService-Protocol.h"
#import "ISServiceProxy.h"

@protocol CKDownloadQueueObserver

- (void)downloadQueue:(CKDownloadQueue *)downloadQueue changedWithAddition:(SSDownload *)download;
- (void)downloadQueue:(CKDownloadQueue *)downloadQueue changedWithRemoval:(SSDownload *)download;
- (void)downloadQueue:(CKDownloadQueue *)downloadQueue statusChangedForDownload:(SSDownload *)download;

@end

NSString* CKDownloadDirectory(NSString *target);

