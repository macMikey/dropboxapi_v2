script "DropBoxAPI2"
/*
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
v1.0.5 
12 Nov 2015
Copyright (c) 2015 Gerard McCarthy
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
-----------------------------------------------------------------------------

function db2_get_account pAccessToken,pUserAccountID
   put db2_get_account_HEADER(pAccessToken) into tHeader
   put db2_get_account_POST(pUserAccountID) into tPost
   put db2_get_account_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_account

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

function db2_get_account_batch pAccessToken,pUserAccountIDs
   /*  pUserAccountIDs on separate lines  */
   put db2_get_account_batch_HEADER(pAccessToken) into tHeader
   put db2_get_account_batch_POST(pUserAccountIDs) into tPost
   put db2_get_account_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_account_batch

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
function db2_get_metadata pAccessToken,pPath,pIncludeMediaInfo
   put db2_get_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_metadata_POST(pPath,pIncludeMediaInfo) into tPost
   put db2_get_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_metadata

function db2_list_folder_longpoll pCursor,pTimeout
   put db2_list_folder_longpoll_HEADER() into tHeader
   put db2_list_folder_longpoll_POST(pCursor,pTimeout) into tPost
   put db2_list_folder_longpoll_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder_longpoll

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

function db2_upload_session_start pAccessToken,pData
   put db2_upload_session_start_HEADER(pAccessToken) into tHeader
   put db2_upload_session_start_POST(pData) into tPost
   put db2_upload_session_start_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload_session_start

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

function db2_upload pAccessToken,pPath,pMode,pAutorename,pMute,pData
   put db2_upload_HEADER(pAccessToken,pPath,pMode,pAutorename,pMute) into tHeader
   put db2_upload_POST(pData) into tPost
   put db2_upload_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload

function db2_search pAccessToken,pPath,pQuery,pStart,pMaxResults,pMode
   put db2_search_HEADER(pAccessToken) into tHeader
   put db2_search_POST(pPath,pQuery,pStart,pMaxResults,pMode) into tPost
   put db2_search_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_search

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

function db2_permanently_delete pAccessToken,pPath
   put db2_permanently_delete_HEADER(pAccessToken) into tHeader
   put db2_permanently_delete_POST(pPath) into tPost
   put db2_permanently_delete_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_permanently_delete

function db2_copy pAccessToken,pPathFrom,pPathTo
   put db2_copy_HEADER(pAccessToken) into tHeader
   put db2_copy_POST(pPathFrom,pPathTo) into tPost
   put db2_copy_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_copy

function db2_move pAccessToken,pPathFrom,pPathTo
   put db2_move_HEADER(pAccessToken) into tHeader
   put db2_move_POST(pPathFrom,pPathTo) into tPost
   put db2_move_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_move

function db2_get_thumbnail pAccessToken,pPath,pFormat,pSize
   put db2_get_thumbnail_HEADER(pAccessToken,pPath,pFormat,pSize) into tHeader
   put db2_get_thumbnail_POST() into tPost
   put db2_get_thumbnail_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_thumbnail

function db2_get_preview pAccessToken,pPath
   put db2_get_preview_HEADER(pAccessToken,pPath) into tHeader
   put db2_get_preview_POST() into tPost
   put db2_get_preview_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_preview

function db2_list_revisions pAccessToken,pPath,pLimit
   put db2_list_revisions_HEADER(pAccessToken) into tHeader
   put db2_list_revisions_POST(pPath,pLimit) into tPost
   put db2_list_revisions_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_revisions

function db2_restore pAccessToken,pPath,pRevision
   put db2_restore_HEADER(pAccessToken) into tHeader
   put db2_restore_POST(pPath,pRevision) into tPost
   put db2_restore_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_restore
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
function db2_get_shared_links pAccessToken,pPath
   put db2_get_shared_links_HEADER(pAccessToken) into tHeader
   put db2_get_shared_links_POST(pPath) into tPost
   put db2_get_shared_links_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_shared_links

function db2_create_shared_link pAccessToken,pPath,pShortUrl,pPendingUpload
   put db2_create_shared_link_HEADER(pAccessToken) into tHeader
   put db2_create_shared_link_POST(pPath,pShortUrl,pPendingUpload) into tPost
   put db2_create_shared_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_create_shared_link

function db2_revoke_shared_link pAccessToken,pURL
   put db2_revoke_shared_link_HEADER(pAccessToken) into tHeader
   put db2_revoke_shared_link_POST(pURL) into tPost
   put db2_revoke_shared_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_revoke_shared_link

function db2_get_folder_metadata pAccessToken,pSharedFolderId,pIncludeMembership
   put db2_get_folder_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_folder_metadata_POST(pSharedFolderId,pIncludeMembership) into tPost
   put db2_get_folder_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_folder_metadata

function db2_list_folders pAccessToken,pIncludeMembership
   put db2_list_folders_HEADER(pAccessToken) into tHeader
   put db2_list_folders_POST(pIncludeMembership) into tPost
   put db2_list_folders_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folders

function db2_share_folder pAccessToken,pPath,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy,pForceAsync
   put db2_share_folder_HEADER(pAccessToken) into tHeader
   put db2_share_folder_POST(pPath,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy,pForceAsync) into tPost
   put db2_share_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_share_folder

function db2_update_folder_policy pAccessToken,pSharedFolderId,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy
   put db2_update_folder_policy_HEADER(pAccessToken) into tHeader
   put db2_update_folder_policy_POST(pSharedFolderId,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy) into tPost
   put db2_update_folder_policy_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_update_folder_policy

function db2_unshare_folder pAccessToken,pSharedFolderId,pLeaveACopy
   put db2_unshare_folder_HEADER(pAccessToken) into tHeader
   put db2_unshare_folder_POST(pSharedFolderId,pLeaveACopy) into tPost
   put db2_unshare_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_unshare_folder

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

function db2_mount_folder pAccessToken,pSharedFolderId
   put db2_mount_folder_HEADER(pAccessToken) into tHeader
   put db2_mount_folder_POST(pSharedFolderId) into tPost
   put db2_mount_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_mount_folder

function db2_add_folder_member pAccessToken,pSharedFolderId,pMembers,pQuiet,pCustomMessage
   put db2_add_folder_member_HEADER(pAccessToken) into tHeader
   put db2_add_folder_member_POST(pSharedFolderId,pMembers,pQuiet,pCustomMessage) into tPost
   put db2_add_folder_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_add_folder_member

function db2_check_share_job_status pAccessToken,pAsyncJobId
   put db2_check_share_job_status_HEADER(pAccessToken) into tHeader
   put db2_check_share_job_status_POST(pAsyncJobId) into tPost
   put db2_check_share_job_status_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_check_share_job_status

function db2_check_job_status pAccessToken,pAsyncJobId
   put db2_check_job_status_HEADER(pAccessToken) into tHeader
   put db2_check_job_status_POST(pAsyncJobId) into tPost
   put db2_check_job_status_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_check_job_status

function db2_remove_folder_member pAccessToken,pSharedFolderId,pMember,pLeaveACopy
   put db2_remove_folder_member_HEADER(pAccessToken) into tHeader
   put db2_remove_folder_member_POST(pSharedFolderId,pMember,pLeaveACopy) into tPost
   put db2_remove_folder_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_remove_folder_member

function db2_update_folder_member pAccessToken,pSharedFolderId,pMember,pAccessLevel
   put db2_update_folder_member_HEADER(pAccessToken) into tHeader
   put db2_update_folder_member_POST(pSharedFolderId,pMember,pAccessLevel) into tPost
   put db2_update_folder_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_update_folder_member

function db2_relinquish_folder_membership pAccessToken,pSharedFolderId
   put db2_relinquish_folder_membership_HEADER(pAccessToken) into tHeader
   put db2_relinquish_folder_membership_POST(pSharedFolderId) into tPost
   put db2_relinquish_folder_membership_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_relinquish_folder_membership

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

function db2_API2 pHeader,pPost,pURL
   put the httpHeaders into oldHTTPHeaders
   set the httpHeaders to pHeader
   post pPost to URL pURL
   put it into tPostReturn
   put the result into tError
   set the httpHeaders to oldHTTPHeaders
   return tPostReturn
end db2_API2

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
------------header building blocks---------------------------------------
-----------------------------------------------------------------------------

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


-----------------------------------------------------------------------------
------------headers---------------------------------------
-----------------------------------------------------------------------------
function db2_Header_Standard pAccessToken
    return db2_Header_Auth(pAccessToken) & cr & db2_Header_Json()
end db2_Header_Standard

function db2_Header_AuthOctet pAccessToken
    return db2_Header_Auth(pAccessToken) & cr & db2_Header_Octet()
end db2_Header_AuthOctet
-----------------------------------------------------------------------------
------------individual headers for all API---------------------------------------
-----------------------------------------------------------------------------

function db2_get_account_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_account_HEADER 

function db2_get_current_account_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_current_account_HEADER 

function db2_get_space_usage_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_space_usage_HEADER 

function db2_get_account_batch_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_account_batch_HEADER 
----------------------------------------------------------------
function db2_get_metadata_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_metadata_HEADER 

function db2_list_folder_longpoll_HEADER 
   return db2_Header_Json()
end db2_list_folder_longpoll_HEADER 

function db2_list_folder_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folder_HEADER 

function db2_list_folder_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folder_continue_HEADER

function db2_list_folder_get_latest_cursor_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folder_get_latest_cursor_HEADER

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

function db2_upload_session_start_HEADER pAccessToken
   return db2_Header_AuthOctet(pAccessToken)
end db2_upload_session_start_HEADER

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
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APIUpload(pPath,pMode,pAutorename,pMute)
end db2_upload_HEADER

function db2_search_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_search_HEADER

function db2_create_folder_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_create_folder_HEADER

function db2_delete_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_delete_HEADER

function db2_permanently_delete_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_permanently_delete_HEADER

function db2_copy_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_copy_HEADER

function db2_move_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_move_HEADER

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
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIThumb(pPath,pFormat,pSize)
end db2_get_thumbnail_HEADER

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

function db2_list_revisions_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_revisions_HEADER

function db2_restore_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_restore_HEADER
----------------------------------------------------------------
function db2_get_shared_links_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_shared_links_HEADER

function db2_create_shared_link_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_create_shared_link_HEADER

function db2_revoke_shared_link_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_revoke_shared_link_HEADER

-------------------------------------------------
function db2_get_folder_metadata_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_folder_metadata_HEADER

function db2_list_folders_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_folders_HEADER

function db2_share_folder_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_share_folder_HEADER

function db2_update_folder_policy_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_update_folder_policy_HEADER

function db2_unshare_folder_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_unshare_folder_HEADER

function db2_transfer_folder_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_transfer_folder_HEADER

function db2_unmount_folder_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_unmount_folder_HEADER

function db2_mount_folder_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_mount_folder_HEADER

function db2_add_folder_member_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_add_folder_member_HEADER

function db2_check_share_job_status_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_check_share_job_status_HEADER

function db2_check_job_status_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_check_job_status_HEADER

function db2_remove_folder_member_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_remove_folder_member_HEADER

function db2_update_folder_member_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_update_folder_member_HEADER

function db2_relinquish_folder_membership_HEADER pAccessToken
   return db2_Header_Auth(pAccessToken)
end db2_relinquish_folder_membership_HEADER

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
------------individual URLs for all API---------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

function db2_get_account_URL
   return "https://api.dropboxapi.com/2/users/get_account?"
end db2_get_account_URL 

function db2_get_current_account_URL
   return "https://api.dropboxapi.com/2/users/get_current_account?"
end db2_get_current_account_URL 

function db2_get_space_usage_URL
   return "https://api.dropboxapi.com/2/users/get_space_usage?"
end db2_get_space_usage_URL 

function db2_get_account_batch_URL
   return "https://api.dropboxapi.com/2/users/get_account_batch?"
end db2_get_account_batch_URL 
----------------------------------------------------------------
function db2_get_metadata_URL
    return "https://api.dropboxapi.com/2/files/get_metadata?"
end db2_get_metadata_URL 

function db2_list_folder_longpoll_URL
   return "https://notify.dropboxapi.com/2-beta-2/files/list_folder/longpoll?"
end db2_list_folder_longpoll_URL

function db2_list_folder_URL
   return "https://api.dropboxapi.com/2/files/list_folder?"
end db2_list_folder_URL 

function db2_list_folder_continue_URL
   return "https://api.dropboxapi.com/2/files/list_folder/continue?"
end db2_list_folder_continue_URL 

function db2_list_folder_get_latest_cursor_URL
   return "https://api.dropboxapi.com/2/files/list_folder/get_latest_cursor?"
end db2_list_folder_get_latest_cursor_URL 

function db2_upload_session_start_URL
    return "https://api.dropboxapi.com/2/files/list_folder/get_latest_cursor?"
end db2_upload_session_start_URL 

function db2_download_URL
   return "https://content.dropboxapi.com/2/files/download?"
end db2_download_URL 

function db2_upload_session_start_URL
   return "https://content.dropboxapi.com/2/files/upload_session/start?"
end db2_upload_session_start_URL 

function db2_upload_session_append_URL
   return "https://content.dropboxapi.com/2/files/upload_session/append?"
end db2_upload_session_append_URL 

function db2_upload_session_finish_URL
    return "https://content.dropboxapi.com/2/files/upload_session/finish?"
end db2_upload_session_finish_URL 

function db2_upload_URL
   return "https://content.dropboxapi.com/2/files/upload?"
end db2_upload_URL 

function db2_search_URL
    return "https://api.dropboxapi.com/2/files/search?"
end db2_search_URL 

function db2_create_folder_URL
    return "https://api.dropboxapi.com/2/files/create_folder?"
end db2_create_folder_URL 

function db2_delete_URL
    return "https://api.dropboxapi.com/2/files/delete?"
end db2_delete_URL 

function db2_permanently_delete_URL
    return "https://api.dropboxapi.com/2/files/permanently_delete?"
end db2_permanently_delete_URL 

function db2_copy_URL
   return "https://api.dropboxapi.com/2/files/copy?"
end db2_copy_URL 

function db2_move_URL
   return "https://api.dropboxapi.com/2/files/move?"
end db2_move_URL

function db2_get_thumbnail_URL
     return "https://content.dropboxapi.com/2/files/get_thumbnail?"
end db2_get_thumbnail_URL

function db2_get_preview_URL
   return "https://content.dropboxapi.com/2/files/get_preview?"
end db2_get_preview_URL

function db2_list_revisions_URL
   return "https://api.dropboxapi.com/2/files/list_revisions?"
end db2_list_revisions_URL

function db2_restore_URL
   return "https://api.dropboxapi.com/2/files/restore?"
end db2_restore_URL 
----------------------------------------------------------------
function db2_get_shared_links_URL
    return "https://api.dropboxapi.com/2/sharing/get_shared_links?"
end db2_get_shared_links_URL 

function db2_create_shared_link_URL
   return "https://api.dropboxapi.com/2/sharing/create_shared_link?"
end db2_create_shared_link_URL 

function db2_revoke_shared_link_URL
    return "https://api.dropboxapi.com/2/sharing/revoke_shared_link?"
end db2_revoke_shared_link_URL 

function db2_get_folder_metadata_URL
    return "https://api.dropboxapi.com/2/sharing/get_folder_metadata?"
end db2_get_folder_metadata_URL 

function db2_list_folders_URL
    return "https://api.dropboxapi.com/2/sharing/list_folders?"
end db2_list_folders_URL 

function db2_share_folder_URL
    return "https://api.dropboxapi.com/2/sharing/share_folder?"
end db2_share_folder_URL 

function db2_update_folder_policy_URL
    return "https://api.dropboxapi.com/2/sharing/update_folder_policy?"
end db2_update_folder_policy_URL 

function db2_unshare_folder_URL
    return "https://api.dropboxapi.com/2/sharing/unshare_folder?"
end db2_unshare_folder_URL 

function db2_transfer_folder_URL
    return "https://api.dropboxapi.com/2/sharing/transfer_folder?"
end db2_transfer_folder_URL 

function db2_unmount_folder_URL
    return "https://api.dropboxapi.com/2/sharing/unmount_folder?"
end db2_unmount_folder_URL 

function db2_mount_folder_URL
    return "https://api.dropboxapi.com/2/sharing/mount_folder?"
end db2_mount_folder_URL 

function db2_add_folder_member_URL
    return "https://api.dropboxapi.com/2/sharing/add_folder_member?"
end db2_add_folder_member_URL 

function db2_check_share_job_status_URL
    return "https://api.dropboxapi.com/2/sharing/check_share_job_status?"
end db2_check_share_job_status_URL 

function db2_check_job_status_URL
    return "https://api.dropboxapi.com/2/sharing/check_job_status?"
end db2_check_job_status_URL 

function db2_remove_folder_member_URL
    return "https://api.dropboxapi.com/2/sharing/remove_folder_member?"
end db2_remove_folder_member_URL 

function db2_update_folder_member_URL
    return "https://api.dropboxapi.com/2/sharing/update_folder_member?"
end db2_update_folder_member_URL 

function db2_relinquish_folder_membership_URL
    return "https://api.dropboxapi.com/2/sharing/relinquish_folder_membership?"
end db2_relinquish_folder_membership_URL 

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
   {"path": "/apps/MyApp/season/newrcpstestfile.txt"}
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

function db2_get_shared_links_POST pPath
   /*
   GetSharedLinksArg
   #--path String? See get_shared_links description. This field is optional.
   This API is not supported for App Folder and filetypes apps.
   {"path": "/Apps/MyApp"}
   {} returns all for user
   */
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath))
end db2_get_shared_links_POST

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
   return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("short_url") & ":" & pShortUrl & "," &fGetQ("pending_upload") & ":" & fGetQ(pPendingUpload))
end db2_create_shared_link_POST

function db2_revoke_shared_link_POST pURL
   /*
   RevokeSharedLinkArg
   #--url String URL of the shared link.
   --needs to be full url not short url
   {"url":"https://www.dropbox.com/s/xm2rco8624tno9g/seasons.txt?dl=0"}
   */
   return fGetCB(fGetQ("url") & ":" &  fGetQ(pURL))
end db2_revoke_shared_link_POST

function db2_get_folder_metadata_POST pSharedFolderId,pIncludeMembership
   /*
   GetMetadataArgs
   #--shared_folder_id String The ID for the shared folder.
   #--include_membership Boolean If True, user and group membership included in the response. 
   The default for this field is True.
   {"shared_folder_id": "15432343","include_membership": true}
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("include_membership") & ":" & pIncludeMembership)
end db2_get_folder_metadata_POST

function db2_list_folders_POST pIncludeMembership
   /*
   ListFoldersArgs
   #--include_membership Boolean If include user and group membership information in the response. 
   The default for this field is False.
   */
   return fGetCB(fGetQ("include_membership") & ":" &  pIncludeMembership)
end db2_list_folders_POST

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
  return fGetCB(fGetQ("path") & ":" &  fGetQ(pPath) & "," &fGetQ("member_policy") & ":" & fGetQ(pMemberPolicy) & "," &fGetQ("acl_update_policy") & ":" & fGetQ(pAclUpdatePolicy) & "," &fGetQ("shared_link_policy") & ":" & fGetQ(pSharedLinkPolicy) & "," &fGetQ("force_async") & ":" & pForceAsync)
end db2_share_folder_POST

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
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("member_policy") & ":" & fGetQ(pMemberPolicy) & "," &fGetQ("acl_update_policy") & ":" & fGetQ(pAclUpdatePolicy) & "," &fGetQ("shared_link_policy") & ":" & fGetQ(pSharedLinkPolicy))
end db2_update_folder_policy_POST

function db2_unshare_folder_POST pSharedFolderId,pLeaveACopy
   /*
   UnshareFolderArg
   #--shared_folder_id String The ID for the shared folder.
   #--leave_a_copy Boolean If true, members of this shared folder will get a copy of this folder after it's unshared. 
   Otherwise, it will be removed from their Dropbox. The current user, who is an owner, will always retain their copy.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("leave_a_copy") & ":" & pLeaveACopy)
end db2_unshare_folder_POST

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

function db2_mount_folder_POST pSharedFolderId
   /*
   MountFolderArg
   #--shared_folder_id String The ID of the shared folder to mount.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId))
end db2_mount_folder_POST

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
   ##----access_level AccessLevel The access level to grant member to the shared folder. AccessLevel.owner is disallowed.
   AccessLevel (open union)
   Defines the access levels for collaborators.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   ###------owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   ###------editor Void The collaborator can both view and edit the shared folder.
   ###------viewer Void The collaborator can only view the shared folder.
   #--quiet Boolean Whether added members should be notified via email and device notifications of their invite. The default for this field is False.
   #--custom_message String? Optional message to display to added members in their invitation. This field is optional.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("members") & ":" & fGetQ(pMembers) & "," &fGetQ("quiet") & ":" & pQuiet & "," &fGetQ("custom_message") & ":" & fGetQ(pCustomMessage))
end db2_add_folder_member_POST

function db2_check_share_job_status_POST pAsyncJobId
   /*
   PollArg
   Arguments for methods that poll the status of an asynchronous job.
   #--async_job_id String Id of the asynchronous job. This is the value of a response returned from the method
   that launched the job.
   */
   return fGetCB(fGetQ("async_job_id") & ":" &  fGetQ(pAsyncJobId))
end db2_check_share_job_status_POST

function db2_check_job_status_POST pAsyncJobId
   /*
   PollArg
   Arguments for methods that poll the status of an asynchronous job.
   #--async_job_id String Id of the asynchronous job. This is the value of a response returned from the method that launched the job.
   */
   return fGetCB(fGetQ("async_job_id") & ":" &  fGetQ(pAsyncJobId))
end db2_check_job_status_POST

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
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId) & "," &fGetQ("member") & ":" & fGetQ(pMember) & "," &fGetQ("access_level") & ":" & fGetQ(pAccessLevel))
end db2_update_folder_member_POST

function db2_relinquish_folder_membership_POST pSharedFolderId
   /*
   RelinquishFolderMembershipArg
   #--shared_folder_id String The ID for the shared folder.
   */
   return fGetCB(fGetQ("shared_folder_id") & ":" &  fGetQ(pSharedFolderId))
end db2_relinquish_folder_membership_POST
