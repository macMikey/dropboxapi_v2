/*
1.07
added descriptions to all

issues: dropbox itself not working properly for:
db2_list_mountable_folders
db2_list_mountable_folders_continue
Waiting on response for dropbox developers

additions:
db2_get_shared_link_file
db2_list_folder_members
db2_list_folder_members_continue
db2_list_folders_continue
db2_list_mountable_folders
db2_list_mountable_folders_continue
db2_list_shared_links
db2_modify_shared_link_settings

1.06 additions:
db2_create_shared_link_with_settings

1.05 bug fixes
parameters
db2_list_folder_longpoll
db2_list_folder
db2_upload_HEADER
db2_upload

removal of quotes around boleans in
db2_Header_APISessionFinish
db2_Header_APISessionAppend
db2_list_folder_POST
db2_get_metadata_POST
db2_list_folder_longpoll_POST
db2_list_folder_get_latest_cursor_POST
db2_search_POST
db2_list_revisions_POST
db2_create_shared_link_POST
db2_get_folder_metadata_POST
db2_list_folders_POST
db2_share_folder_POST
db2_unshare_folder_POST
db2_add_folder_member_POST
db2_remove_folder_member_POST
*/

/*
DropBox API v2 Library
v1.0.7
Mar 18 2016
Copyright (c) 2016 Gerard McCarthy
The MIT License (MIT)
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
/*
--DropboxAPI as on 12 Nov 2015
--doesn't include business pro API
--OAuth 2 not included since tokens are easily obtained from apps via https://www.dropbox.com/developers/apps

--users-get_account
--users-get_current_account
--users-get_space_usage
--users-get_account_batch

--files-get_metadata
--files-list_folder-longpoll
--files-list_folder
--files-list_folder-continue
--files-list_folder-get_latest_cursor
--files-download
--files-upload_session-start
--files-upload_session-append
--files-upload_session-finish
--files-upload
--files-search
--files-create_folder
--files-delete
--files-permanently_delete
--files-copy
--files-move
--files-get_thumbnail
--files-get_preview
--files-list_revisions
--files-restore

--sharing-get_shared_links
--sharing-create_shared_link
--sharing-revoke_shared_link
--sharing-get_folder_metadata
--sharing-list_folders
--sharing-share_folder
--sharing-update_folder_policy
--sharing-unshare_folder
--sharing-transfer_folder
--sharing-unmount_folder
--sharing-mount_folder
--sharing-add_folder_member
--sharing-check_share_job_status
--sharing-check_job_status
--sharing-remove_folder_member
--sharing-update_folder_member
--sharing-relinquish_folder_membership
*/

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
---------users-----------------------------------------------------------

function db2_get_account pAccessToken,pUserAccountID
   put db2_get_account_HEADER(pAccessToken) into tHeader
   put db2_get_account_POST(pUserAccountID) into tPost
   put db2_get_account_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_account

function db2_get_account_batch pAccessToken,pUserAccountIDs
   /*  pUserAccountIDs on separate lines  */
   put db2_get_account_batch_HEADER(pAccessToken) into tHeader
   put db2_get_account_batch_POST(pUserAccountIDs) into tPost
   put db2_get_account_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_account_batch

function db2_get_current_account pAccessToken
   put db2_get_current_account_HEADER(pAccessToken) into tHeader
   put db2_get_current_account_POST() into tPost
   put db2_get_current_account_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_current_account

function db2_get_space_usage pAccessToken
   put db2_get_space_usage_HEADER(pAccessToken) into tHeader
   put db2_get_space_usage_POST() into tPost
   put db2_get_space_usage_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_space_usage

-----------------------------------------------------------------------------
------files------------------------------------------------------

function db2_copy pAccessToken,pPathFrom,pPathTo
   put db2_copy_HEADER(pAccessToken) into tHeader
   put db2_copy_POST(pPathFrom,pPathTo) into tPost
   put db2_copy_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_copy

function db2_create_folder pAccessToken,pPath
   put db2_create_folder_HEADER(pAccessToken) into tHeader
   put db2_create_folder_POST(pPath) into tPost
   put db2_create_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_create_folder

function db2_delete pAccessToken,pPath
   put db2_delete_HEADER(pAccessToken) into tHeader
   put db2_delete_POST(pPath) into tPost
   put db2_delete_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_delete

function db2_download pAccessToken,pPath
   /*
   DownloadArg
   path String The path of the file to download.
   {"path": "/apps/MyApp/Prime_Numbers.txt"}
   Example: id {"path": "id:a4ayc_80_OEAAAAAAAAAYa"}
   Example: rev  {"path": "rev:a1c10ce0dd78"}
   */
   put db2_download_HEADER(pAccessToken,pPath) into tHeader
   put db2_download_POST() into tPost
   put db2_download_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_download

function db2_get_metadata pAccessToken,pPath,pIncludeMediaInfo
   put db2_get_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_metadata_POST(pPath,pIncludeMediaInfo) into tPost
   put db2_get_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_metadata

function db2_get_preview pAccessToken,pPath
   put db2_get_preview_HEADER(pAccessToken,pPath) into tHeader
   put db2_get_preview_POST() into tPost
   put db2_get_preview_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_preview

function db2_get_thumbnail pAccessToken,pPath,pFormat,pSize
   put db2_get_thumbnail_HEADER(pAccessToken,pPath,pFormat,pSize) into tHeader
   put db2_get_thumbnail_POST() into tPost
   put db2_get_thumbnail_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_thumbnail

function db2_list_folder pAccessToken,pPath,pRecursive,pIncludeMediaInfo
   put db2_list_folder_HEADER(pAccessToken) into tHeader
   put db2_list_folder_POST(pPath,pRecursive,pIncludeMediaInfo) into tPost
   put db2_list_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder

function db2_list_folder_continue pAccessToken,pCursor
   put db2_list_folder_continue_HEADER(pAccessToken) into tHeader
   put db2_list_folder_continue_POST(pCursor) into tPost
   put db2_list_folder_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder_continue

function db2_list_folder_get_latest_cursor pAccessToken,pPath,pRecursive,pIncludeMediaInfo
   put db2_list_folder_get_latest_cursor_HEADER(pAccessToken) into tHeader
   put db2_list_folder_get_latest_cursor_POST(pPath,pRecursive,pIncludeMediaInfo) into tPost
   put db2_list_folder_get_latest_cursor_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder_get_latest_cursor

function db2_list_folder_longpoll pCursor,pTimeout
   put db2_list_folder_longpoll_HEADER() into tHeader
   put db2_list_folder_longpoll_POST(pCursor,pTimeout) into tPost
   put db2_list_folder_longpoll_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder_longpoll

function db2_list_revisions pAccessToken,pPath,pLimit
   put db2_list_revisions_HEADER(pAccessToken) into tHeader
   put db2_list_revisions_POST(pPath,pLimit) into tPost
   put db2_list_revisions_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_revisions

function db2_move pAccessToken,pPathFrom,pPathTo
   put db2_move_HEADER(pAccessToken) into tHeader
   put db2_move_POST(pPathFrom,pPathTo) into tPost
   put db2_move_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_move

function db2_permanently_delete pAccessToken,pPath
   put db2_permanently_delete_HEADER(pAccessToken) into tHeader
   put db2_permanently_delete_POST(pPath) into tPost
   put db2_permanently_delete_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_permanently_delete

function db2_restore pAccessToken,pPath,pRevision
   put db2_restore_HEADER(pAccessToken) into tHeader
   put db2_restore_POST(pPath,pRevision) into tPost
   put db2_restore_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_restore

function db2_search pAccessToken,pPath,pQuery,pStart,pMaxResults,pMode
   put db2_search_HEADER(pAccessToken) into tHeader
   put db2_search_POST(pPath,pQuery,pStart,pMaxResults,pMode) into tPost
   put db2_search_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_search

function db2_upload pAccessToken,pPath,pMode,pAutorename,pMute,pData
   put db2_upload_HEADER(pAccessToken,pPath,pMode,pAutorename,pMute) into tHeader
   put db2_upload_POST(pData) into tPost
   put db2_upload_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload

function db2_upload_session_append pAccessToken,pSession,pOffset,pData
   put db2_upload_session_append_HEADER(pAccessToken,pSession,pOffset) into tHeader
   put db2_upload_session_append_POST(pData) into tPost
   put db2_upload_session_append_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload_session_append

function db2_upload_session_finish pAccessToken,pSession,pOffset,pPath,pMode,pAutorename,pMute,pData
   put db2_upload_session_finish_HEADER(pAccessToken,pSession,pOffset,pPath,pMode,pAutorename,pMute) into tHeader
   put db2_upload_session_finish_POST(pData) into tPost
   put db2_upload_session_finish_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload_session_finish

function db2_upload_session_start pAccessToken,pData
   put db2_upload_session_start_HEADER(pAccessToken) into tHeader
   put db2_upload_session_start_POST(pData) into tPost
   put db2_upload_session_start_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload_session_start

-----------------------------------------------------------------------------
-----------sharing---------------------------------------------------------

function db2_add_folder_member pAccessToken,pSharedFolderId,pMembers,pQuiet,pCustomMessage
   --members as an array
   put db2_add_folder_member_HEADER(pAccessToken) into tHeader
   put db2_add_folder_member_POST(pSharedFolderId,pMembers,pQuiet,pCustomMessage) into tPost
   put db2_add_folder_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_add_folder_member

function db2_check_job_status pAccessToken,pAsyncJobId
   put db2_check_job_status_HEADER(pAccessToken) into tHeader
   put db2_check_job_status_POST(pAsyncJobId) into tPost
   put db2_check_job_status_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_check_job_status

function db2_check_share_job_status pAccessToken,pAsyncJobId
   put db2_check_share_job_status_HEADER(pAccessToken) into tHeader
   put db2_check_share_job_status_POST(pAsyncJobId) into tPost
   put db2_check_share_job_status_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_check_share_job_status

function db2_create_shared_link pAccessToken,pPath,pShortUrl,pPendingUpload
   --deprecated by version with settings
   put db2_create_shared_link_HEADER(pAccessToken) into tHeader
   put db2_create_shared_link_POST(pPath,pShortUrl,pPendingUpload) into tPost
   put db2_create_shared_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_create_shared_link

function db2_create_shared_link_with_settings pAccessToken,pPath,pSettings
   put db2_create_shared_link_HEADER(pAccessToken) into tHeader
   put db2_create_shared_link_POST(pPath,pSettings) into tPost
   put db2_create_shared_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_create_shared_link_with_settings

function db2_get_folder_metadata pAccessToken,pSharedFolderId,pActions
   put db2_get_folder_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_folder_metadata_POST(pSharedFolderId,pActions) into tPost
   put db2_get_folder_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_folder_metadata

function db2_get_shared_link_file pAccessToken,pUrl,pPath,pLinkPassword
   put db2_get_shared_link_file_HEADER(pAccessToken,pUrl,pPath,pLinkPassword) into tHeader
   put db2_get_shared_link_file_POST(pPath) into tPost
   put db2_get_shared_link_file_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_shared_link_file

function db2_get_shared_link_metadata pAccessToken,pUrl,pPath,pLinkPassword
   put db2_get_shared_link_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_shared_link_metadata_POST(pUrl,pPath,pLinkPassword) into tPost
   put db2_get_shared_link_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_shared_link_metadata

function db2_get_shared_links pAccessToken,pPath
   --DEPRECATED BY /list_shared_links
   put db2_get_shared_links_HEADER(pAccessToken) into tHeader
   put db2_get_shared_links_POST(pPath) into tPost
   put db2_get_shared_links_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_shared_links

function db2_list_folder_members pAccessToken,pSharedFolderId,pActions,pLimit
   put db2_list_folder_members_HEADER(pAccessToken) into tHeader
   put db2_list_folder_members_POST(pSharedFolderId,pActions,pLimit) into tPost
   put db2_list_folder_members_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder_members

function db2_list_folder_members_continue pAccessToken,pPath
   put db2_list_folder_members_continue_HEADER(pAccessToken) into tHeader
   put db2_list_folder_members_continue_POST(pPath) into tPost
   put db2_list_folder_members_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder_members_continue

function db2_list_folders pAccessToken,pLimit,pActions
   put db2_list_folders_HEADER(pAccessToken) into tHeader
   put db2_list_folders_POST(pLimit,pActions) into tPost
   put db2_list_folders_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folders

function db2_list_folders_continue pAccessToken,pCursor
   put db2_list_folders_continue_HEADER(pAccessToken) into tHeader
   put db2_list_folders_continue_POST(pCursor) into tPost
   put db2_list_folders_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folders_continue

function db2_list_mountable_folders pAccessToken,pLimit,pActions
   put db2_list_mountable_folders_HEADER(pAccessToken) into tHeader
   put db2_list_mountable_folders_POST(pLimit,pActions) into tPost
   put db2_list_mountable_folders_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_mountable_folders

function db2_list_mountable_folders_continue pAccessToken,pPath
   put db2_list_mountable_folders_continue_HEADER(pAccessToken) into tHeader
   put db2_list_mountable_folders_continue_POST(pPath) into tPost
   put db2_list_mountable_folders_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_mountable_folders_continue

function db2_list_shared_links pAccessToken,pPath,pDirectOnly,pCursor
   put db2_list_shared_links_HEADER(pAccessToken) into tHeader
   put db2_list_shared_links_POST(pPath,pDirectOnly,pCursor) into tPost
   put db2_list_shared_links_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_shared_links

function db2_modify_shared_link_settings pAccessToken,pUrl,pRequestedVisibility,pLinkPassword,pExpires
   put db2_modify_shared_link_settings_HEADER(pAccessToken) into tHeader
   put db2_modify_shared_link_settings_POST(pUrl,pRequestedVisibility,pLinkPassword,pExpires) into tPost
   put db2_modify_shared_link_settings_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_modify_shared_link_settings

function db2_mount_folder pAccessToken,pSharedFolderId
   put db2_mount_folder_HEADER(pAccessToken) into tHeader
   put db2_mount_folder_POST(pSharedFolderId) into tPost
   put db2_mount_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_mount_folder

function db2_relinquish_folder_membership pAccessToken,pSharedFolderId
   put db2_relinquish_folder_membership_HEADER(pAccessToken) into tHeader
   put db2_relinquish_folder_membership_POST(pSharedFolderId) into tPost
   put db2_relinquish_folder_membership_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_relinquish_folder_membership

function db2_remove_folder_member pAccessToken,pSharedFolderId,pMember,pLeaveACopy
   put db2_remove_folder_member_HEADER(pAccessToken) into tHeader
   put db2_remove_folder_member_POST(pSharedFolderId,pMember,pLeaveACopy) into tPost
   put db2_remove_folder_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_remove_folder_member

function db2_revoke_shared_link pAccessToken,pURL
   put db2_revoke_shared_link_HEADER(pAccessToken) into tHeader
   put db2_revoke_shared_link_POST(pURL) into tPost
   put db2_revoke_shared_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_revoke_shared_link

function db2_share_folder pAccessToken,pPath,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy,pForceAsync
   put db2_share_folder_HEADER(pAccessToken) into tHeader
   put db2_share_folder_POST(pPath,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy,pForceAsync) into tPost
   put db2_share_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_share_folder

function db2_transfer_folder pAccessToken,pSharedFolderId,pToDropboxId
   put db2_transfer_folder_HEADER(pAccessToken) into tHeader
   put db2_transfer_folder_POST(pSharedFolderId,pToDropboxId) into tPost
   put db2_transfer_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_transfer_folder

function db2_unmount_folder pAccessToken,pSharedFolderId
   put db2_unmount_folder_HEADER(pAccessToken) into tHeader
   put db2_unmount_folder_POST(pSharedFolderId) into tPost
   put db2_unmount_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_unmount_folder

function db2_unshare_folder pAccessToken,pSharedFolderId,pLeaveACopy
   put db2_unshare_folder_HEADER(pAccessToken) into tHeader
   put db2_unshare_folder_POST(pSharedFolderId,pLeaveACopy) into tPost
   put db2_unshare_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_unshare_folder

function db2_update_folder_member pAccessToken,pSharedFolderId,pMember,pAccessLevel
   put db2_update_folder_member_HEADER(pAccessToken) into tHeader
   put db2_update_folder_member_POST(pSharedFolderId,pMember,pAccessLevel) into tPost
   put db2_update_folder_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_update_folder_member

function db2_update_folder_policy pAccessToken,pSharedFolderId,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy
   put db2_update_folder_policy_HEADER(pAccessToken) into tHeader
   put db2_update_folder_policy_POST(pSharedFolderId,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy) into tPost
   put db2_update_folder_policy_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_update_folder_policy

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

function db2_API2 pHeader,pPost,pURL
   set socketTimeoutInterval to 30000  --30 seconds
   put the httpHeaders into oldHTTPHeaders
   set the httpHeaders to pHeader
   put cr & db2_Header_Close() after pHeader  --gmc feb 2016
   post pPost to URL pURL
   put it into tPostReturn
   put the result into tError
   set the httpHeaders to oldHTTPHeaders
   return tPostReturn
end db2_API2

function db2_Header_Close
   return "connection: close"
end db2_Header_Close

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
------------header building blocks---------------------------------------
-----------------------------------------------------------------------------

function db2_Header_Standard pAccessToken
    return db2_Header_Auth(pAccessToken) & cr & db2_Header_Json()
end db2_Header_Standard

function db2_Header_AuthOctet pAccessToken
    return db2_Header_Auth(pAccessToken) & cr & db2_Header_Octet()
end db2_Header_AuthOctet

function db2_Header_Auth pAccessToken
   return "Authorization: Bearer " & pAccessToken
end db2_Header_Auth

function db2_Header_Json
   return "Content-Type: application/json; charset=UTF-8"
end db2_Header_Json

function db2_Header_Octet
   return "Content-Type: application/octet-stream"
end db2_Header_Octet

function db2_Header_EmptyContent
   /*
   needed for get_thumbnail and get_preview (which dont set a Content Type) to clear standard value in headers
   */
   return "Content-Type:"
end db2_Header_EmptyContent

function db2_Header_APIDownload pPath
   /*
   Dropbox-API-Arg: {"path":"/apps/MyApp/seasons.txt"}
   path can be a path string, an id or a revision
   "path": "/apps/MyApp/seasons.txt"
   "path": "id:a4ayc_80_OEAAAAAAAAAYa"
   "path": "rev:a1c10ce0dd78"
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ":" & fGetQ(pPath))
end db2_Header_APIDownload

function db2_Header_APISessionAppend pSession,pOffset
   /*
   Dropbox-API-Arg:
   {"session_id":"AAAAAAAAAYSEAI0qRJ7GMg","offset":327}
    */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("session_id") & ":" & fGetQ(pSession)& "," &fGetQ("offset") & ":" & pOffset)
end db2_Header_APISessionAppend

function db2_Header_APISessionFinish pSession,pOffset,pPath,pMode,pAutorename,pMute
   /*
   Dropbox-API-Arg:
   {"cursor":{"session_id":"AAAAAAAAAYSEAI0qRJ7GMg","offset":358},"commit":{"path":"/apps/MyApp/seasons.txt","mode":"add"}}
   {"cursor": {"session_id": "1234faaf0678bcde","offset": 0},"commit": {"path": "/apps/MyApp/seasons.txt","mode": "add","autorename": true,"mute": false}}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("cursor") & ":" &  fGetCB(fGetQ("session_id") & ":" & fGetQ(pSession) & "," &fGetQ("offset") & ":" & pOffset) & "," &  fGetQ("commit") & ":" & fGetCB(fGetQ("path") & ":" & fGetQ(pPath) & "," & fGetQ("mode") & ":" & fGetQ(pMode) & "," & fGetQ("autorename") & ":" & pAutorename & "," &fGetQ("mute") & ":" & pMute))
end db2_Header_APISessionFinish

function db2_Header_APIUpload pPath,pMode,pAutorename,pMute
   /*
   Dropbox-API-Arg: {"path":"/Apps/MyApp/season/NewRCPStestfile.txt","mode":"overwrite","autorename": true,"mute": false}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ":" & fGetQ(pPath) & "," & fGetQ("mode") & ":" & fGetQ(pMode) & "," & fGetQ("autorename") & ":" & pAutorename & "," &fGetQ("mute") & ":" & pMute)
end db2_Header_APIUpload

function db2_Header_APIThumb pPath,pFormat,pSize
   /*
   Dropbox-API-Arg: {"path":"/apps/MyApp/RCsubmitter.jpg","format": "jpeg","size": "w64h64"}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ":" & fGetQ(pPath) & "," &fGetQ("format") & ":" & fGetQ(pFormat)& "," &fGetQ("size") & ":" & fGetQ(pSize))
end db2_Header_APIThumb

function db2_Header_APIPreview pPath
   /*
   Dropbox-API-Arg: {"path":"/apps/MyApp/seasons.txt"}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ":" & fGetQ(pPath))
end db2_Header_APIPreview

function db2_Header_APISharedLinkFile pUrl,pPath,pLinkPassword
   /*
   Dropbox-API-Arg: {"url": "https://www.dropbox.com/s/2sn712vy1ovegw8/Prime_Numbers.txt?dl=0","path": "/Prime_Numbers.txt"}"
   */
   if pPath is not empty then
      if pLinkPassword is not empty then
         return "Dropbox-API-Arg: " & fGetCB(fGetQ("url") & ":" &  fGetQ(pUrl) & "," &fGetQ("path") & ":" & fGetQ(pPath) & "," &fGetQ("link_password") & ":" & fGetQ(pLinkPassword))
      else
         return "Dropbox-API-Arg: " & fGetCB(fGetQ("url") & ":" &  fGetQ(pUrl) & "," &fGetQ("path") & ":" & fGetQ(pPath))
      end if
   else
      return "Dropbox-API-Arg: " & fGetCB(fGetQ("url") & ":" &  fGetQ(pUrl))
   end if
end db2_Header_APISharedLinkFile

-----------------------------------------------------------------------------
------------individual headers for all API---------------------------------------
-------users--------------------------------------------------------------

function db2_get_account_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_account_HEADER

function db2_get_account_batch_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_account_batch_HEADER

function db2_get_current_account_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_current_account_HEADER

function db2_get_space_usage_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_space_usage_HEADER

-------files--------------------------------------------------------------

function db2_copy_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_copy_HEADER

function db2_create_folder_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_create_folder_HEADER

function db2_delete_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_delete_HEADER

function db2_download_HEADER pAccessToken,pPath
   /*
   DownloadArg
   path String The path of the file to download.
   {"path": "/Homework/math/Prime_Numbers.txt"}
   Example: id {"path": "id:a4ayc_80_OEAAAAAAAAAYa"}
   Example: rev  {"path": "rev:a1c10ce0dd78"}
   */
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIDownload(pPath)
end db2_download_HEADER

function db2_get_metadata_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_metadata_HEADER

function db2_get_preview_HEADER pAccessToken,pPath
   /*
   {"path": "/word.docx"}
   Example: id  {"path": "id:a4ayc_80_OEAAAAAAAAAYa"}
   Example: rev  {"path": "rev:a1c10ce0dd78"}
   PreviewArg
   #--path String The path of the file to preview.
   */
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIPreview(pPath)
end db2_get_preview_HEADER

function db2_get_thumbnail_HEADER pAccessToken,pPath,pFormat,pSize
   /*
   {"path": "/image.jpg","format": "jpeg","size": "w64h64"}
   Example: id  {"path": "id:a4ayc_80_OEAAAAAAAAAYa","format": "jpeg","size": "w64h64"}
   Example: rev  {"path": "rev:a1c10ce0dd78","format": "jpeg","size": "w64h64"}
   ThumbnailArg
   #--path String The path to the image file you want to thumbnail.
   #--format ThumbnailFormat The format for the thumbnail image, jpeg (default) or png. For images that are photos, jpeg should be preferred, while png is better for screenshots and digital arts.
   ThumbnailFormat (union)
   The value will be one of the following datatypes:
   ##----jpeg Void
   ##----png Void
   #--size ThumbnailSize The size for the thumbnail image.
   ThumbnailSize (union)
   The value will be one of the following datatypes:
   ##----w32h32 Void 32 by 32 px.
   ##----w64h64 Void 64 by 64 px.
   ##----w128h128 Void 128 by 128 px.
   ##----w640h480 Void 640 by 480 px.
   ##----w1024h768 Void 1024 by 768
   */
   if pFormat is empty then put "jpeg" into pFormat
   if pSize is empty then put "w32h32" into pSize
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIThumb(pPath,pFormat,pSize)
end db2_get_thumbnail_HEADER

function db2_list_folder_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folder_HEADER

function db2_list_folder_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folder_continue_HEADER

function db2_list_folder_get_latest_cursor_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folder_get_latest_cursor_HEADER

function db2_list_folder_longpoll_HEADER
   return db2_Header_Json()
end db2_list_folder_longpoll_HEADER

function db2_list_revisions_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_revisions_HEADER

function db2_move_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_move_HEADER

function db2_permanently_delete_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_permanently_delete_HEADER

function db2_restore_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_restore_HEADER

function db2_search_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_search_HEADER

function db2_upload_session_append_HEADER pAccessToken,pSession,pOffset
   /*
   {"session_id": "1234faaf0678bcde","offset": 0}
   UploadSessionCursor
   #--session_id String The upload session ID (returned by upload_session/start).
   #--offset UInt64 The amount of data that has been uploaded so far to make sure upload data isn't lost or duplicated in the event of a network error.
   */
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionAppend(pSession,pOffset)
end db2_upload_session_append_HEADER

function db2_upload_session_finish_HEADER pAccessToken,pSession,pOffset,pPath,pMode,pAutorename,pMute
   /*
   {"cursor": {"session_id": "1234faaf0678bcde","offset": 0},
   "commit": {"path": "/apps/MyApp/seasons.txt","mode": "add","autorename": true,"mute": false}}
   UploadSessionFinishArg
   #--cursor UploadSessionCursor Contains the upload session ID and the offset.
   UploadSessionCursor
   ##--session_id String The upload session ID (returned by upload_session/start).
   ##--offset UInt64 The amount of data that has been uploaded so far to make sure upload data isn't lost or duplicated in the event of a network error.
   #--commit CommitInfo Contains the path and other optional modifiers for the commit.
   CommitInfo
   ##--path String Path in the user's Dropbox to save the file.
   ##--mode WriteMode Selects what to do if the file already exists.
   WriteMode (union)
   Your intent when writing a file to some path. This is used to determine what constitutes a conflict and what the autorename strategy is.
   In some situations, the conflict behavior is identical: (a) If the target path doesn't contain anything, the file is always written; no conflict. (b) If the target path contains a folder, it's always a conflict. (c) If the target path contains a file with identical contents, nothing gets written; no conflict.
   The conflict checking differs in the case where there's a file at the target path with contents different from the contents you're trying to write.The value will be one of the following datatypes:
   ##--#--add Void Never overwrite the existing file. The autorename strategy is to append a number to the file name. For example, "document.txt" might become "document (2).txt".
   ##--#--overwrite Void Always overwrite the existing file. The autorename strategy is the same as it is for add.
   ##--#--update String Overwrite if the given "rev" matches the existing file's "rev". The autorename strategy is to append the string "conflicted copy" to the file name. For example, "document.txt" might become "document (conflicted copy).txt" or "document (Panda's conflicted copy).txt".
   ##--autorename Boolean If there's a conflict, as determined by mode, have the Dropbox server try to autorename the file to avoid conflict. The default for this field is False.
   ##--client_modified Timestamp? The value to store as the client_modified timestamp. Dropbox automatically records the time at which the file was written to the Dropbox servers. It can also record an additional timestamp, provided by Dropbox desktop clients, mobile clients, and API apps of when the file was actually created or modified. This field is optional.
   ##--mute Boolean Normally, users are made aware of any file modifications in their Dropbox account via notifications in the client software. If True, this tells the clients that this modification shouldn't result in a user notification. The default for this field is False.
   */
   if pMode is empty then put "add" into pMode
   if pMute is empty then put "False" into pMute
   if pAutorename is empty then put "False" into pAutorename
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionFinish(pSession,pOffset,pPath,pMode,pAutorename,pMute)
end db2_upload_session_finish_HEADER

function db2_upload_HEADER pAccessToken,pPath,pMode,pAutorename,pMute
   /*
   {"path": "/apps/MyApp/seasons.txt","mode": "add","autorename": true,"mute": false}
   CommitInfo
   #--path String Path in the user's Dropbox to save the file.
   #--mode WriteMode Selects what to do if the file already exists.
   WriteMode (union)
   Your intent when writing a file to some path. This is used to determine what constitutes a conflict and what the autorename strategy is.
   In some situations, the conflict behavior is identical: (a) If the target path doesn't contain anything, the file is always written; no conflict. (b) If the target path contains a folder, it's always a conflict. (c) If the target path contains a file with identical contents, nothing gets written; no conflict.
   The conflict checking differs in the case where there's a file at the target path with contents different from the contents you're trying to write.The value will be one of the following datatypes:
   ##--add Void Never overwrite the existing file. The autorename strategy is to append a number to the file name. For example, "document.txt" might become "document (2).txt".
   ##--overwrite Void Always overwrite the existing file. The autorename strategy is the same as it is for add.
   ##--update String Overwrite if the given "rev" matches the existing file's "rev". The autorename strategy is to append the string "conflicted copy" to the file name. For example, "document.txt" might become "document (conflicted copy).txt" or "document (Panda's conflicted copy).txt".
   #--autorename Boolean If there's a conflict, as determined by mode, have the Dropbox server try to autorename the file to avoid conflict. The default for this field is False.
   client_modified Timestamp? The value to store as the client_modified timestamp. Dropbox automatically records the time at which the file was written to the Dropbox servers. It can also record an additional timestamp, provided by Dropbox desktop clients, mobile clients, and API apps of when the file was actually created or modified. This field is optional.
   #--mute Boolean Normally, users are made aware of any file modifications in their Dropbox account via notifications in the client software. If True, this tells the clients that this modification shouldn't result in a user notification. The default for this field is False.
   */
   if pMode is empty then put "add" into pMode
   if pAutorename is empty then put "False" into pAutorename
   if pMute is empty then put "False" into pMute
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APIUpload(pPath,pMode,pAutorename,pMute)
end db2_upload_HEADER

function db2_upload_session_start_HEADER pAccessToken
   return db2_Header_AuthOctet(pAccessToken)
end db2_upload_session_start_HEADER

----------------------------------------------------------------
------sharing-----------------------------------------------

function db2_add_folder_member_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_add_folder_member_HEADER

function db2_check_job_status_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_check_job_status_HEADER

function db2_check_share_job_status_HEADER pAccessToken
    return db2_Header_Standard(pAccessToken)
end db2_check_share_job_status_HEADER

function db2_create_shared_link_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_create_shared_link_HEADER

function db2_create_shared_link_with_settings_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_create_shared_link_with_settings_HEADER

function db2_get_folder_metadata_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_folder_metadata_HEADER

function db2_get_shared_link_file_HEADER pAccessToken,pUrl,pPath,pLinkPassword
   /*
   {"path": "/word.docx"}
   Example: id  {"path": "id:a4ayc_80_OEAAAAAAAAAYa"}
   Example: rev  {"path": "rev:a1c10ce0dd78"}
   GetSharedLinkMetadataArg
   url String URL of the shared link.
   path String? If the shared link is to a folder, this parameter can be used to retrieve the metadata for a specific file or sub-folder in this folder.
   A relative path should be used. This field is optional.
   link_password String? If the shared link has a password, this parameter can be used. This field is optional.
   */
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APISharedLinkFile(pUrl,pPath,pLinkPassword)
end db2_get_shared_link_file_HEADER

function db2_get_shared_link_metadata_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_shared_link_metadata_HEADER

function db2_get_shared_links_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_shared_links_HEADER

function db2_list_folder_members_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folder_members_HEADER

function db2_list_folder_members_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folder_members_continue_HEADER

function db2_list_folders_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folders_HEADER

function db2_list_folders_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folders_continue_HEADER

function db2_list_mountable_folders_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_mountable_folders_HEADER

function db2_list_mountable_folders_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_mountable_folders_continue_HEADER

function db2_list_shared_links_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_shared_links_HEADER

function db2_modify_shared_link_settings_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_modify_shared_link_settings_HEADER

function db2_mount_folder_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_mount_folder_HEADER

function db2_relinquish_folder_membership_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_relinquish_folder_membership_HEADER

function db2_remove_folder_member_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_remove_folder_member_HEADER

function db2_revoke_shared_link_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_revoke_shared_link_HEADER

function db2_share_folder_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_share_folder_HEADER

function db2_transfer_folder_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_transfer_folder_HEADER

function db2_unmount_folder_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_unmount_folder_HEADER

function db2_unshare_folder_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_unshare_folder_HEADER

function db2_update_folder_member_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_update_folder_member_HEADER

function db2_update_folder_policy_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_update_folder_policy_HEADER

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
------------individual URLs for all API---------------------------------------
----------------------------------------------------------------
---------users------------------------------------------------

function db2_get_account_URL
   return "https://api.dropboxapi.com/2/users/get_account?"
end db2_get_account_URL

function db2_get_account_batch_URL
   return "https://api.dropboxapi.com/2/users/get_account_batch?"
end db2_get_account_batch_URL

function db2_get_current_account_URL
   return "https://api.dropboxapi.com/2/users/get_current_account?"
end db2_get_current_account_URL

function db2_get_space_usage_URL
   return "https://api.dropboxapi.com/2/users/get_space_usage?"
end db2_get_space_usage_URL

----------------------------------------------------------------
---------files------------------------------------------------

function db2_copy_URL
   return "https://api.dropboxapi.com/2/files/copy?"
end db2_copy_URL

function db2_create_folder_URL
    return "https://api.dropboxapi.com/2/files/create_folder?"
end db2_create_folder_URL

function db2_delete_URL
    return "https://api.dropboxapi.com/2/files/delete?"
end db2_delete_URL

function db2_download_URL
   return "https://content.dropboxapi.com/2/files/download?"
end db2_download_URL

function db2_get_metadata_URL
    return "https://api.dropboxapi.com/2/files/get_metadata?"
end db2_get_metadata_URL

function db2_get_preview_URL
   return "https://content.dropboxapi.com/2/files/get_preview?"
end db2_get_preview_URL

function db2_get_thumbnail_URL
   return "https://content.dropboxapi.com/2/files/get_thumbnail?"
end db2_get_thumbnail_URL

function db2_list_folder_URL
   return "https://api.dropboxapi.com/2/files/list_folder?"
end db2_list_folder_URL

function db2_list_folder_continue_URL
   return "https://api.dropboxapi.com/2/files/list_folder/continue?"
end db2_list_folder_continue_URL

function db2_list_folder_get_latest_cursor_URL
   return "https://api.dropboxapi.com/2/files/list_folder/get_latest_cursor?"
end db2_list_folder_get_latest_cursor_URL

function db2_list_folder_longpoll_URL
   return "https://notify.dropboxapi.com/2-beta-2/files/list_folder/longpoll?"
end db2_list_folder_longpoll_URL

function db2_list_revisions_URL
   return "https://api.dropboxapi.com/2/files/list_revisions?"
end db2_list_revisions_URL

function db2_move_URL
   return "https://api.dropboxapi.com/2/files/move?"
end db2_move_URL

function db2_permanently_delete_URL
    return "https://api.dropboxapi.com/2/files/permanently_delete?"
end db2_permanently_delete_URL

function db2_restore_URL
   return "https://api.dropboxapi.com/2/files/restore?"
end db2_restore_URL

function db2_search_URL
    return "https://api.dropboxapi.com/2/files/search?"
end db2_search_URL

function db2_upload_URL
   return "https://content.dropboxapi.com/2/files/upload?"
end db2_upload_URL

function db2_upload_session_append_URL
   return "https://content.dropboxapi.com/2/files/upload_session/append?"
end db2_upload_session_append_URL

function db2_upload_session_finish_URL
    return "https://content.dropboxapi.com/2/files/upload_session/finish?"
end db2_upload_session_finish_URL

function db2_upload_session_start_URL
   return "https://content.dropboxapi.com/2/files/upload_session/start?"
end db2_upload_session_start_URL

----------------------------------------------------------------
---------sharing---------------------------------------------

function db2_add_folder_member_URL
    return "https://api.dropboxapi.com/2/sharing/add_folder_member?"
end db2_add_folder_member_URL

function db2_check_job_status_URL
    return "https://api.dropboxapi.com/2/sharing/check_job_status?"
end db2_check_job_status_URL

function db2_check_share_job_status_URL
   return "https://api.dropboxapi.com/2/sharing/check_share_job_status?"
end db2_check_share_job_status_URL

function db2_create_shared_link_URL
   return "https://api.dropboxapi.com/2/sharing/create_shared_link?"
end db2_create_shared_link_URL

function db2_create_shared_link_with_settings_URL
   return "https://api.dropboxapi.com/2/sharing/create_shared_link_with_settings?"
end db2_create_shared_link_with_settings_URL

function db2_get_folder_metadata_URL
    return "https://api.dropboxapi.com/2/sharing/get_folder_metadata?"
end db2_get_folder_metadata_URL

function db2_get_shared_link_file_URL
    return "https://content.dropboxapi.com/2/sharing/get_shared_link_file?"
end db2_get_shared_link_file_URL

function db2_get_shared_link_metadata_URL
    return "https://api.dropboxapi.com/2/sharing/get_shared_link_metadata?"
end db2_get_shared_link_metadata_URL

function db2_get_shared_links_URL
    return "https://api.dropboxapi.com/2/sharing/get_shared_links?"
end db2_get_shared_links_URL

function db2_list_folder_members_URL
    return "https://api.dropboxapi.com/2/sharing/list_folder_members?"
end db2_list_folder_members_URL

function db2_list_folder_members_continue_URL
    return "https://api.dropboxapi.com/2/sharing/list_folder_members/continue?"
end db2_list_folder_members_continue_URL

function db2_list_folders_URL
    return "https://api.dropboxapi.com/2/sharing/list_folders?"
end db2_list_folders_URL

function db2_list_folders_continue_URL
    return "https://api.dropboxapi.com/2/sharing/list_folders/continue?"
end db2_list_folders_continue_URL

function db2_list_mountable_folders_URL
    return "https://api.dropboxapi.com/2/sharing/list_mountable_folders?"
end db2_list_mountable_folders_URL

function db2_list_mountable_folders_continue_URL
    return "https://api.dropboxapi.com/2/sharing/list_mountable_folders/continue?"
end db2_list_mountable_folders_continue_URL

function db2_list_shared_links_URL
    return "https://api.dropboxapi.com/2/sharing/list_shared_links?"
end db2_list_shared_links_URL

function db2_modify_shared_link_settings_URL
    return "https://api.dropboxapi.com/2/sharing/modify_shared_link_settings?"
end db2_modify_shared_link_settings_URL

function db2_mount_folder_URL
    return "https://api.dropboxapi.com/2/sharing/mount_folder?"
end db2_mount_folder_URL

function db2_relinquish_folder_membership_URL
    return "https://api.dropboxapi.com/2/sharing/relinquish_folder_membership?"
end db2_relinquish_folder_membership_URL

function db2_remove_folder_member_URL
    return "https://api.dropboxapi.com/2/sharing/remove_folder_member?"
end db2_remove_folder_member_URL

function db2_revoke_shared_link_URL
    return "https://api.dropboxapi.com/2/sharing/revoke_shared_link?"
end db2_revoke_shared_link_URL

function db2_share_folder_URL
    return "https://api.dropboxapi.com/2/sharing/share_folder?"
end db2_share_folder_URL

function db2_transfer_folder_URL
    return "https://api.dropboxapi.com/2/sharing/transfer_folder?"
end db2_transfer_folder_URL

function db2_unmount_folder_URL
    return "https://api.dropboxapi.com/2/sharing/unmount_folder?"
end db2_unmount_folder_URL

function db2_unshare_folder_URL
    return "https://api.dropboxapi.com/2/sharing/unshare_folder?"
end db2_unshare_folder_URL

function db2_update_folder_member_URL
    return "https://api.dropboxapi.com/2/sharing/update_folder_member?"
end db2_update_folder_member_URL

function db2_update_folder_policy_URL
    return "https://api.dropboxapi.com/2/sharing/update_folder_policy?"
end db2_update_folder_policy_URL


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
------------individual Posts for all API---------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

function db2_get_account_POST pUserAccountID
   /*
   account_id String A user's account identifier.
   {"account_id":"pUserAccountID"}
   */
   return fGetCB(fGetQ("account_id") & ":" &  fGetQ(pUserAccountID))
end db2_get_account_POST

function db2_get_current_account_POST
     /*
   No parameters.
   */
   return ""
end db2_get_current_account_POST

function db2_get_space_usage_POST
   /*
   No parameters.
   */
   return ""
end db2_get_space_usage_POST

function db2_get_account_batch_POST pUserAccountIDs
   //pUserAccountIDs on separate lines
   /*
   GetAccountBatchArg
   account_ids List of (String) List of user account identifiers. Should not contain any duplicate account IDs.
   {"account_ids":["dbid:________________","dbid:_____________________"]}
   */
   if the number of lines of pUserAccountIDs =  1 then
      return fGetCB(fGetQ("account_ids") & ":" &  fGetSB(fGetQ(pUserAccountID)))
      esle
      put "{" & fGetQ("account_ids") & ":" &  "["  into tgabString
      repeat for each line rAccountID in pUserAccountIDs
         put fGetQ(pUserAccountID) & comma after tgabString
      end repeat
      delete last char of tgabString
      put "]"  after tgabString
      return tgabString
   end if
end db2_get_account_batch_POST

----------------------------------------------------------------

function db2_get_metadata_POST pPath,pIncludeMediaInfo
   /*
   GetMetadataArg
   #--path String The path of a file or folder on Dropbox
   #--include_media_info Boolean If true, :field:'FileMetadata.media_info' is set for photo and video. The default for this field is False.
   path can be file or folder
   {"path":"/apps/MyApp/seasons.txt"}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("include_media_info") & ":" & pIncludeMediaInfo)
end db2_get_metadata_POST

function db2_list_folder_longpoll_POST pCursor,pTimeout
   /*
   ListFolderLongpollArg
   #--cursor String A cursor as returned by list_folder or list_folder/continue
   #--timeout UInt64 A timeout in seconds. The request will block for at most this length of time,
   plus up to 90 seconds of random jitter added to avoid the thundering herd problem.
   Care should be taken when using this parameter, as some network infrastructure does not support long timeouts.
   The default for this field is 30.
   timeout in range [30, 480]
   {"cursor":"1AAGnnWDvEOO2b9xOCXEfhAdJVQeR8jk43Bn2GlNIamvCI2gqCP_Qa129jmJSlbVyIyH6XCEuTjRXUjO-j1jgbk9Lytw0PgEfiq1wartuO9M-kqlfHhRqmu08N-3WD-qNNYs","timeout":30}
   */
   return fGetCB(fGetQ("cursor") & ":" &  fGetQ(pCursor) & "," &fGetQ("timeout") & ":" & pTimeout)
end db2_list_folder_longpoll_POST

function db2_list_folder_POST pPath,pRecursive,pIncludeMediaInfo
   /*
   ListFolderArg
   #--path String The path to the folder you want to see the contents of.
   #--recursive Boolean If true, the list folder operation will be applied recursively to all subfolders
   and the response will contain contents of all subfolders. The default for this field is False.
   #--include_media_info Boolean If true, :field:'FileMetadata.media_info' is set for photo and video. The default for this field is False.
   {"path":"/Apps","recursive":true,"include_media_info":false}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("recursive") & ":" & pRecursive & "," &fGetQ("include_media_info") & ":" & pIncludeMediaInfo)
end db2_list_folder_POST

function db2_list_folder_continue_POST pCursor
   /*
   ListFolderContinueArg
   cursor String The cursor returned by your last call to list_folder or list_folder/continue.
   {"cursor":"1AAEb-y66nJOFj6oqkqCRg01Big_P2chM_2BQle73ZKEIiF6vhScKQQoTpilthdbcu1ML4gqGt6sCZTTYbxwESLhIbIMMxN3z-rElwaoH3v0Y-AYNV6oQm7n7MjkdfOrRm151PeJhHJMZN1Pw_NItgO8UvFnHhLBEsRTa8TGg4DaYtAIpj2pqFKX7w4X6RW7dnUs3BOJUYRsdaLF9Rem0JShPLT_DlRei9VYKDrPJzEliDg"}
   */
   return fGetCB(fGetQ("cursor") & ":" &  fGetQ(pCursor))
end db2_list_folder_continue_POST

function db2_list_folder_get_latest_cursor_POST pPath,pRecursive,pIncludeMediaInfo
   /*
   ListFolderArg
   #--path String The path to the folder you want to see the contents of.
   #--recursive Boolean If true, the list folder operation will be applied recursively to all subfolders and the response
   will contain contents of all subfolders. The default for this field is False.
   #--include_media_info Boolean If true, :field:'FileMetadata.media_info' is set for photo and video. The default for this field is False.
   {"path":"/Apps/MyApp","recursive":false,"include_media_info":false}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("recursive") & ":" & pRecursive & "," &fGetQ("include_media_info") & ":" & pIncludeMediaInfo)
end db2_list_folder_get_latest_cursor_POST

function db2_download_POST
   /*
   No parameters. Path in header instead.
   */
   return ""
end db2_download_POST

function db2_upload_session_start_POST pData
     /*
   data-binary @local_file.png
   */
   return pData
end db2_upload_session_start_POST

function db2_upload_session_append_POST pData
      /*
   data-binary @local_file.png
   */
return pData
end db2_upload_session_append_POST

function db2_upload_session_finish_POST pData
     /*
   data-binary @local_file.png
   */
   return pData
end db2_upload_session_finish_POST

function db2_upload_POST pData
   /*
   data-binary @local_file.png
   */
   return pData
end db2_upload_POST

function db2_search_POST pPath,pQuery,pStart,pMaxResults,pMode
   /*
   SearchArg
   #--path String The path in the user's Dropbox to search. Should probably be a folder.
   #--query String The string to search for. The search string is split on spaces into multiple tokens. For file name searching, the last token is used for prefix matching (i.e. "bat c" matches "bat cave" but not "batman car").
  #--start UInt64 The starting index within the search results (used for paging). The default for this field is 0.
   #--max_results UInt64 The maximum number of search results to return. The default for this field is 100.
   #--mode SearchMode The search mode (filename, filename_and_content, or deleted_filename).
   {"path": "/apps/MyApp","query": "mytext","start": 0,"max_results": 100,"mode": "filename"}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("query") & ":" & fGetQ(pQuery) & "," &fGetQ("start") & ":" & pStart & "," &fGetQ("max_results") & ":" & pMaxResults & "," &fGetQ("mode") & ":" & fGetQ(pMode))
end db2_search_POST

function db2_create_folder_POST pPath
   /*
   CreateFolderArg
   #--path String Path in the user's Dropbox to create.
   {"path": "/Apps/MyApp/new1/season7"}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath))
end db2_create_folder_POST

function db2_delete_POST pPath
   /*
   DeleteArg
   #--path String Path in the user's Dropbox to delete.
   {"path": "/apps/MyApp/newFolder31"}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath))
end db2_delete_POST

function db2_permanently_delete_POST pPath
   /*
   DeleteArg
   #--path String Path in the user's Dropbox to delete.
   {"path": "/apps/MyApp/testfile.txt"}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath))
end db2_permanently_delete_POST

function db2_copy_POST pPathFrom,pPathTo
   /*
   RelocationArg
   #--from_path String Path in the user's Dropbox to be copied or moved.
   #--to_path String Path in the user's Dropbox that is the destination.
   {"from_path":"/apps/MyApp/seasons.txt","to_path":"/apps/MyApp/New1/seasons.txt"}
   */
   return fGetCB(fGetQ("from_path") & ":" &  fGetQ(pPathFrom) & "," &fGetQ("to_path") & ":" & fGetQ(pPathTo))
end db2_copy_POST

function db2_move_POST pPathFrom,pPathTo
   /*
   RelocationArg
   #--from_path String Path in the user's Dropbox to be copied or moved.
   #--to_path String Path in the user's Dropbox that is the destination.
   {"from_path":"/apps/MyApp/seasons.txt","to_path":"/apps/MyApp/New2/seasons.txt"}
   */
   return fGetCB(fGetQ("from_path") & ":" &  fGetQ(pPathFrom) & "," &fGetQ("to_path") & ":" & fGetQ(pPathTo))
end db2_move_POST

function db2_get_thumbnail_POST
   /*
   No parameters. Parameters in header instead.
   */
   return ""
end db2_get_thumbnail_POST

function db2_get_preview_POST
   /*
   No parameters. Parameters in header instead.
   */
   return ""
end db2_get_preview_POST

function db2_list_revisions_POST pPath,pLimit
   /*
   ListRevisionsArg
   #--path String The path to the file you want to see the revisions of.
   #--limit UInt64 The maximum number of revision entries returned. The default for this field is 10.
   {"path":"/apps/MyApp/seasons.docx","limit": 10}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("limit") & ":" & pLimit)
end db2_list_revisions_POST

function db2_restore_POST pPath,pRevision
   /*
   RestoreArg
   #--path String The path to the file you want to restore.
   #--rev String The revision to restore for the file.
   {"path":"/apps/MyApp/seasons.docx","rev":"403e457377"}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("rev") & ":" & fGetQ(pRevision))
end db2_restore_POST

----------------------------------------------------------------
----------------------------------------------------------------
---------sharing-----------------------------------------

function db2_add_folder_member_POST pSharedFolderId,pMembers,pQuiet,pCustomMessage
   /*
   AddFolderMemberArg
   #--shared_folder_id String The ID for the shared folder.
   #--members List of (AddMember) The intended list of members to add. Added members will receive invites to join the shared folder.
   AddMember
   The member and type of access the member should have when added to a shared folder.
   ##----member MemberSelector The member to add to the shared folder.
   MemberSelector (open union)
   Includes different ways to identify a member to add to a shared folder.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ###------dropbox_id String Dropbox account, team member, or group ID of member to add.
   ###------email String E-mail address of member to add.
   ##----access_level AccessLevel The access level to grant member to the shared folder. AccessLevel. owner is disallowed.
   AccessLevel (open union)
   Defines the access levels for collaborators.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ###------owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   ###------editor Void The collaborator can both view and edit the shared folder.
   ###------viewer Void The collaborator can only view the shared folder.
   #--quiet Boolean Whether added members should be notified via email and device notifications of their invite. The default for this field is False.
   #--custom_message String? Optional message to display to added members in their invitation. This field is optional.

   --{"shared_folder_id":"1172266522","members": [{"member":{".tag":"email","email": "gmctt@tpg.com.au"},"access_level": {".tag":"editor"} }]}
   */
   if pQuiet is empty then put "False" into pQuiet
   if pCustomMessage is empty then put "" into pCustomMessage
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("members") & ":" & db2_FormatAddFolderMembers(pMembers) & "," &fGetQ("quiet") & ":" & pQuiet & "," &fGetQ("custom_message") & ":" & fGetQ(pCustomMessage))
end db2_add_folder_member_POST

function db2_FormatAddFolderMembers pMembers
   -- pMembers is an array  pMembers[1][email] or [1][dropbox_id], [1][accesslevel]
   /*"members":
   [
   { "member": {".tag": "email","email": "justin@example.com"},"access_level": {".tag": "editor"}},
   {"member": {".tag": "dropbox_id","dropbox_id": "dbid:AAEufNrMPSPe0dMQijRP0N_aZtBJRm26W4Q"},"access_level": {".tag": "editor"}}
   ]
   -- [{"member":{".tag":"email","email": "gmctt@tpg.com.au"},"access_level": {".tag":"editor"} }]
   */
   if pMembers is empty then return "[]"
   put "["  into tString
   repeat for each key rKey in pMembers
      if pMember[rKey]["email"] is not empty then
         put fGetQ("member") & ":" after tString
         put fGetCB(fGetQ(".tag") & ":" & fGetQ("email") & "," & fGetQ("email") & ":" & fGetQ(pMember[rKey]["email"])) after tString
         put "," & fGetQ("access_level") & ":" & fGetCB(fGetQ(".tag") & ":" & fGetQ(pMember[rKey]["accesslevel"])) after tString
      else
         if pMember[rKey]["dropbox_id"] is not empty then
            put fGetQ("member") & ":" after tString
            put fGetCB(fGetQ(".tag") & ":" & fGetQ("dropbox_id") & "," & fGetQ("dropbox_id") & ":" & fGetQ(pMember[rKey]["dropbox_id"])) after tString
            put "," & fGetQ("access_level") & ":" & fGetCB(fGetQ(".tag") & ":" & fGetQ(pMember[rKey]["accesslevel"])) after tString
         end if
      end if
   end repeat
   put "]"  after tString
   return tString
   --
   return pMembers
end db2_FormatAddFolderMembers

function db2_check_job_status_POST pAsyncJobId
   /*
   PollArg
   Arguments for methods that poll the status of an asynchronous job.
   #--async_job_id String Id of the asynchronous job. This is the value of a response returned from the method that launched the job.
   */
   return fGetCB(fGetQ("async_job_id") & ":" &  fGetQ(pAsyncJobId))
end db2_check_job_status_POST

function db2_check_share_job_status_POST pAsyncJobId
   /*
   PollArg
   Arguments for methods that poll the status of an asynchronous job.
   #--async_job_id String Id of the asynchronous job. This is the value of a response returned from the method
   that launched the job.
   pAsyncJobId from remove_folder_member, share_folder, unshare_folder
   */
   return fGetCB(fGetQ("async_job_id") & ":" &  fGetQ(pAsyncJobId))
end db2_check_share_job_status_POST

function db2_create_shared_link_POST pPath,pShortUrl,pPendingUpload
   /*
   CreateSharedLinkArg
   #--path String The path to share.
   #--short_url Boolean Whether to return a shortened URL. The default for this field is False.
   #--pending_upload PendingUploadMode? If it's okay to share a path that does not yet exist,
   set this to either 'file' or 'folder' to indicate whether to assume it's a file or folder. This field is optional.
   PendingUploadMode (union)
   Flag to indicate pending upload default (for linking to not-yet-existing paths).The value will be one of the following datatypes:
   ##----file Void Assume pending uploads are files.
   ##----folder Void Assume pending uploads are folders.
   {"path":"/apps/MyApp/seasons.txt","short_url":false,"pending_upload":"file"}
   */
   if pShortUrl is empty then put "false" into pShortUrl
  if pPendingUpload is empty then put "file" into pPendingUpload
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("short_url") & ":" & pShortUrl & "," &fGetQ("pending_upload") & ":" & fGetQ(pPendingUpload))
end db2_create_shared_link_POST

function db2_create_shared_link_with_settings_POST pPath,pSettings
   /*
   CreateSharedLinkArg
   #--path String The path to be shared by the shared link
   #--settings SharedLinkSettings? The requested settings for the newly created shared link This field is optional.
   SharedLinkSettings
   ##--requested_visibility RequestedVisibility? The requested access for this shared link. This field is optional.
   RequestedVisibility (union)
   The access permission that can be requested by the caller for the shared link.
   Note that the final resolved visibility of the shared link takes into account other aspects, such as team and shared folder settings.
   Check the ResolvedVisibility for more info on the possible resolved visibility values of shared links.
   The value will be one of the following datatypes:
   ###--public Void Anyone who has received the link can access it. No login required.
   ###--team_only Void Only members of the same team can access the link. Login is required.
   ###--password Void A link-specific password is required to access the link. Login is not required.
   ##--link_password String? If requested_visibility is RequestedVisibility.password this is needed to specify the password to access the link. This field is optional.
   ##--expires Timestamp? Expiration time of the shared link. By default the link won't expire. This field is optional.
   {"path":"/apps/MyApp/seasons.txt"," "settings": {"requested_visibility": "public"}}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("settings") & ":" & pSettings)
end db2_create_shared_link_with_settings_POST

function db2_get_folder_metadata_POST pSharedFolderId,pActions
   /*
   GetMetadataArgs
   shared_folder_id String The ID for the shared folder.
   actions List of (FolderAction)? Folder actions to query. This field is optional.
   FolderAction (open union)
   Actions that may be taken on shared folders. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   change_options Void Change folder options, such as who can be invited to join the folder.
   edit_contents Void Change or edit contents of the folder.
   invite_editor Void Invite a user or group to join the folder with read and write permission.
   invite_viewer Void Invite a user or group to join the folder with read permission.
   relinquish_membership Void Relinquish one's own membership in the folder.
   unmount Void Unmount the folder.
   unshare Void Stop sharing this folder.
   */
   if pActions is not empty then
      return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("actions") & ":" & fGetSB(pActions))
   else
      return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId))
   end if
end db2_get_folder_metadata_POST

function db2_get_shared_link_file_POST pPath
   /*
   No parameters. Parameters in header instead.
   */
   return ""
end db2_get_shared_link_file_POST

function db2_get_shared_link_metadata_POST pUrl,pPath,pLinkPassword
   /*
   GetSharedLinkMetadataArg
   #--url String URL of the shared link.
   #--path String? If the shared link is to a folder, this parameter can be used to retrieve the metadata for a specific file or sub-folder in this folder. A relative path should be used. This field is optional.
   #--link_password String? If the shared link has a password, this parameter can be used. This field is optional.
   */
   if pPath is not empty then
      if pLinkPassword is not empty then
         return fGetCB(fGetQ("url") & ":" &  fGetQ(pUrl) & "," &fGetQ("path") & ":" & fGetQ(pPath) & "," &fGetQ("link_password") & ":" & fGetQ(pLinkPassword))
      else
         return fGetCB(fGetQ("url") & ":" &  fGetQ(pUrl) & "," &fGetQ("path") & ":" & fGetQ(pPath))
      end if
   else
      return fGetCB(fGetQ("url") & ":" &  fGetQ(pUrl))
   end if
end db2_get_shared_link_metadata_POST

function db2_get_shared_links_POST pPath
   /*
   DEPRECATED BY /list_shared_links
   GetSharedLinksArg
   #--path String? See get_shared_links description.
   {"path": "/Apps/MyApp"}
   {"path": ""}
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath))
end db2_get_shared_links_POST

function db2_list_folder_members_POST pSharedFolderId,pActions,pLimit
   /*
   ListFolderMembersArgs
   #--shared_folder_id String The ID for the shared folder.
   #--actions List of (MemberAction)? Member actions to query. This field is optional.
   MemberAction (open union)
   Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ##----make_editor Void Make the member an editor of the folder.
   ##----make_owner Void Make the member an owner of the folder.
   ##----make_viewer Void Make the member a viewer of the folder.
   ##----remove Void Remove the member from the folder.
   #--limit UInt32 The maximum number of results that include members, groups and invitees to return per request. The default for this field is 1000.
   --
   { "shared_folder_id": "84528192421","actions": [], "limit": 1000}
   */
   if pActions is empty then put "[]" into pActions
   if pLimit is empty then put "1000" into pLimit
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," & fGetQ("actions") & ":" & fGetSB(pActions)& "," & fGetQ("limit") & ":" &  fGetQ(pLimit) )
end db2_list_folder_members_POST

function db2_list_folder_members_continue_POST pCursor
   /*
   ListFolderMembersContinueArg
   cursor String The cursor returned by your last call to list_folder_members or list_folder_members/continue.
   */
   return fGetCB(fGetQ("cursor") & ":" &  fGetQ(pCursor))
end db2_list_folder_members_continue_POST

function db2_list_folders_POST pLimit,pActions
   /*
   ListFoldersArgs
   limit UInt32 The maximum number of results to return per request. The default for this field is 1000.
   actions List of (FolderAction)? Folder actions to query. This field is optional.
   FolderAction (open union)
   Actions that may be taken on shared folders. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   change_options Void Change folder options, such as who can be invited to join the folder.
   edit_contents Void Change or edit contents of the folder.
   invite_editor Void Invite a user or group to join the folder with read and write permission.
   invite_viewer Void Invite a user or group to join the folder with read permission.
   relinquish_membership Void Relinquish one's own membership in the folder.
   unmount Void Unmount the folder.
   unshare Void Stop sharing this folder.
   {"limit": 100, "actions": []}
   */
   if pLimit is empty then put "1000" into pLimit
   if pActions is empty then put "[]" into pActions
   return fGetCB(fGetQ("limit") & ":" &  fGetQ(pLimit) & "," & fGetQ("actions") & ":" & fGetSB(pActions))
end db2_list_folders_POST

function db2_list_folders_continue_POST pCursor
   /*
   ListFoldersContinueArg
   cursor String The cursor returned by your last call to list_folder_members or list_folder_members/continue.
   */
   return fGetCB(fGetQ("cursor") & ":" &  fGetQ(pCursor))
end db2_list_folders_continue_POST

function db2_list_mountable_folders_POST pLimit,pActions
   /*
   ListFoldersArgs
   limit UInt32 The maximum number of results to return per request. The default for this field is 1000.
   actions List of (FolderAction)? Folder actions to query. This field is optional.
   FolderAction (open union)
   */
   if pLimit is empty then put "1000" into pLimit
   if pActions is empty then put "[]" into pActions
   return fGetCB(fGetQ("limit") & ":" &  fGetQ(pLimit) & "," & fGetQ("actions") & ":" & fGetSB(pActions))
end db2_list_mountable_folders_POST

function db2_list_mountable_folders_continue_POST pCursor
   /*
   ListFoldersContinueArg
   cursor String The cursor returned by the previous API call specified in the endpoint description.
   Apps must have full Dropbox access to use this endpoint.
   {"cursor": "ZtkX9_EHj3x7PMkVuFIhwKYXEpwpLwyxp9vMKomUhllil9q7eWiAu"}
    */
   return fGetCB(fGetQ("cursor") & ":" &  fGetQ(pCursor))
end db2_list_mountable_folders_continue_POST

function db2_list_shared_links_POST pPath,pDirectOnly,pCursor
   /*
   ListSharedLinksArg
   path String? See list_shared_links description. This field is optional.
   cursor String? The cursor returned by your last call to list_shared_links. This field is optional.
   direct_only Boolean? See list_shared_links description. This field is optional.
   {"path": "/MySharedFolder1"}
   {"path": "id:a4ayc_80_OEAAAAAAAAAYa"}
   {"path": "rev:a1c10ce0dd78"}
   {"path": "id:a4ayc_80_OEAAAAAAAAAYa","direct_only": true}
   {"cursor": "ZtkX9_EHj3x7PMkVuFIhwKYXEpwpLwyxp9vMKomUhllil9q7eWiAu"}  -from last call to list_shared_links
   {} returns all for user
   */
   if pCursor is not empty then
      if pDirectOnly is not empty then
         --for display in help stack only
         return fGetCB(fGetQ("cursor") & ":" &  fGetQ(pCursor)) & " OR " & fGetCB(fGetQ("path") & ":" & fGetQ(pPath) & "," &fGetQ("direct_only") & ":" & fGetQ(pDirectOnly))
      else
         return fGetCB(fGetQ("cursor") & ":" &  fGetQ(pCursor))
      end if
   else
      if pDirectOnly is not empty then
         return fGetCB(fGetQ("path") & ":" & fGetQ(pPath) & "," &fGetQ("direct_only") & ":" & fGetQ(pDirectOnly))
      else
         return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath))
      end if
   end if
end db2_list_shared_links_POST

function db2_modify_shared_link_settings_POST pUrl,pRequestedVisibility,pLinkPassword,pExpires
   /*
   ModifySharedLinkSettingsArgs
   #--url String URL of the shared link to change its settings
   #--settings SharedLinkSettings Set of settings for the shared link.
   SharedLinkSettings
   ##----requested_visibility RequestedVisibility? The requested access for this shared link. This field is optional.
   RequestedVisibility (union)
   The access permission that can be requested by the caller for the shared link. Note that the final resolved visibility of the shared link takes into account other aspects, such as team and shared folder settings. Check the ResolvedVisibility for more info on the possible resolved visibility values of shared links. The value will be one of the following datatypes:
   ###------public Void Anyone who has received the link can access it. No login required.
   ###------team_only Void Only members of the same team can access the link. Login is required.
   ###------password Void A link-specific password is required to access the link. Login is not required.
   ##----link_password String? If requested_visibility is RequestedVisibility.password this is needed to specify the password to access the link. This field is optional.
   ##----expires Timestamp? Expiration time of the shared link. By default the link won't expire. This field is optional.
   */
   put fGetQ("url") & ":" &  fGetQ(pUrl) into tPost
   put "," &fGetQ("settings") & "{" after tPost
   if pRequestedVisibility is not empty then
      put fGetQ("requested_visibility") & ":" & fGetQ(pRequestedVisibility) after tPost
   else
      --default
      put fGetQ("requested_visibility") & ":" & fGetQ("public") after tPost
   end if
   if pLinkPassword is not empty then
      put "," &fGetQ("link_password") & ":" & fGetQ(pLinkPassword) after tPost
   end if
   if pExpires is not empty then
      put "," &fGetQ("expires") & ":" & fGetQ(pExpires) after tPost
   end if
   put  "}" after tPost
   return fGetCB(tPost)
end db2_modify_shared_link_settings_POST

function db2_mount_folder_POST pSharedFolderId
   /*
   MountFolderArg
   #--shared_folder_id String The ID of the shared folder to mount.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId))
end db2_mount_folder_POST

function db2_relinquish_folder_membership_POST pSharedFolderId
   /*
   RelinquishFolderMembershipArg
   #--shared_folder_id String The ID for the shared folder.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId))
end db2_relinquish_folder_membership_POST

function db2_remove_folder_member_POST pSharedFolderId,pMember,pLeaveACopy
   /*
   RemoveFolderMemberArg
   #--shared_folder_id String The ID for the shared folder.
   #--member MemberSelector The member to remove from the folder. Only the MemberSelector.dropbox_id may be set at this time.
   MemberSelector (open union)
   Includes different ways to identify a member to add to a shared folder.The value will be one of the following datatypes.
   New values may be introduced as our API evolves.
   ##----dropbox_id String Dropbox account, team member, or group ID of member to add.
   ##----email String E-mail address of member to add.
   #--leave_a_copy Boolean If true, the removed user will keep their copy of the folder after it's unshared, assuming it was mounted.
   Otherwise, it will be removed from their Dropbox. Also, this must be set to false when kicking a group.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("member") & ":" & fGetQ(pMember) & "," &fGetQ("leave_a_copy") & ":" & pLeaveACopy)
end db2_remove_folder_member_POST

function db2_revoke_shared_link_POST pURL
   /*
   RevokeSharedLinkArg
   #--url String URL of the shared link.
   --needs to be full url not short url
   {"url":"https://www.dropbox.com/s/xm2rco8624tno9g/seasons.txt?dl=0"}
   */
   return fGetCB(fGetQ("url") & ":" &  fGetQ(pURL))
end db2_revoke_shared_link_POST

function db2_share_folder_POST pPath,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy,pForceAsync
   /*
   ShareFolderArg
   #--path String The path to the folder to share. If it does not exist, then a new one is created.
   #--member_policy MemberPolicy Who can be a member of this shared folder.
   MemberPolicy (open union)
   Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team.The value will be one of the following datatypes.
   New values may be introduced as our API evolves.
   ##----team Void Only a teammate can become a member.
   ##----anyone Void Anyone can become a member.
   #--acl_update_policy AclUpdatePolicy Who can add and remove members of this shared folder.
   AclUpdatePolicy (open union)
   Policy governing who can change a shared folder's access control list (ACL). In other words, who can add, remove, or change the privileges of members.
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ##----owner Void Only the owner can update the ACL.
   ##----editors Void Any editor can update the ACL. This may be further restricted to editors on the same team.
   #--shared_link_policy SharedLinkPolicy The policy to apply to shared links created for content inside this shared folder.
   SharedLinkPolicy (open union)
   Policy governing who can view shared links.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ##----anyone Void Links can be shared with anyone.
   ##----members Void Links can only be shared among members of the shared folder.
   #--force_async Boolean Whether to force the share to happen asynchronously. The default for this field is False.
   */
   put fGetQ("path") & ":" &  fGetQ(pPath) into tPost
   if pMemberPolicy is not empty then
      put "," &fGetQ("member_policy") & ":" & fGetQ(pMemberPolicy) after tPost
   end if
   if pAclUpdatePolicy is not empty then
      put "," &fGetQ("acl_update_policy") & ":" & fGetQ(pAclUpdatePolicy) after tPost
   end if
   if pSharedLinkPolicy is not empty then
      put "," &fGetQ("shared_link_policy") & ":" & fGetQ(pSharedLinkPolicy) after tPost
   end if
   if pForceAsync is not empty then
      --default false
      put "," &fGetQ("force_async") & ":" & fGetQ(pForceAsync) after tPost
   end if
   return fGetCB(tPost)
end db2_share_folder_POST

function db2_transfer_folder_POST pSharedFolderId,pToDropboxId
   /*
   TransferFolderArg
   #--shared_folder_id String The ID for the shared folder.
   #--to_dropbox_id String A account or team member ID to transfer ownership to.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("to_dropbox_id") & ":" & fGetQ(pToDropboxId))
end db2_transfer_folder_POST

function db2_unmount_folder_POST pSharedFolderId
   /*
   UnmountFolderArg
   #--shared_folder_id String The ID for the shared folder.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId))
end db2_unmount_folder_POST

function db2_unshare_folder_POST pSharedFolderId,pLeaveACopy
   /*
   UnshareFolderArg
   #--shared_folder_id String The ID for the shared folder.
   #--leave_a_copy Boolean If true, members of this shared folder will get a copy of this folder after it's unshared.
   Otherwise, it will be removed from their Dropbox. The current user, who is an owner, will always retain their copy.
   */
   if pLeaveACopy is empty then put "false" into pLeaveACopy
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("leave_a_copy") & ":" & pLeaveACopy)
end db2_unshare_folder_POST

function db2_update_folder_member_POST pSharedFolderId,pMember,pAccessLevel
   /*
   UpdateFolderMemberArg
   #--shared_folder_id String The ID for the shared folder.
   #--member MemberSelector The member of the shared folder to update. Only the MemberSelector.dropbox_id may be set at this time.
   MemberSelector (open union)
   Includes different ways to identify a member to add to a shared folder.The value will be one of the following datatypes.
   New values may be introduced as our API evolves.
   ##----dropbox_id String Dropbox account, team member, or group ID of member to add.
   ##----email String E-mail address of member to add.
   #--access_level AccessLevel The new access level for member. AccessLevel.owner is disallowed.
   AccessLevel (open union)
   Defines the access levels for collaborators.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ##----owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   ##----editor Void The collaborator can both view and edit the shared folder.
   ##----viewer Void The collaborator can only view the shared folder.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("member") & ":" & db2_FormatUpdateFolderMember(pMember) & "," &fGetQ("access_level") & ":" & fGetQ(pAccessLevel))
end db2_update_folder_member_POST

function db2_FormatUpdateFolderMember pMember
   -- pMember is an array  pMember["email"] or pMember["dropbox_id"]
   /*
   --{".tag":"email","email":"myemailaddress"}
   --{".tag": "dropbox_id","dropbox_id": "dbid:mydropboxid"}
   */
   if pMember["email"] is not empty then
      return fGetCB(fGetQ(".tag") & ":" & fGetQ("email") & "," & fGetQ("email") & ":" & fGetQ(pMember["email"]))
   end if
   if pMember["dropbox_id"] is not empty then
      return fGetCB(fGetQ(".tag") & ":" & fGetQ("dropbox_id") & "," & fGetQ("dropbox_id") & ":" & fGetQ(pMember["dropbox_id"]))
   end if
   return pMember  --this is useful for syntax display and also allows preformatted json to be passed eg. {".tag":"email","email":"myemailaddress"}
end db2_FormatUpdateFolderMember

function db2_update_folder_policy_POST pSharedFolderId,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy
   /*
   UpdateFolderPolicyArg
   If any of the policy's are unset, then they retain their current setting.
   #--shared_folder_id String The ID for the shared folder.
   #--member_policy MemberPolicy? Who can be a member of this shared folder. Only set this if the current user is on a team. This field is optional.
   MemberPolicy (open union)
   Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team.
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ##----team Void Only a teammate can become a member.
   ##----anyone Void Anyone can become a member.
   #--acl_update_policy AclUpdatePolicy? Who can add and remove members of this shared folder. This field is optional.
   AclUpdatePolicy (open union)
   Policy governing who can change a shared folder's access control list (ACL). In other words, who can add, remove, or change the privileges of members.
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ##----owner Void Only the owner can update the ACL.
   ##----editors Void Any editor can update the ACL. This may be further restricted to editors on the same team.
   #--shared_link_policy SharedLinkPolicy? The policy to apply to shared links created for content inside this shared folder. This field is optional.
   SharedLinkPolicy (open union)
   Policy governing who can view shared links.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ##----anyone Void Links can be shared with anyone.
   ##----members Void Links can only be shared among members of the shared folder.
   */
   put fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) into tPost
   if pMemberPolicy is not empty then
      put "," &fGetQ("member_policy") & ":" & fGetQ(pMemberPolicy) after tPost
   end if
   if pAclUpdatePolicy is not empty then
      put "," &fGetQ("acl_update_policy") & ":" & fGetQ(pAclUpdatePolicy) after tPost
   end if
   if pSharedLinkPolicy is not empty then
      put "," &fGetQ("shared_link_policy") & ":" & fGetQ(pSharedLinkPolicy) after tPost
   end if
   return fGetCB(tPost)
end db2_update_folder_policy_POST

#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------


on SortAPI2calls
   sort lines of fld "API2calls" by fGetSortedAPIcalls(each) & fGetSortedAPIcallsChars(each)
   put 0 into tStart
   put the number of lines of fld "API2calls" into rMax
   put fld "API2calls" into tText
   set the textstyle of char 1 to  -1 of fld "API2calls" to "plain"
   repeat rMax times
      put offset("folder",tText,tStart) into tOffsetChar
      if tOffsetChar = 0  then exit repeat
      put tStart + tOffsetChar into tChar1
      put tChar1+ 5 into tChar2
      set the textstyle of char tChar1 to tChar2 of fld "API2calls" to "bold"
      put tChar2 + 1 into tStart
     end repeat
 end SortAPI2calls

function fGetSortedAPIcallsChars pLineText
   put char 1 of pLineText into tChar
   switch tChar
      case "u"
         --user
      case "f"
         --file
         return char 7 to -1 of pLineText
         break
      case "s"
         --sharing
         if "Folder" is in pLineText then
            return "z" & char 9 to -1 of pLineText
         else
            return char 9 to -1 of pLineText
         end if
         break
      default
         return char 7 to -1 of pLineText
         break
   end switch
end fGetSortedAPIcallsChars

function fGetSortedAPIcalls pLineText
   put char 1 of pLineText into tChar
   switch tChar
      case "u"
         return "a"
         break
      case "f"
         return "b"
         break
      case "s"
         return "c"
         break
      default
         return "d"
         break
   end switch
end fGetSortedAPIcalls

on SetFldRects
   put the rect of fld "URL_users-get_account" into tURLrect
   put the rect of fld "Header_users-get_account" into tHeaderrect
   put the rect of fld "Post_users-get_account" into tPostrect
   put the rect of fld "Notes_users-get_account" into tNotesrect
   put the number of groups of this card into rMax
   repeat with rGrp = 1 to rMax
      if the short name of grp rGrp is "GetStarted" then next repeat
      put the number of flds of grp rGrp into tMaxFlds
      repeat with rFld = 1 to tMaxFlds
         put char 1 of the short name of fld rFld of grp rGrp into tInit
         switch tInit
            case "U"
               set the rect of fld rFld of grp rGrp to tURLrect
               break
            case "H"
               set the rect of fld rFld of grp rGrp to tHeaderrect
               break
            case "P"
               set the rect of fld rFld of grp rGrp to tPostrect
               break
            case "N"
               set the rect of fld rFld of grp rGrp to tNotesrect
               break
            default
         end switch
      end repeat
   end repeat
end SetFldRects


--see card script for library work
on openStack
   pass openStack
end openStack
on closeStack
   pass closeStack
end closeStack

--------------------------------------------------------------------
function fGetQInStr pString,pAltChar
   if pAltChar = empty then put "^" into pAltChar
   replace pAltChar with quote in pString
   return pString
end fGetQInStr

function fGetQ pString
   return quote & pString & quote
end fGetQ

function fGetCB pString
   return "{" & pString & "}"
end fGetCB

function fGetSB pString
   return "[" & pString & "]"
end fGetSB

function fGetB pString
   return "(" & pString & ")"
end fGetB

function fGetChev pString
   return "<<" & pString & ">>"
end fGetChev

function fGetArrayFromResponse pResponse
   return jsonToArray(pResponse, false, true)
end fGetArrayFromResponse

function fGetResponseTextFromResponse pResponse
   return fGetDisplayArrayKeysAndElements(jsonToArray(pResponse, false, true))
end fGetResponseTextFromResponse

function fGetDisplayArrayKeysAndElements pArray,pIndentKey
   put empty into tKandE
   #-- loop through each row of the array
   put the keys of pArray into tOrderedKeys
   sort lines of tOrderedKeys numeric
   repeat for each line rKey in tOrderedKeys
      if pArray[rKey] is an array then
         --put fGetDisplayArrayKeysAndElements(pArray[rKey],rKey) after tKandE
         if pIndentKey is not empty then
            put fGetDisplayArrayKeysAndElements(pArray[rKey], pIndentKey & "]" & "[" & rKey) after tKandE
         else
            put fGetDisplayArrayKeysAndElements(pArray[rKey],rKey) after tKandE
         end if
      else
         if pIndentKey is not empty then
            put "[" & pIndentKey & "]" & "[" & rKey & "]" & "=" & tab & pArray[rKey] & cr after tKandE
         else
            put "[" & rKey & "]" & "=" & tab & pArray[rKey] & cr after tKandE
         end if
      end if
   end repeat
   return tKandE
end fGetDisplayArrayKeysAndElements

#-- ------------------------------------------------------------------------------------------------------------

function fGetDisplayArrayKeysAndElements2 pArray
   if pArray is not an array then
      return ""
   end if
   local pLevel, pCounter, pList
   put 0 into pLevel
   put 0 into pCounter
   put "" into pList
   return fGetArrayRecurse(pArray, pLevel, pCounter, pList)
end fGetDisplayArrayKeysAndElements2

function fGetArrayRecurse pArray, pLevel, @pCounter, @pList
   local tOrderedKeys
   put the keys of pArray into tOrderedKeys
   sort lines of tOrderedKeys numeric
   repeat for each line rKey in tOrderedKeys
      add 1 to pCounter
      repeat for pLevel
         put tab after line pCounter of pList
      end repeat
      put ("[" & rKey & "]" & tab) after line pCounter of pList
      if (the keys of pArray[rKey]) is empty then
         put line 1 of pArray[rKey] after line pCounter of pList
      else
         put fGetArrayRecurse(pArray[rKey], (pLevel + 1), pCounter, pList) into pList
      end if
   end repeat
   return pList
end fGetArrayRecurse

#-- ------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

function fGetDropboxAPI2 pHeader,pPost,pURL
   set socketTimeoutInterval to 30000  --30 seconds
   put fReplaceAccessTokenInHeader(pHeader) into pHeader
   put the httpHeaders into oldHTTPHeaders
   set the httpHeaders to pHeader
   put cr & db2_Header_Close() after pHeader  --gmc feb 2016
   --libURLSetCustomHTTPHeaders tHeaders
   post pPost to URL pURL
   put it into tPostReturn
   put the result into tError
   set the httpHeaders to oldHTTPHeaders
   if tError is not empty then
      if there is a fld "Error" then put tError into fld "Error"
   end if
   return tPostReturn
end fGetDropboxAPI2

function fReplaceAccessTokenInHeader pHeader
   if the hilite of btn "AT1" then
      put fld "Aouth2accesstoken1" into tAccessToken
   else
      if the hilite of btn "AT2" then
         put fld "Aouth2accesstoken2" into tAccessToken
      else
         put fld "Aouth2accesstoken3" into tAccessToken
      end if
   end if
   replace "<<AccessToken>>" with tAccessToken in pHeader
   return pHeader
end fReplaceAccessTokenInHeader

on ClearResponseFlds
   put empty into fld "ResponseJson"
   put empty into fld "ResponseText"
   put empty into fld "Error"
end ClearResponseFlds

function fGetDropboxOnline
   put "https://api.dropboxapi.com/2/users/get_current_account" into tURL
   put URL tUrl into tAnswer
   if tAnswer begins with ( "Error in call to API function") then return true
   else return false
end fGetDropboxOnline



#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
#-- FASTJSON v0.4.1
#-- -------------------------------------------------------------------
#-- -------------------------------------------------------------------
#-- -------------------------------------------------------------------
#-- https://github.com/bhall2001/fastjson
#-- The MIT License (MIT)
/*Copyright (c) 2015 Bob Hall
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
-------------------------------------------------------------------
#-- FASTJSON v0.4.1
#-- -------------------------------------------------------------------
#--
#-- Bob Hall
#-- October 18, 2015
#--
#-- By combining the best of easyjson and libjson and adding in
#-- performance enhancements, fastjson improves the speed of encoding
#-- and decoding Livecode arrays to/from JSON.
#--
#-- Credit goes first to Mark Smith for creating the original libjson
#-- library and to Igor de Oliveira Couto who created the also excellent
#-- easyJson library.
#--
#-- I am combining routines from both of these libraries to give us
#-- a decent boost in performance for JSON to/from Array needs.
#-- Yes, you can go faster than this with an custom coded extension.
#-- But I find the speed of this library to be pretty impressive.
#--
#-- -------------------------------------------------------------------
#-- Instructions
#-- -------------------------------------------------------------------
#--
#-- There are 3 calls that you will make from your Livecode scripts.
#--
#--     arrayToJson(pArrayData, keepNumeric)
#--     jsonToArray(pJsonData, asUnicode, skipValidation)
#--     isJson(pJsonData)
#--
#-- NOTE:
#-- You will also find the following for compatibilty with existing
#-- easyJson scripts
#--
#--     arrayFromJson(pJsonData) (NOT TESTED)
#--     jsonFromArray(pArrayData) (NOT TESTED)
#--
#-- All other functions and commands in this script are for local use
#-- only.
#--
#-- To use this library in a Stack I would suggest creating a substack
#-- of your main project named fastJson. Copy and paste the text of
#-- fastjson.lc minus the first line (<?lc) into the stack script of
#-- your new substack. In the preOpenStack handler of your main stack:
#--
#--     start using stack "fastJson"
#--
#-- For livecode server use, include "fastjson.lc" in your server
#-- script.
#--
#-- -------------------------------------------------------------------
#--
##--

#-- DECLARE SCRIPT LOCAL VARIABLES
local sOutputUnicode=""
local sJson=""
local sIndex=0
local sNumTokens=0

##--
#-- -------------------------------------------------------------------
#--  JSON to Array
#-- -------------------------------------------------------------------
#-- Convert a valid JSON data structure to a multi-dimensional Livecode
#-- array.
#--
#-- Prototype:
#--
#--     put jsonToArray( tJsonData, false, true ) into tArrayData
#--
##--
function jsonToArray pJson, asUnicode, pSkipValidation
   local tJson = ""
   local tArray = ""

   put asUnicode is true into sOutputUnicode
   put jsonToUtf8(pJson) into tJson

   if tJson begins with "fastJson-error" then return tJson

   if pSkipValidation then
      tokenize tJson
   else
      if not isJson(tJson) then -- isJson will tokenize tJson for us
         return false
         //else
         //tokenize tJson
      end if
   end if

   //if the result is not empty then return the result
   put 0 into sIndex
   if sJson[1] = "[" then
      add 1 to sIndex
      put jArraytoArray() into tArray
   else
      put jObjectToArray() into tArray
   end if

   put empty into sJson
   return tArray
end jsonToArray

##--
#--
#--  Included for compatibility with easyJson scripts
#--
##--
function arrayFromJson pJson
   return jsonToArray(pJson)
end arrayFromJson

##--
#-- -------------------------------------------------------------------
#--  Array To JSON
#-- -------------------------------------------------------------------
#-- Convert a multi-dimensional Livecode array to a valid JSON data
#-- structure.
#--
#-- Prototype:
#--
#--     put arrayToJson( tArrayData ) into tJsonData
#--
##--
function arrayToJson pArray keepNumeric
   local tJSON
   local tValue
   local tKey

   if pArray is not an array then return "Parser Error: parameter given is not an array."
   if isNumericalArray(pArray) and keepNumeric is not true then
      #-- the array's keys are all *numerical*, so the root element will be a JSON *array*
      #-- if keepNumeric is true, then the keys will remain numeric keys
      put "[" into tJSON
      repeat for each element tValue in pArray
         put jsonValue(tValue) & comma after tJSON
      end repeat
      put "]" into the last char of tJSON
   else
      #-- the array's keys are not all numerical, so the root element will be a JSON *object*
      put "{" into tJSON
      repeat for each key tKey in pArray
         #-- all JSON object keys are double-quoted strings:
         put quote & tKey & quote & ":" & jsonValue(pArray[tKey]) & comma after tJSON
      end repeat
      put "}" into the last char of tJSON
   end if
   return tJSON
end arrayToJson

##--
#--
#--  Included for compatibility with easyJson scripts
#--
##--
function jsonFromArray pJson
   return arrayToJson(pJson)
end jsonFromArray

##--
#-- -------------------------------------------------------------------
#--  Validate JSON data structure
#-- -------------------------------------------------------------------
#-- Validates a JSON data structure
#--
#--
#-- Prototype:
#--
#--     if isJson( tJsonData ) then
#--        put "Valid JSON" into tTemp
#--     else
#--        put "ERROR! Not Valid JSON"
#--     end if
#--
##--
function isJson pJson
   local n

   tokenize pJson
   /*
   repeat for each element tToken in sJson
      if tToken is in "{[" then add 1 to tDepth
      if tToken is in "}]" then subtract 1 from tDepth
   end repeat

   if tDepth <> 0 then return false
   */
   put 2 into n
   repeat for each element tToken in sJson
      --repeat with n = 1 to sNumTokens - 1
      if (sJson[n-1] is not in "{}[],:") and (sJson[n] is not in "{}[],:") then
         put sJson[n-3] & return & sJson[n-2] &  return & sJson[n-1] &  return & sJson[n] &  return & sJson[n+1] &  return


         return false
      end if
      add 1 to n
   end repeat

   return true
end isJson

/*
This was the original tokeninze code from libJson commented out for now.
This code will be removed eventually.

Bob Hall (2015-OCT-02)

private command tokenizeJson pJson
   put empty into sJson
   put 0 into sIndex
   put 0 into sNumTokens

   #-- escaped quotes < \" > and reverse-solidus < \\ > will confuse the tokenizer
   #-- so we replace them with "\u0022" and "\u005C" which we'll unescape
   #-- with all the other unescapes when we parse - jsonDecode()
   replace "\\" with "\u005C" in pJson
   replace "\" & quote with "\u0022" in pJson

   put 0 into tDepth
   put empty into prevToken
   repeat for each token tToken in pJson
      if tToken is in "+-" then
         #-- since "+" & "-" are rev tokens, but not jSon tokens,
         #-- we have to prepend them to the next token
         put tToken into prevToken
      else
         add 1 to sNumTokens
         put prevToken & tToken into sJson[sNumTokens]
         put empty into prevToken

         if tToken is in "{[" then add 1 to tDepth
         if tToken is in "}]" then subtract 1 from tDepth
      end if
   end repeat

   if tDepth <> 0 then return "fastJson-error: json malformed"
   repeat with n = 1 to sNumTokens - 1
      if (sJson[n] is not in "{}[],:") and (sJson[n + 1] is not in "{}[],:") then return "fastJson-error: json malformed"
   end repeat
end tokenizeJson
*/

private function jObjectToArray
   local tArray
   local tName

   put empty into tArray

   -- using a repeat forever with a conditional got small improvement
   repeat forever
      --repeat while sIndex <= sNumTokens
      if sIndex > sNumTokens then exit repeat
      add 1 to sIndex

      switch sJson[sIndex]
         case "{"
            put jsonDecode(sJson[sIndex + 1]) into tName
            add 1 to sIndex -- we can skip ahead
            break
         case ":"
            if sJson[sIndex + 1] is not "{" then
               put jsonDecode(sJson[sIndex + 1]) into tArray[tName]
            else
               put jObjectToArray() into tArray[tName]
            end if
            break
         case "}"
            return tArray
            break
         case "["
            put jArrayToArray() into tArray[tName]
            break
         case comma -- must be after "[" or will mess up jArrays
            put jsonDecode(sJson[sIndex + 1]) into tName
            add 1 to sIndex -- we can skip ahead
            break
      end switch

   end repeat
   return tArray
end jObjectToArray

private function jArrayToArray
   local tKey=0
   local tArray=""

   repeat while sIndex <= sNumTokens
      add 1 to sIndex

      switch sJson[sIndex]
         case "]"
            return tArray
            break
         case comma
            next repeat
            break
         case "{"
            add 1 to tKey
            subtract 1 from sIndex
            put jObjectToArray() into tArray[tKey]
            break
         case "["
            add 1 to tKey
            put jArrayToArray() into tArray[tKey]
            break
         default
            add 1 to tKey
            put jsonDecode(sJson[sIndex]) into tArray[tKey]
      end switch
   end repeat
end jArrayToArray

private function jsonToUtf8 @pJson
   local tNulls = "1111"
   local tCounter = "1,2,3,4"
   local bigEndian

   ##--
   #-- Repeat for each is faster than repeat with
   #--
   repeat for each element n in tCounter
      --repeat with n = 1 to 4
      if (byte n of pJson is null) then put 0 into char n of tNulls
   end repeat

   put (char 1 of (binaryencode("I",1)) is null) into bigEndian

   switch tNulls
      case "1111"  -- UTF-8
         return pJson
         break
      case "0101"  -- UTF-16BE
         if bigEndian then
            return utf8encode(pJson, true)
         else
            return utf8encode(swapEndianness(pJson), true)
         end if
         break
      case "1010"  -- UTF-16LE
         if not bigEndian then
            return utf8encode(pJson, true)
         else
            return utf8encode(swapEndianness(pJson), true)
         end if
         break
      case "0001"  -- UTF-32BE
         return "fastJson-error: 4 byte unicode, can't decode"
         break
      case "1000"  -- UTF-32LE
         return "fastJson-error: 4 byte unicode, can't decode"
         break
   end switch
end jsonToUtf8

private function utf8encode pString, pIsUnicode
   if pIsUnicode then
      return unidecode(pString, "UTF8")
   else
      return unidecode(uniencode(pString),"UTF8")
   end if
end utf8encode

private function utf8decode pString, pToUnicode
   if pToUnicode then
      return uniencode(pString,"UTF8")
   else
      return unidecode(uniencode(pString,"UTF8"))
   end if
end utf8decode

private function jsonDecode pString
   local tCode
   local tChar

   switch pString
      case "false"
         return "false"
         break
      case "true"
         return "true"
         break
         #--
         #-- SPECIAL CASE. Need to catch this in JSON or performace takes a hit.
         #--
      case ""
         return empty
         break
      case "null"
         return empty
         break
      default
         if pString is a number then
            return pString
         else
            replace "\" & quote with quote in pString
            replace "\\" with "\" in pString
            replace "\b" with numtochar(8) in pString
            replace "\t" with numtochar(9) in pString
            replace "\f" with numtochar(12) in pString
            replace "\r" with numtochar(13) in pString
            replace "\n" with numtochar(10) in pString

            -- some more common unicode escapees
            replace "\u0022" with quote in pString
            replace "\u005C" with "\" in pString
            -- any others

            ##--
            #-- REMOVED 10/15/2015 by BobH
            #-- Below causing issues with RTF escaped characters.
            #-- In general I am removing Unicode support for the time being.
            #--
            ##-- if "\u" is in pString then put unicodeEscapes(pString) into pString

            ##--
            #-- JSON encoders escape unicode characters as "\uHHHH",
            #-- where 'H' is a hexadecimal digit. Convert to UTF8
            #--
            repeat while matchtext(pString,"\\u([0-9A-Fa-f]{4})",tCode)
               set the useunicode to true
               put unidecode(numtochar(baseconvert(tCode,16,10)),"UTF8") into tChar
               replace ("\u" & tCode) with tChar in pString
            end repeat

            if not sOutputUnicode then
               return utf8decode(pString)
            else
               return pString
            end if
         end if
   end switch
end jsonDecode

##--
#-- REMOVED 10/16/2015 by BobH
#-- Removed this function. Replaced with code in Json string hanlding
#--
/*
private function unicodeEscapes pString
   put false into inEsc
   repeat for each char c in pString
      add 1 to count
      put c after buffer

      if count < 2 then next repeat

      if buffer is "\u" then put true into inEscape

      if inEscape then
         if length(buffer) < 6 then
            next repeat
         else
            put numtochar(baseconvert(char 3 to 6 of buffer, 16, 10)) into buffer
            put false into inEscape
         end if
      else
         put char 1 of buffer after nString
         delete char 1 of buffer
      end if

   end repeat
   put buffer after nString
   return nString
end unicodeEscapes
*/

/*
This function checks the keys of a LiveCode array,
and returns TRUE if all the keys are numerical - otherwise, returns false.

@param pArray a LiveCode array
@return TRUE if the array's keys are all numerical, otherwise FALSE
*/
private function isNumericalArray @pArray
   local tKeys, aKey
   put the keys of pArray into tKeys
   /*
   #-- REMOVED 10/18/2015
   #-- the filter command returns true if there is a number in the string anywhere
   #--
   filter tKeys without "[0-9]*"
   if the number of lines in tKeys > 0 then
      return false
   else
      return true
   end if
   */
   repeat for each line aKey in tKeys
      if aKey is not a number then
         -- as soon as we don't get a number, get outa here!
         return false
         exit isNumericalArray
      end if
   end repeat
   return true
end isNumericalArray

/*
This function takes a LiveCode value, and produces a string representing
a valid JSON 'value', as per http://www.json.org/.
@param pValue any LiveCode value: array, string, number, date, colour, boolean, etc.
@return a string representing a valid and comparable JSON 'value' - JSON values are:
number, string, boolean, array or object.
LiveCode 'empty' returns JSON 'null'.
*/
private function jsonValue pValue
   switch
      case pValue is an array
         #-- this allows us to have nested JSON objects and arrays:
         return arrayToJson(pValue)
         break
      case pValue is empty
         return "null"
         break
      case pValue is a boolean
         if pValue then return "true"
         else return "false"
         break
      case pValue is a number
         -- need to catch when a "number" starts with a 0
         -- decided to return this as a quoted string
         -- JSON lint throws an exception if a number starts with a 0
         if (character 1 of pValue = 0) and not (character 2 of pValue = ".") and (length(pValue) > 1) then
            return quote & pValue & quote
         end if
         -- there is an "anomoly" in LC where "inf" and "Infinity" are getting through "is a number"
         -- function. Not sure what the result will be but the code below will catch both.
         -- I have submitted the following bugs: 16160, 16162, 16163
         if char 1 of pValue is "i" then
            return quote & pValue & quote
         else
            return pValue
         end if
      default
         #-- any other value is processed as a string.
         #-- JSON strings require that certain characters be 'escaped' with a backslash:
         replace "\" with "\\" in pValue // the backslash itself
         replace quote with ("\" & quote) in pValue // the double quote
         replace "/" with "\/" in pValue // the (forward) slash
         replace tab with "\t" in pValue // the tab
         replace return with "\n" in pValue // the return
         return quote & pValue & quote
   end switch
end jsonValue

private command tokenize @pJson
   local prevToken

   put empty into sJson
   put 0 into sNumTokens

   #-- escaped quotes < \" > and reverse-solidus < \\ > will confuse the tokenizer
   #-- so we replace them with "\u0022" and "\u005C" which we'll unescape
   #-- with all the other unescapes when we parse - jsonDecode()
   replace "\\" with "\u005C" in pJson
   replace "\" & quote with "\u0022" in pJson

   put 1 into sIndex
   put "" into prevToken
   repeat for each token tToken in pJson
      ##-- I've removed the following.
      ##-- debugging an Json where we have
      ##-- "name":"-",
      ##-- this appears to trip up the tokenizer
      /*
      if tToken is in "+-" then -- needed for numbers in json
         #-- since "+" & "-" are rev tokens, but not jSon tokens,
         #-- we have to prepend them to the next token
         put tToken into prevToken
      else*/

      switch
         case tToken is in "+-"
            #-- since "+" & "-" are rev tokens, but not jSon tokens,
            #-- we have to prepend them to the next token
            put tToken after prevToken
            break
         case (prevToken is in "+-") and (tToken is not a number)
            add 1 to sNumTokens
            put prevToken into sJson[sNumTokens]
            put "" into prevToken
            add 1 to sNumTokens
            put tToken into sJson[sNumTokens]
            break
         default
            add 1 to sNumTokens
            put prevToken & tToken into sJson[sNumTokens]
            put "" into prevToken
      end switch
   end repeat
end tokenize

function numTokens @pJson
   tokenize pJson
   return sNumTokens
end numTokens

#-- -------------------------------------------------------------------
#-- -------------------------------------------------------------------
#-- -------------------------------------------------------------------
#-- FASTJSON end
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
