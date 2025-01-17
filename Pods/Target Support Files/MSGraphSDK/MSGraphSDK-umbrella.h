#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MSGraphSDK.h"
#import "MSAuthenticationProvider.h"
#import "MSGraphSDKVersion.h"
#import "MSHttpProvider.h"
#import "MSLoggerProtocol.h"
#import "MSGraphClient+DefaultConfiguration.h"
#import "MSGraphClientConfiguration+DefaultConfiguration.h"
#import "NSError+MSGraphSDK.h"
#import "MSNSURLSessionTaskDelegate.h"
#import "MSURLSessionManager.h"
#import "MSBlockAuthenticationProvider.h"
#import "MSLogger.h"
#import "MSCollection.h"
#import "MSCollectionRequest.h"
#import "MSCollectionRequestBuilder.h"
#import "MSConstants.h"
#import "MSDate.h"
#import "MSGraphClientConfiguration.h"
#import "MSObject.h"
#import "MSRequest.h"
#import "MSRequestBuilder.h"
#import "MSAsyncURLSessionDataTask.h"
#import "MSURLSessionDataTask.h"
#import "MSURLSessionDownloadTask.h"
#import "MSURLSessionProgressTask.h"
#import "MSURLSessionTask+Protected.h"
#import "MSURLSessionTask.h"
#import "MSURLSessionUploadTask.h"
#import "ODataBaseClient.h"
#import "MSExpandOptions.h"
#import "MSFunctionParameters.h"
#import "MSHeaderOptions.h"
#import "MSIfMatch.h"
#import "MSIfNoneMatch.h"
#import "MSNameConflict.h"
#import "MSOrderByOptions.h"
#import "MSQueryParameters.h"
#import "MSRequestOptions.h"
#import "MSRequestOptionsBuilder.h"
#import "MSSelectOptions.h"
#import "MSTopOptions.h"
#import "MSError.h"
#import "MSErrorCodes.h"
#import "MSGraphClient+Base.h"
#import "MSGraphDriveItemRequestBuilder+ItemByPath.h"
#import "MSGraphDriveSpecialCollectionRequestBuilder+KnownFolders.h"
#import "MSGraphThumbnailSet+CustomThumbnail.h"
#import "MSGraphUserMailFoldersCollectionRequestBuilder+KnownFolders.h"
#import "NSArray+MSSerialization.h"
#import "NSDate+MSSerialization.h"
#import "NSJSONSerialization+ResponseHelper.h"
#import "MSGraphAlternativeSecurityId.h"
#import "MSGraphAssignedLicense.h"
#import "MSGraphAssignedPlan.h"
#import "MSGraphAttachment.h"
#import "MSGraphAttendee.h"
#import "MSGraphAttendeeType.h"
#import "MSGraphAudio.h"
#import "MSGraphBodyType.h"
#import "MSGraphCalendar.h"
#import "MSGraphCalendarColor.h"
#import "MSGraphCalendarGroup.h"
#import "MSGraphContact.h"
#import "MSGraphContactFolder.h"
#import "MSGraphConversation.h"
#import "MSGraphConversationThread.h"
#import "MSGraphDateTimeTimeZone.h"
#import "MSGraphDayOfWeek.h"
#import "MSGraphDeleted.h"
#import "MSGraphDevice.h"
#import "MSGraphDirectoryObject.h"
#import "MSGraphDirectoryRole.h"
#import "MSGraphDirectoryRoleTemplate.h"
#import "MSGraphDrive.h"
#import "MSGraphDriveItem.h"
#import "MSGraphDriveRecipient.h"
#import "MSGraphEmailAddress.h"
#import "MSGraphEntity.h"
#import "MSGraphEvent.h"
#import "MSGraphEventMessage.h"
#import "MSGraphEventType.h"
#import "MSGraphFile.h"
#import "MSGraphFileAttachment.h"
#import "MSGraphFileSystemInfo.h"
#import "MSGraphFolder.h"
#import "MSGraphFreeBusyStatus.h"
#import "MSGraphGeoCoordinates.h"
#import "MSGraphGroup.h"
#import "MSGraphHashes.h"
#import "MSGraphIdentity.h"
#import "MSGraphIdentitySet.h"
#import "MSGraphImage.h"
#import "MSGraphImportance.h"
#import "MSGraphItemAttachment.h"
#import "MSGraphItemBody.h"
#import "MSGraphItemReference.h"
#import "MSGraphLicenseUnitsDetail.h"
#import "MSGraphLocation.h"
#import "MSGraphMailFolder.h"
#import "MSGraphMeetingMessageType.h"
#import "MSGraphMessage.h"
#import "MSGraphModels.h"
#import "MSGraphOrganization.h"
#import "MSGraphOutlookItem.h"
#import "MSGraphPackage.h"
#import "MSGraphPasswordProfile.h"
#import "MSGraphPatternedRecurrence.h"
#import "MSGraphPermission.h"
#import "MSGraphPhoto.h"
#import "MSGraphPhysicalAddress.h"
#import "MSGraphPost.h"
#import "MSGraphProfilePhoto.h"
#import "MSGraphProvisionedPlan.h"
#import "MSGraphQuota.h"
#import "MSGraphRecipient.h"
#import "MSGraphRecurrencePattern.h"
#import "MSGraphRecurrencePatternType.h"
#import "MSGraphRecurrenceRange.h"
#import "MSGraphRecurrenceRangeType.h"
#import "MSGraphReferenceAttachment.h"
#import "MSGraphReminder.h"
#import "MSGraphRemoteItem.h"
#import "MSGraphResponseStatus.h"
#import "MSGraphResponseType.h"
#import "MSGraphSearchResult.h"
#import "MSGraphSensitivity.h"
#import "MSGraphServicePlanInfo.h"
#import "MSGraphShared.h"
#import "MSGraphSharingInvitation.h"
#import "MSGraphSharingLink.h"
#import "MSGraphSpecialFolder.h"
#import "MSGraphSubscribedSku.h"
#import "MSGraphThumbnail.h"
#import "MSGraphThumbnailSet.h"
#import "MSGraphUploadSession.h"
#import "MSGraphUser.h"
#import "MSGraphVerifiedDomain.h"
#import "MSGraphVideo.h"
#import "MSGraphWeekIndex.h"
#import "MSGraphCoreSDK.h"
#import "MSGraphAttachmentRequest.h"
#import "MSGraphAttachmentRequestBuilder.h"
#import "MSGraphCalendarCalendarViewCollectionRequest.h"
#import "MSGraphCalendarCalendarViewCollectionRequestBuilder.h"
#import "MSGraphCalendarEventsCollectionRequest.h"
#import "MSGraphCalendarEventsCollectionRequestBuilder.h"
#import "MSGraphCalendarGroupCalendarsCollectionRequest.h"
#import "MSGraphCalendarGroupCalendarsCollectionRequestBuilder.h"
#import "MSGraphCalendarGroupRequest.h"
#import "MSGraphCalendarGroupRequestBuilder.h"
#import "MSGraphCalendarRequest.h"
#import "MSGraphCalendarRequestBuilder.h"
#import "MSGraphClient.h"
#import "MSGraphContactFolderChildFoldersCollectionRequest.h"
#import "MSGraphContactFolderChildFoldersCollectionRequestBuilder.h"
#import "MSGraphContactFolderContactsCollectionRequest.h"
#import "MSGraphContactFolderContactsCollectionRequestBuilder.h"
#import "MSGraphContactFolderRequest.h"
#import "MSGraphContactFolderRequestBuilder.h"
#import "MSGraphContactRequest.h"
#import "MSGraphContactRequestBuilder.h"
#import "MSGraphConversationRequest.h"
#import "MSGraphConversationRequestBuilder.h"
#import "MSGraphConversationThreadPostsCollectionRequest.h"
#import "MSGraphConversationThreadPostsCollectionRequestBuilder.h"
#import "MSGraphConversationThreadReplyRequest.h"
#import "MSGraphConversationThreadReplyRequestBuilder.h"
#import "MSGraphConversationThreadRequest.h"
#import "MSGraphConversationThreadRequestBuilder.h"
#import "MSGraphConversationThreadsCollectionRequest.h"
#import "MSGraphConversationThreadsCollectionRequestBuilder.h"
#import "MSGraphDeviceRegisteredOwnersCollectionReferencesRequest.h"
#import "MSGraphDeviceRegisteredOwnersCollectionReferencesRequestBuilder.h"
#import "MSGraphDeviceRegisteredOwnersCollectionWithReferencesRequest.h"
#import "MSGraphDeviceRegisteredOwnersCollectionWithReferencesRequestBuilder.h"
#import "MSGraphDeviceRegisteredUsersCollectionReferencesRequest.h"
#import "MSGraphDeviceRegisteredUsersCollectionReferencesRequestBuilder.h"
#import "MSGraphDeviceRegisteredUsersCollectionWithReferencesRequest.h"
#import "MSGraphDeviceRegisteredUsersCollectionWithReferencesRequestBuilder.h"
#import "MSGraphDeviceRequest.h"
#import "MSGraphDeviceRequestBuilder.h"
#import "MSGraphDirectoryObjectCheckMemberGroupsRequest.h"
#import "MSGraphDirectoryObjectCheckMemberGroupsRequestBuilder.h"
#import "MSGraphDirectoryObjectGetMemberGroupsRequest.h"
#import "MSGraphDirectoryObjectGetMemberGroupsRequestBuilder.h"
#import "MSGraphDirectoryObjectGetMemberObjectsRequest.h"
#import "MSGraphDirectoryObjectGetMemberObjectsRequestBuilder.h"
#import "MSGraphDirectoryObjectReferenceRequest.h"
#import "MSGraphDirectoryObjectReferenceRequestBuilder.h"
#import "MSGraphDirectoryObjectRequest.h"
#import "MSGraphDirectoryObjectRequestBuilder.h"
#import "MSGraphDirectoryObjectWithReferenceRequest.h"
#import "MSGraphDirectoryObjectWithReferenceRequestBuilder.h"
#import "MSGraphDirectoryRoleMembersCollectionReferencesRequest.h"
#import "MSGraphDirectoryRoleMembersCollectionReferencesRequestBuilder.h"
#import "MSGraphDirectoryRoleMembersCollectionWithReferencesRequest.h"
#import "MSGraphDirectoryRoleMembersCollectionWithReferencesRequestBuilder.h"
#import "MSGraphDirectoryRoleRequest.h"
#import "MSGraphDirectoryRoleRequestBuilder.h"
#import "MSGraphDirectoryRoleTemplateRequest.h"
#import "MSGraphDirectoryRoleTemplateRequestBuilder.h"
#import "MSGraphDriveItemChildrenCollectionRequest.h"
#import "MSGraphDriveItemChildrenCollectionRequestBuilder.h"
#import "MSGraphDriveItemContentRequest.h"
#import "MSGraphDriveItemCopyRequest.h"
#import "MSGraphDriveItemCopyRequestBuilder.h"
#import "MSGraphDriveItemCreateLinkRequest.h"
#import "MSGraphDriveItemCreateLinkRequestBuilder.h"
#import "MSGraphDriveItemDeltaRequest.h"
#import "MSGraphDriveItemDeltaRequestBuilder.h"
#import "MSGraphDriveItemPermissionsCollectionRequest.h"
#import "MSGraphDriveItemPermissionsCollectionRequestBuilder.h"
#import "MSGraphDriveItemRequest.h"
#import "MSGraphDriveItemRequestBuilder.h"
#import "MSGraphDriveItemsCollectionRequest.h"
#import "MSGraphDriveItemsCollectionRequestBuilder.h"
#import "MSGraphDriveItemSearchRequest.h"
#import "MSGraphDriveItemSearchRequestBuilder.h"
#import "MSGraphDriveItemThumbnailsCollectionRequest.h"
#import "MSGraphDriveItemThumbnailsCollectionRequestBuilder.h"
#import "MSGraphDriveRecentRequest.h"
#import "MSGraphDriveRecentRequestBuilder.h"
#import "MSGraphDriveRequest.h"
#import "MSGraphDriveRequestBuilder.h"
#import "MSGraphDriveSharedWithMeRequest.h"
#import "MSGraphDriveSharedWithMeRequestBuilder.h"
#import "MSGraphDriveSpecialCollectionRequest.h"
#import "MSGraphDriveSpecialCollectionRequestBuilder.h"
#import "MSGraphEntityRequest.h"
#import "MSGraphEntityRequestBuilder.h"
#import "MSGraphEventAcceptRequest.h"
#import "MSGraphEventAcceptRequestBuilder.h"
#import "MSGraphEventAttachmentsCollectionRequest.h"
#import "MSGraphEventAttachmentsCollectionRequestBuilder.h"
#import "MSGraphEventDeclineRequest.h"
#import "MSGraphEventDeclineRequestBuilder.h"
#import "MSGraphEventDismissReminderRequest.h"
#import "MSGraphEventDismissReminderRequestBuilder.h"
#import "MSGraphEventInstancesCollectionRequest.h"
#import "MSGraphEventInstancesCollectionRequestBuilder.h"
#import "MSGraphEventMessageRequest.h"
#import "MSGraphEventMessageRequestBuilder.h"
#import "MSGraphEventRequest.h"
#import "MSGraphEventRequestBuilder.h"
#import "MSGraphEventSnoozeReminderRequest.h"
#import "MSGraphEventSnoozeReminderRequestBuilder.h"
#import "MSGraphEventTentativelyAcceptRequest.h"
#import "MSGraphEventTentativelyAcceptRequestBuilder.h"
#import "MSGraphFileAttachmentRequest.h"
#import "MSGraphFileAttachmentRequestBuilder.h"
#import "MSGraphGraphServiceDevicesCollectionRequest.h"
#import "MSGraphGraphServiceDevicesCollectionRequestBuilder.h"
#import "MSGraphGraphServiceDirectoryObjectsCollectionRequest.h"
#import "MSGraphGraphServiceDirectoryObjectsCollectionRequestBuilder.h"
#import "MSGraphGraphServiceDirectoryRolesCollectionRequest.h"
#import "MSGraphGraphServiceDirectoryRolesCollectionRequestBuilder.h"
#import "MSGraphGraphServiceDirectoryRoleTemplatesCollectionRequest.h"
#import "MSGraphGraphServiceDirectoryRoleTemplatesCollectionRequestBuilder.h"
#import "MSGraphGraphServiceDrivesCollectionRequest.h"
#import "MSGraphGraphServiceDrivesCollectionRequestBuilder.h"
#import "MSGraphGraphServiceGroupsCollectionRequest.h"
#import "MSGraphGraphServiceGroupsCollectionRequestBuilder.h"
#import "MSGraphGraphServiceOrganizationCollectionRequest.h"
#import "MSGraphGraphServiceOrganizationCollectionRequestBuilder.h"
#import "MSGraphGraphServiceSubscribedSkusCollectionRequest.h"
#import "MSGraphGraphServiceSubscribedSkusCollectionRequestBuilder.h"
#import "MSGraphGraphServiceUsersCollectionRequest.h"
#import "MSGraphGraphServiceUsersCollectionRequestBuilder.h"
#import "MSGraphGroupAcceptedSendersCollectionRequest.h"
#import "MSGraphGroupAcceptedSendersCollectionRequestBuilder.h"
#import "MSGraphGroupAddFavoriteRequest.h"
#import "MSGraphGroupAddFavoriteRequestBuilder.h"
#import "MSGraphGroupCalendarViewCollectionRequest.h"
#import "MSGraphGroupCalendarViewCollectionRequestBuilder.h"
#import "MSGraphGroupConversationsCollectionRequest.h"
#import "MSGraphGroupConversationsCollectionRequestBuilder.h"
#import "MSGraphGroupEventsCollectionRequest.h"
#import "MSGraphGroupEventsCollectionRequestBuilder.h"
#import "MSGraphGroupMemberOfCollectionReferencesRequest.h"
#import "MSGraphGroupMemberOfCollectionReferencesRequestBuilder.h"
#import "MSGraphGroupMemberOfCollectionWithReferencesRequest.h"
#import "MSGraphGroupMemberOfCollectionWithReferencesRequestBuilder.h"
#import "MSGraphGroupMembersCollectionReferencesRequest.h"
#import "MSGraphGroupMembersCollectionReferencesRequestBuilder.h"
#import "MSGraphGroupMembersCollectionWithReferencesRequest.h"
#import "MSGraphGroupMembersCollectionWithReferencesRequestBuilder.h"
#import "MSGraphGroupOwnersCollectionReferencesRequest.h"
#import "MSGraphGroupOwnersCollectionReferencesRequestBuilder.h"
#import "MSGraphGroupOwnersCollectionWithReferencesRequest.h"
#import "MSGraphGroupOwnersCollectionWithReferencesRequestBuilder.h"
#import "MSGraphGroupRejectedSendersCollectionRequest.h"
#import "MSGraphGroupRejectedSendersCollectionRequestBuilder.h"
#import "MSGraphGroupRemoveFavoriteRequest.h"
#import "MSGraphGroupRemoveFavoriteRequestBuilder.h"
#import "MSGraphGroupRequest.h"
#import "MSGraphGroupRequestBuilder.h"
#import "MSGraphGroupResetUnseenCountRequest.h"
#import "MSGraphGroupResetUnseenCountRequestBuilder.h"
#import "MSGraphGroupSubscribeByMailRequest.h"
#import "MSGraphGroupSubscribeByMailRequestBuilder.h"
#import "MSGraphGroupThreadsCollectionRequest.h"
#import "MSGraphGroupThreadsCollectionRequestBuilder.h"
#import "MSGraphGroupUnsubscribeByMailRequest.h"
#import "MSGraphGroupUnsubscribeByMailRequestBuilder.h"
#import "MSGraphItemAttachmentRequest.h"
#import "MSGraphItemAttachmentRequestBuilder.h"
#import "MSGraphMailFolderChildFoldersCollectionRequest.h"
#import "MSGraphMailFolderChildFoldersCollectionRequestBuilder.h"
#import "MSGraphMailFolderCopyRequest.h"
#import "MSGraphMailFolderCopyRequestBuilder.h"
#import "MSGraphMailFolderMessagesCollectionRequest.h"
#import "MSGraphMailFolderMessagesCollectionRequestBuilder.h"
#import "MSGraphMailFolderMoveRequest.h"
#import "MSGraphMailFolderMoveRequestBuilder.h"
#import "MSGraphMailFolderRequest.h"
#import "MSGraphMailFolderRequestBuilder.h"
#import "MSGraphMessageAttachmentsCollectionRequest.h"
#import "MSGraphMessageAttachmentsCollectionRequestBuilder.h"
#import "MSGraphMessageCopyRequest.h"
#import "MSGraphMessageCopyRequestBuilder.h"
#import "MSGraphMessageCreateForwardRequest.h"
#import "MSGraphMessageCreateForwardRequestBuilder.h"
#import "MSGraphMessageCreateReplyAllRequest.h"
#import "MSGraphMessageCreateReplyAllRequestBuilder.h"
#import "MSGraphMessageCreateReplyRequest.h"
#import "MSGraphMessageCreateReplyRequestBuilder.h"
#import "MSGraphMessageForwardRequest.h"
#import "MSGraphMessageForwardRequestBuilder.h"
#import "MSGraphMessageMoveRequest.h"
#import "MSGraphMessageMoveRequestBuilder.h"
#import "MSGraphMessageReplyAllRequest.h"
#import "MSGraphMessageReplyAllRequestBuilder.h"
#import "MSGraphMessageReplyRequest.h"
#import "MSGraphMessageReplyRequestBuilder.h"
#import "MSGraphMessageRequest.h"
#import "MSGraphMessageRequestBuilder.h"
#import "MSGraphMessageSendRequest.h"
#import "MSGraphMessageSendRequestBuilder.h"
#import "MSGraphODataEntities.h"
#import "MSGraphOrganizationRequest.h"
#import "MSGraphOrganizationRequestBuilder.h"
#import "MSGraphOutlookItemRequest.h"
#import "MSGraphOutlookItemRequestBuilder.h"
#import "MSGraphPermissionRequest.h"
#import "MSGraphPermissionRequestBuilder.h"
#import "MSGraphPostAttachmentsCollectionRequest.h"
#import "MSGraphPostAttachmentsCollectionRequestBuilder.h"
#import "MSGraphPostForwardRequest.h"
#import "MSGraphPostForwardRequestBuilder.h"
#import "MSGraphPostReplyRequest.h"
#import "MSGraphPostReplyRequestBuilder.h"
#import "MSGraphPostRequest.h"
#import "MSGraphPostRequestBuilder.h"
#import "MSGraphProfilePhotoRequest.h"
#import "MSGraphProfilePhotoRequestBuilder.h"
#import "MSGraphProfilePhotoStreamRequest.h"
#import "MSGraphReferenceAttachmentRequest.h"
#import "MSGraphReferenceAttachmentRequestBuilder.h"
#import "MSGraphSubscribedSkuRequest.h"
#import "MSGraphSubscribedSkuRequestBuilder.h"
#import "MSGraphThumbnailContentRequest.h"
#import "MSGraphThumbnailRequest.h"
#import "MSGraphThumbnailRequestBuilder.h"
#import "MSGraphThumbnailSetRequest.h"
#import "MSGraphThumbnailSetRequestBuilder.h"
#import "MSGraphUserAssignLicenseRequest.h"
#import "MSGraphUserAssignLicenseRequestBuilder.h"
#import "MSGraphUserCalendarGroupsCollectionRequest.h"
#import "MSGraphUserCalendarGroupsCollectionRequestBuilder.h"
#import "MSGraphUserCalendarsCollectionRequest.h"
#import "MSGraphUserCalendarsCollectionRequestBuilder.h"
#import "MSGraphUserCalendarViewCollectionRequest.h"
#import "MSGraphUserCalendarViewCollectionRequestBuilder.h"
#import "MSGraphUserChangePasswordRequest.h"
#import "MSGraphUserChangePasswordRequestBuilder.h"
#import "MSGraphUserContactFoldersCollectionRequest.h"
#import "MSGraphUserContactFoldersCollectionRequestBuilder.h"
#import "MSGraphUserContactsCollectionRequest.h"
#import "MSGraphUserContactsCollectionRequestBuilder.h"
#import "MSGraphUserCreatedObjectsCollectionReferencesRequest.h"
#import "MSGraphUserCreatedObjectsCollectionReferencesRequestBuilder.h"
#import "MSGraphUserCreatedObjectsCollectionWithReferencesRequest.h"
#import "MSGraphUserCreatedObjectsCollectionWithReferencesRequestBuilder.h"
#import "MSGraphUserDirectReportsCollectionReferencesRequest.h"
#import "MSGraphUserDirectReportsCollectionReferencesRequestBuilder.h"
#import "MSGraphUserDirectReportsCollectionWithReferencesRequest.h"
#import "MSGraphUserDirectReportsCollectionWithReferencesRequestBuilder.h"
#import "MSGraphUserEventsCollectionRequest.h"
#import "MSGraphUserEventsCollectionRequestBuilder.h"
#import "MSGraphUserMailFoldersCollectionRequest.h"
#import "MSGraphUserMailFoldersCollectionRequestBuilder.h"
#import "MSGraphUserMemberOfCollectionReferencesRequest.h"
#import "MSGraphUserMemberOfCollectionReferencesRequestBuilder.h"
#import "MSGraphUserMemberOfCollectionWithReferencesRequest.h"
#import "MSGraphUserMemberOfCollectionWithReferencesRequestBuilder.h"
#import "MSGraphUserMessagesCollectionRequest.h"
#import "MSGraphUserMessagesCollectionRequestBuilder.h"
#import "MSGraphUserOwnedDevicesCollectionReferencesRequest.h"
#import "MSGraphUserOwnedDevicesCollectionReferencesRequestBuilder.h"
#import "MSGraphUserOwnedDevicesCollectionWithReferencesRequest.h"
#import "MSGraphUserOwnedDevicesCollectionWithReferencesRequestBuilder.h"
#import "MSGraphUserOwnedObjectsCollectionReferencesRequest.h"
#import "MSGraphUserOwnedObjectsCollectionReferencesRequestBuilder.h"
#import "MSGraphUserOwnedObjectsCollectionWithReferencesRequest.h"
#import "MSGraphUserOwnedObjectsCollectionWithReferencesRequestBuilder.h"
#import "MSGraphUserReferenceRequest.h"
#import "MSGraphUserReferenceRequestBuilder.h"
#import "MSGraphUserRegisteredDevicesCollectionReferencesRequest.h"
#import "MSGraphUserRegisteredDevicesCollectionReferencesRequestBuilder.h"
#import "MSGraphUserRegisteredDevicesCollectionWithReferencesRequest.h"
#import "MSGraphUserRegisteredDevicesCollectionWithReferencesRequestBuilder.h"
#import "MSGraphUserReminderViewRequest.h"
#import "MSGraphUserReminderViewRequestBuilder.h"
#import "MSGraphUserRequest.h"
#import "MSGraphUserRequestBuilder.h"
#import "MSGraphUserSendMailRequest.h"
#import "MSGraphUserSendMailRequestBuilder.h"
#import "MSGraphUserWithReferenceRequest.h"
#import "MSGraphUserWithReferenceRequestBuilder.h"

FOUNDATION_EXPORT double MSGraphSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char MSGraphSDKVersionString[];

