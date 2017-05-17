/*
to fix still:
db2_upload_session_finish_batch
db2_upload_session_finish_batch_check
write array to handle returned responses and data.
suggested automatically repeat loops with 10 chars of text at a time to be uploaded --10 can be replaced with 10000 later.

1.1
Listed main returned metadata seperately
Added returned info to scripts which are shown in the response text field on clicking call
Deprecated calls coloured
db2_upload_session_append,db2_remove_file_member,db2_create_shared_link,db2_get_shared_links
-------------
A number of calls are in alpha or beta and have not been able to be tested fully. eg properties and templates
-------------
added textencode utf-8 for all posts via fGetDropboxAPI2 and db2_API2
--------------
Numerous other bug fixes with all calls tested.
The Green edit script to text button added to test the library calls manually in its script by removing -- for lines of code.

-----------------
additions:
auth:
db2_token_revoke
files
db2_alpha_get_metadata
db2_alpha_upload
db2_copy_reference_get
db2_copy_reference_save
db2_get_temporary_link
db2_properties_add
db2_properties_overwrite
db2_properties_remove
db2_properties_template_get
db2_properties_template_list
db2_properties_update
db2_save_url
db2_save_url_check_job_status
db2_upload_session_append_v2
db2_upload_session_finish_batch
db2_upload_session_finish_batch_check
Sharing:
db2_add_file_member
db2_check_remove_member_job_status
db2_get_file_metadata
db2_get_file_metadata_batch
db2_list_file_members
db2_list_file_members_batch
db2_list_file_members_continue
db2_list_received_files
db2_list_received_files_continue
db2_relinquish_file_membership
--/files/download_member
db2_remove_file_member_2
db2_unshare_file

----------------------------------------------------------------------------------
Shared Folder ID Format Change
The tags shared_folder_id and parent_shared_folder_id in the API response from 
--/files/copy string(dbsfid:BCcDKIi3BO5uA9Kzv1v7I9MBJiqoXZXx7Fo) to a raw id string(123456). 
This is equivalent to the id returned in API v1.
The following routes are affected as they return shared_folder_id or parent_shared_folder_id:
/files/copy
/files/create_folders
/files/delete
/files/download
/files/get_metadata
/files/get_preview
/files/get_thumbnail
/files/list_folders
/files/list_folders/continue
/files/move
/files/restore
/files/search
/files/upload


/sharing/list_folders/finish
/sharing/check_share_job_status
/sharing/get_folder_metadata
/sharing/list_folders
/sharing/list_folders/continue
/sharing/mount_folder
/sharing/share_folder
/sharing/update_folder_policy
Migrate to the raw IDs by calling /sharing/get_folder_metadata with the encoded IDs to retrieve the raw ID for any stored folder ids.

---------------------------------------
1.07 
added descriptions to all

issues: dropbox itself not working properly for: (seem to be fixed before July 2016)
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

---------------------------------------
1.06 additions:
db2_create_shared_link_with_settings

---------------------------------------
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
v1.1
July 4 2016
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

users:
db2_get_account
db2_get_current_account
db2_get_space_usage
db2_get_account_batch

db2_get_metadata
db2_list_folder-longpoll
db2_list_folder
db2_list_folder-continue
db2_list_folder-get_latest_cursor
db2_download
db2_upload_session-start
db2_upload_session-append
db2_upload_session-finish
db2_upload
db2_search
db2_create_folder
db2_delete
db2_permanently_delete
db2_copy
db2_move
db2_get_thumbnail
db2_get_preview
db2_list_revisions
db2_restore

sharing:
db2_get_shared_links
db2_change_file_member_access
db2_create_shared_link
db2_revoke_shared_link
db2_get_folder_metadata
db2_list_folders
db2_share_folder
db2_update_folder_policy
db2_unshare_folder
db2_transfer_folder
db2_unmount_folder
db2_mount_folder
db2_add_folder_member
db2_check_share_job_status
db2_check_job_status
db2_remove_folder_member
db2_update_folder_member
db2_relinquish_folder_membership
*/

/*
Shared folder notes
If you give people edit access to a folder in your Dropbox, it becomes a shared folder. 
Changes to the contents of these shared folders are synced to everyone who has access to the shared folder.
People with edit access can:
edit files
comment on files
and view files
Note: Make sure you pick a good name for the shared folder as the name of a shared folder can't be changed once it is created 
(you can change it locally but new and existing members will see the original name).
   
Free teams are built for Basic and Pro users who work together at the same company or on the same projects.When you create or join a free team, you get access to:
The team folder
The team folder is a company- or organization-wide folder that’s automatically shared with all members of a free team. 
Changes to a file in the team folder will reflect in the work Dropbox of each team member.
All sub-folders in the team folder are automatically shared with your entire free team; however, if you’re working on a project 
with external collaborators, you can choose to share certain sub-folders with those contributors as well. 
If you're the owner of a shared folder, you can easily keep company information in one place by dragging existing shared folders into the team folder from your desktop or move them at dropbox.com.
A separate work and personal Dropbox
Team members can connect work and personal Dropbox accounts, and easily toggle between the two. 
Both accounts are accessible on dropbox.com, and on any connected computer or mobile device.
Groups
A group is a preset list of members. By creating a group you can share files or folders with everyone in that list with a single click, 
rather than adding colleagues one-by-one.
Sharing controls
Team members can limit access to shared folders and links to team members only.
Dropbox Pro users: You can control who has access to your shared links and for how long by setting passwords and expirations.
Dropbox Business or team users: You can create groups to share with specific team members. 
Dropbox Business users can also control who has access to shared links and for how long by setting passwords and expirations.
Dropbox Pro and Dropbox Business users: You can prevent others from adding, editing, or deleting files in your shared folder 
by setting view-only permissions.
*/
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--------auth---------------------------------------------------------------

function db2_token_revoke pAccessToken
   /*
   
   */
   put db2_token_revoke_HEADER(pAccessToken) into tHeader
   put db2_token_revoke_POST() into tPost
   put db2_token_revoke_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values.
   */
end db2_token_revoke

-----------------------------------------------------------------------------
---------users-----------------------------------------------------------

function db2_get_account pAccessToken,pUserAccountID
   /*
   GetAccountArg
   #--account_id String(min_length=40, max_length=40) A user's account identifier. 
   */
   put db2_get_account_HEADER(pAccessToken) into tHeader
   put db2_get_account_POST(pUserAccountID) into tPost
   put db2_get_account_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   Returns BasicAccount
   Basic information about any account.
   #--account_id String(min_length=40, max_length=40) The user's unique Dropbox ID. 
   #--name Name Details of a user's name.
   Name
   Representations for a person's name to assist with internationalization.
   #--#--given_name String Also known as a first name.
   #--#--surname String Also known as a last name or family name.
   #--#--familiar_name String Locale-dependent name. In the US, a person's familiar name is their given_name, but elsewhere, it could be any combination of a person's given_name and surname.
   #--#--display_name String A name that can be used directly to represent the name of a user's Dropbox account.
   #--email String The user's e-mail address. Do not rely on this without checking the email_verified field. Even then, it's possible that the user has since lost access to their e-mail.
   #--email_verified Boolean Whether the user has verified their e-mail address.
   #--disabled Boolean Whether the user has been disabled.
   #--is_teammate Boolean Whether this user is a teammate of the current user. If this account is the current user's account, then this will be true.
   #--profile_photo_url String? URL for the photo representing the user, if one is set. 
   This field is optional.
   #--team_member_id String? The user's unique team member id. This field will only be present if the user is part of a team and is_teammate is true. 
   This field is optional.
   */
end db2_get_account

function db2_get_account_batch pAccessToken,pUserAccountIDs
   /*
   ##pUserAccountIDs on separate lines
   GetAccountBatchArg
   #--account_ids List of (String(min_length=40, max_length=40), min_items=1) List of user account identifiers. Should not contain any duplicate account IDs. 
   */
   put db2_get_account_batch_HEADER(pAccessToken) into tHeader
   put db2_get_account_batch_POST(pUserAccountIDs) into tPost
   put db2_get_account_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   Returns returns a list of BasicAccount
   Basic information about any account.
   #--account_id String(min_length=40, max_length=40) The user's unique Dropbox ID. 
   #--name Name Details of a user's name.
   Name
   Representations for a person's name to assist with internationalization.
   #--#--given_name String Also known as a first name.
   #--#--surname String Also known as a last name or family name.
   #--#--familiar_name String Locale-dependent name. In the US, a person's familiar name is their given_name, but elsewhere, it could be any combination of a person's given_name and surname.
   #--#--display_name String A name that can be used directly to represent the name of a user's Dropbox account.
   #--email String The user's e-mail address. Do not rely on this without checking the email_verified field. Even then, it's possible that the user has since lost access to their e-mail.
   #--email_verified Boolean Whether the user has verified their e-mail address.
   #--disabled Boolean Whether the user has been disabled.
   #--is_teammate Boolean Whether this user is a teammate of the current user. If this account is the current user's account, then this will be true.
   #--profile_photo_url String? URL for the photo representing the user, if one is set. 
   This field is optional.
   #--team_member_id String? The user's unique team member id. This field will only be present if the user is part of a team and is_teammate is true. 
   This field is optional.
   */
end db2_get_account_batch

function db2_get_current_account pAccessToken
   /*
   No parameters. Null required for POST; empty value fails.
   */
   put db2_get_current_account_HEADER(pAccessToken) into tHeader
   put db2_get_current_account_POST() into tPost
   put db2_get_current_account_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   FullAccount
   Detailed information about the current user's account.
   #--account_id String(min_length=40, max_length=40) The user's unique Dropbox ID. 
   #--name Name Details of a user's name.
   Name
   Representations for a person's name to assist with internationalization.
   #--#--given_name String Also known as a first name.
   #--#--surname String Also known as a last name or family name.
   #--#--familiar_name String Locale-dependent name. In the US, a person's familiar name is their given_name, but elsewhere, it could be any combination of a person's given_name and surname.
   #--#--display_name String A name that can be used directly to represent the name of a user's Dropbox account.
   #--email String The user's e-mail address. Do not rely on this without checking the email_verified field. Even then, it's possible that the user has since lost access to their e-mail.
   #--email_verified Boolean Whether the user has verified their e-mail address.
   #--disabled Boolean Whether the user has been disabled.
   #--locale String(min_length=2) The language that the user specified. Locale tags will be IETF language tags.
   #--referral_link String The user's referral link.
   #--is_paired Boolean Whether the user has a personal and work account. If the current account is personal, then team will always be None, but is_paired will indicate if a work account is linked.
   #--account_type AccountType What type of account this user has.
   AccountType (union)
   What type of account this user has. The value will be one of the following datatypes:
   #--#--basic Void The basic account type.
   #--#--pro Void The Dropbox Pro account type.
   #--#--business Void The Dropbox Business account type.
   #--profile_photo_url String? URL for the photo representing the user, if one is set. 
   This field is optional.
   #--country String(min_length=2, max_length=2)? The user's two-letter country code, if available. Country codes are based on ISO 3166-1. 
   This field is optional.
   #--team FullTeam? If this account is a member of a team, information about that team. 
   This field is optional.
   FullTeam
   Detailed information about a team.
   #--#--id String The team's unique ID.
   #--#--name String The name of the team.
   #--#--sharing_policies TeamSharingPolicies Team policies governing sharing.
   TeamSharingPolicies
   Policies governing sharing within and outside of the team. This datatype comes from an imported namespace originally defined in the team_policies namespace.
   #--#--#--shared_folder_member_policy SharedFolderMemberPolicy Who can join folders shared by team members.
   SharedFolderMemberPolicy (open union)
   Policy governing who can be a member of a folder shared by a team member. This datatype comes from an imported namespace originally defined in the team_policies namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--team Void Only a teammate can be a member of a folder shared by a team member.
   #--#--#--#--anyone Void Anyone can be a member of a folder shared by a team member.
   #--#--#--shared_folder_join_policy SharedFolderJoinPolicy Which shared folders team members can join.
   SharedFolderJoinPolicy (open union)
   Policy governing which shared folders a team member can join. This datatype comes from an imported namespace originally defined in the team_policies namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--from_team_only Void Team members can only join folders shared by teammates.
   #--#--#--#--from_anyone Void Team members can join any shared folder, including those shared by users outside the team.
   #--#--#--shared_link_create_policy SharedLinkCreatePolicy What is the visibility of newly created shared links.
   SharedLinkCreatePolicy (open union)
   Policy governing the visibility of newly created shared links. This datatype comes from an imported namespace originally defined in the team_policies namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--default_public Void By default, anyone can access newly created shared links. No login will be required to access the shared links unless overridden.
   #--#--#--#--default_team_only Void By default, only members of the same team can access newly created shared links. Login will be required to access the shared links unless overridden.
   #--#--#--#--team_only Void Only members of the same team can access newly created shared links. Login will be required to access the shared links.
   #--team_member_id String? This account's unique team member id. This field will only be present if team is present. 
   This field is optional.
   */
end db2_get_current_account

function db2_get_space_usage pAccessToken
   /*
   No parameters. Null required for POST; empty value fails.
   */
   put db2_get_space_usage_HEADER(pAccessToken) into tHeader
   put db2_get_space_usage_POST() into tPost
   put db2_get_space_usage_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SpaceUsage
   Information about a user's space usage and quota.
   #--used UInt64 The user's total space usage (bytes).
   #--allocation SpaceAllocation The user's space allocation.
   SpaceAllocation (open union)
   Space is allocated differently based on the type of account. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--individual IndividualSpaceAllocation The user's space allocation applies only to their individual account.
   IndividualSpaceAllocation
   #--#---allocated UInt64 The total space allocated to the user's account (bytes).
   #--#--team TeamSpaceAllocation The user shares space with other members of their team.
   TeamSpaceAllocation
   #--#--used UInt64 The total space currently used by the user's team (bytes).
   #--#--allocated UInt64 The total space allocated to the user's team (bytes).
   */
end db2_get_space_usage

-----------------------------------------------------------------------------
------files------------------------------------------------------

function db2_alpha_get_metadata pAccessToken,pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,pIncludePropertyTemplates
   /*
   pIncludePropertyTemplates needs to be a list of templates one per line
   AlphaGetMetadataArg
   #--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path of a file or folder on Dropbox. 
   #--include_media_info Boolean If true, FileMetadata.media_info is set for photo and video. 
   The default for this field is False.
   #--include_deleted Boolean If true, DeletedMetadata will be returned for deleted file or folder, otherwise LookupError.not_found will be returned. 
   The default for this field is False.
   #--include_has_explicit_shared_members Boolean If true, the results will include a flag for each file indicating whether or not that file has any explicit members. 
   The default for this field is False.
   #--include_property_templates List of (String(min_length=1, pattern="(/|ptid:).*"), )? If true, FileMetadata.property_groups is set for files with custom properties. This field is optional. 
   */
   put db2_alpha_get_metadata_HEADER(pAccessToken) into tHeader
   put db2_alpha_get_metadata_POST(pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,pIncludePropertyTemplates) into tPost
   put db2_alpha_get_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   Metadata (datatype with subtypes)
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--file FileMetadata
   #--folder FolderMetadata
   #--deleted DeletedMetadata
   */
end db2_alpha_get_metadata

function db2_alpha_upload pAccessToken,pPath,pData,pMode,pAutorename,pClientModified,pMute,pTemplateIdFieldsArray
   /*
   --pTemplateIdFieldsArray is an array to store template data
   CommitInfoWithProperties
   #--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") Path in the user's Dropbox to save the file. 
   #--mode WriteMode Selects what to do if the file already exists. The default for this union is add.
   WriteMode (union)
   Your intent when writing a file to some path. This is used to determine what constitutes a conflict and what the autorename strategy is.
   In some situations, the conflict behavior is identical: (a) If the target path doesn't contain anything, the file is always written; no conflict. (b) If the target path contains a folder, it's always a conflict. (c) If the target path contains a file with identical contents, nothing gets written; no conflict.
   The conflict checking differs in the case where there's a file at the target path with contents different from the contents you're trying to write. The value will be one of the following datatypes:
   #--#--add Void Never overwrite the existing file. The autorename strategy is to append a number to the file name. For example, "document.txt" might become "document (2).txt".
   #--#--overwrite Void Always overwrite the existing file. The autorename strategy is the same as it is for add.
   #--#--update String(min_length=9, pattern="[0-9a-f]+") Overwrite if the given "rev" matches the existing file's "rev". The autorename strategy is to append the string "conflicted copy" to the file name. For example, "document.txt" might become "document (conflicted copy).txt" or "document (Panda's conflicted copy).txt".
   #--autorename Boolean If there's a conflict, as determined by mode, have the Dropbox server try to autorename the file to avoid conflict. The default for this field is False.
   #--client_modified Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? The value to store as the client_modified timestamp. Dropbox automatically records the time at which the file was written to the Dropbox servers. It can also record an additional timestamp, provided by Dropbox desktop clients, mobile clients, and API apps of when the file was actually created or modified. 
   This field is optional.
   #--mute Boolean Normally, users are made aware of any file modifications in their Dropbox account via notifications in the client software. If true, this tells the clients that this modification shouldn't result in a user notification. The default for this field is False.
   #--property_groups List of (PropertyGroup)? List of custom properties to add to file. 
   This field is optional.
   PropertyGroup
   Collection of custom properties in filled property templates. This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--template_id String(min_length=1, pattern="(/|ptid:).*") A unique identifier for a property template type.
   #--#--fields List of (PropertyField) This is a list of custom properties associated with a file. There can be up to 32 properties for a template.
   PropertyField
   This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--#--name String This is the name or key of a custom property in a property template. File property names can be up to 256 bytes.
   #--#--#--value String Value of a custom property attached to a file. Values can be up to 1024 bytes.
   --client_modified not implemented yet
   --property_groups not implemented yet
   */
   put db2_alpha_upload_HEADER(pAccessToken,pPath,pMode,pAutorename,pClientModified,pMute,pTemplateIdFieldsArray) into tHeader
   put db2_alpha_upload_POST(pData) into tPost
   put db2_alpha_upload_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   FileMetadata
   */
end db2_alpha_upload

function db2_copy_reference_get pAccessToken,pPath
   /*
   ??seems to require full dropbox acess rather than an app folder
   GetCopyReferenceArg
   #--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") 
   The path to the file or folder you want to get a copy reference to. 
   */
   put db2_copy_reference_get_HEADER(pAccessToken) into tHeader
   put db2_copy_reference_get_POST(pPath) into tPost
   put db2_copy_reference_get_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   GetCopyReferenceResult
   #--metadata Metadata 
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--#--file FileMetadata
   #--#--folder FolderMetadata
   #--#--deleted DeletedMetadata
   #--copy_reference String A copy reference to the file or folder.
   #--expires Timestamp The expiration date of the copy reference. This value is currently set to be far enough in the future so that expiration is effectively not an issue. 
   */
end db2_copy_reference_get

function db2_copy_reference_save pAccessToken,pCopyReference,pPath
   /*
   ??seems to require full dropbox acess rather than an app folder
   SaveCopyReferenceArg
   #--copy_reference String A copy reference returned by copy_reference/get.
   #--path String(pattern="/(.|[\r\n])*") Path in the user's Dropbox that is the destination. 
   */
   put db2_copy_reference_save_HEADER(pAccessToken) into tHeader
   put db2_copy_reference_save_POST(pCopyReference,pPath) into tPost
   put db2_copy_reference_save_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SaveCopyReferenceResult
   #--metadata Metadata The metadata of the saved file or folder in the user's Dropbox.
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--#--file FileMetadata
   #--#--folder FolderMetadata
   #--#--deleted DeletedMetadata
   */
end db2_copy_reference_save

function db2_get_temporary_link pAccessToken,pPath
   /*
   GetTemporaryLinkArg
   #--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path to the file you want a temporary link to. 
   Get a temporary link to stream content of a file. This link will expire in four hours. 
   Content-Type of the link is determined automatically by the file's mime type. 
   */
   put db2_get_temporary_link_HEADER(pAccessToken) into tHeader
   put db2_get_temporary_link_POST(pPath) into tPost
   put db2_get_temporary_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   GetTemporaryLinkResult
   #--metadata FileMetadata
   #--link String The temporary link which can be used to stream content the file. 
   */
end db2_get_temporary_link

function db2_properties_add pAccessToken,pPath,pTemplateIdFieldsArray
   /*
   use pTemplateFieldsArray to store template_id, name, value  eg:
   pTemplateIdFieldsArray[1][template_id]=   ptid:1a5n2i6d3OYEAAAAAAAAAYa
   pTemplateIdFieldsArray[1][fields][1][name]=  SecurityPolicy
   pTemplateIdFieldsArray[1][fields][1][value]= Confidential
   pTemplateIdFieldsArray[1][fields][2][name]=  Author
   pTemplateIdFieldsArray[1][fields][2][value]= A001
   pTemplateIdFieldsArray[2][template_id]=   ptid:1a5n2i6d3OYEAAAAAAAAXXb
   pTemplateIdFieldsArray[2][fields][1][name]=  Topic
   pTemplateIdFieldsArray[2][fields][1][value]= Science
   pTemplateIdFieldsArray[2][fields][2][name]=  SubTopic
   pTemplateIdFieldsArray[2][fields][2][value]= Biology
   --
   PropertyGroupWithPath
   #--path String(pattern="/(.|[\r\n])*|id:.*|(ns:[0-9]+(/.*)?)") A unique identifier for the file. 
   #--property_groups List of (PropertyGroup) Filled custom property templates associated with a file.
   PropertyGroup
   Collection of custom properties in filled property templates. This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--template_id String A unique identifier for a property template type.
   #--#--fields List of (PropertyField) This is a list of custom properties associated with a file. 
   There can be up to 32 properties for a template.
   PropertyField
   This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--#--name String This is the name or key of a custom property in a property template. 
   File property names can be up to 256 bytes.
   #--#--#--value String Value of a custom property attached to a file. Values can be up to 1024 bytes.
   */
   put db2_properties_add_HEADER(pAccessToken) into tHeader
   put db2_properties_add_POST(pPath,pTemplateIdFieldsArray) into tPost
   put db2_properties_add_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values.  Returns null for empty template
   */
end db2_properties_add

function db2_properties_overwrite pAccessToken,pPath,pTemplateIdFieldsArray
   /*
   PropertyGroupWithPath
   #--path String(pattern="/(.|[\r\n])*|id:.*|(ns:[0-9]+(/.*)?)") A unique identifier for the file. 
   #--property_groups List of (PropertyGroup) Filled custom property templates associated with a file.
   PropertyGroup
   Collection of custom properties in filled property templates. This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--template_id String A unique identifier for a property template type.
   #--#--fields List of (PropertyField) This is a list of custom properties associated with a file. 
   There can be up to 32 properties for a template.
   PropertyField
   This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--#--name String This is the name or key of a custom property in a property template. 
   File property names can be up to 256 bytes.
   #--#--#--value String Value of a custom property attached to a file. Values can be up to 1024 bytes.
   */
   put db2_properties_overwrite_HEADER(pAccessToken) into tHeader
   put db2_properties_overwrite_POST(pPath,pTemplateIdFieldsArray) into tPost
   put db2_properties_overwrite_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_properties_overwrite

function db2_properties_remove pAccessToken,pPath,pTemplateIDs
   /*
   --pass pTemplateIDs with ids on seperate lines
   RemovePropertiesArg
   #--path String(pattern="/(.|[\r\n])*|id:.*|(ns:[0-9]+(/.*)?)") A unique identifier for the file.
   #--property_template_ids List of (String(min_length=1, pattern="(/|ptid:).*"), ) A list of identifiers for a property template created by route properties/template/add. 
   */
   put db2_properties_remove_HEADER(pAccessToken) into tHeader
   put db2_properties_remove_POST(pPath,pTemplateIDs) into tPost
   put db2_properties_remove_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_properties_remove

function db2_properties_template_add pAccessToken,pTemplateDescriptionArray
   /*
   NOT FUNCTIONAL YET
   pTemplateDescriptionArray would be an array containing the template name and description and field names and descriptions.
   */
   put db2_properties_template_add_HEADER(pAccessToken) into tHeader
   put db2_properties_template_add_POST(pTemplateDescriptionArray) into tPost
   put db2_properties_template_add_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa"}
   AddPropertyTemplateResult
   #--template_id String An identifier for property template added
   */
end db2_properties_template_add

function db2_properties_template_get pAccessToken,pTemplateID
   /*
   GetPropertyTemplateArg
   This datatype comes from an imported namespace originally defined in the properties namespace.
   #--template_id String An identifier for property template added by route properties/template/add.
   */
   put db2_properties_template_get_HEADER(pAccessToken) into tHeader
   put db2_properties_template_get_POST(pTemplateID) into tPost
   put db2_properties_template_get_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   GetPropertyTemplateResult
   The Property template for the specified template. This datatype comes from an imported namespace originally defined in the properties namespace.
   #--name String A display name for the property template. Property template names can be up to 256 bytes.
   #--description String Description for new property template. Property template descriptions can be up to 1024 bytes.
   #--fields List of (PropertyFieldTemplate) This is a list of custom properties associated with a property template. There can be up to 64 properties in a single property template.
   PropertyFieldTemplate
   Describe a single property field type which that can be part of a property template. This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--name String This is the name or key of a custom property in a property template. File property names can be up to 256 bytes.
   #--#--description String This is the description for a custom property in a property template. File property description can be up to 1024 bytes.
   #--#--type PropertyType This is the data type of the value of this property. This type will be enforced upon property creation and modifications.
   PropertyType (open union)
   Data type of the given property added. This endpoint is in beta and only properties of type strings is supported. This datatype comes from an imported namespace originally defined in the properties namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--string Void The associated property will be of type string. Unicode is supported.
   */
end db2_properties_template_get

function db2_properties_template_list pAccessToken
   /*
   no parameters
   */
   put db2_properties_template_list_HEADER(pAccessToken) into tHeader
   put db2_properties_template_list_POST() into tPost
   put db2_properties_template_list_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   {"template_ids": ["ptid:1a5n2i6d3OYEAAAAAAAAAYa","ptid:1a5n2i6d3OYEAAAAAAAAXXB"]}
   ListPropertyTemplateIds
   #--template_ids List of (String) List of identifiers for templates added by route properties/template/add.
   */
end db2_properties_template_list

function db2_properties_update pAccessToken,pPath,pTemplateIdFieldsArray
   /*
   {"path": "folder1/testfile2.txt",
   "update_property_groups": [{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa",
   "add_or_update_fields": [{"name": "Security Policy","value": "Confidential"}],
   "remove_fields": []}]}
   --
    UpdatePropertyGroupArg
   #--path String(pattern="/(.|[\r\n])*|id:.*|(ns:[0-9]+(/.*)?)") A unique identifier for the file. 
   #--update_property_groups List of (PropertyGroupUpdate) Filled custom property templates associated with a file.
   PropertyGroupUpdate
   #--template_id String A unique identifier for a property template.
   #--add_or_update_fields List of (PropertyField)? List of property fields to update if the field already exists. 
   If the field doesn't exist, add the field to the property group. 
   This field is optional.
   PropertyField
   This datatype comes from an imported namespace originally defined in the properties namespace.
   #--name String This is the name or key of a custom property in a property template. File property names can be up to 256 bytes.
  #--value String Value of a custom property attached to a file. Values can be up to 1024 bytes.
   #--remove_fields List of (String)? List of property field names to remove from property group if the field exists. 
   This field is optional.
   */
   put db2_properties_update_HEADER(pAccessToken) into tHeader
   put db2_properties_update_POST(pPath,pTemplateIdFieldsArray) into tPost
   put db2_properties_update_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_properties_update

function db2_save_url pAccessToken,pPath,pUrlToSave
   /*
   SaveUrlArg
   #--path String(pattern="/(.|[\r\n])*") The path in Dropbox where the URL will be saved to. 
   #--url String The URL to be saved.
   */
   put db2_save_url_HEADER(pAccessToken) into tHeader
   put db2_save_url_POST(pPath,pUrlToSave) into tPost
   put db2_save_url_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SaveUrlResult (union)
   The value will be one of the following datatypes:
   #--async_job_id String This response indicates that the processing is asynchronous. The string is an id that can be used to obtain the status of the asynchronous job.
   #--complete FileMetadata Metadata of the file where the URL is saved to.
   */
end db2_save_url

function db2_save_url_check_job_status pAccessToken,pAsyncJobId
   /*
   PollArg
   Arguments for methods that poll the status of an asynchronous job. This datatype comes from an imported namespace originally defined in the async namespace.
   #--async_job_id String Id of the asynchronous job. This is the value of a response returned from the method that launched the job.
   */
   put db2_save_url_check_job_status_HEADER(pAccessToken) into tHeader
   put db2_save_url_check_job_status_POST(pAsyncJobId) into tPost
   put db2_save_url_check_job_status_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SaveUrlJobStatus (union)
   The value will be one of the following datatypes:
   #--in_progress Void The asynchronous job is still in progress.
   #--complete FileMetadata Metadata of the file where the URL is saved to.
   FileMetadata
   #--failed SaveUrlError
   SaveUrlError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--path WriteError
   WriteError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--malformed_path String? 
   This field is optional.
   #--#--conflict WriteConflictError Couldn't write to the target path because there was something in the way.
   WriteConflictError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--file Void There's a file in the way.
   #--#--#--folder Void There's a folder in the way.
   #--#--#--file_ancestor Void There's a file at an ancestor path, so we couldn't create the required parent folders.
   #--#--no_write_permission Void The user doesn't have permissions to write to the target location.
   #--#--insufficient_space Void The user doesn't have enough available space (bytes) to write more data.
   #--#--disallowed_name Void Dropbox will not save the file or folder because of its name.
   #--download_failed Void Failed downloading the given URL.
   #--invalid_url Void The given URL is invalid.
   #--not_found Void The file where the URL is saved to no longer exists.
   */
end db2_save_url_check_job_status

function db2_upload_session_append_v2 pAccessToken,pSessionID,pOffset,pClose,pData
   /*
   UploadSessionAppendArg
   #--cursor UploadSessionCursor Contains the upload session ID and the offset.
   UploadSessionCursor
   #--session_id String The upload session ID (returned by upload_session/start).
   #--offset UInt64 The amount of data that has been uploaded so far. We use this to make sure upload data isn't lost or duplicated in the event of a network error.
   #--close Boolean If true, the current session will be closed, at which point you won't be able to call upload_session/append_v2 anymore with the current session. 
   The default for this field is False.
   */
   put db2_upload_session_append_v2_HEADER(pAccessToken,pSessionID,pOffset,pClose) into tHeader
   put db2_upload_session_append_v2_POST(pData) into tPost
   put db2_upload_session_append_v2_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_upload_session_append_v2
--------------------------------------------------------------------------------------

function db2_copy pAccessToken,pPathFrom,pPathTo
   /*
   db2_copy(tAouth2accesstoken,"/folder1","/folder2")
   RelocationArg
   #--from_path String Path in the user's Dropbox to be copied or moved.
   #--to_path String Path in the user's Dropbox that is the destination.
   */
   put db2_copy_HEADER(pAccessToken) into tHeader
   put db2_copy_POST(pPathFrom,pPathTo) into tPost
   put db2_copy_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   Metadata (datatype with subtypes)
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--file FileMetadata
   #--folder FolderMetadata
   #--deleted DeletedMetadata
   */
end db2_copy

function db2_create_folder pAccessToken,pPath
   /*
   CreateFolderArg
   #--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") Path in the user's Dropbox to create. 
   */
   put db2_create_folder_HEADER(pAccessToken) into tHeader
   put db2_create_folder_POST(pPath) into tPost
   put db2_create_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   FolderMetadata
   */
end db2_create_folder

function db2_delete pAccessToken,pPath
   /*
   DeleteArg
   #--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") Path in the user's Dropbox to delete. 
   file or folder
   */
   put db2_delete_HEADER(pAccessToken) into tHeader
   put db2_delete_POST(pPath) into tPost
   put db2_delete_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   Metadata (datatype with subtypes)
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--file FileMetadata
   #--folder FolderMetadata
   #--deleted DeletedMetadata
   */
end db2_delete

function db2_download pAccessToken,pPath
   /*
   DownloadArg
   #--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path of the file to download. 
   #--XX--rev String(min_length=9, pattern="[0-9a-f]+")? Deprecated. Please specify revision in path instead 
   This field is optional.
   Example: string {"path": "/folder1/testfile1.txt"}
   Example: id {"path": "id:vPnA7HCkSoAAAAAAAAAAAQ"}
   Example: rev  {"path": "rev:c73e457377"}
   */
   put db2_download_HEADER(pAccessToken,pPath) into tHeader
   put db2_download_POST() into tPost
   put db2_download_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   --contents of the file
   --FileMetadata??
   */
end db2_download

function db2_get_metadata pAccessToken,pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers
   /*
   GetMetadataArg
   #--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path of a file or folder on Dropbox. 
   #--include_media_info Boolean If true, FileMetadata.media_info is set for photo and video. The default for this field is False.
   #--include_deleted Boolean If true, DeletedMetadata will be returned for deleted file or folder, otherwise LookupError.not_found will be returned. The default for this field is False.
   #--include_has_explicit_shared_members Boolean If true, the results will include a flag for each file indicating whether or not that file has any explicit members. The default for this field is False.
   */
   put db2_get_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_metadata_POST(pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers) into tPost
   put db2_get_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   Metadata (datatype with subtypes)
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--file FileMetadata
   #--folder FolderMetadata
   #--deleted DeletedMetadata
   */
end db2_get_metadata

function db2_get_preview pAccessToken,pPath
   /*
   PreviewArg
   #--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path of the file to preview. 
   #--XX--rev String(min_length=9, pattern="[0-9a-f]+")? Deprecated. Please specify revision in path instead 
   This field is optional.
   For extensions: .doc, .docx, .docm, .ppt, .pps, .ppsx, .ppsm, .pptx, .pptm, .xls, .xlsx, .xlsm, .rtf 
   */
   put db2_get_preview_HEADER(pAccessToken,pPath) into tHeader
   put db2_get_preview_POST() into tPost
   put db2_get_preview_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   PDF version of contents of file
   FileMetadata??
   docx goes to pdf
   xlsx goes to html
   */
end db2_get_preview

function db2_get_thumbnail pAccessToken,pPath,pFormat,pSize
   /*
   Get a thumbnail for an image; file extensions: jpg, jpeg, png, tiff, tif, gif and bmp. 
   Photos that are larger than 20MB in size won't be converted to a thumbnail. 
   ThumbnailArg
   #--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path to the file you want a temporary link to. 
   #--format ThumbnailFormat The format for the thumbnail image, jpeg (default) or png. For images that are photos, jpeg should be preferred, while png is better for screenshots and digital arts. The default for this union is jpeg.
   ThumbnailFormat (union)
   The value will be one of the following datatypes:
   #--#--jpeg Void
   #--#--png Void
   #--size ThumbnailSize The size for the thumbnail image. The default for this union is w64h64.
   Possible sizes: w32h32,w64h64,w128h128,w640h480,w1024h768
   {"path": "/testpic.jpg","format": "jpeg","size": "w64h64"}
   */
   put db2_get_thumbnail_HEADER(pAccessToken,pPath,pFormat,pSize) into tHeader
   put db2_get_thumbnail_POST() into tPost
   put db2_get_thumbnail_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   contents of file
   FileMetadata??
   */
end db2_get_thumbnail

function db2_list_folder pAccessToken,pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember
   /*
   ListFolderArg
   #--path String(pattern="(/(.|[\r\n])*)?|(ns:[0-9]+(/.*)?)") The path to the folder you want to see the contents of. 
   #--recursive Boolean If true, the list folder operation will be applied recursively to all subfolders and the response will contain contents of all subfolders. 
   The default for this field is False.
   #--include_media_info Boolean If true, FileMetadata.media_info is set for photo and video. 
   The default for this field is False.
   #--include_deleted Boolean If true, the results will include entries for files and folders that used to exist but were deleted. 
   The default for this field is False.
   #--include_has_explicit_shared_members Boolean If true, the results will include a flag for each file indicating whether or not that file has any explicit members. 
   The default for this field is False.
   */
   put db2_list_folder_HEADER(pAccessToken) into tHeader
   put db2_list_folder_POST(pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember) into tPost
   put db2_list_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFolderResult
   #--entries List of (Metadata) The files and (direct) subfolders in the folder.
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--#--file FileMetadata
   #--#--folder FolderMetadata
   #--#--deleted DeletedMetadata
   #--cursor String Pass the cursor into list_folder/continue to see what's changed in the folder since your previous query.
   #--has_more Boolean If true, then there are more entries available. Pass the cursor to list_folder/continue to retrieve the rest.
   */
end db2_list_folder

function db2_list_folder_continue pAccessToken,pCursor
   /*
   ListFolderContinueArg
   #--cursor String The cursor returned by your last call to list_folder or list_folder/continue.
   */
   put db2_list_folder_continue_HEADER(pAccessToken) into tHeader
   put db2_list_folder_continue_POST(pCursor) into tPost
   put db2_list_folder_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFolderResult
   #--entries List of (Metadata) The files and (direct) subfolders in the folder.
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--#--file FileMetadata
   #--#--folder FolderMetadata
   #--#--deleted DeletedMetadata
   #--cursor String Pass the cursor into list_folder/continue to see what's changed in the folder since your previous query.
   #--has_more Boolean If true, then there are more entries available. Pass the cursor to list_folder/continue to retrieve the rest.
   */
end db2_list_folder_continue

function db2_list_folder_get_latest_cursor pAccessToken,pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember
   /*
   ListFolderArg
   #--path String(pattern="(/(.|[\r\n])*)?|(ns:[0-9]+(/.*)?)") The path to the folder you want to see the contents of. 
   #--recursive Boolean If true, the list folder operation will be applied recursively to all subfolders and the response will contain contents of all subfolders. 
   The default for this field is False.
   #--include_media_info Boolean If true, FileMetadata.media_info is set for photo and video. 
   The default for this field is False.
   #--include_deleted Boolean If true, the results will include entries for files and folders that used to exist but were deleted. 
   The default for this field is False.
   #--include_has_explicit_shared_members Boolean If true, the results will include a flag for each file indicating whether or not that file has any explicit members. 
   The default for this field is False.
   */
   put db2_list_folder_get_latest_cursor_HEADER(pAccessToken) into tHeader
   put db2_list_folder_get_latest_cursor_POST(pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember) into tPost
   put db2_list_folder_get_latest_cursor_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFolderGetLatestCursorResult
   #--cursor String Pass the cursor into list_folder/continue to see what's changed in the folder since your previous query.
   */
end db2_list_folder_get_latest_cursor

function db2_list_folder_longpoll pCursor,pTimeout
   /*
   Documented url is  https://notify.dropboxapi.com/2/files/list_folder/longpoll?
   This is working as of July 2016:  https://notify.dropboxapi.com/2-beta-2/files/list_folder/longpoll?
   --
   ListFolderLongpollArg
   #--cursor String A cursor as returned by list_folder or list_folder/continue. Cursors retrieved by setting ListFolderArg.include_media_info to true are not supported.
   #--timeout UInt64 A timeout in seconds. 
   The request will block for at most this length of time, plus up to 90 seconds of random jitter added to avoid the thundering herd problem. 
   Care should be taken when using this parameter, as some network infrastructure does not support long timeouts. The default for this field is 30.
   Must be in range 30 to 480
   */
   put db2_list_folder_longpoll_HEADER() into tHeader
   put db2_list_folder_longpoll_POST(pCursor,pTimeout) into tPost
   put db2_list_folder_longpoll_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFolderLongpollResult
   #--changes Boolean Indicates whether new changes are available. If true, call list_folder/continue to retrieve the changes.
   #--backoff UInt64? If present, backoff for at least this many seconds before calling list_folder/longpoll again. 
   This field is optional.
   */
end db2_list_folder_longpoll

function db2_list_revisions pAccessToken,pPath,pLimit
   /*
   ListRevisionsArg
   #--path String(pattern="/(.|[\r\n])*|id:.*|(ns:[0-9]+(/.*)?)") The path to the file you want to see the revisions of. 
   #--limit UInt64 The maximum number of revision entries returned. The default for this field is 10.
   Must be in range 1 to 100
      */
   put db2_list_revisions_HEADER(pAccessToken) into tHeader
   put db2_list_revisions_POST(pPath,pLimit) into tPost
   put db2_list_revisions_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListRevisionsResult
   is_deleted Boolean If the file is deleted.
   entries List of (FileMetadata) The revisions for the file. Only non-delete revisions will show up here.
   FileMetadata
   */
end db2_list_revisions

function db2_move pAccessToken,pPathFrom,pPathTo
   /*
   RelocationArg
   #--from_path String Path in the user's Dropbox to be copied or moved.
   #--to_path String Path in the user's Dropbox that is the destination.
   */
   put db2_move_HEADER(pAccessToken) into tHeader
   put db2_move_POST(pPathFrom,pPathTo) into tPost
   put db2_move_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   Metadata (datatype with subtypes)
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--file FileMetadata
   #--folder FolderMetadata
   #--deleted DeletedMetadata
   */
end db2_move

function db2_permanently_delete pAccessToken,pPath
   /*
   DeleteArg
   #--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") Path in the user's Dropbox to delete. 
   */
   put db2_permanently_delete_HEADER(pAccessToken) into tHeader
   put db2_permanently_delete_POST(pPath) into tPost
   put db2_permanently_delete_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_permanently_delete

function db2_restore pAccessToken,pPath,pRevision
   /*
   RestoreArg
   #--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") The path to the file you want to restore. 
   #--rev String(min_length=9, pattern="[0-9a-f]+")? The revision to restore for the file.
   */
   put db2_restore_HEADER(pAccessToken) into tHeader
   put db2_restore_POST(pPath,pRevision) into tPost
   put db2_restore_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   FileMetadata
   */
end db2_restore

function db2_search pAccessToken,pPath,pQuery,pStart,pMaxResults,pMode
   /*
   SearchArg
   #--path String(pattern="(/(.|[\r\n])*)?|(ns:[0-9]+(/.*)?)") The path in the user's Dropbox to search. Should probably be a folder. 
   #--query String The string to search for. The search string is split on spaces into multiple tokens. For file name searching, the last token is used for prefix matching (i.e. "bat c" matches "bat cave" but not "batman car").
   #--start UInt64 The starting index within the search results (used for paging). The default for this field is 0.
   #--max_results UInt64 The maximum number of search results to return. The default for this field is 100.
   #--mode SearchMode The search mode (filename, filename_and_content, or deleted_filename). Note that searching file content is only available for Dropbox Business accounts. The default for this union is filename.
   SearchMode (union)
   The value will be one of the following datatypes:
   #--#--filename Void Search file and folder names.
   #--#--filename_and_content Void Search file and folder names as well as file contents.
   #--#--deleted_filename Void Search for deleted file and folder names.
   */
   put db2_search_HEADER(pAccessToken) into tHeader
   put db2_search_POST(pPath,pQuery,pStart,pMaxResults,pMode) into tPost
   put db2_search_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SearchResult
   #--matches List of (SearchMatch) A list (possibly empty) of matches for the query.
   SearchMatch
   #--#--match_type SearchMatchType The type of the match.
   SearchMatchType (union)
   Indicates what type of match was found for a given item. The value will be one of the following datatypes:
   filename Void This item was matched on its file or folder name.
   content Void This item was matched based on its file contents.
   both Void This item was matched based on both its contents and its file name.
   #--#--metadata Metadata The metadata for the matched file or folder.
   Metadata (datatype with subtypes)
   Metadata for a file or folder. This datatype will be one of the following subtypes:
   #--#--#--file FileMetadata
   #--#--#--folder FolderMetadata
   #--#--#--deleted DeletedMetadata
   #--more Boolean Used for paging. If true, indicates there is another page of results available that can be fetched by calling search again.
   #--start UInt64 Used for paging. Value to set the start argument to when calling search to fetch the next page of results. 
   */
end db2_search

function db2_upload pAccessToken,pPath,pMode,pAutorename,pMute,pData
   /*
   CommitInfo
   #--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") Path in the user's Dropbox to save the file. 
   #--mode WriteMode Selects what to do if the file already exists. 
   The default for this union is add.
   WriteMode (union)
   Your intent when writing a file to some path. This is used to determine what constitutes a conflict and what the autorename strategy is.
   In some situations, the conflict behavior is identical: (a) If the target path doesn't contain anything, the file is always written; no conflict. (b) If the target path contains a folder, it's always a conflict. (c) If the target path contains a file with identical contents, nothing gets written; no conflict.
   The conflict checking differs in the case where there's a file at the target path with contents different from the contents you're trying to write. The value will be one of the following datatypes:
   #--#--add Void Never overwrite the existing file. The autorename strategy is to append a number to the file name. For example, "document.txt" might become "document (2).txt".
   #--#--overwrite Void Always overwrite the existing file. The autorename strategy is the same as it is for add.
   #--#--update String Overwrite if the given "rev" matches the existing file's "rev". The autorename strategy is to append the string "conflicted copy" to the file name. For example, "document.txt" might become "document (conflicted copy).txt" or "document (Panda's conflicted copy).txt".
   #--autorename Boolean If there's a conflict, as determined by mode, have the Dropbox server try to autorename the file to avoid conflict.
   The default for this field is False.
   #--client_modified Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? The value to store as the client_modified timestamp. Dropbox automatically records the time at which the file was written to the Dropbox servers. It can also record an additional timestamp, provided by Dropbox desktop clients, mobile clients, and API apps of when the file was actually created or modified. 
   This field is optional.
   mute Boolean Normally, users are made aware of any file modifications in their Dropbox account via notifications in the client software. If true, this tells the clients that this modification shouldn't result in a user notification.
   The default for this field is False.
   */
   put db2_upload_HEADER(pAccessToken,pPath,pMode,pAutorename,pMute) into tHeader
   put db2_upload_POST(pData) into tPost
   put db2_upload_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   FileMetadata
   */
end db2_upload

function db2_upload_session_append pAccessToken,pSessionID,pOffset,pData
   /*
   --DEPRECATED BY /upload_session/append_v2
   */
   put db2_upload_session_append_HEADER(pAccessToken,pSessionID,pOffset) into tHeader
   put db2_upload_session_append_POST(pData) into tPost
   put db2_upload_session_append_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_upload_session_append

function db2_upload_session_finish pAccessToken,pSessionID,pOffset,pPath,pMode,pAutorename,pMute,pData
   /*
   UploadSessionFinishArg
   #--cursor UploadSessionCursor Contains the upload session ID and the offset.
   UploadSessionCursor
   #--#--session_id String The upload session ID (returned by upload_session/start).
   #--#--offset UInt64 The amount of data that has been uploaded so far. We use this to make sure upload data isn't lost or duplicated in the event of a network error.
   #--commit CommitInfo Contains the path and other optional modifiers for the commit.
   CommitInfo
   #--#--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") Path in the user's Dropbox to save the file. 
   #--#--mode WriteMode Selects what to do if the file already exists. 
   The default for this union is add.
   WriteMode (union)
   Your intent when writing a file to some path. This is used to determine what constitutes a conflict and what the autorename strategy is.
   In some situations, the conflict behavior is identical: (a) If the target path doesn't contain anything, the file is always written; no conflict. (b) If the target path contains a folder, it's always a conflict. (c) If the target path contains a file with identical contents, nothing gets written; no conflict.
   The conflict checking differs in the case where there's a file at the target path with contents different from the contents you're trying to write. The value will be one of the following datatypes:
   #--#--#--add Void Never overwrite the existing file. The autorename strategy is to append a number to the file name. For example, "document.txt" might become "document (2).txt".
   #--#--#--overwrite Void Always overwrite the existing file. The autorename strategy is the same as it is for add.
   #--#--#--update String Overwrite if the given "rev" matches the existing file's "rev". The autorename strategy is to append the string "conflicted copy" to the file name. For example, "document.txt" might become "document (conflicted copy).txt" or "document (Panda's conflicted copy).txt".
   #--#--autorename Boolean If there's a conflict, as determined by mode, have the Dropbox server try to autorename the file to avoid conflict. 
   The default for this field is False.
   #--#--client_modified Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? The value to store as the client_modified timestamp. Dropbox automatically records the time at which the file was written to the Dropbox servers. It can also record an additional timestamp, provided by Dropbox desktop clients, mobile clients, and API apps of when the file was actually created or modified. 
   This field is optional. NOT IMPLEMENTED in db2_lib YET
   #--#--mute Boolean Normally, users are made aware of any file modifications in their Dropbox account via notifications in the client software. If true, this tells the clients that this modification shouldn't result in a user notification. 
   The default for this field is False.
   */
   put db2_upload_session_finish_HEADER(pAccessToken,pSessionID,pOffset,pPath,pMode,pAutorename,pMute) into tHeader
   put db2_upload_session_finish_POST(pData) into tPost
   put db2_upload_session_finish_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   FileMetadata
   */
end db2_upload_session_finish

function db2_upload_session_finish_batch pAccessToken,pEntriesArray,pMode,pAutorename,pMute
   /*
   array of pSessionID,pOffset,pPath,pData in pEntriesArray
   {"entries":[{"cursor":{"session_id":"1234faaf0678bcde","offset": 0},"commit":{"path":"/Homework/math/Matrices.txt","mode":{".tag":"add"},"autorename":true,"mute":false}}]}
   UploadSessionFinishBatchArg
   #--entries List of (UploadSessionFinishArg) Commit information for each file in the batch.
   UploadSessionFinishArg
   #--#--cursor UploadSessionCursor Contains the upload session ID and the offset.
   UploadSessionCursor
   #--#--#--session_id String The upload session ID (returned by upload_session/start).
   #--#--#--offset UInt64 The amount of data that has been uploaded so far. We use this to make sure upload data isn't lost or duplicated in the event of a network error.
   #--#--commit CommitInfo Contains the path and other optional modifiers for the commit.
   CommitInfo
   #--#--#--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") Path in the user's Dropbox to save the file. 
   #--#--#--mode WriteMode Selects what to do if the file already exists. 
   The default for this union is add.
   WriteMode (union)
   Your intent when writing a file to some path. This is used to determine what constitutes a conflict and what the autorename strategy is.
   In some situations, the conflict behavior is identical: (a) If the target path doesn't contain anything, the file is always written; no conflict. (b) If the target path contains a folder, it's always a conflict. (c) If the target path contains a file with identical contents, nothing gets written; no conflict.
   The conflict checking differs in the case where there's a file at the target path with contents different from the contents you're trying to write. The value will be one of the following datatypes:
   #--#--#--#--add Void Never overwrite the existing file. The autorename strategy is to append a number to the file name. For example, "document.txt" might become "document (2).txt".
   #--#--#--#--overwrite Void Always overwrite the existing file. The autorename strategy is the same as it is for add.
   #--#--#--#--update String Overwrite if the given "rev" matches the existing file's "rev". The autorename strategy is to append the string "conflicted copy" to the file name. For example, "document.txt" might become "document (conflicted copy).txt" or "document (Panda's conflicted copy).txt".
   #--#--#--autorename Boolean If there's a conflict, as determined by mode, have the Dropbox server try to autorename the file to avoid conflict. 
   The default for this field is False.
   #--#--#--client_modified Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? The value to store as the client_modified timestamp. Dropbox automatically records the time at which the file was written to the Dropbox servers. It can also record an additional timestamp, provided by Dropbox desktop clients, mobile clients, and API apps of when the file was actually created or modified. 
   This field is optional. NOT IMPLEMENTED in db2_lib YET
   #--#--#--mute Boolean Normally, users are made aware of any file modifications in their Dropbox account via notifications in the client software. If true, this tells the clients that this modification shouldn't result in a user notification. 
   The default for this field is False.
   */
   put db2_upload_session_finish_HEADER(pAccessToken,pSession,pOffset,pPath,pMode,pAutorename,pMute) into tHeader
   put db2_upload_session_finish_POST(pData) into tPost
   put db2_upload_session_finish_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   LaunchEmptyResult (union)
   Result returned by methods that may either launch an asynchronous job or complete synchronously. Upon synchronous completion of the job, no additional information is returned. This datatype comes from an imported namespace originally defined in the async namespace. The value will be one of the following datatypes:
   #--async_job_id String This response indicates that the processing is asynchronous. The string is an id that can be used to obtain the status of the asynchronous job.
   #--complete Void The job finished synchronously and successfully.
   */
end db2_upload_session_finish_batch

function db2_upload_session_finish_batch_check pAccessToken,pEntriesArray,pMode,pAutorename,pMute
   /*

   */
   put db2_upload_session_finish_HEADER(pAccessToken,pSession,pOffset,pPath,pMode,pAutorename,pMute) into tHeader
   put db2_upload_session_finish_POST(pData) into tPost
   put db2_upload_session_finish_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   */
end db2_upload_session_finish_batch_check

function db2_upload_session_start pAccessToken,pClose,pData
   /*
   UploadSessionStartArg
   #--close Boolean If true, the current session will be closed, at which point you won't be able to call upload_session/append_v2 anymore with the current session. 
   The default for this field is False.
   */
   put db2_upload_session_start_HEADER(pAccessToken,pClose) into tHeader
   put db2_upload_session_start_POST(pData) into tPost
   put db2_upload_session_start_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   {"session_id": "1234faaf0678bcde"}
   UploadSessionStartResult
   session_id String A unique identifier for the upload session. Pass this to upload_session/append_v2 and upload_session/finish.
   */
end db2_upload_session_start

-----------------------------------------------------------------------------
-----------sharing---------------------------------------------------------

function db2_add_file_member pAccessToken,pFile,pMemberArray,pMessage,pQuiet,pAccessLevel,pAddMessageAsComment
   /*
   pMessageArray - id or email 
   AddFileMemberArgs
   Arguments for add_file_member.
   #--file String File to which to add members.
   #--members List of (MemberSelector) Members to add. Note that even an email address is given, this may result in a user being directy added to the membership if that email is the user's main account email.
   MemberSelector (open union)
   Includes different ways to identify a member of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--dropbox_id String Dropbox account, team member, or group ID of member.
   #--#--email String E-mail address of member.
   #--custom_message String? Message to send to added members in their invitation. This field is optional.
   #--quiet Boolean Whether added members should be notified via device notifications of their invitation. The default for this field is False.
   #--access_level AccessLevel AccessLevel union object, describing what access level we want to give new members. The default for this union is viewer.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--viewer Void The collaborator can only view the shared folder.
   #--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   #--add_message_as_comment Boolean If the custom message should be added as a comment on the file. The default for this field is False.
   */
   put db2_add_file_member_HEADER(pAccessToken) into tHeader
   put db2_add_file_member_POST(pFile,pMembers,pMemberArray,pQuiet,pAccessLevel,pAddMessageAsComment) into tPost
   put db2_add_file_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   This route returns a list . This means the route can accept a homogenous list of the following types:
   FileMemberActionResult
   Per-member result for remove_file_member_2 or add_file_member.
   #--member MemberSelector One of specified input members.
   MemberSelector (open union)
   Includes different ways to identify a member of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--dropbox_id String Dropbox account, team member, or group ID of member.
   #--#--email String E-mail address of member.
   #--result FileMemberActionIndividualResult The outcome of the action on this member.
   FileMemberActionIndividualResult (union)
   The value will be one of the following datatypes:
   #--#--success AccessLevel? Member was successfully removed from this file. If AccessLevel is given, the member still has access via a parent shared folder. 
   This field is optional.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--#--viewer Void The collaborator can only view the shared folder.
   #--#--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   #--#--member_error FileMemberActionError User was not able to remove this member.
   FileMemberActionError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--invalid_member Void Specified member was not found.
   #--#--#--no_permission Void User does not have permission to perform this action on this member.
   */
end db2_add_file_member

function db2_change_file_member_access pAccessToken,pFile,pMemberArray,pAccessLevel
   /*
   ChangeFileMemberAccessArgs
   Arguments for change_file_member_access.
   #--file String File for which we are changing a member's access.
   #--member MemberSelector The member whose access we are changing.
   MemberSelector (open union)
   Includes different ways to identify a member of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--dropbox_id String Dropbox account, team member, or group ID of member.
   #--#--email String E-mail address of member.
   #--access_level AccessLevel The new access level for the member.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--viewer Void The collaborator can only view the shared folder.
   #--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   */
   put db2_change_file_member_access_HEADER(pAccessToken) into tHeader
   put db2_change_file_member_access_POST(pFile,pMemberArray,pAccessLevel) into tPost
   put db2_change_file_member_access_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*
   FileMemberActionResult
   Per-member result for remove_file_member_2 or add_file_member or change_file_member_access.
   member MemberSelector One of specified input members.
   MemberSelector (open union)
   Includes different ways to identify a member of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   dropbox_id String Dropbox account, team member, or group ID of member.
   email String E-mail address of member.
   result FileMemberActionIndividualResult The outcome of the action on this member.
   FileMemberActionIndividualResult (union)
   The value will be one of the following datatypes:
   .....
   */
end db2_change_file_member_access

function db2_check_remove_member_job_status pAccessToken,pPath
   /*
   
   */
   put db2_check_remove_member_job_status_HEADER(pAccessToken) into tHeader
   put db2_check_remove_member_job_status_POST(pPath) into tPost
   put db2_check_remove_member_job_status_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   RemoveMemberJobStatus (union)
   The value will be one of the following datatypes:
   #--in_progress Void The asynchronous job is still in progress.
   #--complete MemberAccessLevelResult Removing the folder member has finished. The value is information about whether the member has another form of access.
   MemberAccessLevelResult
   Contains information about a member's access level to content after an operation.
   #--#--#--#--access_level AccessLevel? The member still has this level of access to the content through a parent folder. 
   This field is optional.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--#--#--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--#--#--#--viewer Void The collaborator can only view the shared folder.
   #--#--#--#--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   #--#--#--#--warning String? A localized string with additional information about why the user has this access level to the content. 
   This field is optional.
   #--#--#--#--access_details List of (ParentFolderAccessInfo)? The parent folders that a member has access to. The field is present if the user has access to the first parent folder where the member gains access. 
   This field is optional.
   ParentFolderAccessInfo
   Contains information about a parent folder that a member has access to.
   #--#--#--#--#--folder_name String Display name for the folder.
   #--#--#--#--#--shared_folder_id String The identifier of the parent shared folder.
   #--#--#--#--#--permissions List of (MemberPermission) The user's permissions for the parent shared folder.
   MemberPermission
   Whether the user is allowed to take the action on the associated member.
   #--#--#--#--#--#--action MemberAction The action that the user may wish to take on the member.
   MemberAction (open union)
   Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--#--#--leave_a_copy Void Allow the member to keep a copy of the folder when removing.
   #--#--#--#--#--#--#--make_editor Void Make the member an editor of the folder.
   #--#--#--#--#--#--#--make_owner Void Make the member an owner of the folder.
   #--#--#--#--#--#--#--make_viewer Void Make the member a viewer of the folder.
   #--#--#--#--#--#--#--remove Void Remove the member from the folder.
   #--#--#--#--#--#--allow Boolean True if the user is allowed to take the action.
   #--#--#--#--#--#--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed 
   This field is optional.
   PermissionDeniedReason (open union)
   Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--#--#--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
   #--#--#--#--#--#--#--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
   #--#--#--#--#--#--#--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
   #--#--#--#--#--#--#--target_is_owner Void Target is the owner of the folder.
   #--#--#--#--#--#--#--target_is_self Void Target is the user itself.
   #--#--#--#--#--#--#--target_not_active Void Target is not an active member of the team.
   RemoveFolderMemberError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--access_error SharedFolderAccessError
   SharedFolderAccessError (open union)
   There is an error accessing the shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--invalid_id Void This shared folder ID is invalid.
   #--#--#--not_a_member Void The user is not a member of the shared folder thus cannot access it.
   #--#--#--email_unverified Void The current user's e-mail address is unverified.
   #--#--#--unmounted Void The shared folder is unmounted.
   #--#--member_error SharedFolderMemberError
   SharedFolderMemberError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--invalid_dropbox_id Void The target dropbox_id is invalid.
   #--#--#--not_a_member Void The target dropbox_id is not a member of the shared folder.
   #--#--#--no_explicit_access MemberAccessLevelResult The target member only has inherited access to the shared folder.
   MemberAccessLevelResult
   Contains information about a member's access level to content after an operation.
   #--#--#--#--access_level AccessLevel? The member still has this level of access to the content through a parent folder. 
   This field is optional.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--#--#--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--#--#--#--viewer Void The collaborator can only view the shared folder.
   #--#--#--#--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   #--#--#--#--warning String? A localized string with additional information about why the user has this access level to the content. 
   This field is optional.
   #--#--#--#--access_details List of (ParentFolderAccessInfo)? The parent folders that a member has access to. The field is present if the user has access to the first parent folder where the member gains access. 
   This field is optional.
   ParentFolderAccessInfo
   Contains information about a parent folder that a member has access to.
   #--#--#--#--#--folder_name String Display name for the folder.
   #--#--#--#--#--shared_folder_id String The identifier of the parent shared folder.
   #--#--#--#--#--permissions List of (MemberPermission) The user's permissions for the parent shared folder.
   MemberPermission
   Whether the user is allowed to take the action on the associated member.
   #--#--#--#--#--#--action MemberAction The action that the user may wish to take on the member.
   MemberAction (open union)
   Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--#--#--leave_a_copy Void Allow the member to keep a copy of the folder when removing.
   #--#--#--#--#--#--#--make_editor Void Make the member an editor of the folder.
   #--#--#--#--#--#--#--make_owner Void Make the member an owner of the folder.
   #--#--#--#--#--#--#--make_viewer Void Make the member a viewer of the folder.
   #--#--#--#--#--#--#--remove Void Remove the member from the folder.
   #--#--#--#--#--#--allow Boolean True if the user is allowed to take the action.
   #--#--#--#--#--#--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed 
   This field is optional.
   PermissionDeniedReason (open union)
   Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--#--#--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
   #--#--#--#--#--#--#--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
   #--#--#--#--#--#--#--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
   #--#--#--#--#--#--#--target_is_owner Void Target is the owner of the folder.
   #--#--#--#--#--#--#--target_is_self Void Target is the user itself.
   #--#--#--#--#--#--#--target_not_active Void Target is not an active member of the team.
   #--#--folder_owner Void The target user is the owner of the shared folder. You can't remove this user until ownership has been transferred to another member.
   #--#--group_access Void The target user has access to the shared folder via a group.
   #--#--team_folder Void This action cannot be performed on a team shared folder.
   #--#--no_permission Void The current user does not have permission to perform this action.
   */
end db2_check_remove_member_job_status

function db2_get_file_metadata pAccessToken,pPath
   /*
   GetFileMetadataArg
   Arguments of get_file_metadata
   #--file String The file to query.
   #--actions List of (FileAction)? File actions to query. This field is optional.
   FileAction (open union)
   Sharing actions that may be taken on files. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--edit_contents Void Change or edit contents of the file.
   #--#--invite_viewer Void Add a member with view permissions.
   #--#--unshare Void Stop sharing this file.
   #--#--relinquish_membership Void Relinquish one's own membership to the file.
   #--#--share_link Void Create a shared link to the file.
   */
   put db2_get_file_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_file_metadata_POST(pPath) into tPost
   put db2_get_file_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedFileMetadata
   */
end db2_get_file_metadata

function db2_get_file_metadata_batch pAccessToken,pPath
   /*
   
   */
   put db2_get_file_metadata_batch_HEADER(pAccessToken) into tHeader
   put db2_get_file_metadata_batch_POST(pPath) into tPost
   put db2_get_file_metadata_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   This route returns a list . This means the route can accept a homogenous list of the following types:
   GetFileMetadataBatchResult
   Per file results of get_file_metadata/batch
   #--file String This is the input file identifier corresponding to one of GetFileMetadataBatchArg.files.
   #--result GetFileMetadataIndividualResult The result for this particular file
   GetFileMetadataIndividualResult (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--metadata SharedFileMetadata The result for this file if it was successful.
   SharedFileMetadata
   #--#--access_error SharingFileAccessError The result for this file if it was an error.
   SharingFileAccessError (open union)
   User could not access this file. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--no_permission Void Current user does not have sufficient privileges to perform the desired action.
   #--#--#--invalid_file Void File specified was not found.
   #--#--#--is_folder Void A folder can't be shared this way. Use folder sharing or a shared link instead.
   #--#--#--inside_public_folder Void A file inside a public folder can't be shared this way. Use a public link instead.
   #--#--#--inside_osx_package Void A Mac OS X package can't be shared this way. Use a shared link instead.
   */
end db2_get_file_metadata_batch

function db2_list_file_members pAccessToken,pFile,pActions,pIncludeInherited,pLimit
   /*
   pActions = list of ["leave_a_copy","make_editor","make_owner","make_viewer","make_viewer_no_comment","remove"]
   ListFileMembersArg
   Arguments for list_file_members.
   #--file String The file for which you want to see members.
   #--actions List of (MemberAction)? The actions for which to return permissions on a member.
   This field is optional.
   MemberAction (open union)
   Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--leave_a_copy Void Allow the member to keep a copy of the folder when removing.
   #--#--make_editor Void Make the member an editor of the folder.
   #--#--make_owner Void Make the member an owner of the folder.
   #--#--make_viewer Void Make the member a viewer of the folder.
   #--#--make_viewer_no_comment Void Make the member a viewer of the folder without commenting permissions.
   #--#--remove Void Remove the member from the folder.
   #--include_inherited Boolean Whether to include members who only have access from a parent shared folder. 
   The default for this field is True.
   #--limit UInt32 Number of members to return max per query. Defaults to 100 if no limit is specified. 
   The default for this field is 100.
   */
   put db2_list_file_members_HEADER(pAccessToken) into tHeader
   put db2_list_file_members_POST(pFile,pActions,pIncludeInherited,pLimit) into tPost
   put db2_list_file_members_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedFileMembers
   Shared file user, group, and invitee membership.
   Used for the results of list_file_members and list_file_members/continue, and used as part of the results for list_file_members/batch.
   #--users List of (UserMembershipInfo) The list of user members of the shared file.
   UserMembershipInfo
   --
   #--groups List of (GroupMembershipInfo) The list of group members of the shared file.
   GroupMembershipInfo
   --
   #--invitees List of (InviteeMembershipInfo) The list of invited members of a file, but have not logged in and claimed this.
   InviteeMembershipInfo 
   --
   #--cursor String? Present if there are additional shared file members that have not been returned yet. Pass the cursor into list_file_members/continue to list additional members. 
   This field is optional. 
   */
end db2_list_file_members

function db2_list_file_members_batch pAccessToken,pFile,pIncludeInherited,pLimit
   /*
   
   */
   put db2_list_file_members_batch_HEADER(pAccessToken) into tHeader
   put db2_list_file_members_batch_POST(pFile,pIncludeInherited,pLimit) into tPost
   put db2_list_file_members_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   
   This route returns a list . This means the route can accept a homogenous list of the following types:
   ListFileMembersBatchResult
   Per-file result for list_file_members/batch.
   #--file String This is the input file identifier, whether an ID or a path.
   #--result ListFileMembersIndividualResult The result for this particular file
   ListFileMembersIndividualResult (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--result ListFileMembersCountResult The results of the query for this file if it was successful
   ListFileMembersCountResult
   #--#--#--members SharedFileMembers A list of members on this file.
   SharedFileMembers
   Shared file user, group, and invitee membership.
   Used for the results of list_file_members and list_file_members/continue, and used as part of the results for list_file_members/batch.
   #--#--#--#--users List of (UserMembershipInfo) The list of user members of the shared file.
   UserMembershipInfo
   --
   #--#--#--#--groups List of (GroupMembershipInfo) The list of group members of the shared file.
   GroupMembershipInfo
   --
   #--#--#--#--invitees List of (InviteeMembershipInfo) The list of invited members of a file, but have not logged in and claimed this.
   InviteeMembershipInfo
   --
   #--#--#--#--cursor String? Present if there are additional shared file members that have not been returned yet. Pass the cursor into list_file_members/continue to list additional members. 
   This field is optional.
   #--#--#--member_count UInt32 The number of members on this file. This does not include inherited members
   #--#--access_error SharingFileAccessError The result of the query for this file if it was an error.
   SharingFileAccessError (open union)
   User could not access this file. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--no_permission Void Current user does not have sufficient privileges to perform the desired action.
   #--#--#--invalid_file Void File specified was not found.
   #--#--#--is_folder Void A folder can't be shared this way. Use folder sharing or a shared link instead.
   #--#--#--inside_public_folder Void A file inside a public folder can't be shared this way. Use a public link instead.
   #--#--#--inside_osx_package Void A Mac OS X package can't be shared this way. Use a shared link instead.
   */
end db2_list_file_members_batch

function db2_list_file_members_continue pAccessToken,pPath
     /*
   
   */
put db2_list_file_members_continue_HEADER(pAccessToken) into tHeader
   put db2_list_file_members_continue_POST(pPath) into tPost
   put db2_list_file_members_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedFileMembers
   Shared file user, group, and invitee membership.
   Used for the results of list_file_members and list_file_members/continue, and used as part of the results for list_file_members/batch.
   #--#--#--#--users List of (UserMembershipInfo) The list of user members of the shared file.
   UserMembershipInfo
   --
   #--#--#--#--groups List of (GroupMembershipInfo) The list of group members of the shared file.
   GroupMembershipInfo
   --
   #--#--#--#--invitees List of (InviteeMembershipInfo) The list of invited members of a file, but have not logged in and claimed this.
   InviteeMembershipInfo
   --
   #--#--#--#--cursor String? Present if there are additional shared file members that have not been returned yet. Pass the cursor into list_file_members/continue to list additional members. 
   This field is optional.
   */
end db2_list_file_members_continue

function db2_list_received_files pAccessToken,pPath
     /*
   
   */
put db2_list_received_files_HEADER(pAccessToken) into tHeader
   put db2_list_received_files_POST(pPath) into tPost
   put db2_list_received_files_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFilesResult
   Success results for list_received_files.
   #--entries List of (SharedFileMetadata) Information about the files shared with current user.
   SharedFileMetadata
   --
   #--cursor String? Cursor used to obtain additional shared files. 
   This field is optional. 
   */
end db2_list_received_files

function db2_list_received_files_continue pAccessToken,pPath
     /*
   
   */
put db2_list_received_files_continue_HEADER(pAccessToken) into tHeader
   put db2_list_received_files_continue_POST(pPath) into tPost
   put db2_list_received_files_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFilesResult
   Success results for list_received_files.
   #--entries List of (SharedFileMetadata) Information about the files shared with current user.
   SharedFileMetadata
   --
   #--cursor String? Cursor used to obtain additional shared files. 
   This field is optional. 
   */
end db2_list_received_files_continue

function db2_relinquish_file_membership pAccessToken,pPath
     /*
   
   */
put db2_relinquish_file_membership_HEADER(pAccessToken) into tHeader
   put db2_relinquish_file_membership_POST(pPath) into tPost
   put db2_relinquish_file_membership_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   RelinquishFileMembershipError (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
 #--access_error SharingFileAccessError
SharingFileAccessError (open union)
User could not access this file. The value will be one of the following datatypes. New values may be introduced as our API evolves.
 #--#--no_permission Void Current user does not have sufficient privileges to perform the desired action.
 #--#--invalid_file Void File specified was not found.
 #--#--is_folder Void A folder can't be shared this way. Use folder sharing or a shared link instead.
 #--#--inside_public_folder Void A file inside a public folder can't be shared this way. Use a public link instead.
 #--#--inside_osx_package Void A Mac OS X package can't be shared this way. Use a shared link instead.
 #--group_access Void The current user has access to the shared file via a group. You can't relinquish membership to a file shared via groups.
 #--no_permission Void The current user does not have permission to perform this action.
   */
end db2_relinquish_file_membership

function db2_remove_file_member pAccessToken,pPath
   /*
   --DEPRECATED BY /remove_file_member_2
   */
   put db2_remove_file_member_HEADER(pAccessToken) into tHeader
   put db2_remove_file_member_POST(pPath) into tPost
   put db2_remove_file_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   FileMemberActionIndividualResult (union)
   The value will be one of the following datatypes:
   #--#--success AccessLevel? Member was successfully removed from this file. If AccessLevel is given, the member still has access via a parent shared folder. 
   This field is optional.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--#--viewer Void The collaborator can only view the shared folder.
   #--#--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   #--#--member_error FileMemberActionError User was not able to remove this member.
   FileMemberActionError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--invalid_member Void Specified member was not found.
   #--#--#--no_permission Void User does not have permission to perform this action on this member.
   */
end db2_remove_file_member

function db2_remove_file_member_2 pAccessToken,pPath
     /*
   
   */
put db2_remove_file_member_2_HEADER(pAccessToken) into tHeader
   put db2_remove_file_member_2_POST(pPath) into tPost
   put db2_remove_file_member_2_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   FileMemberRemoveActionResult (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--success MemberAccessLevelResult Member was successfully removed from this file.
   MemberAccessLevelResult
   Contains information about a member's access level to content after an operation.
   #--#--access_level AccessLevel? The member still has this level of access to the content through a parent folder. 
   This field is optional.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--#--viewer Void The collaborator can only view the shared folder.
   #--#--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   #--#--warning String? A localized string with additional information about why the user has this access level to the content. 
   This field is optional.
   #--#--access_details List of (ParentFolderAccessInfo)? The parent folders that a member has access to. The field is present if the user has access to the first parent folder where the member gains access. 
   This field is optional.
   ParentFolderAccessInfo
   Contains information about a parent folder that a member has access to.
   #--#--#--folder_name String Display name for the folder.
   #--#--#--shared_folder_id String The identifier of the parent shared folder.
   #--#--#--permissions List of (MemberPermission) The user's permissions for the parent shared folder.
   MemberPermission
   Whether the user is allowed to take the action on the associated member.
   #--#--#--#--action MemberAction The action that the user may wish to take on the member.
   MemberAction (open union)
   Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--leave_a_copy Void Allow the member to keep a copy of the folder when removing.
   #--#--#--#--#--make_editor Void Make the member an editor of the folder.
   #--#--#--#--#--make_owner Void Make the member an owner of the folder.
   #--#--#--#--#--make_viewer Void Make the member a viewer of the folder.
   #--#--#--#--#--remove Void Remove the member from the folder.
   #--#--#--#--allow Boolean True if the user is allowed to take the action.
   #--#--#--#--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed 
   This field is optional.
   PermissionDeniedReason (open union)
   Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
   #--#--#--#--#--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
   #--#--#--#--#--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
   #--#--#--#--#--target_is_owner Void Target is the owner of the folder.
   #--#--#--#--#--target_is_self Void Target is the user itself.
   #--#--#--#--#--target_not_active Void Target is not an active member of the team.
   #--member_error FileMemberActionError User was not able to remove this member.
   FileMemberActionError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--invalid_member Void Specified member was not found.
   #--#--no_permission Void User does not have permission to perform this action on this member.
   */
end db2_remove_file_member_2

function db2_unshare_file pAccessToken,pPath
     /*
   
   */
put db2_unshare_file_HEADER(pAccessToken) into tHeader
   put db2_unshare_file_POST(pPath) into tPost
   put db2_unshare_file_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_unshare_file

-------------------------------------------------------------------------------------------

function db2_add_folder_member pAccessToken,pSharedFolderId,pMembers,pQuiet,pCustomMessage
   --members as an array
     /*
   
   */
put db2_add_folder_member_HEADER(pAccessToken) into tHeader
   put db2_add_folder_member_POST(pSharedFolderId,pMembers,pQuiet,pCustomMessage) into tPost
   put db2_add_folder_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   AddFolderMemberArg
   #--shared_folder_id String The ID for the shared folder.
   #--members List of (AddMember) The intended list of members to add. Added members will receive invites to join the shared folder.
   AddMember
   The member and type of access the member should have when added to a shared folder.
   #--#--member MemberSelector The member to add to the shared folder.
   MemberSelector (open union)
   Includes different ways to identify a member of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--dropbox_id String Dropbox account, team member, or group ID of member.
   #--#--#--email String E-mail address of member.
   #--#--access_level AccessLevel The access level to grant member to the shared folder. AccessLevel.owner is disallowed. 
   The default for this union is viewer.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--#--viewer Void The collaborator can only view the shared folder.
   #--#--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   #--quiet Boolean Whether added members should be notified via email and device notifications of their invite. 
   The default for this field is False.
   #--custom_message String? Optional message to display to added members in their invitation. 
   This field is optional.
   */
end db2_add_folder_member

function db2_check_job_status pAccessToken,pAsyncJobId
     /*
   
   */
put db2_check_job_status_HEADER(pAccessToken) into tHeader
   put db2_check_job_status_POST(pAsyncJobId) into tPost
   put db2_check_job_status_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   JobStatus (union)
   The value will be one of the following datatypes:
   #--in_progress Void The asynchronous job is still in progress.
    #--complete Void The asynchronous job has finished.
    #--failed JobError The asynchronous job returned an error.
   JobError (open union)
   Error occurred while performing an asynchronous job from unshare_folder or remove_folder_member. The value will be one of the following datatypes. New values may be introduced as our API evolves.
    #--unshare_folder_error UnshareFolderError Error occurred while performing unshare_folder action.
   UnshareFolderError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
    #--#--access_error SharedFolderAccessError
   SharedFolderAccessError (open union)
   There is an error accessing the shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
    #--#--#--invalid_id Void This shared folder ID is invalid.
   #--#--#--not_a_member Void The user is not a member of the shared folder thus cannot access it.
   #--#--#--email_unverified Void The current user's e-mail address is unverified.
   #--#--#--unmounted Void The shared folder is unmounted.
    #--#--team_folder Void This action cannot be performed on a team shared folder.
    #--#--no_permission Void The current user does not have permission to perform this action.
    #--remove_folder_member_error RemoveFolderMemberError Error occurred while performing remove_folder_member action.
   RemoveFolderMemberError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--access_error SharedFolderAccessError
   SharedFolderAccessError (open union)
   There is an error accessing the shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--invalid_id Void This shared folder ID is invalid.
   #--#--#--not_a_member Void The user is not a member of the shared folder thus cannot access it.
   #--#--#--email_unverified Void The current user's e-mail address is unverified.
   #--#--#--unmounted Void The shared folder is unmounted.
   #--#--member_error SharedFolderMemberError
   SharedFolderMemberError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--invalid_dropbox_id Void The target dropbox_id is invalid.
   #--#--#--not_a_member Void The target dropbox_id is not a member of the shared folder.
   #--#--#--no_explicit_access MemberAccessLevelResult The target member only has inherited access to the shared folder.
   MemberAccessLevelResult
   Contains information about a member's access level to content after an operation.
   #--#--#--#--access_level AccessLevel? The member still has this level of access to the content through a parent folder. 
   This field is optional.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--#--#--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--#--#--#--viewer Void The collaborator can only view the shared folder.
   #--#--#--#--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   #--#--#--#--warning String? A localized string with additional information about why the user has this access level to the content. 
   This field is optional.
   #--#--#--#--access_details List of (ParentFolderAccessInfo)? The parent folders that a member has access to. The field is present if the user has access to the first parent folder where the member gains access. 
   This field is optional.
   ParentFolderAccessInfo
   Contains information about a parent folder that a member has access to.
   #--#--#--#--#--folder_name String Display name for the folder.
   #--#--#--#--#--shared_folder_id String The identifier of the parent shared folder.
   #--#--#--#--#--permissions List of (MemberPermission) The user's permissions for the parent shared folder.
   MemberPermission
   Whether the user is allowed to take the action on the associated member.
   #--#--#--#--#--#--action MemberAction The action that the user may wish to take on the member.
   MemberAction (open union)
   Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--#--#--leave_a_copy Void Allow the member to keep a copy of the folder when removing.
   #--#--#--#--#--#--#--make_editor Void Make the member an editor of the folder.
   #--#--#--#--#--#--#--make_owner Void Make the member an owner of the folder.
   #--#--#--#--#--#--#--make_viewer Void Make the member a viewer of the folder.
   #--#--#--#--#--#--#--remove Void Remove the member from the folder.
   #--#--#--#--#--#--allow Boolean True if the user is allowed to take the action.
   #--#--#--#--#--#--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed 
   This field is optional.
   PermissionDeniedReason (open union)
   Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--#--#--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
   #--#--#--#--#--#--#--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
   #--#--#--#--#--#--#--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
   #--#--#--#--#--#--#--target_is_owner Void Target is the owner of the folder.
   #--#--#--#--#--#--#--target_is_self Void Target is the user itself.
   #--#--#--#--#--#--#--target_not_active Void Target is not an active member of the team.
   #--#--folder_owner Void The target user is the owner of the shared folder. You can't remove this user until ownership has been transferred to another member.
   #--#--group_access Void The target user has access to the shared folder via a group.
   #--#--team_folder Void This action cannot be performed on a team shared folder.
   #--#--no_permission Void The current user does not have permission to perform this action.
    #--relinquish_folder_membership_error RelinquishFolderMembershipError Error occurred while performing relinquish_folder_membership action.
   RelinquishFolderMembershipError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
    #--#--access_error SharedFolderAccessError
   SharedFolderAccessError (open union)
   There is an error accessing the shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--invalid_id Void This shared folder ID is invalid.
   #--#--#--not_a_member Void The user is not a member of the shared folder thus cannot access it.
   #--#--#--email_unverified Void The current user's e-mail address is unverified.
   #--#--#--unmounted Void The shared folder is unmounted.
   #--#--folder_owner Void The current user is the owner of the shared folder. Owners cannot relinquish membership to their own folders. Try unsharing or transferring ownership first.
   #--#--mounted Void The shared folder is currently mounted. Unmount the shared folder before relinquishing membership.
   #--#--group_access Void The current user has access to the shared folder via a group. You can't relinquish membership to folders shared via groups.
   #--#--team_folder Void This action cannot be performed on a team shared folder.
   #--#--no_permission Void The current user does not have permission to perform this action.
   */
end db2_check_job_status

function db2_check_share_job_status pAccessToken,pAsyncJobId
     /*
   
   */
put db2_check_share_job_status_HEADER(pAccessToken) into tHeader
   put db2_check_share_job_status_POST(pAsyncJobId) into tPost
   put db2_check_share_job_status_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ShareFolderJobStatus (union)
   The value will be one of the following datatypes:
   #--in_progress Void The asynchronous job is still in progress.
   #--complete SharedFolderMetadata The share job has finished. The value is the metadata for the folder.
   SharedFolderMetadata
   #--failed ShareFolderError
   ShareFolderError (union)
   The value will be one of the following datatypes:
   #--email_unverified Void The current user's e-mail address is unverified.
   #--bad_path SharePathError ShareFolderArg.path is invalid.
   SharePathError (open union)
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--is_file Void A file is at the specified path.
   #--#--inside_shared_folder Void We do not support sharing a folder inside a shared folder.
   #--#--contains_shared_folder Void We do not support shared folders that contain shared folders.
   #--#--is_app_folder Void We do not support sharing an app folder.
   #--#--inside_app_folder Void We do not support sharing a folder inside an app folder.
   #--#--is_public_folder Void A public folder can't be shared this way. Use a public link instead.
   #--#--inside_public_folder Void A folder inside a public folder can't be shared this way. Use a public link instead.
   #--#--already_shared SharedFolderMetadata Folder is already shared. Contains metadata about the existing shared folder.
   SharedFolderMetadata
   #--#--invalid_path Void Path is not valid.
   #--#--is_osx_package Void We do not support sharing a Mac OS X package.
   #--#--inside_osx_package Void We do not support sharing a folder inside a Mac OS X package.
   #--team_policy_disallows_member_policy Void Team policy is more restrictive than ShareFolderArg.member_policy.
   #--disallowed_shared_link_policy Void The current user's account is not allowed to select the specified ShareFolderArg.shared_link_policy.
   #--no_permission Void The current user does not have permission to perform this action.
   */
end db2_check_share_job_status

function db2_create_shared_link pAccessToken,pPath,pShortUrl,pPendingUpload
   /*
   --DEPRECATED BY /create_shared_link_with_settings
   */
   put db2_create_shared_link_HEADER(pAccessToken) into tHeader
   put db2_create_shared_link_POST(pPath,pShortUrl,pPendingUpload) into tPost
   put db2_create_shared_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   PathLinkMetadata
   Metadata for a path-based shared link.
   #--url String URL of the shared link.
   #--visibility Visibility Who can access the link.
   Visibility (open union)
   Who can access a shared link. The most open visibility is public. 
   The default depends on many aspects, such as team and user preferences and shared folder settings. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--public Void Anyone who has received the link can access it. No login required.
   #--#--team_only Void Only members of the same team can access the link. Login is required.
   #--#--password Void A link-specific password is required to access the link. Login is not required.
   #--#--team_and_password Void Only members of the same team who have the link-specific password can access the link.
   #--#--shared_folder_only Void Only members of the shared folder containing the linked file can access the link. Login is required.
   #--path String Path in user's Dropbox.
   #--expires Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time, if set. By default the link won't expire. 
   This field is optional.
   */
end db2_create_shared_link

function db2_create_shared_link_with_settings pAccessToken,pPath,pSettings
   /*
   
   */
   put db2_create_shared_link_HEADER(pAccessToken) into tHeader
   put db2_create_shared_link_POST(pPath,pSettings) into tPost
   put db2_create_shared_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedLinkMetadata (datatype with subtypes)
   The metadata of a shared link This datatype will be one of the following subtypes:
   #--file FileLinkMetadata
   FileLinkMetadata
   #--folder FolderLinkMetadata
   FolderLinkMetadata
   */
end db2_create_shared_link_with_settings

function db2_get_folder_metadata pAccessToken,pSharedFolderId,pActions
   /*
   
   */
   put db2_get_folder_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_folder_metadata_POST(pSharedFolderId,pActions) into tPost
   put db2_get_folder_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedFolderMetadata
   */
end db2_get_folder_metadata

function db2_get_shared_link_file pAccessToken,pUrl,pPath,pLinkPassword
     /*
   
   */
put db2_get_shared_link_file_HEADER(pAccessToken,pUrl,pPath,pLinkPassword) into tHeader
   put db2_get_shared_link_file_POST(pPath) into tPost
   put db2_get_shared_link_file_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedLinkMetadata (datatype with subtypes)
   The metadata of a shared link This datatype will be one of the following subtypes:
   #--file FileLinkMetadata
   FileLinkMetadata
   #--folder FolderLinkMetadata
   FolderLinkMetadata
   */
end db2_get_shared_link_file

function db2_get_shared_link_metadata pAccessToken,pUrl,pPath,pLinkPassword
   /*
   
   */
   put db2_get_shared_link_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_shared_link_metadata_POST(pUrl,pPath,pLinkPassword) into tPost
   put db2_get_shared_link_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedLinkMetadata (datatype with subtypes)
   The metadata of a shared link This datatype will be one of the following subtypes:
   #--file FileLinkMetadata
   FileLinkMetadata
   #--folder FolderLinkMetadata
   FolderLinkMetadata
   */
end db2_get_shared_link_metadata

function db2_get_shared_links pAccessToken,pPath
   /*
   --DEPRECATED BY /list_shared_links
   */
   put db2_get_shared_links_HEADER(pAccessToken) into tHeader
   put db2_get_shared_links_POST(pPath) into tPost
   put db2_get_shared_links_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   GetSharedLinksResult
   links List of (LinkMetadata) Shared links applicable to the path argument.
   LinkMetadata (datatype with subtypes)
   Metadata for a shared link. This can be either a PathLinkMetadata or CollectionLinkMetadata. This datatype will be one of the following subtypes:
   path PathLinkMetadata
   PathLinkMetadata
   Metadata for a path-based shared link.
   url String URL of the shared link.
   visibility Visibility Who can access the link.
   Visibility (open union)
   Who can access a shared link. The most open visibility is public. 
   The default depends on many aspects, such as team and user preferences and shared folder settings. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   public Void Anyone who has received the link can access it. No login required.
   team_only Void Only members of the same team can access the link. Login is required.
   password Void A link-specific password is required to access the link. Login is not required.
   team_and_password Void Only members of the same team who have the link-specific password can access the link.
   shared_folder_only Void Only members of the shared folder containing the linked file can access the link. Login is required.
   path String Path in user's Dropbox.
   expires Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time, if set. By default the link won't expire. 
   This field is optional.
   collection CollectionLinkMetadata
   CollectionLinkMetadata
   Metadata for a collection-based shared link.
   url String URL of the shared link.
   visibility Visibility Who can access the link.
   Visibility (open union)
   Who can access a shared link. The most open visibility is public. 
   The default depends on many aspects, such as team and user preferences and shared folder settings. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   public Void Anyone who has received the link can access it. No login required.
   team_only Void Only members of the same team can access the link. Login is required.
   password Void A link-specific password is required to access the link. Login is not required.
   team_and_password Void Only members of the same team who have the link-specific password can access the link.
   shared_folder_only Void Only members of the shared folder containing the linked file can access the link. Login is required.
   expires Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time, if set. By default the link won't expire. 
   This field is optional.
   */
end db2_get_shared_links

function db2_list_folder_members pAccessToken,pSharedFolderId,pActions,pLimit
     /*
   
   */
put db2_list_folder_members_HEADER(pAccessToken) into tHeader
   put db2_list_folder_members_POST(pSharedFolderId,pActions,pLimit) into tPost
   put db2_list_folder_members_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedFolderMembers
   Shared folder user and group membership.
   #--#--#--#--users List of (UserMembershipInfo) The list of user members of the shared folder.
   UserMembershipInfo
   --
   #--#--#--#--groups List of (GroupMembershipInfo) The list of group members of the shared folder.
   GroupMembershipInfo
   --
   #--#--#--#--invitees List of (InviteeMembershipInfo) The list of invitees to the shared folder.
   InviteeMembershipInfo
   --
   #--#--#--#--cursor String? Present if there are additional shared folder members that have not been returned yet. 
   Pass the cursor into list_folder_members/continue to list additional members. 
   This field is optional.
   */
end db2_list_folder_members

function db2_list_folder_members_continue pAccessToken,pPath
     /*
   
   */
put db2_list_folder_members_continue_HEADER(pAccessToken) into tHeader
   put db2_list_folder_members_continue_POST(pPath) into tPost
   put db2_list_folder_members_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedFolderMembers
   Shared folder user and group membership.
   #--#--#--#--users List of (UserMembershipInfo) The list of user members of the shared folder.
   UserMembershipInfo
   --
   #--#--#--#--groups List of (GroupMembershipInfo) The list of group members of the shared folder.
   GroupMembershipInfo
   --
   #--#--#--#--invitees List of (InviteeMembershipInfo) The list of invitees to the shared folder.
   InviteeMembershipInfo
   --
   #--#--#--#--cursor String? Present if there are additional shared folder members that have not been returned yet. 
   Pass the cursor into list_folder_members/continue to list additional members. 
   This field is optional.
   */
end db2_list_folder_members_continue

function db2_list_folders pAccessToken,pLimit,pActions
   /*'
   pActions = list of ["change_options","edit_contents","invite_editor","invite_viewer","invite_viewer_no_comment","relinquish_membership","unmount","unshare","leave_a_copy","share_link"]
   #--limit UInt32 The maximum number of results to return per request. The default for this field is 1000.
   #--actions List of (FolderAction)? This is a list indicating whether each returned folder data entry will include a boolean field FolderPermission.allow that describes whether the current user can perform the `FolderAction` on the folder. This field is optional.
   FolderAction (open union)
   Actions that may be taken on shared folders. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--change_options Void Change folder options, such as who can be invited to join the folder.
   #--#--edit_contents Void Change or edit contents of the folder.
   #--#--invite_editor Void Invite a user or group to join the folder with read and write permission.
   #--#--invite_viewer Void Invite a user or group to join the folder with read permission.
   #--#--invite_viewer_no_comment Void Invite a user or group to join the folder with read permission but no comment permissions.
   #--#--relinquish_membership Void Relinquish one's own membership in the folder.
   #--#--unmount Void Unmount the folder.
   #--#--unshare Void Stop sharing this folder.
   #--#--leave_a_copy Void Keep a copy of the contents upon leaving or being kicked from the folder.
   #--#--share_link Void Create a shared link for folder.
   */
   put db2_list_folders_HEADER(pAccessToken) into tHeader
   put db2_list_folders_POST(pLimit,pActions) into tPost
   put db2_list_folders_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFoldersResult
   Result for list_folders or list_mountable_folders, depending on which endpoint was requested.
   Unmounted shared folders can be identified by the absence of SharedFolderMetadata.path_lower.
   #--entries List of (SharedFolderMetadata) List of all shared folders the authenticated user has access to.
   SharedFolderMetadata
   --
   #--cursor String? Present if there are additional shared folders that have not been returned yet. Pass the cursor into the corresponding continue endpoint (either list_folders/continue or list_mountable_folders/continue) to list additional folders. 
   This field is optional. 
   */
end db2_list_folders

function db2_list_folders_continue pAccessToken,pCursor
   /*
   ListFoldersContinueArg
   #--cursor String The cursor returned by the previous API call specified in the endpoint description.
   */
   put db2_list_folders_continue_HEADER(pAccessToken) into tHeader
   put db2_list_folders_continue_POST(pCursor) into tPost
   put db2_list_folders_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFoldersResult
   Result for list_folders or list_mountable_folders, depending on which endpoint was requested.
   Unmounted shared folders can be identified by the absence of SharedFolderMetadata.path_lower.
   #--entries List of (SharedFolderMetadata) List of all shared folders the authenticated user has access to.
   SharedFolderMetadata 
   --
   #--cursor String? Present if there are additional shared folders that have not been returned yet. Pass the cursor into the corresponding continue endpoint (either list_folders/continue or list_mountable_folders/continue) to list additional folders. 
   This field is optional. 
   */
end db2_list_folders_continue

function db2_list_mountable_folders pAccessToken,pLimit,pActions
     /*
   
   */
put db2_list_mountable_folders_HEADER(pAccessToken) into tHeader
   put db2_list_mountable_folders_POST(pLimit,pActions) into tPost
   put db2_list_mountable_folders_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFoldersResult
   Result for list_folders or list_mountable_folders, depending on which endpoint was requested.
   Unmounted shared folders can be identified by the absence of SharedFolderMetadata.path_lower.
   #--entries List of (SharedFolderMetadata) List of all shared folders the authenticated user has access to.
   SharedFolderMetadata 
   --
   #--cursor String? Present if there are additional shared folders that have not been returned yet. Pass the cursor into the corresponding continue endpoint (either list_folders/continue or list_mountable_folders/continue) to list additional folders. 
   This field is optional. 
   */
end db2_list_mountable_folders

function db2_list_mountable_folders_continue pAccessToken,pPath
     /*
   
   */
put db2_list_mountable_folders_continue_HEADER(pAccessToken) into tHeader
   put db2_list_mountable_folders_continue_POST(pPath) into tPost
   put db2_list_mountable_folders_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListFoldersResult
   Result for list_folders or list_mountable_folders, depending on which endpoint was requested.
   Unmounted shared folders can be identified by the absence of SharedFolderMetadata.path_lower.
   #--entries List of (SharedFolderMetadata) List of all shared folders the authenticated user has access to.
   SharedFolderMetadata 
   --
   #--cursor String? Present if there are additional shared folders that have not been returned yet. Pass the cursor into the corresponding continue endpoint (either list_folders/continue or list_mountable_folders/continue) to list additional folders. 
   This field is optional. 
   */
end db2_list_mountable_folders_continue

function db2_list_shared_links pAccessToken,pPath,pDirectOnly,pCursor
   /*
   ListSharedLinksArg
   #--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)")? See list_shared_links description. This field is optional.
   {"path": "/folder1/testfile1.txt"}
   {"path": "id:a1XparO6B8AAAAAAAAAAAQ"}
   {"path": "rev:934ac9fd89"}
   #--cursor String? The cursor returned by your last call to list_shared_links. This field is optional.
   {"cursor": "ZtkX9_EHj3x7PMkVuFIhwKYXEpwpLwyxp9vMKomUhllil9q7eWiAu"}
   #--direct_only Boolean? See list_shared_links description. This field is optional.
   {"path": "id:a4ayc_80_OEAAAAAAAAAYa","direct_only": true}
   */
   put db2_list_shared_links_HEADER(pAccessToken) into tHeader
   put db2_list_shared_links_POST(pPath,pDirectOnly,pCursor) into tPost
   put db2_list_shared_links_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ListSharedLinksResult
   #--links List of (SharedLinkMetadata) Shared links applicable to the path argument.
   SharedLinkMetadata (datatype with subtypes)
   The metadata of a shared link This datatype will be one of the following subtypes:
   #--#--file FileLinkMetadata
   FileLinkMetadata
   --
   #--#--folder FolderLinkMetadata
   FolderLinkMetadata
   --
   #--has_more Boolean Is true if there are additional shared links that have not been returned yet. Pass the cursor into list_shared_links to retrieve them.
   #--cursor String? Pass the cursor into list_shared_links to obtain the additional links. Cursor is returned only if no path is given or the path is empty. 
   This field is optional. 
   */
end db2_list_shared_links

function db2_modify_shared_link_settings pAccessToken,pUrl,pRequestedVisibility,pLinkPassword,pExpires
     /*
   
   */
put db2_modify_shared_link_settings_HEADER(pAccessToken) into tHeader
   put db2_modify_shared_link_settings_POST(pUrl,pRequestedVisibility,pLinkPassword,pExpires) into tPost
   put db2_modify_shared_link_settings_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedLinkMetadata (datatype with subtypes)
   The metadata of a shared link This datatype will be one of the following subtypes:
   #--file FileLinkMetadata
   FileLinkMetadata 
   --
   #--folder FolderLinkMetadata
   FolderLinkMetadata
   --
   */
end db2_modify_shared_link_settings

function db2_mount_folder pAccessToken,pSharedFolderId
     /*
   
   */
put db2_mount_folder_HEADER(pAccessToken) into tHeader
   put db2_mount_folder_POST(pSharedFolderId) into tPost
   put db2_mount_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedFolderMetadata
   --
   */
end db2_mount_folder

function db2_relinquish_folder_membership pAccessToken,pSharedFolderId
     /*
   
   */
put db2_relinquish_folder_membership_HEADER(pAccessToken) into tHeader
   put db2_relinquish_folder_membership_POST(pSharedFolderId) into tPost
   put db2_relinquish_folder_membership_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   LaunchEmptyResult (union)
   Result returned by methods that may either launch an asynchronous job or complete synchronously. Upon synchronous completion of the job, no additional information is returned. This datatype comes from an imported namespace originally defined in the async namespace. The value will be one of the following datatypes:
   #--async_job_id String This response indicates that the processing is asynchronous. The string is an id that can be used to obtain the status of the asynchronous job.
   #--complete Void The job finished synchronously and successfully.
   */
end db2_relinquish_folder_membership

function db2_remove_folder_member pAccessToken,pSharedFolderId,pMember,pLeaveACopy
     /*
   
   */
put db2_remove_folder_member_HEADER(pAccessToken) into tHeader
   put db2_remove_folder_member_POST(pSharedFolderId,pMember,pLeaveACopy) into tPost
   put db2_remove_folder_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   LaunchResultBase (union)
   Result returned by methods that launch an asynchronous job.
   A method who may either launch an asynchronous job, or complete the request synchronously, can use this union by extending it, and adding a 'complete' field with the type of the synchronous response.
   See LaunchEmptyResult for an example. This datatype comes from an imported namespace originally defined in the async namespace. The value will be one of the following datatypes:
   #--async_job_id String This response indicates that the processing is asynchronous. The string is an id that can be used to obtain the status of the asynchronous job.
   */
end db2_remove_folder_member

function db2_revoke_shared_link pAccessToken,pURL
     /*
   
   */
put db2_revoke_shared_link_HEADER(pAccessToken) into tHeader
   put db2_revoke_shared_link_POST(pURL) into tPost
   put db2_revoke_shared_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_revoke_shared_link

function db2_share_folder pAccessToken,pPath,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy,pForceAsync
   /*
   {"path":"/MySharedFolder1","member_policy":"anyone","acl_update_policy":"editors","shared_link_policy":"anyone","force_async":false}
   ShareFolderArg
   #--path String(pattern="/(.|[\r\n])*") The path to the folder to share. If it does not exist, then a new one is created.
   #--member_policy MemberPolicy Who can be a member of this shared folder. Only applicable if the current user is on a team. The default for this union is anyone.
   MemberPolicy (open union)
   Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--team Void Only a teammate can become a member. ONLY FOR PRO/BUSINESS
   #--#--anyone Void Anyone can become a member.
   #--acl_update_policy AclUpdatePolicy Who can add and remove members of this shared folder. The default for this union is owner.
   AclUpdatePolicy (open union)
   Policy governing who can change a shared folder's access control list (ACL). In other words, who can add, remove, or change the privileges of members. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--owner Void Only the owner can update the ACL.
   #--#--editors Void Any editor can update the ACL. This may be further restricted to editors on the same team.
   #--shared_link_policy SharedLinkPolicy The policy to apply to shared links created for content inside this shared folder. The current user must be on a team to set this policy to SharedLinkPolicy.members. The default for this union is anyone.
   SharedLinkPolicy (open union)
   Policy governing who can view shared links. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--anyone Void Links can be shared with anyone.
   #--#--members Void Links can only be shared among members of the shared folder.
   #--force_async Boolean Whether to force the share to happen asynchronously. The default for this field is False.
   */
   put db2_share_folder_HEADER(pAccessToken) into tHeader
   put db2_share_folder_POST(pPath,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy,pForceAsync) into tPost
   put db2_share_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   ShareFolderLaunch (union)
   The value will be one of the following datatypes:
   #--async_job_id String This response indicates that the processing is asynchronous. The string is an id that can be used to obtain the status of the asynchronous job.
   #--complete SharedFolderMetadata
   SharedFolderMetadata 
   --
   */
end db2_share_folder

function db2_transfer_folder pAccessToken,pSharedFolderId,pToDropboxId
   /*
   TransferFolderArg
    #--shared_folder_id String(pattern="[-_0-9a-zA-Z:]+") The ID for the shared folder.
    #--to_dropbox_id String(min_length=1) A account or team member ID to transfer ownership to.
   */
   put db2_transfer_folder_HEADER(pAccessToken) into tHeader
   put db2_transfer_folder_POST(pSharedFolderId,pToDropboxId) into tPost
   put db2_transfer_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_transfer_folder

function db2_unmount_folder pAccessToken,pSharedFolderId
   /*
   
   */
   put db2_unmount_folder_HEADER(pAccessToken) into tHeader
   put db2_unmount_folder_POST(pSharedFolderId) into tPost
   put db2_unmount_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   No return values. 
   */
end db2_unmount_folder

function db2_unshare_folder pAccessToken,pSharedFolderId,pLeaveACopy
   /*
   UnshareFolderArg
   #--shared_folder_id String The ID for the shared folder.
   #--leave_a_copy Boolean If true, members of this shared folder will get a copy of this folder after it's unshared. Otherwise, it will be removed from their Dropbox. The current user, who is an owner, will always retain their copy. 
   The default for this field is False.
   */
   put db2_unshare_folder_HEADER(pAccessToken) into tHeader
   put db2_unshare_folder_POST(pSharedFolderId,pLeaveACopy) into tPost
   put db2_unshare_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   LaunchEmptyResult (union)
   Result returned by methods that may either launch an asynchronous job or complete synchronously. Upon synchronous completion of the job, no additional information is returned. This datatype comes from an imported namespace originally defined in the async namespace. The value will be one of the following datatypes:
   #--async_job_id String This response indicates that the processing is asynchronous. The string is an id that can be used to obtain the status of the asynchronous job.
   #--complete Void The job finished synchronously and successfully.
   */
end db2_unshare_folder

function db2_update_folder_member pAccessToken,pSharedFolderId,pMember,pAccessLevel
     /*
   
   */
put db2_update_folder_member_HEADER(pAccessToken) into tHeader
   put db2_update_folder_member_POST(pSharedFolderId,pMember,pAccessLevel) into tPost
   put db2_update_folder_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   MemberAccessLevelResult
   Contains information about a member's access level to content after an operation.
   #--#--access_level AccessLevel? The member still has this level of access to the content through a parent folder. 
   This field is optional.
   AccessLevel (open union)
   Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--#--viewer Void The collaborator can only view the shared folder.
   #--#--#--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
   #--#--warning String? A localized string with additional information about why the user has this access level to the content. 
   This field is optional.
   #--#--access_details List of (ParentFolderAccessInfo)? The parent folders that a member has access to. The field is present if the user has access to the first parent folder where the member gains access. 
   This field is optional.
   ParentFolderAccessInfo
   Contains information about a parent folder that a member has access to.
   #--#--#--folder_name String Display name for the folder.
   #--#--#--shared_folder_id String The identifier of the parent shared folder.
   #--#--#--permissions List of (MemberPermission) The user's permissions for the parent shared folder.
   MemberPermission
   Whether the user is allowed to take the action on the associated member.
   #--#--#--#--action MemberAction The action that the user may wish to take on the member.
   MemberAction (open union)
   Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--leave_a_copy Void Allow the member to keep a copy of the folder when removing.
   #--#--#--#--#--make_editor Void Make the member an editor of the folder.
   #--#--#--#--#--make_owner Void Make the member an owner of the folder.
   #--#--#--#--#--make_viewer Void Make the member a viewer of the folder.
   #--#--#--#--#--remove Void Remove the member from the folder.
   #--#--#--#--allow Boolean True if the user is allowed to take the action.
   #--#--#--#--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed 
   This field is optional.
   PermissionDeniedReason (open union)
   Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--#--#--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
   #--#--#--#--#--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
   #--#--#--#--#--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
   #--#--#--#--#--target_is_owner Void Target is the owner of the folder.
   #--#--#--#--#--target_is_self Void Target is the user itself.
   #--#--#--#--#--target_not_active Void Target is not an active member of the team.
   */
end db2_update_folder_member

function db2_update_folder_policy pAccessToken,pSharedFolderId,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy
   /*
   UpdateFolderPolicyArg
   If any of the policy's are unset, then they retain their current setting.
   #--shared_folder_id String The ID for the shared folder.
   #--member_policy MemberPolicy? Who can be a member of this shared folder. Only applicable if the current user is on a team. This field is optional.
   MemberPolicy (open union)
   Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--team Void Only a teammate can become a member.
   #--#--anyone Void Anyone can become a member.
   #--acl_update_policy AclUpdatePolicy? Who can add and remove members of this shared folder. This field is optional.
   AclUpdatePolicy (open union)
   Policy governing who can change a shared folder's access control list (ACL). In other words, who can add, remove, or change the privileges of members. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--owner Void Only the owner can update the ACL.
   #--#--editors Void Any editor can update the ACL. This may be further restricted to editors on the same team.
   #--shared_link_policy SharedLinkPolicy? The policy to apply to shared links created for content inside this shared folder. The current user must be on a team to set this policy to SharedLinkPolicy.members. This field is optional.
   SharedLinkPolicy (open union)
   Policy governing who can view shared links. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--anyone Void Links can be shared with anyone.
   #--#--members Void Links can only be shared among members of the shared folder.
   */
   put db2_update_folder_policy_HEADER(pAccessToken) into tHeader
   put db2_update_folder_policy_POST(pSharedFolderId,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy) into tPost
   put db2_update_folder_policy_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*Returns
   SharedFolderMetadata
   --
   */
end db2_update_folder_policy

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
----------returned Metadata listed here to avoid repeated long lists in calls
-----------------------------------------------------------------------------
--UserMembershipInfo,GroupMembershipInfo,InviteeMembershipInfo
--FileLinkMetadata, FolderLinkMetadata, SharedFileMetadata, SharedFolderMetadata, FileMetadata, FolderMetadata, DeletedMetadata
-----------------------------------------------------------------------------
/*

*/
-----------------------------------------------------------------------------
/*
InviteeMembershipInfo
Information about an invited member of a shared content.
  #--access_type AccessLevel The access type for this member.
AccessLevel (open union)
Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
  #--editor Void The collaborator can both view and edit the shared folder.
  #--viewer Void The collaborator can only view the shared folder.
  #--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
  #--invitee InviteeInfo Recipient of the invitation.
InviteeInfo (open union)
Information about the recipient of a shared content invitation. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--email String E-mail address of invited user.
  #--permissions List of (MemberPermission)? The permissions that requesting user has on this member. The set of permissions corresponds to the MemberActions in the request. 
This field is optional.
MemberPermission
Whether the user is allowed to take the action on the associated member.
  #--action MemberAction The action that the user may wish to take on the member.
MemberAction (open union)
Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--leave_a_copy Void Allow the member to keep a copy of the folder when removing.
  #--make_editor Void Make the member an editor of the folder.
  #--make_owner Void Make the member an owner of the folder.
  #--make_viewer Void Make the member a viewer of the folder.
  #--remove Void Remove the member from the folder.
  #--allow Boolean True if the user is allowed to take the action.
  #--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed 
This field is optional.
PermissionDeniedReason (open union)
Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
  #--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
  #--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
  #--target_is_owner Void Target is the owner of the folder.
  #--target_is_self Void Target is the user itself.
  #--target_not_active Void Target is not an active member of the team.
  #--initials String? Suggested name initials for a member. 
   This field is optional.
  #--is_inherited Boolean True if the member has access from a parent folder. 
The default for this field is False.
  #--user UserInfo? The user this invitation is tied to, if available. 
   This field is optional.
UserInfo
Basic information about a user. Use users.get_account and users.get_account_batch to obtain more detailed information.
  #--account_id String(min_length=40, max_length=40) The account ID of the user.
  #--same_team Boolean If the user is in the same team as current user.
  #--team_member_id String? The team member ID of the shared folder member. Only present if same_team is true. 
   This field is optional.
*/
-----------------------------------------------------------------------------
/*
GroupMembershipInfo
The information about a group member of the shared content.
  #--access_type AccessLevel The access type for this member.
AccessLevel (open union)
Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
  #--editor Void The collaborator can both view and edit the shared folder.
  #--viewer Void The collaborator can only view the shared folder.
  #--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
  #--group GroupInfo The information about the membership group.
GroupInfo
The information about a group. Groups is a way to manage a list of users who need same access permission to the shared folder.
  #--group_name String
  #--group_id String
  #--group_type GroupType The type of group.
GroupType (open union)
The group type determines how a group is created and managed. This datatype comes from an imported namespace originally defined in the team_common namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--team Void A group to which team members are automatically added. Applicable to team folders only.
  #--user_managed Void A group is created and managed by a user.
  #--is_owner Boolean If the current user is an owner of the group.
  #--same_team Boolean If the group is owned by the current user's team.
  #--group_external_id String? External ID of group. This is an arbitrary ID that an admin can attach to a group. 
   This field is optional.
  #--member_count UInt32? The number of members in the group. 
   This field is optional.
  #--permissions List of (MemberPermission)? The permissions that requesting user has on this member. The set of permissions corresponds to the MemberActions in the request. 
   This field is optional.
MemberPermission
Whether the user is allowed to take the action on the associated member.
  #--action MemberAction The action that the user may wish to take on the member.
MemberAction (open union)
Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--leave_a_copy Void Allow the member to keep a copy of the folder when removing.
  #--make_editor Void Make the member an editor of the folder.
  #--make_owner Void Make the member an owner of the folder.
  #--make_viewer Void Make the member a viewer of the folder.
  #--remove Void Remove the member from the folder.
  #--allow Boolean True if the user is allowed to take the action.
  #--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed 
   This field is optional.
PermissionDeniedReason (open union)
Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
  #--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
  #--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
  #--target_is_owner Void Target is the owner of the folder.
  #--target_is_self Void Target is the user itself.
  #--target_not_active Void Target is not an active member of the team.
  #--initials String? Suggested name initials for a member. 
   This field is optional.
  #--is_inherited Boolean True if the member has access from a parent folder. 
The default for this field is False.
*/
-----------------------------------------------------------------------------
/*
UserMembershipInfo
The information about a user member of the shared content.
  #--access_type AccessLevel The access type for this member.
AccessLevel (open union)
Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
  #--editor Void The collaborator can both view and edit the shared folder.
  #--viewer Void The collaborator can only view the shared folder.
  #--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
  #--user UserInfo The account information for the membership user.
UserInfo
Basic information about a user. Use users.get_account and users.get_account_batch to obtain more detailed information.
  #--account_id String(min_length=40, max_length=40) The account ID of the user.
  #--same_team Boolean If the user is in the same team as current user.
  #--team_member_id String? The team member ID of the shared folder member. Only present if same_team is true. 
   This field is optional.
  #--permissions List of (MemberPermission)? The permissions that requesting user has on this member. The set of permissions corresponds to the MemberActions in the request. 
   This field is optional.
MemberPermission
Whether the user is allowed to take the action on the associated member.
  #--action MemberAction The action that the user may wish to take on the member.
MemberAction (open union)
Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--leave_a_copy Void Allow the member to keep a copy of the folder when removing.
  #--make_editor Void Make the member an editor of the folder.
  #--make_owner Void Make the member an owner of the folder.
  #--make_viewer Void Make the member a viewer of the folder.
  #--remove Void Remove the member from the folder.
  #--allow Boolean True if the user is allowed to take the action.
  #--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed 
   This field is optional.
PermissionDeniedReason (open union)
Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
  #--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
  #--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
  #--target_is_owner Void Target is the owner of the folder.
  #--target_is_self Void Target is the user itself.
  #--target_not_active Void Target is not an active member of the team.
  #--initials String? Suggested name initials for a member. 
   This field is optional.
  #--is_inherited Boolean True if the member has access from a parent folder. 
The default for this field is False.
*/
-----------------------------------------------------------------------------
/*
FileLinkMetadata
The metadata of a file shared link
  #--url String URL of the shared link.
  #--name String The linked file name (including extension). This never contains a slash.
  #--link_permissions LinkPermissions The link's access permissions.
LinkPermissions
  #--can_revoke Boolean Whether the caller can revoke the shared link
  #--resolved_visibility ResolvedVisibility? The current visibility of the link after considering the shared links policies of the the team (in case the link's owner is part of a team) and the shared folder (in case the linked file is part of a shared folder). This field is shown only if the caller has access to this info (the link's owner always has access to this data). 
   This field is optional.
ResolvedVisibility (open union)
The actual access permissions values of shared links after taking into account user preferences and the team and shared folder settings. Check the RequestedVisibility for more info on the possible visibility values that can be set by the shared link's owner. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--public Void Anyone who has received the link can access it. No login required.
  #--team_only Void Only members of the same team can access the link. Login is required.
  #--password Void A link-specific password is required to access the link. Login is not required.
  #--team_and_password Void Only members of the same team who have the link-specific password can access the link. Login is required.
  #--shared_folder_only Void Only members of the shared folder containing the linked file can access the link. Login is required.
  #--requested_visibility RequestedVisibility? The shared link's requested visibility. This can be overridden by the team and shared folder policies. The final visibility, after considering these policies, can be found in resolved_visibility. This is shown only if the caller is the link's owner. 
   This field is optional.
RequestedVisibility (union)
The access permission that can be requested by the caller for the shared link. Note that the final resolved visibility of the shared link takes into account other aspects, such as team and shared folder settings. Check the ResolvedVisibility for more info on the possible resolved visibility values of shared links. The value will be one of the following datatypes:
  #--public Void Anyone who has received the link can access it. No login required.
  #--team_only Void Only members of the same team can access the link. Login is required.
  #--password Void A link-specific password is required to access the link. Login is not required.
  #--revoke_failure_reason SharedLinkAccessFailureReason? The failure reason for revoking the link. This field will only be present if the can_revoke is false. 
   This field is optional.
SharedLinkAccessFailureReason (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--login_required Void User is not logged in.
  #--email_verify_required Void User's email is not verified.
  #--password_required Void The link is password protected.
  #--team_only Void Access is allowed for team members only.
  #--owner_only Void Access is allowed for the shared link's owner only.
  #--client_modified Timestamp The modification time set by the desktop client when the file was added to Dropbox. Since this time is not verified (the Dropbox server stores whatever the desktop client sends up), this should only be used for display purposes (such as sorting) and not, for example, to determine if a file has changed or not.
  #--server_modified Timestamp The last time the file was modified on Dropbox.
  #--rev String(min_length=9, pattern="[0-9a-f]+")? A unique identifier for the current revision of a file. This field is the same rev as elsewhere in the API and can be used to detect changes and avoid conflicts.
  #--size UInt64 The file size in bytes.
  #--id String(min_length=1) A unique identifier for the linked file. 
   This field is optional.
  #--expires Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time, if set. By default the link won't expire. 
   This field is optional.
  #--path_lower String? The lowercased full path in the user's Dropbox. This always starts with a slash. This field will only be present only if the linked file is in the authenticated user's dropbox. 
   This field is optional.
  #--team_member_info TeamMemberInfo? The team membership information of the link's owner. This field will only be present if the link's owner is a team member. 
   This field is optional.
TeamMemberInfo
Information about a team member.
  #--team_info Team Information about the member's team
Team
Information about a team. This datatype comes from an imported namespace originally defined in the users namespace.
  #--id String(min_length=1) The team's unique ID.
  #--name String The name of the team.
  #--display_name String The display name of the user.
  #--member_id String? ID of user as a member of a team. This field will only be present if the member is in the same team as current user. 
   This field is optional.
  #--content_owner_team_info Team? The team information of the content's owner. This field will only be present if the content's owner is a team member and the content's owner team is different from the link's owner team. 
   This field is optional.
Team
Information about a team. This datatype comes from an imported namespace originally defined in the users namespace.
  #--id String(min_length=1) The team's unique ID.
  #--name String The name of the team.
*/
-----------------------------------------------------------------------------
/*
FolderLinkMetadata
The metadata of a folder shared link
  #--url String URL of the shared link.
  #--name String The linked file name (including extension). This never contains a slash.
  #--link_permissions LinkPermissions The link's access permissions.
LinkPermissions
  #--can_revoke Boolean Whether the caller can revoke the shared link
resolved_visibility ResolvedVisibility? The current visibility of the link after considering the shared links policies of the the team (in case the link's owner is part of a team) and the shared folder (in case the linked file is part of a shared folder). This field is shown only if the caller has access to this info (the link's owner always has access to this data). 
   This field is optional.
ResolvedVisibility (open union)
The actual access permissions values of shared links after taking into account user preferences and the team and shared folder settings. Check the RequestedVisibility for more info on the possible visibility values that can be set by the shared link's owner. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--public Void Anyone who has received the link can access it. No login required.
  #--team_only Void Only members of the same team can access the link. Login is required.
  #--password Void A link-specific password is required to access the link. Login is not required.
  #--team_and_password Void Only members of the same team who have the link-specific password can access the link. Login is required.
  #--shared_folder_only Void Only members of the shared folder containing the linked file can access the link. Login is required.
  #--requested_visibility RequestedVisibility? The shared link's requested visibility. This can be overridden by the team and shared folder policies. The final visibility, after considering these policies, can be found in resolved_visibility. This is shown only if the caller is the link's owner. 
   This field is optional.
RequestedVisibility (union)
The access permission that can be requested by the caller for the shared link. Note that the final resolved visibility of the shared link takes into account other aspects, such as team and shared folder settings. Check the ResolvedVisibility for more info on the possible resolved visibility values of shared links. The value will be one of the following datatypes:
  #--public Void Anyone who has received the link can access it. No login required.
  #--team_only Void Only members of the same team can access the link. Login is required.
  #--password Void A link-specific password is required to access the link. Login is not required.
  #--revoke_failure_reason SharedLinkAccessFailureReason? The failure reason for revoking the link. This field will only be present if the can_revoke is false. 
   This field is optional.
SharedLinkAccessFailureReason (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--login_required Void User is not logged in.
  #--email_verify_required Void User's email is not verified.
  #--password_required Void The link is password protected.
  #--team_only Void Access is allowed for team members only.
  #--owner_only Void Access is allowed for the shared link's owner only.
  #--id String(min_length=1)? A unique identifier for the linked file. 
   This field is optional.
  #--expires Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time, if set. By default the link won't expire. 
   This field is optional.
  #--path_lower String? The lowercased full path in the user's Dropbox. This always starts with a slash. This field will only be present only if the linked file is in the authenticated user's dropbox. 
   This field is optional.
  #--team_member_info TeamMemberInfo? The team membership information of the link's owner. This field will only be present if the link's owner is a team member. 
   This field is optional.
TeamMemberInfo
Information about a team member.
  #--team_info Team Information about the member's team
Team
Information about a team. This datatype comes from an imported namespace originally defined in the users namespace.
  #--id String(min_length=1) The team's unique ID.
  #--name String The name of the team.
  #--display_name String The display name of the user.
  #--member_id String? ID of user as a member of a team. This field will only be present if the member is in the same team as current user. 
   This field is optional.
  #--content_owner_team_info Team? The team information of the content's owner. This field will only be present if the content's owner is a team member and the content's owner team is different from the link's owner team. 
   This field is optional.
Team
Information about a team. This datatype comes from an imported namespace originally defined in the users namespace.
  #--id String(min_length=1) The team's unique ID.
  #--name String The name of the team.
*/
-----------------------------------------------------------------------------
/*
SharedFileMetadata
Properties of the shared file.
#--policy FolderPolicy Policies governing this shared file.
FolderPolicy
A set of policies governing membership and privileges for a shared folder.
#--#--acl_update_policy AclUpdatePolicy Who can add and remove members from this shared folder.
AclUpdatePolicy (open union)
Policy governing who can change a shared folder's access control list (ACL). In other words, who can add, remove, or change the privileges of members. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--owner Void Only the owner can update the ACL.
#--#--#--editors Void Any editor can update the ACL. This may be further restricted to editors on the same team.
#--#--shared_link_policy SharedLinkPolicy Who links can be shared with.
SharedLinkPolicy (open union)
Policy governing who can view shared links. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--anyone Void Links can be shared with anyone.
#--#--#--members Void Links can only be shared among members of the shared folder.
#--#--member_policy MemberPolicy? Who can be a member of this shared folder, as set on the folder itself. The effective policy may differ from this value if the team-wide policy is more restrictive. Present only if the folder is owned by a team. This field is optional.
MemberPolicy (open union)
Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--team Void Only a teammate can become a member.
#--#--#--anyone Void Anyone can become a member.
#--#--resolved_member_policy MemberPolicy? Who can be a member of this shared folder, taking into account both the folder and the team-wide policy. This value may differ from that of member_policy if the team-wide policy is more restrictive than the folder policy. Present only if the folder is owned by a team. This field is optional.
MemberPolicy (open union)
Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--team Void Only a teammate can become a member.
#--#--#--anyone Void Anyone can become a member.
#--preview_url String URL for displaying a web preview of the shared file.
#--name String The name of this file.
#--id String(min_length=1) The ID of the file.
#--permissions List of (FilePermission)? The sharing permissions that requesting user has on this file. This corresponds to the entries given in GetFileMetadataBatchArg.actions or GetFileMetadataArg.actions. This field is optional.
FilePermission
Whether the user is allowed to take the sharing action on the file.
#--#--action FileAction The action that the user may wish to take on the file.
FileAction (open union)
Sharing actions that may be taken on files. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--edit_contents Void Change or edit contents of the file.
#--#--#--invite_viewer Void Add a member with view permissions.
#--#--#--unshare Void Stop sharing this file.
#--#--#--relinquish_membership Void Relinquish one's own membership to the file.
#--#--#--share_link Void Create a shared link to the file.
#--#--allow Boolean True if the user is allowed to take the action.
#--#--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed This field is optional.
PermissionDeniedReason (open union)
Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
#--#--#--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
#--#--#--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
#--#--#--target_is_owner Void Target is the owner of the folder.
#--#--#--target_is_self Void Target is the user itself.
#--#--#--target_not_active Void Target is not an active member of the team.
#--owner_team Team? The team that owns the file. This field is not present if the file is not owned by a team. This field is optional.
Team
Information about a team. This datatype comes from an imported namespace originally defined in the users namespace.
#--#--id String(min_length=1) The team's unique ID.
#--#--name String The name of the team.
#--parent_shared_folder_id String? The ID of the parent shared folder. This field is present only if the file is contained within a shared folder. This field is optional.
#--path_lower String? The lower-case full path of this file. Absent for unmounted files. This field is optional.
#--path_display String? The cased path to be used for display purposes only. In rare instances the casing will not correctly match the user's filesystem, but this behavior will match the path provided in the Core API v1. Absent for unmounted files. This field is optional.
*/
-----------------------------------------------------------------------------
/*
SharedFolderMetadata
The metadata which includes basic information about the shared folder.
  #--access_type AccessLevel The current user's access level for this shared folder.
AccessLevel (open union)
Defines the access levels for collaborators. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
  #--editor Void The collaborator can both view and edit the shared folder.
  #--viewer Void The collaborator can only view the shared folder.
  #--viewer_no_comment Void The collaborator can only view the shared folder and does not have any access to comments.
  #--is_team_folder Boolean Whether this folder is a team folder.
  #--policy FolderPolicy Policies governing this shared folder.
FolderPolicy
A set of policies governing membership and privileges for a shared folder.
  #--acl_update_policy AclUpdatePolicy Who can add and remove members from this shared folder.
AclUpdatePolicy (open union)
Policy governing who can change a shared folder's access control list (ACL). In other words, who can add, remove, or change the privileges of members. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--owner Void Only the owner can update the ACL.
  #--editors Void Any editor can update the ACL. This may be further restricted to editors on the same team.
  #--shared_link_policy SharedLinkPolicy Who links can be shared with.
SharedLinkPolicy (open union)
Policy governing who can view shared links. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--anyone Void Links can be shared with anyone.
  #--members Void Links can only be shared among members of the shared folder.
  #--member_policy MemberPolicy? Who can be a member of this shared folder, as set on the folder itself. The effective policy may differ from this value if the team-wide policy is more restrictive. Present only if the folder is owned by a team. This field is optional.
MemberPolicy (open union)
Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--team Void Only a teammate can become a member.
  #--anyone Void Anyone can become a member.
  #--resolved_member_policy MemberPolicy? Who can be a member of this shared folder, taking into account both the folder and the team-wide policy. This value may differ from that of member_policy if the team-wide policy is more restrictive than the folder policy. Present only if the folder is owned by a team. This field is optional.
MemberPolicy (open union)
Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--team Void Only a teammate can become a member.
  #--anyone Void Anyone can become a member.
  #--name String The name of the this shared folder.
  #--shared_folder_id String The ID of the shared folder.
  #--time_invited Timestamp Timestamp indicating when the current user was invited to this shared folder.
  #--owner_team Team? The team that owns the folder. This field is not present if the folder is not owned by a team. This field is optional.
Team
Information about a team. This datatype comes from an imported namespace originally defined in the users namespace.
  #--id String The team's unique ID.
  #--name String The name of the team.
  #--parent_shared_folder_id String? The ID of the parent shared folder. This field is present only if the folder is contained within another shared folder. This field is optional.
  #--path_lower String? The lower-cased full path of this shared folder. Absent for unmounted folders. This field is optional.
  #--permissions List of (FolderPermission)? Actions the current user may perform on the folder and its contents. The set of permissions corresponds to the FolderActions in the request. This field is optional.
FolderPermission
Whether the user is allowed to take the action on the shared folder.
  #--action FolderAction The action that the user may wish to take on the folder.
FolderAction (open union)
Actions that may be taken on shared folders. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--change_options Void Change folder options, such as who can be invited to join the folder.
  #--edit_contents Void Change or edit contents of the folder.
  #--invite_editor Void Invite a user or group to join the folder with read and write permission.
  #--invite_viewer Void Invite a user or group to join the folder with read permission.
  #--relinquish_membership Void Relinquish one's own membership in the folder.
  #--unmount Void Unmount the folder.
  #--unshare Void Stop sharing this folder.
  #--leave_a_copy Void Keep a copy of the contents upon leaving or being kicked from the folder.
  #--share_link Void Create a shared link for folder.
  #--allow Boolean True if the user is allowed to take the action.
  #--reason PermissionDeniedReason? The reason why the user is denied the permission. Not present if the action is allowed, or if no reason is available. This field is optional.
PermissionDeniedReason (open union)
Possible reasons the user is denied a permission. The value will be one of the following datatypes. New values may be introduced as our API evolves.
  #--user_not_same_team_as_owner Void User is not on the same team as the folder owner.
  #--user_not_allowed_by_owner Void User is prohibited by the owner from taking the action.
  #--target_is_indirect_member Void Target is indirectly a member of the folder, for example by being part of a group.
  #--target_is_owner Void Target is the owner of the folder.
  #--target_is_self Void Target is the user itself.
  #--target_not_active Void Target is not an active member of the team.
*/
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
/*
FileMetadata
#--name String The last component of the path (including extension). This never contains a slash.
#--id String(min_length=1) A unique identifier for the file.
#--client_modified Timestamp(format="%Y-%m-%dT%H:%M:%SZ") For files, this is the modification time set by the desktop client when the file was added to Dropbox. Since this time is not verified (the Dropbox server stores whatever the desktop client sends up), this should only be used for display purposes (such as sorting) and not, for example, to determine if a file has changed or not.
#--server_modified Timestamp(format="%Y-%m-%dT%H:%M:%SZ") The last time the file was modified on Dropbox.
#--rev String(min_length=9, pattern="[0-9a-f]+")? A unique identifier for the current revision of a file. This field is the same rev as elsewhere in the API and can be used to detect changes and avoid conflicts.
#--size UInt64 The file size in bytes.
#--path_lower String? The lowercased full path in the user's Dropbox. This always starts with a slash. This field will be null if the file or folder is not mounted. This field is optional.
#--path_display String? The cased path to be used for display purposes only. In rare instances the casing will not correctly match the user's filesystem, but this behavior will match the path provided in the Core API v1. Changes to the casing of paths won't be returned by list_folder/continue. This field will be null if the file or folder is not mounted. This field is optional.
#--parent_shared_folder_id String? Deprecated. Please use FileSharingInfo.parent_shared_folder_id or FolderSharingInfo.parent_shared_folder_id instead. This field is optional.
#--media_info MediaInfo? Additional information if the file is a photo or video. This field is optional.
MediaInfo (union)
The value will be one of the following datatypes:
#--#--pending Void Indicate the photo/video is still under processing and metadata is not available yet.
#--#--metadata MediaMetadata The metadata for the photo/video.
MediaMetadata (datatype with subtypes)
Metadata for a photo or video. This datatype will be one of the following subtypes:
#--#--#--photo PhotoMetadata
PhotoMetadata
Metadata for a photo.
#--#--#--#--dimensions Dimensions? Dimension of the photo/video. This field is optional.
Dimensions
Dimensions for a photo or video.
#--#--#--#--#--height UInt64 Height of the photo/video.
#--#--#--#--#--width UInt64 Width of the photo/video.
#--#--#--#--location GpsCoordinates? The GPS coordinate of the photo/video. 
   This field is optional.
GpsCoordinates
GPS coordinates for a photo or video.
#--#--#--#--#--latitude Float64 Latitude of the GPS coordinates.
#--#--#--#--#--longitude Float64 Longitude of the GPS coordinates.
#--#--#--#--time_taken Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? The timestamp when the photo/video is taken. 
   This field is optional.
#--#--#--video VideoMetadata
VideoMetadata
Metadata for a video.
#--#--#--#--dimensions Dimensions? Dimension of the photo/video. 
   This field is optional.
Dimensions
Dimensions for a photo or video.
#--#--#--#--#--height UInt64 Height of the photo/video.
#--#--#--#--#--width UInt64 Width of the photo/video.
#--#--#--#--location GpsCoordinates? The GPS coordinate of the photo/video. 
   This field is optional.
GpsCoordinates
GPS coordinates for a photo or video.
#--#--#--#--#--latitude Float64 Latitude of the GPS coordinates.
#--#--#--#--#--longitude Float64 Longitude of the GPS coordinates.
#--#--#--#--time_taken Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? The timestamp when the photo/video is taken. 
   This field is optional.
#--#--#--#--duration UInt64? The duration of the video in milliseconds. 
   This field is optional.
#--sharing_info FileSharingInfo? Set if this file is contained in a shared folder. 
   This field is optional.
FileSharingInfo
Sharing info for a file which is contained by a shared folder.
#--#--read_only Boolean True if the file or folder is inside a read-only shared folder.
#--#--parent_shared_folder_id String ID of shared folder that holds this file.
#--#--modified_by String? The last user who modified the file. This field will be null if the user's account has been deleted. 
   This field is optional.
#--property_groups List of (PropertyGroup)? Additional information if the file has custom properties with the property template specified. 
   This field is optional.
PropertyGroup
Collection of custom properties in filled property templates. This datatype comes from an imported namespace originally defined in the properties namespace.
#--#--template_id String A unique identifier for a property template type.
#--#--fields List of (PropertyField) This is a list of custom properties associated with a file. There can be up to 32 properties for a template.
PropertyField
This datatype comes from an imported namespace originally defined in the properties namespace.
#--#--#--name String This is the name or key of a custom property in a property template. File property names can be up to 256 bytes.
#--#--#--value String Value of a custom property attached to a file. Values can be up to 1024 bytes.
#--#---has_explicit_shared_members Boolean? This flag will only be present if include_has_explicit_shared_members is true in list_folder or get_metadata. If this flag is present, it will be true if this file has any explicit shared members. This is different from sharing_info in that this could be true in the case where a file has explicit members but is not contained within a shared folder. 
   This field is optional.
*/
-----------------------------------------------------------------------------
/*
FolderMetadata
#--#--name String The last component of the path (including extension). This never contains a slash.
#--#--id String A unique identifier for the folder.
#--#--path_lower String? The lowercased full path in the user's Dropbox. This always starts with a slash. This field will be null if the file or folder is not mounted. 
   This field is optional.
#--#--path_display String? The cased path to be used for display purposes only. In rare instances the casing will not correctly match the user's filesystem, but this behavior will match the path provided in the Core API v1. Changes to the casing of paths won't be returned by list_folder/continue. This field will be null if the file or folder is not mounted. 
   This field is optional.
#--#--parent_shared_folder_id String? Deprecated. Please use FileSharingInfo.parent_shared_folder_id or FolderSharingInfo.parent_shared_folder_id instead. 
   This field is optional.
#--#--shared_folder_id String? Deprecated. Please use sharing_info instead. 
   This field is optional.
#--#--sharing_info FolderSharingInfo? Set if the folder is contained in a shared folder or is a shared folder mount point. 
   This field is optional.
FolderSharingInfo
Sharing info for a folder which is contained in a shared folder or is a shared folder mount point.
#--#--#--read_only Boolean True if the file or folder is inside a read-only shared folder.
#--#--#--parent_shared_folder_id String? Set if the folder is contained by a shared folder. 
   This field is optional.
#--#--#--shared_folder_id String? If this folder is a shared folder mount point, the ID of the shared folder mounted at this location. 
   This field is optional.
#--#--property_groups List of (PropertyGroup)? Additional information if the file has custom properties with the property template specified. 
   This field is optional.
PropertyGroup
Collection of custom properties in filled property templates. This datatype comes from an imported namespace originally defined in the properties namespace.
#--#--#--template_id String A unique identifier for a property template type.
#--#--#--fields List of (PropertyField) This is a list of custom properties associated with a file. There can be up to 32 properties for a template.
PropertyField
This datatype comes from an imported namespace originally defined in the properties namespace.
#--#--#--#--name String This is the name or key of a custom property in a property template. File property names can be up to 256 bytes.
#--#--#--#--value String Value of a custom property attached to a file. Values can be up to 1024 bytes.
*/
-----------------------------------------------------------------------------
/*
DeletedMetadata
Indicates that there used to be a file or folder at this path, but it no longer exists.
#--#--name String The last component of the path (including extension). This never contains a slash.
#--#--path_lower String? The lowercased full path in the user's Dropbox. This always starts with a slash. This field will be null if the file or folder is not mounted. 
   This field is optional.
#--#--path_display String? The cased path to be used for display purposes only. In rare instances the casing will not correctly match the user's filesystem, but this behavior will match the path provided in the Core API v1. Changes to the casing of paths won't be returned by list_folder/continue. This field will be null if the file or folder is not mounted. 
   This field is optional.
#--#--parent_shared_folder_id String? Deprecated. Please use FileSharingInfo.parent_shared_folder_id or FolderSharingInfo.parent_shared_folder_id instead. 
   This field is optional.
*/
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

function db2_API2 pHeader,pPost,pURL
   set socketTimeoutInterval to 30000  --30 seconds
   put the httpHeaders into oldHTTPHeaders
   --put cr & db2_Header_Close() after pHeader  --gmc july 2016
   set the httpHeaders to pHeader
   put textencode(pPost,"UTF-8") into pPost --gmc july 2016
   post pPost to URL pURL
   put it into tPostReturn
   put the result into tError
   set the httpHeaders to oldHTTPHeaders
   return tPostReturn
end db2_API2

function db2_Header_Close
   return "connection: close"
end db2_Header_Close

function fReplaceUserAccountIDInPost pPost
   --used by all eg buttons for each each API call 
   if the hilite of btn "AT1" then put fld "UserAccountID1" into tUserAccountID
   if the hilite of btn "AT2" then put fld "UserAccountID2" into tUserAccountID
   if the hilite of btn "AT3" then put fld "UserAccountID3" into tUserAccountID
   if the hilite of btn "AT4" then put fld "UserAccountID4" into tUserAccountID
   replace "<<UserAccountID>>" with tUserAccountID in pPost
   return pPost
end fReplaceUserAccountIDInPost

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
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath))
end db2_Header_APIDownload

function db2_Header_APISessionStart pClose
   /* 
   Dropbox-API-Arg: 
   {"session_id":"AAAAAAAAAYSEAI0qRJ7GMg","offset":327}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("close") & ": " & (pClose))
end db2_Header_APISessionStart

function db2_Header_APISessionAppend pSession,pOffset
   /* 
   Dropbox-API-Arg: 
   {"session_id": "1234faaf0678bcde","offset": 0}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("session_id") & ": " & fGetQ(pSession)& "," &fGetQ("offset") & ": " & pOffset)
end db2_Header_APISessionAppend

function db2_Header_APISessionAppend_v2 pSession,pOffset,pClose
   /* 
   Dropbox-API-Arg: 
   {"cursor": {"session_id": "1234faaf0678bcde","offset": 0},"close": false}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("cursor") & ": " & fGetCB(fGetQ("session_id") & ": " & fGetQ(pSession)& "," &fGetQ("offset") & ": " & pOffset) & "," &fGetQ("close") & ": " & pClose)
end db2_Header_APISessionAppend_v2

function db2_Header_APISessionFinish pSession,pOffset,pPath,pMode,pAutorename,pMute
   /* 
   Dropbox-API-Arg: 
   {"cursor":{"session_id":"AAAAAAAAAYSEAI0qRJ7GMg","offset":358},"commit":{"path":"/apps/MyApp/seasons.txt","mode":"add"}}
   {"cursor": {"session_id": "1234faaf0678bcde","offset": 0},"commit": {"path": "/apps/MyApp/seasons.txt","mode": "add","autorename": true,"mute": false}}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("cursor") & ": " & fGetCB(fGetQ("session_id") & ": " & fGetQ(pSession) & "," &fGetQ("offset") & ": " & pOffset) & "," & fGetQ("commit") & ": " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," & fGetQ("mode") & ": " & fGetQ(pMode) & "," & fGetQ("autorename") & ": " & pAutorename & "," &fGetQ("mute") & ": " & pMute))
end db2_Header_APISessionFinish


function db2_Header_APIAlphaUploadTemplate pPath,pMode,pAutorename,pClientModified,pMute,pTemplateIdFieldsArray
   /* 
   Dropbox-API-Arg: {"path":"/folder3/testfile5.txt","mode":"overwrite","autorename":false,"client_modified": "2016-07-24T20:58:03Z","mute":false}
   one template 
   property_groups": [{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa", "fields": [{"name": "SecurityPolicy","value": "Confidential"},{"name": "Author","value": "A001"}]}]}
   2 templates
  "property_groups": [{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "SecurityPolicy","value": "Confidential"},{"name": "Author","value": "A001"}]},{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAXXb","fields": [{"name": "Topic","value": "Science"},{"name": "SubTopic","value": "Biology"}]}]}
   */
   if pTemplateIdFieldsArray is not empty then
      --
      --{"path": "/folder1/testfile1.txt","property_groups": []}
      put "{" & fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("property_groups") & ": [" into tString
      repeat for each key rTemplateKeyNum in pTemplateIdFieldsArray
         --  {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"}]},
         --pTemplateIdFieldsArray[1][template_id]= ptid:1a5n2i6d3OYEAAAAAAAAAYa
         put "{" & fGetQ("template_id") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["template_id"]) & "," & fGetQ("fields") & ": [" after tString
         repeat for each key rFieldNum in pTemplateIdFieldsArray[rTemplateKeyNum]["fields"]
            --pTemplateIdFieldsArray[1][fields][1][name]=   SecurityPolicy
            -- pTemplateIdFieldsArray[1][fields][1][value]= Confidential
            --{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"},
            put "{" & fGetQ("name") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["fields"][rFieldNum]["name"]) after tString
            put "," after tString
            put fGetQ("value") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["fields"][rFieldNum]["value"]) after tString
            put "}," after tString
         end repeat
         if last char of tString is comma then delete last char of tString  --delete trailing comma
         put "]}," after tString
      end repeat
      if last char of tString is comma then delete last char of tString  --delete trailing comma
      put "]}" after tString
   else
      if pClientModified is empty then
         return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," & fGetQ("mode") & ": " & fGetQ(pMode) & "," & fGetQ("autorename") & ": " & pAutorename & "," & fGetQ("mute") & ": " & pMute)
      else
         return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," & fGetQ("mode") & ": " & fGetQ(pMode) & "," & fGetQ("autorename") & ": " & pAutorename & "," & fGetQ("client_modified") & ": " & pClientModified & "," & fGetQ("mute") & ": " & pMute)
      end if
   end if
   if pClientModified is empty then
      return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," & fGetQ("mode") & ": " & fGetQ(pMode) & "," & fGetQ("autorename") & ": " & pAutorename & "," & fGetQ("mute") & ": " & pMute)
   else
      return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," & fGetQ("mode") & ": " & fGetQ(pMode) & "," & fGetQ("autorename") & ": " & pAutorename & "," & fGetQ("client_modified") & ": " & pClientModified & "," & fGetQ("mute") & ": " & pMute)
   end if
end db2_Header_APIAlphaUploadTemplate

function db2_Header_APIAlphaUpload pPath,pMode,pAutorename,pClientModified,pMute
   /* 
    Dropbox-API-Arg: {"path":"/folder3/testfile5.txt","mode":"overwrite","autorename":false,"client_modified": "2016-07-24T20:58:03Z","mute":false}
   */
   if pClientModified is empty then
      return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," & fGetQ("mode") & ": " & fGetQ(pMode) & "," & fGetQ("autorename") & ": " & pAutorename & "," & fGetQ("mute") & ": " & pMute)
   else
      return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," & fGetQ("mode") & ": " & fGetQ(pMode) & "," & fGetQ("autorename") & ": " & pAutorename & "," & fGetQ("client_modified") & ": " & pClientModified & "," & fGetQ("mute") & ": " & pMute)
   end if
end db2_Header_APIAlphaUpload

function db2_Header_APIUpload pPath,pMode,pAutorename,pMute
   /* 
   Dropbox-API-Arg: {"path":"/Apps/MyApp/season/NewRCPStestfile.txt","mode":"overwrite","autorename": true,"mute": false}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," & fGetQ("mode") & ": " & fGetQ(pMode) & "," & fGetQ("autorename") & ": " & pAutorename & "," & fGetQ("mute") & ": " & pMute)
end db2_Header_APIUpload

function db2_Header_APIThumb pPath,pFormat,pSize
   /* 
   Dropbox-API-Arg: {"path":"/apps/MyApp/RCsubmitter.jpg","format": "jpeg","size": "w64h64"}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," &fGetQ("format") & ": " & fGetQ(pFormat)& "," &fGetQ("size") & ": " & fGetQ(pSize))
end db2_Header_APIThumb

function db2_Header_APIPreview pPath
   /* 
   Dropbox-API-Arg: {"path":"/apps/MyApp/seasons.txt"}
   */
   return "Dropbox-API-Arg: " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath))
end db2_Header_APIPreview

function db2_Header_APISharedLinkFile pUrl,pPath,pLinkPassword
   /* 
   Dropbox-API-Arg: {"url": "https://www.dropbox.com/s/2sn712vy1ovegw8/Prime_Numbers.txt?dl=0","path": "/Prime_Numbers.txt"}"
   */
   if pPath is not empty then
      if pLinkPassword is not empty then
         return "Dropbox-API-Arg: " & fGetCB(fGetQ("url") & ": " &  fGetQ(pUrl) & "," &fGetQ("path") & ": " & fGetQ(pPath) & "," &fGetQ("link_password") & ": " & fGetQ(pLinkPassword))
      else
         return "Dropbox-API-Arg: " & fGetCB(fGetQ("url") & ": " &  fGetQ(pUrl) & "," &fGetQ("path") & ": " & fGetQ(pPath))
      end if
   else
      return "Dropbox-API-Arg: " & fGetCB(fGetQ("url") & ": " &  fGetQ(pUrl))
   end if
end db2_Header_APISharedLinkFile

-----------------------------------------------------------------------------
------------individual headers for all API---------------------------------------
-------auth--------------------------------------------------------------

function db2_token_revoke_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_token_revoke_HEADER

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

function db2_alpha_get_metadata_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_alpha_get_metadata_HEADER

function db2_alpha_upload_HEADER pAccessToken,pPath,pMode,pAutorename,pClientModified,pMute,pTemplateIdFieldsArray
   if pMode is empty then put "add" into pMode
   if pAutorename is empty then put "False" into pAutorename
   if pMute is empty then put "False" into pMute
   if pTemplateIdFieldsArray is empty then  
      return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APIAlphaUploadTemplate(pPath,pMode,pAutorename,pClientModified,pMute,pTemplateIdFieldsArray)
   else
      return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APIAlphaUpload(pPath,pMode,pAutorename,pClientModified,pMute)
   end if
end db2_alpha_upload_HEADER

function db2_copy_reference_get_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_copy_reference_get_HEADER

function db2_copy_reference_save_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_copy_reference_save_HEADER

function db2_get_temporary_link_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_temporary_link_HEADER

function db2_properties_add_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_add_HEADER

function db2_properties_overwrite_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_overwrite_HEADER

function db2_properties_remove_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_remove_HEADER

function db2_properties_template_add_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_template_add_HEADER

function db2_properties_template_get_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_template_get_HEADER

function db2_properties_template_list_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_template_list_HEADER

function db2_properties_update_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_update_HEADER

function db2_save_url_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_save_url_HEADER

function db2_save_url_check_job_status_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_save_url_check_job_status_HEADER

function db2_upload_session_append_v2_HEADER pAccessToken,pSessionID,pOffset,pClose
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionAppend_v2(pSessionID,pOffset,pClose)
end db2_upload_session_append_v2_HEADER

--------------------------------------------------------------
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
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIDownload(pPath)
end db2_download_HEADER

function db2_get_metadata_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_metadata_HEADER

function db2_get_preview_HEADER pAccessToken,pPath
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIPreview(pPath)
end db2_get_preview_HEADER

function db2_get_thumbnail_HEADER pAccessToken,pPath,pFormat,pSize
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

function db2_upload_session_append_HEADER pAccessToken,pSessionID,pOffset
    return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionAppend(pSessionID,pOffset)
end db2_upload_session_append_HEADER

function db2_upload_session_finish_HEADER pAccessToken,pSessionID,pOffset,pPath,pMode,pAutorename,pMute
   if pMode is empty then put "add" into pMode
   if pAutorename is empty then put "False" into pAutorename
   if pMute is empty then put "False" into pMute
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionFinish(pSessionID,pOffset,pPath,pMode,pAutorename,pMute)
end db2_upload_session_finish_HEADER

function db2_upload_session_finish_batch_HEADER pAccessToken,pSessionID,pOffset,pPath,pMode,pAutorename,pMute
   if pMode is empty then put "add" into pMode
   if pMute is empty then put "False" into pMute
   if pAutorename is empty then put "False" into pAutorename
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionFinish(pSession,pOffset,pPath,pMode,pAutorename,pMute)
end db2_upload_session_finish_batch_HEADER

function db2_upload_session_finish_batch_check_HEADER pAccessToken,pSessionID,pOffset,pPath,pMode,pAutorename,pMute
  if pMode is empty then put "add" into pMode
   if pMute is empty then put "False" into pMute
   if pAutorename is empty then put "False" into pAutorename
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionFinish(pSession,pOffset,pPath,pMode,pAutorename,pMute)
end db2_upload_session_finish_batch_check_HEADER

function db2_upload_HEADER pAccessToken,pPath,pMode,pAutorename,pMute
   if pMode is empty then put "add" into pMode
   if pAutorename is empty then put "False" into pAutorename
   if pMute is empty then put "False" into pMute
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APIUpload(pPath,pMode,pAutorename,pMute)
end db2_upload_HEADER

function db2_upload_session_start_HEADER pAccessToken,pClose
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionStart(pClose)
end db2_upload_session_start_HEADER

----------------------------------------------------------------
------sharing-----------------------------------------------

function db2_add_file_member_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_add_file_member_HEADER

function db2_change_file_member_access_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_change_file_member_access_HEADER

function db2_check_remove_member_job_status_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_check_remove_member_job_status_HEADER

function db2_get_file_metadata_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_file_metadata_HEADER

function db2_get_file_metadata_batch_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_file_metadata_batch_HEADER

function db2_list_file_members_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_file_members_HEADER

function db2_list_file_members_batch_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_file_members_batch_HEADER

function db2_list_file_members_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_file_members_continue_HEADER

function db2_list_received_files_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_received_files_HEADER

function db2_list_received_files_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_received_files_continue_HEADER

function db2_list_received_files_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_received_files_HEADER

function db2_list_received_files_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_received_files_continue_HEADER

function db2_relinquish_file_membership_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_relinquish_file_membership_HEADER

function db2_remove_file_member_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_remove_file_member_HEADER

function db2_remove_file_member_2_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_remove_file_member_2_HEADER

function db2_unshare_file_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_unshare_file_HEADER

---------------------------------------------------------------

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
---------auth------------------------------------------------

function db2_token_revoke_URL
   return "https://api.dropboxapi.com/2/auth/token/revoke"
end db2_token_revoke_URL 

---------users------------------------------------------------

function db2_get_account_URL
   return "https://api.dropboxapi.com/2/users/get_account"
end db2_get_account_URL 

function db2_get_account_batch_URL
   return "https://api.dropboxapi.com/2/users/get_account_batch"
end db2_get_account_batch_URL 

function db2_get_current_account_URL
   return "https://api.dropboxapi.com/2/users/get_current_account"
end db2_get_current_account_URL 

function db2_get_space_usage_URL
   return "https://api.dropboxapi.com/2/users/get_space_usage"
end db2_get_space_usage_URL 

----------------------------------------------------------------
---------files------------------------------------------------

function db2_alpha_get_metadata_URL
   return "https://api.dropboxapi.com/2/files/alpha/get_metadata"
end db2_alpha_get_metadata_URL 

function db2_alpha_upload_URL
   return "https://content.dropboxapi.com/2/files/alpha/upload"
end db2_alpha_upload_URL 

function db2_copy_reference_get_URL
   return "https://api.dropboxapi.com/2/files/copy_reference/get"
end db2_copy_reference_get_URL 

function db2_copy_reference_save_URL
   return "https://api.dropboxapi.com/2/files/copy_reference/save"
end db2_copy_reference_save_URL 

function db2_get_temporary_link_URL
   return "https://api.dropboxapi.com/2/files/get_temporary_link"
end db2_get_temporary_link_URL 

function db2_properties_add_URL
   return "https://api.dropboxapi.com/2/files/properties/add"
end db2_properties_add_URL 

function db2_properties_overwrite_URL
   return "https://api.dropboxapi.com/2/files/properties/overwrite"
end db2_properties_overwrite_URL 

function db2_properties_remove_URL
   return "https://api.dropboxapi.com/2/files/properties/remove"
end db2_properties_remove_URL 

function db2_properties_template_add_URL
   return "https://api.dropboxapi.com/2/files/properties/template/add"
end db2_properties_template_add_URL 

function db2_properties_template_get_URL
   return "https://api.dropboxapi.com/2/files/properties/template/get"
end db2_properties_template_get_URL 

function db2_properties_template_list_URL
   return "https://api.dropboxapi.com/2/files/properties/template/list"
end db2_properties_template_list_URL 

function db2_properties_update_URL
   return "https://api.dropboxapi.com/2/files/properties/update"
end db2_properties_update_URL 

function db2_save_url_URL
   return "https://api.dropboxapi.com/2/files/save_url"
end db2_save_url_URL 

function db2_save_url_check_job_status_URL
   return "https://api.dropboxapi.com/2/files/save_url/check_job_status"
end db2_save_url_check_job_status_URL 

function db2_upload_session_append_v2_URL
   return "https://content.dropboxapi.com/2/files/upload_session/append_v2"
end db2_upload_session_append_v2_URL 

-----------------------------------------------------------------------------------

function db2_copy_URL
   return "https://api.dropboxapi.com/2/files/copy"
end db2_copy_URL 

function db2_create_folder_URL
   return "https://api.dropboxapi.com/2/files/create_folder"
end db2_create_folder_URL 

function db2_delete_URL
   return "https://api.dropboxapi.com/2/files/delete"
end db2_delete_URL 

function db2_download_URL
   return "https://content.dropboxapi.com/2/files/download"
end db2_download_URL 

function db2_get_metadata_URL
   return "https://api.dropboxapi.com/2/files/get_metadata"
end db2_get_metadata_URL 

function db2_get_preview_URL
   return "https://content.dropboxapi.com/2/files/get_preview"
end db2_get_preview_URL

function db2_get_thumbnail_URL
   return "https://content.dropboxapi.com/2/files/get_thumbnail"
end db2_get_thumbnail_URL

function db2_list_folder_URL
   return "https://api.dropboxapi.com/2/files/list_folder"
end db2_list_folder_URL 

function db2_list_folder_continue_URL
   return "https://api.dropboxapi.com/2/files/list_folder/continue"
end db2_list_folder_continue_URL 

function db2_list_folder_get_latest_cursor_URL
   return "https://api.dropboxapi.com/2/files/list_folder/get_latest_cursor"
end db2_list_folder_get_latest_cursor_URL 

function db2_list_folder_longpoll_URL
   --documented as https://notify.dropboxapi.com/2/files/list_folder/longpoll but it isn't working as of july 2016
   return "https://notify.dropboxapi.com/2-beta-2/files/list_folder/longpoll"
end db2_list_folder_longpoll_URL

function db2_list_revisions_URL
   return "https://api.dropboxapi.com/2/files/list_revisions"
end db2_list_revisions_URL

function db2_move_URL
   return "https://api.dropboxapi.com/2/files/move"
end db2_move_URL

function db2_permanently_delete_URL
   return "https://api.dropboxapi.com/2/files/permanently_delete"
end db2_permanently_delete_URL 

function db2_restore_URL
   return "https://api.dropboxapi.com/2/files/restore"
end db2_restore_URL 

function db2_search_URL
   return "https://api.dropboxapi.com/2/files/search"
end db2_search_URL 

function db2_upload_URL
   return "https://content.dropboxapi.com/2/files/upload"
end db2_upload_URL 

function db2_upload_session_append_URL
   return "https://content.dropboxapi.com/2/files/upload_session/append"
end db2_upload_session_append_URL 

function db2_upload_session_finish_URL
   return "https://content.dropboxapi.com/2/files/upload_session/finish"
end db2_upload_session_finish_URL 

function db2_upload_session_finish_batch_URL
   return "https://content.dropboxapi.com/2/files/upload_session/finish_batch"
end db2_upload_session_finish_batch_URL 

function db2_upload_session_finish_batch_check_URL
   return "https://content.dropboxapi.com/2/files/upload_session/finish_batch/check"
end db2_upload_session_finish_batch_check_URL 

function db2_upload_session_start_URL
   return "https://content.dropboxapi.com/2/files/upload_session/start"
end db2_upload_session_start_URL 

----------------------------------------------------------------
---------sharing---------------------------------------------

function db2_add_file_member_URL
   return "https://api.dropboxapi.com/2/sharing/add_file_member"
end db2_add_file_member_URL 

function db2_change_file_member_access_URL
   return "https://api.dropboxapi.com/2/sharing/change_file_member_access"
end db2_change_file_member_access_URL 

function db2_check_remove_member_job_status_URL
   return "https://api.dropboxapi.com/2/sharing/check_remove_member_job_status"
end db2_check_remove_member_job_status_URL 

function db2_get_file_metadata_URL
   return "https://api.dropboxapi.com/2/sharing/get_file_metadata"
end db2_get_file_metadata_URL 

function db2_get_file_metadata_batch_URL
   return "https://api.dropboxapi.com/2/sharing/get_file_metadata/batch"
end db2_get_file_metadata_batch_URL 

function db2_list_file_members_URL
   return "https://api.dropboxapi.com/2/sharing/list_file_members"
end db2_list_file_members_URL 

function db2_list_file_members_batch_URL
   return "https://api.dropboxapi.com/2/sharing/list_file_members/batch"
end db2_list_file_members_batch_URL 

function db2_list_file_members_continue_URL
   return "https://api.dropboxapi.com/2/sharing/list_file_members/continue"
end db2_list_file_members_continue_URL 

function db2_list_received_files_URL
   return "https://api.dropboxapi.com/2/sharing/list_received_files"
end db2_list_received_files_URL 

function db2_list_received_files_continue_URL
   return "https://api.dropboxapi.com/2/sharing/list_received_files/continue"
end db2_list_received_files_continue_URL 

function db2_relinquish_file_membership_URL
   return "https://api.dropboxapi.com/2/sharing/relinquish_file_membership"
end db2_relinquish_file_membership_URL 

function db2_remove_file_member_URL
   return "https://api.dropboxapi.com/2/sharing/remove_file_member"
end db2_remove_file_member_URL 

function db2_remove_file_member_2_URL
   return "https://api.dropboxapi.com/2/sharing/remove_file_member_2"
end db2_remove_file_member_2_URL 

function db2_unshare_file_URL
   return "https://api.dropboxapi.com/2/sharing/unshare_file"
end db2_unshare_file_URL 
-------------------------------------------------------------------------------
function db2_add_folder_member_URL
   return "https://api.dropboxapi.com/2/sharing/add_folder_member"
end db2_add_folder_member_URL 

function db2_check_job_status_URL
   return "https://api.dropboxapi.com/2/sharing/check_job_status"
end db2_check_job_status_URL

function db2_check_share_job_status_URL
   return "https://api.dropboxapi.com/2/sharing/check_share_job_status"
end db2_check_share_job_status_URL 

function db2_create_shared_link_URL
   return "https://api.dropboxapi.com/2/sharing/create_shared_link"
end db2_create_shared_link_URL 

function db2_create_shared_link_with_settings_URL
   return "https://api.dropboxapi.com/2/sharing/create_shared_link_with_settings"
end db2_create_shared_link_with_settings_URL 

function db2_get_folder_metadata_URL
   return "https://api.dropboxapi.com/2/sharing/get_folder_metadata"
end db2_get_folder_metadata_URL 

function db2_get_shared_link_file_URL
   return "https://content.dropboxapi.com/2/sharing/get_shared_link_file"
end db2_get_shared_link_file_URL 

function db2_get_shared_link_metadata_URL
   return "https://api.dropboxapi.com/2/sharing/get_shared_link_metadata"
end db2_get_shared_link_metadata_URL 

function db2_get_shared_links_URL
   return "https://api.dropboxapi.com/2/sharing/get_shared_links"
end db2_get_shared_links_URL 

function db2_list_folder_members_URL
   return "https://api.dropboxapi.com/2/sharing/list_folder_members"
end db2_list_folder_members_URL 

function db2_list_folder_members_continue_URL
   return "https://api.dropboxapi.com/2/sharing/list_folder_members/continue"
end db2_list_folder_members_continue_URL 

function db2_list_folders_URL
   return "https://api.dropboxapi.com/2/sharing/list_folders"
end db2_list_folders_URL 

function db2_list_folders_continue_URL
   return "https://api.dropboxapi.com/2/sharing/list_folders/continue"
end db2_list_folders_continue_URL 

function db2_list_mountable_folders_URL
   return "https://api.dropboxapi.com/2/sharing/list_mountable_folders"
end db2_list_mountable_folders_URL 

function db2_list_mountable_folders_continue_URL
   return "https://api.dropboxapi.com/2/sharing/list_mountable_folders/continue"
end db2_list_mountable_folders_continue_URL 

function db2_list_shared_links_URL
   return "https://api.dropboxapi.com/2/sharing/list_shared_links"
end db2_list_shared_links_URL 

function db2_modify_shared_link_settings_URL
   return "https://api.dropboxapi.com/2/sharing/modify_shared_link_settings"
end db2_modify_shared_link_settings_URL 

function db2_mount_folder_URL
   return "https://api.dropboxapi.com/2/sharing/mount_folder"
end db2_mount_folder_URL 

function db2_relinquish_folder_membership_URL
   return "https://api.dropboxapi.com/2/sharing/relinquish_folder_membership"
end db2_relinquish_folder_membership_URL 

function db2_remove_folder_member_URL
   return "https://api.dropboxapi.com/2/sharing/remove_folder_member"
end db2_remove_folder_member_URL 

function db2_revoke_shared_link_URL
   return "https://api.dropboxapi.com/2/sharing/revoke_shared_link"
end db2_revoke_shared_link_URL 

function db2_share_folder_URL
   return "https://api.dropboxapi.com/2/sharing/share_folder"
end db2_share_folder_URL 

function db2_transfer_folder_URL
   return "https://api.dropboxapi.com/2/sharing/transfer_folder"
end db2_transfer_folder_URL 

function db2_unmount_folder_URL
   return "https://api.dropboxapi.com/2/sharing/unmount_folder"
end db2_unmount_folder_URL 

function db2_unshare_folder_URL
   return "https://api.dropboxapi.com/2/sharing/unshare_folder"
end db2_unshare_folder_URL 

function db2_update_folder_member_URL
   return "https://api.dropboxapi.com/2/sharing/update_folder_member"
end db2_update_folder_member_URL 

function db2_update_folder_policy_URL
   return "https://api.dropboxapi.com/2/sharing/update_folder_policy"
end db2_update_folder_policy_URL 


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
------------individual Posts for all API---------------------------------------
------------------------------------------------------------------------------------------------------
----------auth-------------------------------------------------------------------------------

function db2_token_revoke_POST
   /*
   No parameters.
   */
   return ""
end db2_token_revoke_POST

----------user-------------------------------------------------------------------------------

function db2_get_account_POST pUserAccountID
   /*
   {"account_id":"pUserAccountID"}
   {"account_id:"dbid:________________"}
   */
   return fGetCB(fGetQ("account_id") & ": " &  fGetQ(pUserAccountID))
end db2_get_account_POST

function db2_get_current_account_POST
   /*
   No parameters. Null required; empty value fails.
   */
   return "null"
end db2_get_current_account_POST

function db2_get_space_usage_POST
   /*
   No parameters. Null required; empty value fails.
   */
   return "null"
end db2_get_space_usage_POST

function db2_get_account_batch_POST pUserAccountIDs
   /*
   pUserAccountIDs on separate lines
   {"account_ids":["dbid:________________","dbid:_____________________"]}
   */
   if pUserAccountIDs is empty then return fGetCB(fGetQ("account_ids") & ": " &  fGetSB())
   if the number of lines of pUserAccountIDs =  1 then
      return fGetCB(fGetQ("account_ids") & ": " &  fGetSB(fGetQ(pUserAccountIDs)))
   else
      put "{" & fGetQ("account_ids") & ": " &  "["  into tString
      repeat for each line rAccountID in pUserAccountIDs
         put fGetQ(rAccountID) & comma after tString
      end repeat
      if last char of tString is comma then delete last char of tString
      put "]}"  after tString
      return tString
   end if
end db2_get_account_batch_POST

---------files-------------------------------------------

function db2_alpha_get_metadata_POST pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,pIncludePropertyTemplates
   /*
   pIncludePropertyTemplates needs to be a list of templates one per line
   {"path": "/folder1/testfile1.txt","include_media_info": false,"include_deleted": false,"include_has_explicit_shared_members": false}
   {"path": "/folder1/testfile1.txt","include_media_info": false,"include_deleted": false,"include_has_explicit_shared_members": false,
   "include_property_templates": ["ptid:1a5n2i6d3OYEAAAAAAAAAYa","ptid:1a5n2i6d3OYEAAAAAAAAXXb"]
   */
   if pIncludeMediaInfo is empty then put "False" into pIncludeMediaInfo
   if pIncludeDeleted is empty then put "False" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "False" into pIncludeHasExplicitSharedMembers
   if pIncludePropertyTemplates is empty then
      return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("include_media_info") & ": " & pIncludeMediaInfo & \
            "," &fGetQ("include_deleted") & ": " & pIncludeDeleted & \
            "," &fGetQ("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers)
   else
      --"include_property_templates": ["ptid:1a5n2i6d3OYEAAAAAAAAAYa","ptid:1a5n2i6d3OYEAAAAAAAAXXb"]
      if the number of lines of pIncludePropertyTemplates =  1 then
         put fGetSB(fGetQ(pIncludePropertyTemplates)) into tTemplateListString
      else
         put "[" into tTemplateListString
         repeat for each line pTemplateID in pIncludePropertyTemplates
            put fGetQ(pTemplateID) & comma after tTemplateListString
         end repeat
         if last char of tString is comma then delete last char of tTemplateListString
         put "]"  after tTemplateListString
      end if
      --
      return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("include_media_info") & ": " & pIncludeMediaInfo & \
            "," &fGetQ("include_deleted") & ": " & pIncludeDeleted & \
            "," &fGetQ("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers& \
            "," &fGetQ("include_property_templates") & ": " & tTemplateListString)
   end if
end db2_alpha_get_metadata_POST

function db2_alpha_upload_POST pData
   /*
   data-binary @local_file.png
   */
   return pData
end db2_alpha_upload_POST

function db2_copy_reference_get_POST pPath
   /*
   {"path": "/folder1/testfile2.txt"}
   GetCopyReferenceArg
   #--path String The path to the file or folder you want to get a copy reference to.
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath))
end db2_copy_reference_get_POST

function db2_copy_reference_save_POST pCopyReference,pPath
   /*
   {"copy_reference": "z1X6ATl6aWtzOGq0c3g5Ng","path": "/folder1/testfile2.txt"}
   SaveCopyReferenceArg
   #--copy_reference String A copy reference returned by copy_reference/get.
   #--path String Path in the user's Dropbox that is the destination.
   */
    return fGetCB(fGetQ("copy_reference") & ": " &  fGetQ(pCopyReference) & "," &fGetQ("path") & ": " & fGetQ(pPath))
end db2_copy_reference_save_POST

function db2_get_temporary_link_POST pPath
   /*
   {"path": "/folder1/testfile2.txt"}
   GetTemporaryLinkArg
   #--path String The path to the file you want a temporary link to.
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath))
end db2_get_temporary_link_POST

function db2_properties_add_POST pPath,pTemplateIdFieldsArray
   /*   
   use pTemplateFieldsArray to store template_id, name, value  eg:
   {"path": "/folder1/testfile1.txt","property_groups": [
   {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "SecurityPolicy","value": "Confidential"},{"name": "Author","value": "A001"}]},
   {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAXXb","fields": [{"name": "Topic","value": "Science"},{"name": "SubTopic","value": "Biology"}]}
   ]}
   pTemplateIdFieldsArray[1][template_id]=   ptid:1a5n2i6d3OYEAAAAAAAAAYa
   pTemplateIdFieldsArray[1][fields][1][name]=  SecurityPolicy
   pTemplateIdFieldsArray[1][fields][1][value]= Confidential
   pTemplateIdFieldsArray[1][fields][2][name]=  Author
   pTemplateIdFieldsArray[1][fields][2][value]= A001
   pTemplateIdFieldsArray[2][template_id]=   ptid:1a5n2i6d3OYEAAAAAAAAXXb
   pTemplateIdFieldsArray[2][fields][1][name]=  Topic
   pTemplateIdFieldsArray[2][fields][1][value]= Science
   pTemplateIdFieldsArray[2][fields][2][name]=  SubTopic
   pTemplateIdFieldsArray[2][fields][2][value]= Biology
   */
   if pTemplateIdFieldsArray is empty then return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("property_groups") & ": " &  fGetSB())
   --
   --{"path": "/folder1/testfile1.txt","property_groups": []}
   put "{" & fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("property_groups") & ": [" into tString
   repeat for each key rTemplateKeyNum in pTemplateIdFieldsArray
      --  {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"}]},
      --pTemplateIdFieldsArray[1][template_id]= ptid:1a5n2i6d3OYEAAAAAAAAAYa
      put "{" & fGetQ("template_id") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["template_id"]) & "," & fGetQ("fields") & ": [" after tString
      repeat for each key rFieldNum in pTemplateIdFieldsArray[rTemplateKeyNum]["fields"]
         --pTemplateIdFieldsArray[1][fields][1][name]=   SecurityPolicy
         -- pTemplateIdFieldsArray[1][fields][1][value]= Confidential
         --{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"},
         put "{" & fGetQ("name") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["fields"][rFieldNum]["name"]) after tString
         put "," after tString
         put fGetQ("value") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["fields"][rFieldNum]["value"]) after tString
         put "}," after tString
      end repeat
      if last char of tString is comma then delete last char of tString  --delete trailing comma
      put "]}," after tString
   end repeat
   if last char of tString is comma then delete last char of tString  --delete trailing comma
   put "]}" after tString
   return tString
end db2_properties_add_POST

function db2_properties_overwrite_POST pPath,pTemplateIdFieldsArray
   /*   
   use pTemplateFieldsArray to store template_id, name, value  eg:
   {"path": "/folder1/testfile1.txt","property_groups": [
   {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"}]},
   {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAXXb","fields": [{"name": "Topic","value": "Science"},{"name": "SubTopic","value": "Biology"}]}
   ]}
   --
   PropertyGroupWithPath
   #--path String A unique identifier for the file.
   #--property_groups List of (PropertyGroup) Filled custom property templates associated with a file.
   PropertyGroup
   Collection of custom properties in filled property templates. This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--template_id String A unique identifier for a property template type.
   #--#--fields List of (PropertyField) This is a list of custom properties associated with a file. There can be up to 32 properties for a template.
   PropertyField
   This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--#--name String This is the name or key of a custom property in a property template. File property names can be up to 256 bytes.
   #--#--#--value String Value of a custom property attached to a file. Values can be up to 1024 bytes.
   */
   if pTemplateIdFieldsArray is empty then return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("property_groups") & ": " &  fGetSB())
   --
   --{"path": "/folder1/testfile1.txt","property_groups": []}
   put "{" & fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("property_groups") & ": [" into tString
   repeat for each key rTemplateKeyNum in pTemplateIdFieldsArray
      --  {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"}]},
      --pTemplateIdFieldsArray[1][template_id]= ptid:1a5n2i6d3OYEAAAAAAAAAYa
      put "{" & fGetQ("template_id") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["template_id"]) & "," & fGetQ("fields") & ": [" after tString
      repeat for each key rFieldNum in pTemplateIdFieldsArray[rTemplateKeyNum]["fields"]
         --pTemplateIdFieldsArray[1][fields][1][name]=   SecurityPolicy
         -- pTemplateIdFieldsArray[1][fields][1][value]= Confidential
         --{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"},
         put "{" & fGetQ("name") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["fields"][rFieldNum]["name"]) after tString
         put "," after tString
         put fGetQ("value") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["fields"][rFieldNum]["value"]) after tString
         put "}," after tString
      end repeat
      if last char of tString is comma then delete last char of tString  --delete trailing comma
      put "]}," after tString
   end repeat
   if last char of tString is comma then delete last char of tString  --delete trailing comma
   put "]}" after tString
   return tString
end db2_properties_overwrite_POST

function db2_properties_remove_POST pPath,pTemplateIDs
   /*
   {"path": "/folder1/testfile2.txt","property_template_ids": ["ptid:1a5n2i6d3OYEAAAAAAAAAYa"]}
   RemovePropertiesArg
   path String A unique identifier for the file.
   property_template_ids List of (String) A list of identifiers for a property template created by route properties/template/add.
   */
   if pTemplateIDs is empty then return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("property_template_ids") & ": " &  fGetSB())
   if the number of lines of pTemplateIDs =  1 then
      return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("property_template_ids") & ": " & fGetSB(fGetQ(pTemplateIDs)))
   else
      put "{" & fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("property_template_ids") & ": " & "[" into tString
      repeat for each line pTemplateID in pTemplateIDs
         put fGetQ(pTemplateID) & comma after tString
      end repeat
      if last char of tString is comma then delete last char of tString
      put "]}"  after tString
      return tString
   end if
end db2_properties_remove_POST

function db2_properties_template_add_POST pTemplateDescriptionArray
   /*
   {"name": "Security",
   "description": "These properties describe how confidential this file is.",
   "fields": [{"name": "Security Policy",
   "description": "This is the security policy of the file or folder described.\nPolicies can be Confidential, Public or Internal.",
   "type": {".tag": "string"}}]}
   AddPropertyTemplateArg
   #--name
   #--description
   #--fields
   #--#---name
   #--#---description
   #--#---type {".tag": "string"
   */
   --FIX array processing
   if pTemplateDescriptionArray is empty then return fGetCB(fGetQ("name") & ": " &  fGetQ() & "," & fGetQ("description") & ": " &  fGetQ() & "," &\
   fGetQ("fields") & ": " &  fGetSB())
   --
   --{"path": "/folder1/testfile1.txt","property_groups": []}
   put "{" & fGetQ("name") & ": " &  fGetQ(pTemplateDescriptionArray) & "," & fGetQ("description") & ": [" into tString
   repeat for each key rTemplateKeyNum in pTemplateDescriptionArray
      --  {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"}]},
      --pTemplateDescriptionArray[1][template_id]= ptid:1a5n2i6d3OYEAAAAAAAAAYa
      put "{" & fGetQ("template_id") & ": " & fGetQ(pTemplateDescriptionArray[rTemplateKeyNum]["template_id"]) & "," & fGetQ("fields") & ": [" after tString
      repeat for each key rFieldNum in pTemplateDescriptionArray[rTemplateKeyNum]["fields"]
         --pTemplateDescriptionArray[1][fields][1][name]=   SecurityPolicy
         -- pTemplateDescriptionArray[1][fields][1][value]= Confidential
         --{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"},
         put "{" & fGetQ("name") & ": " & fGetQ(pTemplateDescriptionArray[rTemplateKeyNum]["fields"][rFieldNum]["name"]) after tString
         put "," after tString
         put fGetQ("value") & ": " & fGetQ(pTemplateDescriptionArray[rTemplateKeyNum]["fields"][rFieldNum]["value"]) after tString
         put "}," after tString
      end repeat
      if last char of tString is comma then delete last char of tString  --delete trailing comma
      put "]}," after tString
   end repeat
   if last char of tString is comma then delete last char of tString  --delete trailing comma
   put "]}" after tString
   return tString
end db2_properties_template_add_POST

function db2_properties_template_get_POST pTemplateID
   /*
   {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa"}
   GetPropertyTemplateArg
   This datatype comes from an imported namespace originally defined in the properties namespace.
   #--template_id String An identifier for property template added by route properties/template/add.
   */
   return fGetCB(fGetQ("template_id") & ": " &  fGetQ(pTemplateID))
end db2_properties_template_get_POST

function db2_properties_template_list_POST
   /*
   No parameters. "null" seems to work
   */
   return "null"
end db2_properties_template_list_POST

function db2_properties_update_POST pPath,pTemplateIdFieldsArray
   /*
   {"path": "/folder1/testfile2.txt",
   "update_property_groups":[
   {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","add_or_update_fields": [{"name": "Security Policy","value": "Confidential"}],"remove_fields": []}
   ]}
   --
   UpdatePropertyGroupArg
   #--path String A unique identifier for the file.
   update_property_groups List of (PropertyGroupUpdate) Filled custom property templates associated with a file.
   PropertyGroupUpdate
   #--template_id String A unique identifier for a property template.
   add_or_update_fields List of (PropertyField)? List of property fields to update if the field already exists. If the field doesn't exist, add the field to the property group. 
   This field is optional.
   PropertyField
   This datatype comes from an imported namespace originally defined in the properties namespace.
   #--#--name String This is the name or key of a custom property in a property template. File property names can be up to 256 bytes.
   #--#--value String Value of a custom property attached to a file. Values can be up to 1024 bytes.
   remove_fields List of (String)? List of property field names to remove from property group if the field exists. 
   This field is optional.
   */
   --{"path": "/folder1/testfile1.txt","update_property_groups": []}
   if pTemplateIdFieldsArray is empty then return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("update_property_groups") & ": " &  fGetSB())
   -- {"path": "/folder1/testfile2.txt","update_property_groups":[
   put "{" & fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("update_property_groups") & ": [" into tString
   repeat for each key rTemplateKeyNum in pTemplateIdFieldsArray
      --  {"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa",
      put "{" & fGetQ("template_id") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["template_id"]) & "," after tString
      --"add_or_update_fields": [{"name": "Security Policy","value": "Confidential"}, ...],
      if pTemplateIdFieldsArray[rTemplateKeyNum]["add_or_update_fields"] is empty then
         put fGetQ("add_or_update_fields") & ": []," after tString
      else
         put fGetQ("add_or_update_fields") & ": [" after tString
         repeat for each key rFieldNum in pTemplateIdFieldsArray[rTemplateKeyNum]["add_or_update_fields"]
            --{"name": "Security Policy","value": "Confidential"},{"name": "Author","value": "A001"},
            put "{" & fGetQ("name") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["add_or_update_fields"][rFieldNum]["name"]) after tString
            put "," after tString
            put fGetQ("value") & ": " & fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["add_or_update_fields"][rFieldNum]["value"]) after tString
            put "}," after tString
         end repeat
         if last char of tString is comma then delete last char of tString  --delete trailing comma
         put "]," after tString
      end if
      --
      --"remove_fields": []}  --field names are comma delim in list
      if pTemplateIdFieldsArray[rTemplateKeyNum]["remove_fields"] is empty then
         put fGetQ("remove_fields") & ": []" after tString
      else
         put fGetQ("remove_fields") & ": [" after tString
         repeat for each key rFieldNum in pTemplateIdFieldsArray[rTemplateKeyNum]["remove_fields"]
             --["Security Policy","Author"],
            put fGetQ(pTemplateIdFieldsArray[rTemplateKeyNum]["remove_fields"][rFieldNum]["fieldname"]) after tString
            put "," after tString
         end repeat
         if last char of tString is comma then delete last char of tString  --delete trailing comma
         put "]}," after tString
      end if
   end repeat
   if last char of tString is comma then delete last char of tString  --delete trailing comma
   put "]}" after tString
   return tString
end db2_properties_update_POST

function db2_save_url_POST pPath,pUrl
   /*
   SaveUrlArg
   #--path String The path in Dropbox where the URL will be saved to.
   #--url String The URL to be saved.
   --
   {"path": "/folder3/testfile3.xls","url": "http://esctta.com.au/wp-content/uploads/B-grade-Winter-2016.xls"}
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("url") & ": " & fGetQ(pUrl))
end db2_save_url_POST

function db2_save_url_check_job_status_POST pAsyncJobId
   /*
   PollArg
   Arguments for methods that poll the status of an asynchronous job.
   This datatype comes from an imported namespace originally defined in the async namespace.
   #--async_job_id String Id of the asynchronous job. This is the value of a response returned from the method that launched the job.
   {"async_job_id": "562VTx1rtSMAAAAAAAABvQ"}
   */
   return fGetCB(fGetQ("async_job_id") & ": " &  fGetQ(pAsyncJobId))
end db2_save_url_check_job_status_POST

function db2_upload_session_append_v2_POST pData
   /*
   data-binary @local_file.png
   */
   return pData
end db2_upload_session_append_v2_POST

----------------------------------------------------------------

function db2_get_metadata_POST pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers
   /*
   {"path":"/apps/rctester/folder2/testfile2.txt",
   "include_media_info":false,
   "include_deleted": false,
   "include_has_explicit_shared_members": false}
   GetMetadataArg
   #--path String The path of a file or folder on Dropbox.
   #--include_media_info Boolean If true, FileMetadata.media_info is set for photo and video. 
   The default for this field is False.
   #--include_deleted Boolean If true, DeletedMetadata will be returned for deleted file or folder, 
   otherwise LookupError.not_found will be returned. 
   The default for this field is False.
   #--include_has_explicit_shared_members Boolean If true, the results will include a flag for each file
   indicating whether or not that file has any explicit members. 
   The default for this field is False.
   */
   if pIncludeMediaInfo is empty then put "False" into pIncludeMediaInfo
   if pIncludeDeleted is empty then put "False" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "False" into pIncludeHasExplicitSharedMembers
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("include_media_info") & ": " & pIncludeMediaInfo& "," &fGetQ("include_deleted") & ": " & pIncludeDeleted & "," &fGetQ("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers)
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
   return fGetCB(fGetQ("cursor") & ": " &  fGetQ(pCursor) & "," &fGetQ("timeout") & ": " & pTimeout)
end db2_list_folder_longpoll_POST

function db2_list_folder_POST pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers
   /*
   ListFolderArg
   #--path String The path to the folder you want to see the contents of.
   #--recursive Boolean If true, the list folder operation will be applied recursively to all subfolders and the response will contain contents of all subfolders. 
   The default for this field is False.
   #--include_media_info Boolean If true, FileMetadata.media_info is set for photo and video. 
   The default for this field is False.
   #--include_deleted Boolean If true, the results will include entries for files and folders that used to exist but were deleted. 
   The default for this field is False.
   #--include_has_explicit_shared_members Boolean If true, the results will include a flag for each file indicating whether or not that file has any explicit members. 
   The default for this field is False.
   {"path":"/Apps","recursive":true,"include_media_info":false}
   */
   if pRecursive is empty then put "False" into pRecursive
   if pIncludeMediaInfo is empty then put "False" into pIncludeMediaInfo
   if pIncludeDeleted is empty then put "False" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "False" into pIncludeHasExplicitSharedMembers
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("recursive") & ": " & pRecursive & "," & fGetQ("include_media_info") & ": " & pIncludeMediaInfo & "," & fGetQ("include_deleted") & ": " & pIncludeDeleted & "," & fGetQ("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers)
end db2_list_folder_POST

function db2_list_folder_continue_POST pCursor
   /*
   ListFolderContinueArg
   cursor String The cursor returned by your last call to list_folder or list_folder/continue.
   {"cursor":"1AAEb-y66nJOFj6oqkqCRg01Big_P2chM_2BQle73ZKEIiF6vhScKQQoTpilthdbcu1ML4gqGt6sCZTTYbxwESLhIbIMMxN3z-rElwaoH3v0Y-AYNV6oQm7n7MjkdfOrRm151PeJhHJMZN1Pw_NItgO8UvFnHhLBEsRTa8TGg4DaYtAIpj2pqFKX7w4X6RW7dnUs3BOJUYRsdaLF9Rem0JShPLT_DlRei9VYKDrPJzEliDg"}
   */
   return fGetCB(fGetQ("cursor") & ": " &  fGetQ(pCursor))
end db2_list_folder_continue_POST

function db2_list_folder_get_latest_cursor_POST pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers
   /*
   ListFolderArg
   #--path String The path to the folder you want to see the contents of.
   #--recursive Boolean If true, the list folder operation will be applied recursively to all subfolders and the response will contain contents of all subfolders. 
   The default for this field is False.
   #--include_media_info Boolean If true, FileMetadata.media_info is set for photo and video.  
   The default for this field is False.
   #--include_deleted Boolean If true, the results will include entries for files and folders that used to exist but were deleted.  
   The default for this field is False.
   #--include_has_explicit_shared_members Boolean If true, the results will include a flag for each file indicating whether or not that file has any explicit members.  
   The default for this field is False.
   {"path":"/Apps","recursive":true,"include_media_info":false}
   */
   if pRecursive is empty then put "False" into pRecursive
   if pIncludeMediaInfo is empty then put "False" into pIncludeMediaInfo
   if pIncludeDeleted is empty then put "False" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "False" into pIncludeHasExplicitSharedMembers
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," & fGetQ("recursive") & ": " & pRecursive & "," & fGetQ("include_media_info") & ": " & pIncludeMediaInfo & "," & fGetQ("include_deleted") & ": " & pIncludeDeleted & "," & fGetQ("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers)
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

function db2_upload_session_finish_batch_POST pData
   /*
   data-binary @local_file.png
   */
   return pData
end db2_upload_session_finish_batch_POST

function db2_upload_session_finish_batch_check_POST pData
   /*
   data-binary @local_file.png
   */
   return pData
end db2_upload_session_finish_batch_check_POST

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
   #--start UInt64 The starting index within the search results (used for paging).  
   The default for this field is 0.
   #--max_results UInt64 The maximum number of search results to return.  
   The default for this field is 100.
   #--mode SearchMode The search mode (filename, filename_and_content, or deleted_filename).
   {"path": "/apps/MyApp","query": "mytext","start": 0,"max_results": 100,"mode": "filename"}
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("query") & ": " & fGetQ(pQuery) & "," &fGetQ("start") & ": " & pStart & "," &fGetQ("max_results") & ": " & pMaxResults & "," &fGetQ("mode") & ": " & fGetQ(pMode))
end db2_search_POST

function db2_create_folder_POST pPath
   /*
   CreateFolderArg
   #--path String Path in the user's Dropbox to create.
   {"path": "/Apps/MyApp/new1/season7"}
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath))
end db2_create_folder_POST

function db2_delete_POST pPath
   /*
   DeleteArg
   #--path String Path in the user's Dropbox to delete.
   {"path": "/apps/MyApp/newFolder31"}
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath))
end db2_delete_POST

function db2_permanently_delete_POST pPath
   /*
   DeleteArg
   #--path String Path in the user's Dropbox to delete.
   {"path": "/apps/MyApp/testfile.txt"}
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath))
end db2_permanently_delete_POST

function db2_copy_POST pPathFrom,pPathTo
   /*
   RelocationArg
   #--from_path String Path in the user's Dropbox to be copied or moved.
   #--to_path String Path in the user's Dropbox that is the destination.
   {"from_path":"/folder1/testfile1.txt","to_path":"/folder1/testfile3.txt"}
   */
   return fGetCB(fGetQ("from_path") & ": " &  fGetQ(pPathFrom) & "," &fGetQ("to_path") & ": " & fGetQ(pPathTo))
end db2_copy_POST

function db2_move_POST pPathFrom,pPathTo
   /*
   RelocationArg
   #--from_path String Path in the user's Dropbox to be copied or moved.
   #--to_path String Path in the user's Dropbox that is the destination.
   {"from_path":"/apps/MyApp/seasons.txt","to_path":"/apps/MyApp/New2/seasons.txt"}
   */
   return fGetCB(fGetQ("from_path") & ": " &  fGetQ(pPathFrom) & "," &fGetQ("to_path") & ": " & fGetQ(pPathTo))
end db2_move_POST

function db2_get_thumbnail_POST
   /*
   No parameters. Parameters in header instead. Must be empty POST
   */
   return ""
end db2_get_thumbnail_POST

function db2_get_preview_POST
   /*
   No parameters. Parameters in header instead. Must be empty POST
   */
   return ""
end db2_get_preview_POST

function db2_list_revisions_POST pPath,pLimit
   /*
   ListRevisionsArg
   #--path String The path to the file you want to see the revisions of.
   #--limit UInt64 The maximum number of revision entries returned.  
   The default for this field is 10.
   {"path":"/apps/MyApp/seasons.docx","limit": 10}
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("limit") & ": " & pLimit)
end db2_list_revisions_POST

function db2_restore_POST pPath,pRevision
   /*
   RestoreArg
   #--path String The path to the file you want to restore.
   #--rev String(min_length=9, pattern="[0-9a-f]+")? The revision to restore for the file.
   {"path":"/apps/MyApp/seasons.docx","rev":"403e457377"}
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("rev") & ": " & fGetQ(pRevision))
end db2_restore_POST

----------------------------------------------------------------
----------------------------------------------------------------
---------sharing-----------------------------------------

function db2_add_file_member_POST pFile,pMembersArray,pMessage,pQuiet,pAccessLevel,pAddMessageAsComment
   /*
   {"file": "/MySharedFolder1/sharedfolder1/testfile1.txt",
   "members": [{".tag": "email","email": "me@myip"}],
   "custom_message": "This is a custom message about this file.",
   "quiet": false,
   "access_level": "viewer",
   "add_message_as_comment": false}
   */
   if pQuiet is empty then put "False" into pQuiet
   if pAccessLevel is empty then put "viewer" into pAccessLevel
   if pAddMessageAsComment is empty then put "False" into pAddMessageAsComment
   --
   put "["  into tString
   put fGetQ("file") & ": " &  fGetQ(pFile) & "," after tString
   put fGetQ("members") & ": [" after tString
   repeat for each key rKey in pMembersArray
      if pMembersArray[rKey]["email"] is not empty then 
         put "{" & fGetQ(".tag") & ": " & fGetQ("email") & "," & fGetQ("email") & ": " & fGetQ(pMembersArray[rKey]["email"]) & "},"after tString
      else
         if pMembersArray[rKey]["id"] is not empty then 
            put "{" & fGetQ(".tag") & ": " & fGetQ("id") & "," & fGetQ("id") & ": " & fGetQ(pMembersArray[rKey]["id"]) & "}," after tString
         end if
      end if
   end repeat
   if last char of tString is comma then delete last char of tString
   put "],"  after tString
   if pMessage is not empty then put fGetQ("custom_message") & ": " &  fGetQ(pMessage) & "," after tString
   put fGetQ("quiet") & ": " & pQuiet & "," after tString
   put fGetQ("access_level") & ": " &  fGetQ(pAccessLevel) & "," after tString
   put fGetQ("add_message_as_comment") & ": " &  pAddMessageAsComment after tString
   put "}"  after tString
   --
   return tString
end db2_add_file_member_POST

function db2_change_file_member_access_POST pFile,pMemberArray,pAccessLevel
   /*
   {"file": "/MySharedFolder1/sharedfolder1/testfile1.txt",
   "member": {".tag": "email","email": "me@myip"},
   "access_level": "viewer"}
   */
   if pAccessLevel is empty then put "viewer" into pAccessLevel
   --
   put "["  into tString
   put fGetQ("file") & ": " &  fGetQ(pFile) & "," after tString
   put fGetQ("member") & ": " after tString
   if pMembersArray[rKey]["email"] is not empty then 
      put "{" & fGetQ(".tag") & ": " & fGetQ("email") & "," & fGetQ("email") & ": " & fGetQ(pMembersArray[rKey]["email"]) & "},"after tString
   else
      if pMembersArray[rKey]["id"] is not empty then 
         put "{" & fGetQ(".tag") & ": " & fGetQ("id") & "," & fGetQ("id") & ": " & fGetQ(pMembersArray[rKey]["id"]) & "}," after tString
      end if
   end if
   put fGetQ("access_level") & ": " &  fGetQ(pAccessLevel) & "}" after tString
   --
   return tString
end db2_change_file_member_access_POST

function db2_check_remove_member_job_status_POST
     /*
   No parameters.
   */
   return "null"
   --return ""
end db2_check_remove_member_job_status_POST

function db2_get_file_metadata_POST
     /*
   No parameters.
   */
   return "null"
   --return ""
end db2_get_file_metadata_POST

function db2_get_file_metadata_batch_POST
   /*
   No parameters.
   */
   return "null"
   --return ""
end db2_get_file_metadata_batch_POST

function db2_list_file_members_POST pFile,pActions,pIncludeInherited,pLimit
   /*
   pActions = list of ["leave_a_copy","make_editor","make_owner","make_viewer","make_viewer_no_comment","remove"]
   {
   "file": "id:3kmLmQFnf1AAAAAAAAAAAw",
   "include_inherited": true,
   "limit": 100
   }
   */
   if pIncludeInherited is empty then put "False" into pIncludeMediaInfo
   if pLimit is empty then put "False" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "False" into pIncludeHasExplicitSharedMembers
   --if pIncludePropertyTemplates is empty then put "False" into pIncludePropertyTemplates
   --
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("include_media_info") & ": " & pIncludeMediaInfo & \
         "," &fGetQ("include_deleted") & ": " & pIncludeDeleted & \
         "," &fGetQ("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers)
   --& "," &fGetQ("include_property_templates") & ": " & pIncludePropertyTemplates)
   
   
   return "null"
   --return ""
end db2_list_file_members_POST

function db2_list_file_members_batch_POST pFile,pIncludeInherited,pLimit
   /*
   {
   "file": "id:3kmLmQFnf1AAAAAAAAAAAw",
   "include_inherited": true,
   "limit": 100
   }
   */
   return "null"
   --return ""
end db2_list_file_members_batch_POST

function db2_list_file_members_continue_POST
     /*
   No parameters.
   */
   return "null"
   --return ""
end db2_list_file_members_continue_POST

function db2_list_received_files_POST
     /*
   No parameters.
   */
   return "null"
   --return ""
end db2_list_received_files_POST

function db2_list_received_files_continue_POST
     /*
   No parameters.
   */
   return "null"
   --return ""
end db2_list_received_files_continue_POST

function db2_relinquish_file_membership_POST
     /*
   No parameters.
   */
   return "null"
   --return ""
end db2_relinquish_file_membership_POST

function db2_remove_file_member_POST
     /*
   No parameters.
   */
   return "null"
   --return ""
end db2_remove_file_member_POST

function db2_remove_file_member_2_POST
     /*
   No parameters.
   */
   return "null"
   --return ""
end db2_remove_file_member_2_POST

function db2_unshare_file_POST
     /*
   No parameters.
   */
   return "null"
   --return ""
end db2_unshare_file_POST

--------------------------------------------------------------------------------------

function db2_add_folder_member_POST pSharedFolderId,pMembersArray,pQuiet,pCustomMessage
   /*
   {"shared_folder_id":"1172266522","members": [{"member":{".tag":"email","email": "me@myip"},"access_level": {".tag":"editor"} }]}
   AddFolderMemberArg
   #--shared_folder_id String The ID for the shared folder.
   #--members List of (AddMember) The intended list of members to add. Added members will receive invites to join the shared folder.
   AddMember
   The member and type of access the member should have when added to a shared folder.
   #--#--member MemberSelector The member to add to the shared folder.
   MemberSelector (open union)
   Includes different ways to identify a member to add to a shared folder.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--dropbox_id String Dropbox account, team member, or group ID of member to add.
   #--#--#--email String E-mail address of member to add.
   #--#--access_level AccessLevel The access level to grant member to the shared folder. AccessLevel. owner is disallowed.
   AccessLevel (open union)
   Defines the access levels for collaborators.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--#--viewer Void The collaborator can only view the shared folder.
   #--quiet Boolean Whether added members should be notified via email and device notifications of their invite.  
   The default for this field is False.
   #--custom_message String? Optional message to display to added members in their invitation. 
   This field is optional.
   */
   if pQuiet is empty then put "False" into pQuiet
   if pCustomMessage is empty then put "" into pCustomMessage
   return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId) & "," &fGetQ("members") & ": " & db2_FormatAddFolderMembers(pMembers) & "," &fGetQ("quiet") & ": " & pQuiet & "," &fGetQ("custom_message") & ": " & fGetQ(pCustomMessage))
end db2_add_folder_member_POST

function db2_FormatAddFolderMembers pMembers
   -- pMembers is an array  pMembers[1][email] or [1][dropbox_id], [1][accesslevel]
   /*"members": 
   [
   { "member": {".tag": "email","email": "justin@example.com"},"access_level": {".tag": "editor"}},
   {"member": {".tag": "dropbox_id","dropbox_id": "dbid:AAEufNrMPSPe0dMQijRP0N_aZtBJRm26W4Q"},"access_level": {".tag": "editor"}}
   ]
   -- [{"member":{".tag":"email","email": "me@myip"},"access_level": {".tag":"editor"} }]
   */
   if pMembers is empty then return "[]" 
   put "["  into tString
   repeat for each key rKey in pMembers
      if pMember[rKey]["email"] is not empty then 
         put fGetQ("member") & ":" after tString
         put fGetCB(fGetQ(".tag") & ": " & fGetQ("email") & "," & fGetQ("email") & ": " & fGetQ(pMember[rKey]["email"])) after tString
         put "," & fGetQ("access_level") & ": " & fGetCB(fGetQ(".tag") & ": " & fGetQ(pMember[rKey]["accesslevel"])) after tString
      else
         if pMember[rKey]["dropbox_id"] is not empty then 
            put fGetQ("member") & ":" after tString
            put fGetCB(fGetQ(".tag") & ": " & fGetQ("dropbox_id") & "," & fGetQ("dropbox_id") & ": " & fGetQ(pMember[rKey]["dropbox_id"])) after tString
            put "," & fGetQ("access_level") & ": " & fGetCB(fGetQ(".tag") & ": " & fGetQ(pMember[rKey]["accesslevel"])) after tString
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
   return fGetCB(fGetQ("async_job_id") & ": " &  fGetQ(pAsyncJobId))
end db2_check_job_status_POST

function db2_check_share_job_status_POST pAsyncJobId
   /*
   PollArg
   Arguments for methods that poll the status of an asynchronous job.
   #--async_job_id String Id of the asynchronous job. This is the value of a response returned from the method
   that launched the job. 
   pAsyncJobId from remove_folder_member, share_folder, unshare_folder
   */
   return fGetCB(fGetQ("async_job_id") & ": " &  fGetQ(pAsyncJobId))
end db2_check_share_job_status_POST

function db2_create_shared_link_POST pPath,pShortUrl,pPendingUpload
   /*
   CreateSharedLinkArg
   #--path String The path to share.
   #--short_url Boolean Whether to return a shortened URL.  
   The default for this field is False.
   #--pending_upload PendingUploadMode? If it's okay to share a path that does not yet exist, 
   set this to either 'file' or 'folder' to indicate whether to assume it's a file or folder. 
   This field is optional.
   PendingUploadMode (union)
   Flag to indicate pending upload default (for linking to not-yet-existing paths).The value will be one of the following datatypes:
   #--#--file Void Assume pending uploads are files.
   #--#--folder Void Assume pending uploads are folders.
   {"path":"/apps/MyApp/seasons.txt","short_url":false,"pending_upload":"file"}
   */
   if pShortUrl is empty then put "false" into pShortUrl
   if pPendingUpload is empty then put "file" into pPendingUpload
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("short_url") & ": " & pShortUrl & "," &fGetQ("pending_upload") & ": " & fGetQ(pPendingUpload))
end db2_create_shared_link_POST

function db2_create_shared_link_with_settings_POST pPath,pSettings
   /*
   CreateSharedLinkArg
   #--path String The path to be shared by the shared link 
   #--settings SharedLinkSettings? The requested settings for the newly created shared link 
   This field is optional.
   SharedLinkSettings
   #--#--requested_visibility RequestedVisibility? The requested access for this shared link. 
   This field is optional.
   RequestedVisibility (union)
   The access permission that can be requested by the caller for the shared link. 
   Note that the final resolved visibility of the shared link takes into account other aspects, such as team and shared folder settings. 
   Check the ResolvedVisibility for more info on the possible resolved visibility values of shared links. 
   The value will be one of the following datatypes:
   #--#--#--public Void Anyone who has received the link can access it. No login required.
   #--#--#--team_only Void Only members of the same team can access the link. Login is required.
   #--#--#--password Void A link-specific password is required to access the link. Login is not required.
   #--#--link_password String? If requested_visibility is RequestedVisibility.password this is needed to specify the password to access the link. 
   This field is optional.
   #--#--expires Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time of the shared link. By default the link won't expire. 
   This field is optional.
   {"path":"/apps/MyApp/seasons.txt"," "settings": {"requested_visibility": "public"}}
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath) & "," &fGetQ("settings") & ": " & pSettings)
end db2_create_shared_link_with_settings_POST

function db2_get_folder_metadata_POST pSharedFolderId,pActions
   /*
   GetMetadataArgs
   shared_folder_id String The ID for the shared folder.
   actions List of (FolderAction)? Folder actions to query. 
   This field is optional.
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
      return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId) & "," &fGetQ("actions") & ": " & fGetSB(pActions))
   else
      return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId))
   end if
end db2_get_folder_metadata_POST

function db2_get_shared_link_file_POST pPath
   /*
   No parameters. Parameters in header instead.
   */
   return "null"
   --return ""
end db2_get_shared_link_file_POST

function db2_get_shared_link_metadata_POST pUrl,pPath,pLinkPassword
   /*
   GetSharedLinkMetadataArg
   #--url String URL of the shared link.
   #--path String? If the shared link is to a folder, this parameter can be used to retrieve the metadata for a specific file or sub-folder in this folder. A relative path should be used. 
   This field is optional.
   #--link_password String? If the shared link has a password, this parameter can be used. 
   This field is optional.
   */
   if pPath is not empty then
      if pLinkPassword is not empty then
         return fGetCB(fGetQ("url") & ": " &  fGetQ(pUrl) & "," &fGetQ("path") & ": " & fGetQ(pPath) & "," &fGetQ("link_password") & ": " & fGetQ(pLinkPassword))
      else
         return fGetCB(fGetQ("url") & ": " &  fGetQ(pUrl) & "," &fGetQ("path") & ": " & fGetQ(pPath))
      end if
   else
      return fGetCB(fGetQ("url") & ": " &  fGetQ(pUrl))
   end if
end db2_get_shared_link_metadata_POST

function db2_get_shared_links_POST pPath
   /*
   GetSharedLinksArg
   #--path String? See get_shared_links description. 
   {"path": "/Apps/MyApp"}
   {"path": ""}
   */
   return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath))
end db2_get_shared_links_POST

function db2_list_folder_members_POST pSharedFolderId,pActions,pLimit
   /*
   ListFolderMembersArgs
   #--shared_folder_id String The ID for the shared folder.
   #--actions List of (MemberAction)? Member actions to query. 
   This field is optional.
   MemberAction (open union)
   Actions that may be taken on members of a shared folder. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--make_editor Void Make the member an editor of the folder.
   #--#--make_owner Void Make the member an owner of the folder.
   #--#--make_viewer Void Make the member a viewer of the folder.
   #--#--remove Void Remove the member from the folder.
   #--limit UInt32 The maximum number of results that include members, groups and invitees to return per request.  
   The default for this field is 1000.
   --
   { "shared_folder_id": "84528192421","actions": [], "limit": 1000}
   */
   if pActions is empty then put "[]" into pActions
   if pLimit is empty then put "1000" into pLimit
   return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId) & "," & fGetQ("actions") & ": " & fGetSB(pActions)& "," & fGetQ("limit") & ": " &  fGetQ(pLimit) )
end db2_list_folder_members_POST

function db2_list_folder_members_continue_POST pCursor
   /*
   ListFolderMembersContinueArg
   #--cursor String The cursor returned by your last call to list_folder_members or list_folder_members/continue.
   */
   return fGetCB(fGetQ("cursor") & ": " &  fGetQ(pCursor))
end db2_list_folder_members_continue_POST

function db2_list_folders_POST pLimit,pActions
   /*
   pActions = any part of list: "change_options","edit_contents","invite_editor","invite_viewer","invite_viewer_no_comment","relinquish_membership","unmount","unshare","leave_a_copy","share_link"
   #--limit UInt32 The maximum number of results to return per request. The default for this field is 1000.
   #--actions List of (FolderAction)? This is a list indicating whether each returned folder data entry will include a boolean field FolderPermission.allow that describes whether the current user can perform the `FolderAction` on the folder. This field is optional.
   FolderAction (open union)
   Actions that may be taken on shared folders. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--change_options Void Change folder options, such as who can be invited to join the folder.
   #--#--edit_contents Void Change or edit contents of the folder.
   #--#--invite_editor Void Invite a user or group to join the folder with read and write permission.
   #--#--invite_viewer Void Invite a user or group to join the folder with read permission.
   #--#--invite_viewer_no_comment Void Invite a user or group to join the folder with read permission but no comment permissions.
   #--#--relinquish_membership Void Relinquish one's own membership in the folder.
   #--#--unmount Void Unmount the folder.
   #--#--unshare Void Stop sharing this folder.
   #--#--leave_a_copy Void Keep a copy of the contents upon leaving or being kicked from the folder.
   #--#--share_link Void Create a shared link for folder.
   {"limit": 100, "actions": []}
   */
   if pLimit is empty then put "1000" into pLimit
   if pActions then
      return fGetCB(fGetQ("limit") & ": " &  pLimit)
   else
      return fGetCB(fGetQ("limit") & ": " &  pLimit & "," & fGetQ("actions") & ": " & fGetSB(fGetQItems(pActions)))
   end if
end db2_list_folders_POST

function db2_list_folders_continue_POST pCursor
   /*
   ListFoldersContinueArg
   cursor String The cursor returned by your last call to list_folder_members or list_folder_members/continue.
   */
   return fGetCB(fGetQ("cursor") & ": " &  fGetQ(pCursor))
end db2_list_folders_continue_POST

function db2_list_mountable_folders_POST pLimit,pActions
   /*
   ListFoldersArgs
   limit UInt32 The maximum number of results to return per request.  
   The default for this field is 1000.
   actions List of (FolderAction)? Folder actions to query. 
   This field is optional.
   FolderAction (open union) 
   */
   if pLimit is empty then put "1000" into pLimit
   if pActions is empty then put "[]" into pActions
   return fGetCB(fGetQ("limit") & ": " &  fGetQ(pLimit) & "," & fGetQ("actions") & ": " & fGetSB(pActions))
end db2_list_mountable_folders_POST

function db2_list_mountable_folders_continue_POST pCursor
   /*
   ListFoldersContinueArg
   cursor String The cursor returned by the previous API call specified in the endpoint description.
   Apps must have full Dropbox access to use this endpoint. 
   {"cursor": "ZtkX9_EHj3x7PMkVuFIhwKYXEpwpLwyxp9vMKomUhllil9q7eWiAu"}
   */
   return fGetCB(fGetQ("cursor") & ": " &  fGetQ(pCursor))
end db2_list_mountable_folders_continue_POST

function db2_list_shared_links_POST pPath,pDirectOnly,pCursor
   /*
   ListSharedLinksArg
   path String? See list_shared_links description. 
   This field is optional.
   cursor String? The cursor returned by your last call to list_shared_links. 
   This field is optional.
   direct_only Boolean? See list_shared_links description. 
   This field is optional.
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
         return fGetCB(fGetQ("cursor") & ": " &  fGetQ(pCursor)) & " OR " & fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," &fGetQ("direct_only") & ": " & fGetQ(pDirectOnly))
      else
         return fGetCB(fGetQ("cursor") & ": " &  fGetQ(pCursor))
      end if
   else
      if pDirectOnly is not empty then
         return fGetCB(fGetQ("path") & ": " & fGetQ(pPath) & "," &fGetQ("direct_only") & ": " & fGetQ(pDirectOnly))
      else
         return fGetCB(fGetQ("path") & ": " &  fGetQ(pPath))
      end if
   end if
end db2_list_shared_links_POST

function db2_modify_shared_link_settings_POST pUrl,pRequestedVisibility,pLinkPassword,pExpires
   /*
   ModifySharedLinkSettingsArgs
   #--url String URL of the shared link to change its settings
   #--settings SharedLinkSettings Set of settings for the shared link.
   SharedLinkSettings
   #--#--requested_visibility RequestedVisibility? The requested access for this shared link. 
   This field is optional.
   RequestedVisibility (union)
   The access permission that can be requested by the caller for the shared link. Note that the final resolved visibility of the shared link takes into account other aspects, such as team and shared folder settings. Check the ResolvedVisibility for more info on the possible resolved visibility values of shared links. The value will be one of the following datatypes:
   #--#--#--public Void Anyone who has received the link can access it. No login required.
   #--#--#--team_only Void Only members of the same team can access the link. Login is required.
   #--#--#--password Void A link-specific password is required to access the link. Login is not required.
   #--#--link_password String? If requested_visibility is RequestedVisibility.password this is needed to specify the password to access the link. 
   This field is optional.
   #--#--expires Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time of the shared link. By default the link won't expire. 
   This field is optional.
   */
   put fGetQ("url") & ": " &  fGetQ(pUrl) into tPost
   put "," &fGetQ("settings") & "{" after tPost
   if pRequestedVisibility is not empty then
      put fGetQ("requested_visibility") & ": " & fGetQ(pRequestedVisibility) after tPost
   else
      --default
      put fGetQ("requested_visibility") & ": " & fGetQ("public") after tPost
   end if
   if pLinkPassword is not empty then
      put "," &fGetQ("link_password") & ": " & fGetQ(pLinkPassword) after tPost
   end if
   if pExpires is not empty then
      put "," &fGetQ("expires") & ": " & fGetQ(pExpires) after tPost
   end if
   put  "}" after tPost
   return fGetCB(tPost)
end db2_modify_shared_link_settings_POST

function db2_mount_folder_POST pSharedFolderId
   /*
   MountFolderArg
   #--shared_folder_id String The ID of the shared folder to mount.
   */
   return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId))
end db2_mount_folder_POST

function db2_relinquish_folder_membership_POST pSharedFolderId
   /*
   RelinquishFolderMembershipArg
   #--shared_folder_id String The ID for the shared folder.
   */
   return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId))
end db2_relinquish_folder_membership_POST

function db2_remove_folder_member_POST pSharedFolderId,pMember,pLeaveACopy
   /*
   RemoveFolderMemberArg
   #--shared_folder_id String The ID for the shared folder.
   #--member MemberSelector The member to remove from the folder. Only the MemberSelector.dropbox_id may be set at this time.
   MemberSelector (open union)
   Includes different ways to identify a member to add to a shared folder.The value will be one of the following datatypes. 
   New values may be introduced as our API evolves.
   #--#--dropbox_id String Dropbox account, team member, or group ID of member to add.
   #--#--email String E-mail address of member to add.
   #--leave_a_copy Boolean If true, the removed user will keep their copy of the folder after it's unshared, assuming it was mounted. 
   Otherwise, it will be removed from their Dropbox. Also, this must be set to false when kicking a group.
   */
   return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId) & "," &fGetQ("member") & ": " & fGetQ(pMember) & "," &fGetQ("leave_a_copy") & ": " & pLeaveACopy)
end db2_remove_folder_member_POST

function db2_revoke_shared_link_POST pURL
   /*
   RevokeSharedLinkArg
   #--url String URL of the shared link.
   --needs to be full url not short url
   {"url":"https://www.dropbox.com/s/xm2rco8624tno9g/seasons.txt?dl=0"}
   */
   return fGetCB(fGetQ("url") & ": " &  fGetQ(pURL))
end db2_revoke_shared_link_POST

function db2_share_folder_POST pPath,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy,pForceAsync
   /*
   ShareFolderArg
   #--path String The path to the folder to share. If it does not exist, then a new one is created.
   #--member_policy MemberPolicy Who can be a member of this shared folder. Only applicable if the current user is on a team. 
   The default for this union is anyone.
   MemberPolicy (open union)
   Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team.The value will be one of the following datatypes. 
   New values may be introduced as our API evolves.
   #--#--team Void Only a teammate can become a member.
   #--#--anyone Void Anyone can become a member.
   #--acl_update_policy AclUpdatePolicy Who can add and remove members of this shared folder.
   The default for this union is owner.
   AclUpdatePolicy (open union)
   Policy governing who can change a shared folder's access control list (ACL). In other words, who can add, remove, or change the privileges of members.
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--owner Void Only the owner can update the ACL.
   #--#--editors Void Any editor can update the ACL. This may be further restricted to editors on the same team.
   #--shared_link_policy SharedLinkPolicy The policy to apply to shared links created for content inside this shared folder.
   The default for this union is anyone.
   SharedLinkPolicy (open union)
   Policy governing who can view shared links.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--anyone Void Links can be shared with anyone.
   #--#--members Void Links can only be shared among members of the shared folder.
   #--force_async Boolean Whether to force the share to happen asynchronously.  
   The default for this field is False.
   */
   put fGetQ("path") & ": " &  fGetQ(pPath) into tPost
   if pMemberPolicy is not empty then
      put "," &fGetQ("member_policy") & ": " & fGetQ(pMemberPolicy) after tPost
   else
      --default
      put "," &fGetQ("member_policy") & ": " & fGetQ("anyone") after tPost
   end if
   if pAclUpdatePolicy is not empty then
      put "," &fGetQ("acl_update_policy") & ": " & fGetQ(pAclUpdatePolicy) after tPost
   else
      --default
      put "," &fGetQ("acl_update_policy") & ": " & fGetQ("owner") after tPost
   end if
   if pSharedLinkPolicy is not empty then
      put "," &fGetQ("shared_link_policy") & ": " & fGetQ(pSharedLinkPolicy) after tPost
   else
      --default
      put "," &fGetQ("shared_link_policy") & ": " & fGetQ("anyone") after tPost
   end if
   if pForceAsync is not empty then
      put "," &fGetQ("force_async") & ": " & fGetQ(pForceAsync) after tPost
   else
      --default false
      put "," &fGetQ("shared_link_policy") & ": " & "false" after tPost
   end if
   return fGetCB(tPost)
end db2_share_folder_POST

function db2_transfer_folder_POST pSharedFolderId,pToDropboxId
   /*
   TransferFolderArg
   #--shared_folder_id String The ID for the shared folder.
   #--to_dropbox_id String A account or team member ID to transfer ownership to.
   */
   return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId) & "," &fGetQ("to_dropbox_id") & ": " & fGetQ(pToDropboxId))
end db2_transfer_folder_POST

function db2_unmount_folder_POST pSharedFolderId
   /*
   UnmountFolderArg
   #--shared_folder_id String The ID for the shared folder.
   */
   return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId))
end db2_unmount_folder_POST

function db2_unshare_folder_POST pSharedFolderId,pLeaveACopy
   /*
   UnshareFolderArg
   #--shared_folder_id String The ID for the shared folder.
   #--leave_a_copy Boolean If true, members of this shared folder will get a copy of this folder after it's unshared. 
   Otherwise, it will be removed from their Dropbox. The current user, who is an owner, will always retain their copy.
   */
   if pLeaveACopy is empty then put "false" into pLeaveACopy
   return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId) & "," &fGetQ("leave_a_copy") & ": " & pLeaveACopy)
end db2_unshare_folder_POST

function db2_update_folder_member_POST pSharedFolderId,pMember,pAccessLevel
   /*
   UpdateFolderMemberArg
   #--shared_folder_id String The ID for the shared folder.
   #--member MemberSelector The member of the shared folder to update. Only the MemberSelector.dropbox_id may be set at this time.
   MemberSelector (open union)
   Includes different ways to identify a member to add to a shared folder.The value will be one of the following datatypes. 
   New values may be introduced as our API evolves.
   #--#--dropbox_id String Dropbox account, team member, or group ID of member to add.
   #--#--email String E-mail address of member to add.
   #--access_level AccessLevel The new access level for member. AccessLevel.owner is disallowed.
   AccessLevel (open union)
   Defines the access levels for collaborators.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--owner Void The collaborator is the owner of the shared folder. Owners can view and edit the shared folder as well as set the folder's policies using update_folder_policy.
   #--#--editor Void The collaborator can both view and edit the shared folder.
   #--#--viewer Void The collaborator can only view the shared folder.
   */
   return fGetCB(fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId) & "," &fGetQ("member") & ": " & db2_FormatUpdateFolderMember(pMember) & "," &fGetQ("access_level") & ": " & fGetQ(pAccessLevel))
end db2_update_folder_member_POST

function db2_FormatUpdateFolderMember pMember
   -- pMember is an array  pMember["email"] or pMember["dropbox_id"]
   /*
   --{".tag":"email","email":"myemailaddress"}
   --{".tag": "dropbox_id","dropbox_id": "dbid:mydropboxid"}
   */
   if pMember["email"] is not empty then 
      return fGetCB(fGetQ(".tag") & ": " & fGetQ("email") & "," & fGetQ("email") & ": " & fGetQ(pMember["email"]))
   end if
   if pMember["dropbox_id"] is not empty then 
      return fGetCB(fGetQ(".tag") & ": " & fGetQ("dropbox_id") & "," & fGetQ("dropbox_id") & ": " & fGetQ(pMember["dropbox_id"]))
   end if
   return pMember  --this is useful for syntax display and also allows preformatted json to be passed eg. {".tag":"email","email":"myemailaddress"}
end db2_FormatUpdateFolderMember

function db2_update_folder_policy_POST pSharedFolderId,pMemberPolicy,pAclUpdatePolicy,pSharedLinkPolicy
   /*
   UpdateFolderPolicyArg
   If any of the policy's are unset, then they retain their current setting.
   #--shared_folder_id String The ID for the shared folder.
   #--member_policy MemberPolicy? Who can be a member of this shared folder. Only set this if the current user is on a team. 
   This field is optional.
   MemberPolicy (open union)
   Policy governing who can be a member of a shared folder. Only applicable to folders owned by a user on a team.
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--team Void Only a teammate can become a member.
   #--#--anyone Void Anyone can become a member.
   #--acl_update_policy AclUpdatePolicy? Who can add and remove members of this shared folder. 
   This field is optional.
   AclUpdatePolicy (open union)
   Policy governing who can change a shared folder's access control list (ACL). In other words, who can add, remove, or change the privileges of members.
   The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--owner Void Only the owner can update the ACL.
   #--#--editors Void Any editor can update the ACL. This may be further restricted to editors on the same team.
   #--shared_link_policy SharedLinkPolicy? The policy to apply to shared links created for content inside this shared folder. 
   This field is optional.
   SharedLinkPolicy (open union)
   Policy governing who can view shared links.The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--anyone Void Links can be shared with anyone.
   #--#--members Void Links can only be shared among members of the shared folder.
   */
   put fGetQ("shared_folder_id") & ": " &  fGetQ(pSharedFolderId) into tPost
   if pMemberPolicy is not empty then
      put "," &fGetQ("member_policy") & ": " & fGetQ(pMemberPolicy) after tPost
   end if
   if pAclUpdatePolicy is not empty then
      put "," &fGetQ("acl_update_policy") & ": " & fGetQ(pAclUpdatePolicy) after tPost
   end if
   if pSharedLinkPolicy is not empty then
      put "," &fGetQ("shared_link_policy") & ": " & fGetQ(pSharedLinkPolicy) after tPost
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

on ColorAPICalls
   --use find to get a list of fileds with "Apps must have full Dropbox access to use this endpoint."
   --get text using: put fld "name" of stack "revSearch"
   put "files-upload_session_append,sharing-remove_file_member,sharing-create_shared_link,sharing-get_shared_links" into tDeprecated
   put fld "API2calls" into tAPI2calls
   repeat for each item rCall in tDeprecated
      put lineoffset(rCall,tAPI2calls) into tLineOffset
      if tLineOffset = 0  then exit repeat
      set the textcolor of line tLineOffset of fld "API2calls" to "43,27,23"
      set the backcolor of line tLineOffset of fld "API2calls" to "255,179,179"  --yellow
      put "Notes_" before rCall
      if not(there is a fld rCall) then 
         put rCall & cr after msg
      else
         set the backcolor of fld rCall to "255,179,179"
      end if
   end repeat
   --
   put "files-permanently_delete,files-properties_template_add" into tBusinessPro
   put fld "API2calls" into tAPI2calls
   repeat for each item rCall in tBusinessPro
      put lineoffset(rCall,tAPI2calls) into tLineOffset
      if tLineOffset = 0  then exit repeat
      set the textcolor of line tLineOffset of fld "API2calls" to "43,27,23"
      set the backcolor of line tLineOffset of fld "API2calls" to "214,179,255"
      put "Notes_" before rCall
      if not(there is a fld rCall) then 
         put rCall & cr after msg
      else
         set the backcolor of fld rCall to "214,179,255"
      end if
   end repeat
   --
   --sharing-add_file_member,sharing-change_file_member_access
   --files
   put "sharing-relinquish_file_membership," into tFullDropbox
   --folders
   put "sharing-add_folder_member,sharing-check_job_status,sharing-check_remove_member_job_status," after tFullDropbox
   put "sharing-get_folder_metadata,sharing-list_folder_members,sharing-list_folder_members_continue,sharing-list_folders," after tFullDropbox
   put "sharing-list_folders_continue,sharing-list_mountable_folders,sharing-list_mountable_folders_continue,sharing-mount_folder," after tFullDropbox
   put "sharing-relinquish_folder_membership,sharing-remove_folder_member,sharing-share_folder,sharing-transfer_folder," after tFullDropbox
   put "sharing-unmount_folder,sharing-unshare_folder,sharing-update_folder_member,sharing-update_folder_policy" after tFullDropbox
   put fld "API2calls" into tAPI2calls
   repeat for each item rCall in tFullDropbox
      put lineoffset(rCall,tAPI2calls) into tLineOffset
      if tLineOffset = 0  then exit repeat
      set the textcolor of line tLineOffset of fld "API2calls" to "0,0,0"
      set the backcolor of line tLineOffset of fld "API2calls" to "240,255,240"
      put "Notes_" before rCall
      if not(there is a fld rCall) then 
         put rCall & cr after msg
      else
         set the backcolor of fld rCall to "240,255,240"  --pale green
      end if
   end repeat
   --
   put "files-alpha_get_metadata,files-alpha_upload,files-properties_add,files-properties_overwrite,files-properties_remove,files-properties_overwrite," into tBeta
   put "files-properties_template_get,files-properties_template_list,files-properties_update" after tBeta
   put fld "API2calls" into tAPI2calls
   repeat for each item rCall in tBeta
      put lineoffset(rCall,tAPI2calls) into tLineOffset
      if tLineOffset = 0  then exit repeat
      set the textcolor of line tLineOffset of fld "API2calls" to "0,0,0"
      set the backcolor of line tLineOffset of fld "API2calls" to "247,255,214"
      put "Notes_" before rCall
      if not(there is a fld rCall) then 
         put rCall & cr after msg
      else
         set the backcolor of fld rCall to "247,255,214"--yellow
      end if
   end repeat
end ColorAPICalls

function fGetSortedAPIcallsChars pLineText
   put char 1 of pLineText into tChar
   switch tChar
      case "a"
         --auth
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
      case "a"
         return "a"
         break
      case "u"
         return "b"
         break
      case "f"
         return "c"
         break
      case "s"
         return "d"
         break
      default
         return "e"
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
--------------------------------------------------------------------
function fGetSecondsToISO pSecs
   /* 
   put fGetSecondsToISO(the seconds)
   2016-07-23T08:22:47Z
   ISODateTime */
   convert pSecs to dateitems
   repeat with i=2 to 6
      if item i of pSecs < 10 then put "0" before item i of pSecs
   end repeat
   return item 1 of pSecs & "-" & item 2 of of pSecs & "-" & item 3 of pSecs & "T" & item 4 of pSecs & ":" & item 5 of pSecs & ":" & item 6 of pSecs & "Z"
end fGetSecondsToISO

--function fGetQInStr pString,pAltChar
--   if pAltChar = empty then put "^" into pAltChar
--   replace pAltChar with quote in pString
--   return pString
--end fGetQInStr

function fGetQItems pString
   replace comma with quote & comma & quote in pString
   return quote & pString & quote
end fGetQItems

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
   sort lines of tOrderedKeys --numeric
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
   --put cr & db2_Header_Close() after pHeader  --gmc july 2016
   set the httpHeaders to pHeader
   --libURLSetCustomHTTPHeaders tHeaders
   put textencode(pPost,"UTF-8") into pPost  --gmc july 2016
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
   if the hilite of btn "AT1" then put fld "Aouth2accesstoken1" into tAccessToken
   if the hilite of btn "AT2" then put fld "Aouth2accesstoken2" into tAccessToken
   if the hilite of btn "AT3" then put fld "Aouth2accesstoken3" into tAccessToken
   if the hilite of btn "AT4" then put fld "Aouth2accesstoken4" into tAccessToken
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





#-- -------------------------------------------------------------------
#-- -------------------------------------------------------------------
# -------------------------------------------------------------------
# FASTJSON v1.1.0
# -------------------------------------------------------------------
#
# Bob Hall
# May 15, 2016
#
# By combining the best of easyjson and libjson and adding in
# performance enhancements, fastjson improves the speed of encoding
# and decoding Livecode arrays to/from JSON.
#
# Credit goes first to Mark Smith for creating the original libjson
# library and to Igor de Oliveira Couto who created the also excellent
# easyJson library.
#
# I am combining routines from both of these libraries to give us
# a decent boost in performance for JSON to/from Array needs.
# Yes, you can go faster than this with an custom coded extension.
# But I find the speed of this library to be pretty impressive.
#
# -------------------------------------------------------------------
# Instructions
# -------------------------------------------------------------------
#
# There are 3 calls that you will make from your Livecode scripts.
#
#     arrayToJson(pArrayData, keepNumeric)
#     jsonToArray(pJsonData, asUnicode, skipValidation)
#     isJson(pJsonData)
#
# NOTE:
# You will also find the following for compatibilty with existing
# easyJson scripts
#
#     arrayFromJson(pJsonData) (NOT TESTED)
#     jsonFromArray(pArrayData) (NOT TESTED)
#
# All other functions and commands in this script are for local use
# only.
#
# To use this library in a Stack I would suggest creating a substack
# of your main project named fastJson. Copy and paste the text of
# fastjson.lc minus the first line (<?lc) into the stack script of
# your new substack. In the preOpenStack handler of your main stack:
#
#     start using stack "fastJson"
#
# For livecode server use, include "fastjson.lc" in your server
# script.
#
# -------------------------------------------------------------------
#
##

# DECLARE SCRIPT LOCAL VARIABLES
local sOutputUnicode=""
local sJson=""
local sIndex=0
local sNumTokens=0

##
# -------------------------------------------------------------------
#  JSON to Array
# -------------------------------------------------------------------
#
# Convert a valid JSON data structure to a multi-dimensional Livecode
# array.
#
# Prototype:
#
#     put jsonToArray( tJsonData, false, true ) into tArrayData
#
# -------------------------------------------------------------------
#
##
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

##
#
#  Included for compatibility with easyJson scripts
#
##
function arrayFromJson pJson
   return jsonToArray(pJson)
end arrayFromJson

##
# -------------------------------------------------------------------
#  Array To JSON
# -------------------------------------------------------------------
#
# Convert a multi-dimensional Livecode array to a valid JSON data
# structure.
#
# Prototype:
#
#     put arrayToJson( tArrayData ) into tJsonData
#
# -------------------------------------------------------------------
#
##
function arrayToJson pArray keepNumeric
   local tJSON
   local tValue
   local tKey
   
   if pArray is not an array then return "Parser Error: parameter given is not an array."
   if isNumericalArray(pArray) and keepNumeric is not true then
      # the array's keys are all *numerical*, so the root element will be a JSON *array*
      # if keepNumeric is true, then the keys will remain numeric keys
      put "[" into tJSON
      repeat for each element tValue in pArray
         --put jsonValue(tValue) & comma after tJSON
         if tValue is empty then
            put space after tJSON
         else
            put jsonValue(tValue) & comma after tJSON
         end if
      end repeat
      put "]" into the last char of tJSON
   else
      # the array's keys are not all numerical, so the root element will be a JSON *object*
      put "{" into tJSON
      repeat for each key tKey in pArray
         # all JSON object keys are double-quoted strings:
         put quote & tKey & quote & ": " & jsonValue(pArray[tKey]) & comma after tJSON
      end repeat
      put "}" into the last char of tJSON
   end if
   return tJSON
end arrayToJson

##
## -------------------------------------------------------------------
#
#  Included for compatibility with easyJson scripts
#
# -------------------------------------------------------------------
#
##
function jsonFromArray pJson
   return arrayToJson(pJson)
end jsonFromArray

##
# -------------------------------------------------------------------
#  Validate JSON data structure
# -------------------------------------------------------------------
#
# Prototype:
#
#     if isJson( tJsonData ) then
#        put "Valid JSON" into tTemp
#     else
#        put "ERROR! Not Valid JSON"
#     end if
#
# -------------------------------------------------------------------
#
##

constant kJSONStart = "{"
constant kJSONEnd = "}"
constant kJSONArrayStart = "["
constant kJSONArrayEnd = "]"
constant kJSONDelimiter = ":"
constant kValidJSONDelimiters = "{}[],:"

function isJson pJson
   --local tToken, tDepth
   local n
   local tObjectCount, tArrayCount
   put 0 into tObjectCount
   put 0 into tArrayCount
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
      if (sJson[n-1] is not in kValidJSONDelimiters) and (sJson[n] is not in kValidJSONDelimiters) then
         put sJson[n-3] & return & sJson[n-2] &  return & sJson[n-1] &  return & sJson[n] &  return & sJson[n+1] &  return
         return false
      end if
      switch tToken
         case kJSONStart
            add 1 to tObjectCount
            break
         case kJSONEnd
            subtract 1 from tObjectCount
            break
         case kJSONArrayStart
            add 1 to tArrayCount
            break
         case kJSONArrayEnd
            subtract 1 from tArrayCount
            break
      end switch
      add 1 to n
   end repeat
   if tObjectCount is not 0 then
      put sNumTokens & cr after msg
      return "ERR: unbalanced objects:" && tObjectCount
   end if
   if tArrayCount is not 0 then
      return "ERR: unbalanced arrays:" && tArrayCount
   end if
   return true
end isJson


private function jObjectToArray
   local tArray
   local tName
   put empty into tArray
   -- using a repeat forever with a conditional got small improvement
   repeat forever
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
   repeat for each element n in tCounter
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
         #
         # SPECIAL CASE. Need to catch this in JSON or performace takes a hit.
         #
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
            ##
            # JSON encoders escape unicode characters as "\uHHHH",
            # where 'H' is a hexadecimal digit. Convert to UTF8
            #
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


##
# -------------------------------------------------------------------
#
# This function checks the keys of a LiveCode array,
# and returns TRUE if all the keys are numerical - otherwise, returns false.
#
#  @param pArray a LiveCode array
#  @return TRUE if the array's keys are all numerical, otherwise FALSE
#
# -------------------------------------------------------------------
#
private function isNumericalArray @pArray
   local tKeys, aKey
   put the keys of pArray into tKeys
   repeat for each line aKey in tKeys
      if aKey is not a number then
         -- as soon as we don't get a number, get outa here!
         return false
         exit isNumericalArray
      end if
   end repeat
   return true
end isNumericalArray

##
# -------------------------------------------------------------------
#
# This function takes a LiveCode value, and produces a string representing
# a valid JSON 'value', as per http://www.json.org/.
#  @param pValue any LiveCode value: array, string, number, date, colour, boolean, etc.
#  @return a string representing a valid and comparable JSON 'value' - JSON values are:
#        number, string, boolean, array or object.
#        LiveCode 'empty' returns JSON 'null'.
#
# -------------------------------------------------------------------
#

private function jsonValue pValue
   switch
      case pValue is an array
         # this allows us to have nested JSON objects and arrays:
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
         # any other value is processed as a string.
         # JSON strings require that certain characters be 'escaped' with a backslash:
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
   # escaped quotes < \" > and reverse-solidus < \\ > will confuse the tokenizer
   # so we replace them with "\u0022" and "\u005C" which we'll unescape
   # with all the other unescapes when we parse - jsonDecode()
   replace "\\" with "\u005C" in pJson
   replace "\" & quote with "\u0022" in pJson
   put 1 into sIndex
   put "" into prevToken
   repeat for each token tToken in pJson
      switch
         case tToken is in "+-"
            # since "+" & "-" are rev tokens, but not jSon tokens,
            # we have to prepend them to the next token
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



#-- FASTJSON end
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------
#-- ------------------------------------------------------------------------------------------------------------


