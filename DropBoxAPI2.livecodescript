-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
------db2 Library start--------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
--------auth---------------------------------------------------------------
-----------------------------------------------------------------------------

/**
db2_token_revoke pAccessToken
--
Description
Disables the access token used to authenticate the call.
--
Returns
null
No return values.
*/

function db2_token_revoke pAccessToken
   local tHeader,tPost,tUrl
   put db2_token_revoke_HEADER(pAccessToken) into tHeader
   put db2_token_revoke_POST() into tPost
   put db2_token_revoke_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_token_revoke

-----------------------------------------------------------------------------
---------users-----------------------------------------------------------
-----------------------------------------------------------------------------

/**
db2_get_account pAccessToken,pUserAccountID
--
Description
Get information about a user's account.
--
GetAccountArg
#--account_id String(min_length=40, max_length=40) A user's account identifier. 
--
for POST
{"account_id":"pUserAccountID"}
{"account_id:"dbid:________________"}
--
Returns
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

function db2_get_account pAccessToken,pUserAccountID
   local tHeader,tPost,tUrl
   put db2_get_account_HEADER(pAccessToken) into tHeader
   put db2_get_account_POST(pUserAccountID) into tPost
   put db2_get_account_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_account

/**
db2_get_account_batch pAccessToken,pUserAccountIDs
--
Description
Get information about multiple user accounts. At most 300 accounts may be queried per request.
--
pUserAccountIDs on separate lines
GetAccountBatchArg
#--account_ids List of (String(min_length=40, max_length=40), min_items=1) List of user account identifiers. Should not contain any duplicate account IDs. 
--
Returns
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

function db2_get_account_batch pAccessToken,pUserAccountIDs
   local tHeader,tPost,tUrl
   put db2_get_account_batch_HEADER(pAccessToken) into tHeader
   put db2_get_account_batch_POST(pUserAccountIDs) into tPost
   put db2_get_account_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_account_batch

/**
db2_get_current_account pAccessToken
--
Description
Get information about a user's account.
--
No parameters. Null required for POST; empty value fails.
--
Returns
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

function db2_get_current_account pAccessToken
   local tHeader,tPost,tUrl
   put db2_get_current_account_HEADER(pAccessToken) into tHeader
   put db2_get_current_account_POST() into tPost
   put db2_get_current_account_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_current_account

/**
db2_get_space_usage pAccessToken
--
Description
Get the space usage information for the current user's account.
--
No parameters. Null required for POST; empty value fails.
--
Returns
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

function db2_get_space_usage pAccessToken
   local tHeader,tPost,tUrl
   put db2_get_space_usage_HEADER(pAccessToken) into tHeader
   put db2_get_space_usage_POST() into tPost
   put db2_get_space_usage_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_space_usage

-----------------------------------------------------------------------------
-------file properties--------------------------------------------------------------
-----------------------------------------------------------------------------

/**
db2_properties_add pAccessToken,pPath,pPropertyGroupsArray
--
Description
Add property groups to a Dropbox file.
See templates/add_for_user  to create new templates. 
--
use pPropertyGroupsArray to store template_id, and field name, value eg:
pPropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pPropertyGroupsArray[1][fields][1][name]=	Name
pPropertyGroupsArray[1][fields][1][value]=	me
pPropertyGroupsArray[1][fields][2][name]=	Age
pPropertyGroupsArray[1][fields][2][value]=	21
pPropertyGroupsArray[2][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAXXb
pPropertyGroupsArray[2][fields][1][name]=	Topic
pPropertyGroupsArray[2][fields][1][value]=	Science
pPropertyGroupsArray[2][fields][2][name]=	SubTopic
pPropertyGroupsArray[2][fields][2][value]=	Biology
--
for POST
{"path": "/folder1/testfile1.txt",
"property_groups": [
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "name","value": "me"},{"name": "age","value": "21"}]},
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAXXb","fields": [{"name": "Topic","value": "Science"},{"name": "SubTopic","value": "Biology"}]}
]}
--
AddPropertiesArg
#--path String(pattern="/(.|[\r\n])*|id:.*|(ns:[0-9]+(/.*)?)") A unique identifier for the file or folder.
#--property_groups List of (PropertyGroup) The property groups which are to be added to a Dropbox file.
PropertyGroup
A subset of the property fields described by the corresponding PropertyGroupTemplate. Properties are always added to a Dropbox file as a PropertyGroup. 
The possible key names and value types in this group are defined by the corresponding PropertyGroupTemplate.
#--#--template_id String(min_length=1, pattern="(/|ptid:).*") A unique identifier for the associated template.
#--#--fields List of (PropertyField) The actual properties associated with the template. There can be up to 32 property types per template.
PropertyField
Raw key/value data to be associated with a Dropbox file. Property fields are added to Dropbox files as a PropertyGroup.
#--#--#--name String Key of the property field associated with a file and template. Keys can be up to 256 bytes.
#--#--#--value String Value of the property field associated with a file and template. Values can be up to 1024 bytes.
--
Returns
null
No return values.
*/

function db2_properties_add pAccessToken,pPath,pPropertyGroupsArray
   local tHeader,tPost,tUrl
   put db2_properties_add_HEADER(pAccessToken) into tHeader
   put db2_properties_add_POST(pPath,pPropertyGroupsArray) into tPost
   put db2_properties_add_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_properties_add

/**
db2_properties_overwrite pAccessToken,pPath,pPropertyGroupsArray
--
Description
Overwrite property groups associated with a file. 
This endpoint should be used instead of properties/update when property groups are being updated via a "snapshot" instead of via a "delta". 
In other words, this endpoint will delete all omitted fields from a property group, whereas properties/update will only delete fields that are explicitly marked for deletion.
See: https://blogs.dropbox.com/developers/2013/07/how-the-datastore-api-handles-conflicts-part-1-basics-of-offline-conflict-handling/
--
use pPropertyGroupsArray to store template_id, and field name, value eg:
pPropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pPropertyGroupsArray[1][fields][1][name]=	Name
pPropertyGroupsArray[1][fields][1][value]=	me
pPropertyGroupsArray[1][fields][2][name]=	Age
pPropertyGroupsArray[1][fields][2][value]=	21
pPropertyGroupsArray[2][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAXXb
pPropertyGroupsArray[2][fields][1][name]=	Topic
pPropertyGroupsArray[2][fields][1][value]=	Science
pPropertyGroupsArray[2][fields][2][name]=	SubTopic
pPropertyGroupsArray[2][fields][2][value]=	Biology
--
for POST
{"path": "/folder1/testfile1.txt",
"property_groups": [
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "name","value": "me"},{"name": "age","value": "21"}]},
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAXXb","fields": [{"name": "Topic","value": "Science"},{"name": "SubTopic","value": "Biology"}]}
] }
--
OverwritePropertyGroupArg
#--path String(pattern="/(.|[\r\n])*|id:.*|(ns:[0-9]+(/.*)?)") A unique identifier for the file or folder.
#--property_groups List of (PropertyGroup, min_items=1) The property groups "snapshot" updates to force apply.
PropertyGroup
A subset of the property fields described by the corresponding PropertyGroupTemplate. Properties are always added to a Dropbox file as a PropertyGroup. 
The possible key names and value types in this group are defined by the corresponding PropertyGroupTemplate.
template_id String(min_length=1, pattern="(/|ptid:).*") A unique identifier for the associated template.
#--#--fields List of (PropertyField) The actual properties associated with the template. There can be up to 32 property types per template.
PropertyField
Raw key/value data to be associated with a Dropbox file. Property fields are added to Dropbox files as a PropertyGroup.
#--#--#--name String Key of the property field associated with a file and template. Keys can be up to 256 bytes.
#--#--#--value String Value of the property field associated with a file and template. Values can be up to 1024 bytes.
--
Returns
null
No return values. 
*/

function db2_properties_overwrite pAccessToken,pPath,pPropertyGroupsArray
   local tHeader,tPost,tUrl
   put db2_properties_overwrite_HEADER(pAccessToken) into tHeader
   put db2_properties_overwrite_POST(pPath,pPropertyGroupsArray) into tPost
   put db2_properties_overwrite_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_properties_overwrite

/**
db2_properties_remove pAccessToken,pPath,pTemplateIDs
--
Description
Permanently removes the specified property group from the file. 
To remove specific property field key value pairs, see properties/update. 
To update a template, see templates/update_for_user. 
--
pass pTemplateIDs with ids on separate lines, include "ptid" with id
--
for POST
{"path": "/Apps/AppTesterAppFolderUser2/TestFolder/testfile.txt","property_template_ids": ["ptid:562VTx1rtSMAAAAAAAACaA"]}
--
RemovePropertiesArg
#--path String(pattern="/(.|[\r\n])*|id:.*|(ns:[0-9]+(/.*)?)") A unique identifier for the file.
#--property_template_ids List of (String(min_length=1, pattern="(/|ptid:).*"), ) A list of identifiers for a property template created by route properties/template/add. 
--
Returns
null
No return values. 
*/

function db2_properties_remove pAccessToken,pPath,pTemplateIDs
   local tHeader,tPost,tUrl
   put db2_properties_remove_HEADER(pAccessToken) into tHeader
   put db2_properties_remove_POST(pPath,pTemplateIDs) into tPost
   put db2_properties_remove_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_properties_remove

/**
db2_properties_search pAccessToken,pQueryText,pQueryMode,pQueryModeField,pLogicalOperator,pFilterTemplateIDs
--
Description
Search across property templates for particular property field values.
--
for POST
{"queries":[{"query":"gmc","mode":{".tag":"field_name","field_name":"name"}}]}
--
{"queries":[{"query":"gmc","mode":{".tag":"field_name","field_name":"name"}}],"template_filter":{".tag":"filter_none"}}
--
{"queries": [{"query": "gmc","mode": {".tag": "field_name", "field_name": "name"},"logical_operator": "or_operator"}],"template_filter": "filter_none"}
--
{"queries": [{"query": "gmc","mode": {".tag": "field_name", "field_name": "name"},"logical_operator": "or_operator"}],
"template_filter":{".tag":"filter_some","filter_some":["ptid:562VTx1rtSMAAAAAAAACaA","ptid:562VTx1rtSMAAAAAAAACaX"]}}
--
{"queries":[{"query":"gmc",
"mode":{".tag":"field_name","field_name":"name"},
"logical_operator":{".tag":"or_operator"}},
{"query":"21",
"mode":{".tag":"field_name","field_name":"age"},
"logical_operator":{".tag":"or_operator"}}],
"template_filter":{".tag":"filter_some","filter_some":["ptid:562VTx1rtSMAAAAAAAACaA","ptid:562VTx1rtSMAAAAAAAACaX"]}}
--
PropertiesSearchArg
#--queries List of (PropertiesSearchQuery, min_items=1) Queries to search.
PropertiesSearchQuery
#--#--query String The property field value for which to search across templates.
#--#--mode PropertiesSearchMode The mode with which to perform the search.
PropertiesSearchMode (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--field_name String Search for a value associated with this field name.
#--#--logical_operator LogicalOperator The logical operator with which to append the query. The default for this union is or_operator.
LogicalOperator (open union)
Logical operator to join search queries together. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--#--or_operator Void Append a query with an "or" operator.
#--template_filter TemplateFilter Filter results to contain only properties associated with these template IDs. The default for this union is filter_none.
TemplateFilter (union)
The value will be one of the following datatypes:
#--#--filter_some List of (String(min_length=1, pattern="(/|ptid:).*"), min_items=1) Only templates with an ID in the supplied list will be returned (a subset of templates will be returned).
#--#--filter_none Void No templates will be filtered from the result (all templates will be returned).
--
Returns
{"matches": [{"id": "id:F5QvTmxtJVAAAAAAAAAAAQ", "path": "/TestFolder/testfile.txt", "is_deleted": false, "property_groups": 
[{"template_id": "ptid:562VTx1rtSMAAAAAAAACaA", "fields": 
[{"name": "gender", "value": "M"}, {"name": "age", "value": "21"}, {"name": "name", "value": "gmc"}]}]}]}
--
PropertiesSearchResult
#--matches List of (PropertiesSearchMatch) A list (possibly empty) of matches for the query.
PropertiesSearchMatch
#--#--id String(min_length=1) The ID for the matched file or folder.
#--#--path String The path for the matched file or folder.
#--#--is_deleted Boolean Whether the file or folder is deleted.
#--#--property_groups List of (PropertyGroup) List of custom property groups associated with the file.
PropertyGroup
A subset of the property fields described by the corresponding PropertyGroupTemplate. Properties are always added to a Dropbox file as a PropertyGroup. The possible key names and value types in this group are defined by the corresponding PropertyGroupTemplate.
#--#--#--template_id String(min_length=1, pattern="(/|ptid:).*") A unique identifier for the associated template.
#--#--#--fields List of (PropertyField) The actual properties associated with the template. There can be up to 32 property types per template.
PropertyField
Raw key/value data to be associated with a Dropbox file. Property fields are added to Dropbox files as a PropertyGroup.
#--#--#--#--name String Key of the property field associated with a file and template. Keys can be up to 256 bytes.
#--#--#--#--value String Value of the property field associated with a file and template. Values can be up to 1024 bytes.
#--cursor String(min_length=1)? Pass the cursor into properties/search/continue to continue to receive search results. Cursor will be null when there are no more results. This field is optional.
*/

function db2_properties_search pAccessToken,pQueryText,pQueryField,pQueryMode,pLogicalOperator,pFilterTemplateIDs
   local tHeader,tPost,tUrl
   put db2_properties_search_HEADER(pAccessToken) into tHeader
   put db2_properties_search_POST(pQueryText,pQueryField,pQueryMode,pLogicalOperator,pFilterTemplateIDs) into tPost
   put db2_properties_search_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_properties_search

/**
db2_properties_search_continue pAccessToken,pSearchCursor
--
Description
Once a cursor has been retrieved from properties/search, use this to paginate through all search results. 
--
for POST
{"cursor": "ZtkX9_EHj3x7PMkVuFIhwKYXEpwpLwyxp9vMKomUhllil9q7eWiAu"}
--
PropertiesSearchContinueArg
#--cursor String(min_length=1) The cursor returned by your last call to properties/search or properties/search/continue.
--
Returns
{"matches": [{"id": "id:F5QvTmxtJVAAAAAAAAAAAQ", "path": "/TestFolder/testfile.txt", "is_deleted": false, "property_groups": 
[{"template_id": "ptid:562VTx1rtSMAAAAAAAACaA", "fields": 
[{"name": "gender", "value": "M"}, {"name": "age", "value": "21"}, {"name": "name", "value": "gmc"}]}]}]}
--
PropertiesSearchResult
#--matches List of (PropertiesSearchMatch) A list (possibly empty) of matches for the query.
PropertiesSearchMatch
#--#--id String(min_length=1) The ID for the matched file or folder.
#--#--path String The path for the matched file or folder.
#--#--is_deleted Boolean Whether the file or folder is deleted.
#--#--property_groups List of (PropertyGroup) List of custom property groups associated with the file.
PropertyGroup
A subset of the property fields described by the corresponding PropertyGroupTemplate. Properties are always added to a Dropbox file as a PropertyGroup. The possible key names and value types in this group are defined by the corresponding PropertyGroupTemplate.
#--#--#--template_id String(min_length=1, pattern="(/|ptid:).*") A unique identifier for the associated template.
#--#--#--fields List of (PropertyField) The actual properties associated with the template. There can be up to 32 property types per template.
PropertyField
Raw key/value data to be associated with a Dropbox file. Property fields are added to Dropbox files as a PropertyGroup.
#--#--#--#--name String Key of the property field associated with a file and template. Keys can be up to 256 bytes.
#--#--#--#--value String Value of the property field associated with a file and template. Values can be up to 1024 bytes.
#--cursor String(min_length=1)? Pass the cursor into properties/search/continue to continue to receive search results. Cursor will be null when there are no more results. This field is optional.
*/

function db2_properties_search_continue pAccessToken,pSearchCursor
   local tHeader,tPost,tUrl
   put db2_properties_search_continue_HEADER(pAccessToken) into tHeader
   put db2_properties_search_continue_POST(pSearchCursor) into tPost
   put db2_properties_search_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_properties_search_continue

/**
db2_properties_update pAccessToken,pPath,pUpdatePropertyGroupsArray
--
Description
Add, update or remove properties associated with the supplied file and templates. 
This endpoint should be used instead of properties/overwrite when property groups are being updated via a "delta" instead of via a "snapshot" . 
In other words, this endpoint will not delete any omitted fields from a property group, 
whereas properties/overwrite will delete any fields that are omitted from a property group. 
--
use pUpdatePropertyGroupsArray to store template_id, name, value  eg:
pUpdatePropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
use pUpdatePropertyGroupsArray to store template_id, name, value  eg:
pUpdatePropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pUpdatePropertyGroupsArray[1][add_or_update_fields][1][name]=	Name
pUpdatePropertyGroupsArray[1][add_or_update_fields][1][value]=	me
pUpdatePropertyGroupsArray[1][add_or_update_fields][2][name]=	Age
pUpdatePropertyGroupsArray[1][add_or_update_fields][2][value]=	21
pUpdatePropertyGroupsArray[1][remove_fields]=	Gender & cr & Race  cr delimited list of fields to remove
pUpdatePropertyGroupsArray[2][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAXXb
pUpdatePropertyGroupsArray[2][add_or_update_fields][1][name]=	Topic
pUpdatePropertyGroupsArray[2][add_or_update_fields][1][value]=	Science
pUpdatePropertyGroupsArray[2][remove_fields]=	SubTopic

--
for POST
{"path": "folder1/testfile2.txt",
"update_property_groups": [{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa",
"add_or_update_fields": [{"name": "Security Policy","value": "Confidential"}],
"remove_fields": []}
]}

{"path": "/folder1/testfile1.txt",
"update_property_groups": [
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa",
"add_or_update_fields": [{"name": "name","value": "me"},{"name": "age","value": "21"}],
"remove_fields": ["Gender","Race"]},
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAXXb",
add_or_update_fields": [{"name": "Topic","value": "Science"}],
"remove_fields": ["SubTopic"]}
]}
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
#-- #--name String This is the name or key of a custom property in a property template. File property names can be up to 256 bytes.
#-- #--value String Value of a custom property attached to a file. Values can be up to 1024 bytes.
#--remove_fields List of (String)? List of property field names to remove from property group if the field exists. 
This field is optional.
--Returns
No return values. 
*/ 

function db2_properties_update pAccessToken,pPath,pUpdatePropertyGroupsArray
   local tHeader,tPost,tUrl
   put db2_properties_update_HEADER(pAccessToken) into tHeader
   put db2_properties_update_POST(pPath,pUpdatePropertyGroupsArray) into tPost
   put db2_properties_update_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_properties_update

-----------------------------------------------------------------------------
-------file properties templates--------------------------------------------------------------
-----------------------------------------------------------------------------

/**
db2_templates_add_for_user pAccessToken,pTemplateName,pTemplateDescription,pFieldsArray
--
Description
Add a specified template.
Apps must have full Dropbox access to use this endpoint.
--
pFieldsArray would be an array containing the field names and descriptions and types (string)
pFieldsArray[1]["name"]...[2]["name"] etc
pFieldsArray[1][name]=	Name
pFieldsArray[1][description]=	Enter name
pFieldsArray[1][type]=	string
pFieldsArray[2][name]=	Age
pFieldsArray[2][description]=	Enter age
pFieldsArray[2][type]=	string
--
For POST
{"name": "UserInfo","description": "UserInfo template.",
"fields": [{"name": "name","description": "Enter name.","type": "string"},
{"name": "age","description": "Enter age.","type": "string"},
{"name": "gender","description": "Enter gender.","type": "string"}]}
--
AddTemplateArg
#--name String Display name for the template. Template names can be up to 256 bytes.
#--description String Description for the template. Template descriptions can be up to 1024 bytes.
#--fields List of (PropertyFieldTemplate) Definitions of the property fields associated with this template. There can be up to 32 properties in a single template.
PropertyFieldTemplate
Defines how a single property field may be structured. Used exclusively by PropertyGroupTemplate.
#--#--name String Key of the property field being described. Property field keys can be up to 256 bytes.
#--#--description String Description of the property field. Property field descriptions can be up to 1024 bytes.
#--#--type PropertyType Data type of the value of this property field. This type will be enforced upon property creation and modifications.
PropertyType (open union)
Data type of the given property field added. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--string Void The associated property field will be of type string. Unicode is supported.
--
*Returns
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa"}
AddTemplateResult
#--template_id String(min_length=1, pattern="(/|ptid:).*") An identifier for template added by templates/add_for_user
*/

function db2_templates_add_for_user pAccessToken,pTemplateName,pTemplateDescription,pFieldsArray
   local tHeader,tPost,tUrl
   put db2_templates_add_for_user_HEADER(pAccessToken) into tHeader
   put db2_templates_add_for_user_POST(pTemplateName,pTemplateDescription,pFieldsArray) into tPost
   put db2_templates_add_for_user_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_templates_add_for_user

/**
db2_templates_get_for_user pAccessToken,pTemplateID
--
Description
Get the schema for a specified template.
Apps must have full Dropbox access to use this endpoint.
--
GetTemplateArg
#--template_id String(min_length=1, pattern="(/|ptid:).*") An identifier for template added by templates/add_for_user 
--
For POST
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa"}
--
Returns
GetTemplateResult
#--name String Display name for the template. Template names can be up to 256 bytes.
#--description String Description for the template. Template descriptions can be up to 1024 bytes.
#--fields List of (PropertyFieldTemplate) Definitions of the property fields associated with this template. There can be up to 32 properties in a single template.
PropertyFieldTemplate
Defines how a single property field may be structured. Used exclusively by PropertyGroupTemplate.
#--#--name String Key of the property field being described. Property field keys can be up to 256 bytes.
#--#--description String Description of the property field. Property field descriptions can be up to 1024 bytes.
#--#--type PropertyType Data type of the value of this property field. This type will be enforced upon property creation and modifications.
*/

function db2_templates_get_for_user pAccessToken,pTemplateID
   local tHeader,tPost,tUrl
   put db2_templates_get_for_user_HEADER(pAccessToken) into tHeader
   put db2_templates_get_for_user_POST(pTemplateID) into tPost
   put db2_templates_get_for_user_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_templates_get_for_user

/**
db2_templates_list_for_user pAccessToken
--
Description
Get the property template identifiers for a user.
Apps must have full Dropbox access to use this endpoint.
--
Returns
{"template_ids": ["ptid:1a5n2i6d3OYEAAAAAAAAAYa","ptid:1a5n2i6d3OYEAAAAAAAAXXB"]}
ListTemplateResult
#--template_ids List of (String(min_length=1, pattern="(/|ptid:).*")) List of identifiers for templates added by templates/add_for_user
*/

function db2_templates_list_for_user pAccessToken
   local tHeader,tPost,tUrl
   put db2_templates_list_for_user_HEADER(pAccessToken) into tHeader
   put db2_templates_list_for_user_POST() into tPost
   put db2_templates_list_for_user_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_templates_list_for_user

/**
db2_templates_remove_for_user pAccessToken,pTemplateID
--
Description
Permanently removes the specified template created from templates/add_for_user. 
All properties associated with the template will also be removed. This action cannot be undone.
Apps must have full Dropbox access to use this endpoint.
--
pTemplateID is one id only; can't delete multiple ids in one call.
--
for POST
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa"}
--
RemoveTemplateArg
template_id String(min_length=1, pattern="(/|ptid:).*") An identifier for a template added by templates/add_for_user 
--
Returns
null. No return values. 
*/

function db2_templates_remove_for_user pAccessToken,pTemplateID
   local tHeader,tPost,tUrl
   put db2_templates_remove_for_user_HEADER(pAccessToken) into tHeader
   put db2_templates_remove_for_user_POST(pTemplateID) into tPost
   put db2_templates_remove_for_user_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_templates_remove_for_user

/**
db2_templates_update_for_user pAccessToken,pTemplateID,pTemplateName,pTemplateDescription,pFieldsArray
--
Description
Update a template associated with a user. 
This route can update  the template name, the template description and add optional properties  to templates.
Apps must have full Dropbox access to use this endpoint.
--
pFieldsArray would be an array containing the field names and descriptions and types (string)
pFieldsArray[1][name]=	Me
pFieldsArray[1][description]=	Full name
pFieldsArray[1][type]=	string
--
Since the last 3 params are optional pass those not being updated as empty "" so any one of them can be updated
If a field name is passed that is already present it will not overwrite the field --just ignored.
--
for POST
{"template_id": "ptid:562VTx1rtSMAAAAAAAACYg", "name": "UserInfo","description": "UserInfo template.",
"add_fields": [{"name": "name","description": "Enter name.","type": "string"},
{"name": "age","description": "Enter age.","type": "string"},
{"name": "gender","description": "Enter gender.","type": "string"}]}
--
UpdateTemplateArg
#--template_id String(min_length=1, pattern="(/|ptid:).*") An identifier for template added by templates/add_for_user
#--name String? A display name for the template. template names can be up to 256 bytes. This field is optional.
#--description String? Description for the new template. Template descriptions can be up to 1024 bytes. This field is optional.
#--add_fields List of (PropertyFieldTemplate)? Property field templates to be added to the group template. There can be up to 32 properties in a single template. This field is optional.
--
Returns
{"template_id": ["ptid:562VTx1rtSMAAAAAAAACYg"]}
UpdateTemplateResult
#--template_id String(min_length=1, pattern="(/|ptid:).*") An identifier for template added by route templates/add_for_user
*/

function db2_templates_update_for_user pAccessToken,pTemplateID,pTemplateName,pTemplateDescription,pFieldsArray
   local tHeader,tPost,tUrl
   put db2_templates_update_for_user_HEADER(pAccessToken) into tHeader
   put db2_templates_update_for_user_POST(pTemplateID,pTemplateName,pTemplateDescription,pFieldsArray) into tPost
   put db2_templates_update_for_user_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_templates_update_for_user


-----------------------------------------------------------------------------
---------file requests-------------------------------------------
/* see https://www.dropbox.com/help/files-folders/create-file-request */
-----------------------------------------------------------------------------

/**
db2_create pAccessToken,pTitle,pDestination,pOpenBoolean
--
Description
Creates a file request for this user. This generates a url that has buttons for others to upload a file.
Deadline parameter requires Business account, so is not implemented here.
--
for POST
{"title": "Homework submission","destination": "/File Requests/Homework","deadline": {"deadline": "2020-10-12T17:00:00Z","allow_late_uploads": "seven_days"},"open": true}
--
CreateFileRequestArgs
Arguments for create.
#--title String(min_length=1) 
The title of the file request. Must not be empty.
#--destination String(pattern="/(.|[\r\n])*") 
The path of the folder in the Dropbox where uploaded files will be sent. For apps with the app folder permission, this will be relative to the app folder.
#--deadline FileRequestDeadline? 
The deadline for the file request. Deadlines can only be set by Pro and Business accounts. This field is optional.
FileRequestDeadline
#--#--deadline Timestamp(format="%Y-%m-%dT%H:%M:%SZ") 
The deadline for this file request.
#--#--allow_late_uploads GracePeriod? 
If set, allow uploads after the deadline has passed. These uploads will be marked overdue. This field is optional.
GracePeriod (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--one_day Void
#--#--#--two_days Void
#--#--#--seven_days Void
#--#--#--thirty_days Void
#--#--#--always Void
#--open Boolean Whether or not the file request should be open. If the file request is closed, it will not accept any file submissions, but it can be opened later. The default for this field is True.
--
Returns
FileRequest
A file request for receiving files into the user's Dropbox account.
id String(min_length=1, pattern="[-_0-9a-zA-Z]+") The ID of the file request.
url String(min_length=1) The URL of the file request.
title String(min_length=1) The title of the file request.
created Timestamp(format="%Y-%m-%dT%H:%M:%SZ") When this file request was created.
is_open Boolean Whether or not the file request is open. If the file request is closed, it will not accept any more file submissions.
file_count Int64 The number of files this file request has received.
destination String(pattern="/(.|[\r\n])*")? The path of the folder in the Dropbox where uploaded files will be sent. This can be None if the destination was removed. For apps with the app folder permission, this will be relative to the app folder. This field is optional.
deadline FileRequestDeadline? The deadline for this file request. Only set if the request has a deadline. This field is optional.
FileRequestDeadline
deadline Timestamp(format="%Y-%m-%dT%H:%M:%SZ") The deadline for this file request.
allow_late_uploads GracePeriod? If set, allow uploads after the deadline has passed. These uploads will be marked overdue. This field is optional.
GracePeriod (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
one_day Void
two_days Void
seven_days Void
thirty_days Void
always Void
*/

function db2_create pAccessToken,pTitle,pDestination,pOpenBoolean
   local tHeader,tPost,tUrl
   put db2_create_HEADER(pAccessToken) into tHeader
   put db2_create_POST(pTitle,pDestination,pOpenBoolean) into tPost
   put db2_create_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_create

/**
db2_get pAccessToken,pRequestID
--
Description
Returns the specified file request.
--
GetFileRequestArgs
Arguments for get.
#--id String(min_length=1, pattern="[-_0-9a-zA-Z]+") 
The ID of the file request to retrieve.
--
for POST
{"id":"cEH1UE9LC3f8BNp5Qn2X"}
--
Returns
FileRequest
A file request for receiving files into the user's Dropbox account.
id String(min_length=1, pattern="[-_0-9a-zA-Z]+") The ID of the file request.
url String(min_length=1) The URL of the file request.
title String(min_length=1) The title of the file request.
created Timestamp(format="%Y-%m-%dT%H:%M:%SZ") When this file request was created.
is_open Boolean Whether or not the file request is open. If the file request is closed, it will not accept any more file submissions.
file_count Int64 The number of files this file request has received.
destination String(pattern="/(.|[\r\n])*")? The path of the folder in the Dropbox where uploaded files will be sent. This can be None if the destination was removed. For apps with the app folder permission, this will be relative to the app folder. This field is optional.
deadline FileRequestDeadline? The deadline for this file request. Only set if the request has a deadline. This field is optional.
FileRequestDeadline
deadline Timestamp(format="%Y-%m-%dT%H:%M:%SZ") The deadline for this file request.
allow_late_uploads GracePeriod? If set, allow uploads after the deadline has passed. These uploads will be marked overdue. This field is optional.
GracePeriod (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
one_day Void
two_days Void
seven_days Void
thirty_days Void
always Void
*/

function db2_get pAccessToken,pRequestID
   local tHeader,tPost,tUrl
   put db2_get_HEADER(pAccessToken) into tHeader
   put db2_get_POST(pRequestID) into tPost
   put db2_get_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get

/**
db2_list pAccessToken
--
Description
Returns a list of file requests owned by this user.
For apps with the app folder permission, this will only return file requests with destinations in the app folder.
#Note: this seems to require Apps to have full Dropbox access to use this endpoint.
For App folder apps, a 500 server error results
--
No parameters. Null is used at https://dropbox.github.io/dropbox-api-v2-explorer/#file_requests_list
Note: this seems to require Apps to have full Dropbox access to use this endpoint.
For App folder apps, a 500 server error results including in the API explorer (url above)
--
Returns
ListFileRequestsResult
Result for list.
file_requests List of (FileRequest) The file requests owned by this user. Apps with the app folder permission will only see file requests in their app folder.
FileRequest
A file request for receiving files into the user's Dropbox account.
id String(min_length=1, pattern="[-_0-9a-zA-Z]+") The ID of the file request.
url String(min_length=1) The URL of the file request.
title String(min_length=1) The title of the file request.
created Timestamp(format="%Y-%m-%dT%H:%M:%SZ") When this file request was created.
is_open Boolean Whether or not the file request is open. If the file request is closed, it will not accept any more file submissions.
file_count Int64 The number of files this file request has received.
destination String(pattern="/(.|[\r\n])*")? The path of the folder in the Dropbox where uploaded files will be sent. This can be None if the destination was removed. For apps with the app folder permission, this will be relative to the app folder. This field is optional.
deadline FileRequestDeadline? The deadline for this file request. Only set if the request has a deadline. This field is optional.
FileRequestDeadline
deadline Timestamp(format="%Y-%m-%dT%H:%M:%SZ") The deadline for this file request.
allow_late_uploads GracePeriod? If set, allow uploads after the deadline has passed. These uploads will be marked overdue. This field is optional.
GracePeriod (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
one_day Void
two_days Void
seven_days Void
thirty_days Void
always Void
*/

function db2_list pAccessToken
   local tHeader,tPost,tUrl
   put db2_list_HEADER(pAccessToken) into tHeader
   put db2_list_POST() into tPost
   put db2_list_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list

/**
db2_update pAccessToken,pRequestID,pTitle,pDestination,pOpenBoolean
--
Description
Update a file request.
Deadline parameter requires Business account, so is omitted here.
--
for POST
{"id": "NwqYGFabZnv90CVgQN57","open": true}

{"id": "NwqYGFabZnv90CVgQN57","open": false}

{"id": "tmIpSMwDfkyxoyDZN03X","title": "Homework submission","destination": "/File Requests/Homework"}

--for Business eg:
{"id": "tmIpSMwDfkyxoyDZN03X","title": "Homework submission","destination": "/File Requests/Homework",
"deadline": {".tag": "update","deadline": "2020-10-12T17:00:00Z","allow_late_uploads": "seven_days"},"open": true}
--
UpdateFileRequestArgs
Arguments for update.
#--id String(min_length=1, pattern="[-_0-9a-zA-Z]+") 
The ID of the file request to update.
#--title String(min_length=1)? 
The new title of the file request. Must not be empty. This field is optional.
#--destination String(pattern="/(.|[\r\n])*")? 
The new path of the folder in the Dropbox where uploaded files will be sent. 
For apps with the app folder permission, this will be relative to the app folder. This field is optional.
#--deadline UpdateFileRequestDeadline 
The new deadline for the file request. The default for this union is no_update.
UpdateFileRequestDeadline (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--no_update Void 
Do not change the file request's deadline.
#--#--update FileRequestDeadline? 
If None, the file request's deadline is cleared. This field is optional.
FileRequestDeadline
#--#--deadline Timestamp(format="%Y-%m-%dT%H:%M:%SZ") 
The deadline for this file request.
#--#--allow_late_uploads GracePeriod? 
If set, allow uploads after the deadline has passed. These uploads will be marked overdue. This field is optional.
GracePeriod (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--#--one_day Void
#--#--#--two_days Void
#--#--#--seven_days Void
#--#--#--thirty_days Void
#--#--#--always Void
#--open Boolean? 
Whether to set this file request as open or closed. This field is optional.
--
Returns
FileRequest
A file request for receiving files into the user's Dropbox account.
id String(min_length=1, pattern="[-_0-9a-zA-Z]+") The ID of the file request.
url String(min_length=1) The URL of the file request.
title String(min_length=1) The title of the file request.
created Timestamp(format="%Y-%m-%dT%H:%M:%SZ") When this file request was created.
is_open Boolean Whether or not the file request is open. If the file request is closed, it will not accept any more file submissions.
file_count Int64 The number of files this file request has received.
destination String(pattern="/(.|[\r\n])*")? The path of the folder in the Dropbox where uploaded files will be sent. This can be None if the destination was removed. For apps with the app folder permission, this will be relative to the app folder. This field is optional.
deadline FileRequestDeadline? The deadline for this file request. Only set if the request has a deadline. This field is optional.
FileRequestDeadline
deadline Timestamp(format="%Y-%m-%dT%H:%M:%SZ") The deadline for this file request.
allow_late_uploads GracePeriod? If set, allow uploads after the deadline has passed. These uploads will be marked overdue. This field is optional.
GracePeriod (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
one_day Void
two_days Void
seven_days Void
thirty_days Void
always Void
*/

function db2_update pAccessToken,pRequestID,pTitle,pDestination,pOpenBoolean
   local tHeader,tPost,tUrl
   put db2_update_HEADER(pAccessToken) into tHeader
   put db2_update_POST(pRequestID,pTitle,pDestination,pOpenBoolean) into tPost
   put db2_update_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_update

-----------------------------------------------------------------------------
------files------------------------------------------------------
-----------------------------------------------------------------------------

/**
db2_copy_batch pAccessToken,pPathFromAndToArray,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
--
Description
Copy multiple files or folders to different locations at once in the user's Dropbox.
Note that a it fails with a conflict error if the to_path folder already exists
This route will return job ID immediately and do the async copy job in background. 
Use copy_batch/check to check the job status. 
--
pPathFromAndToArray would be an array containing the from_path and to_path
pFieldsArray[1][from_path]=	/folder1
pFieldsArray[1][to_path]=	/folder1a
pFieldsArray[2][from_path]=	/folder2
pFieldsArray[2][to_path]=	/folder2a
--
for POST
folders
{"entries": [{"from_path": "/folder1","to_path": "/folder1a"},{"from_path": "/folder2","to_path": "/folder2a"}],
"allow_shared_folder": false,"autorename": false,"allow_ownership_transfer": false}
--
files
{"entries": [{"from_path": "/folder1/testfile1.txt","to_path": "/folder1/testfile2.txt"},{"from_path": "/folder1/testfile1.txt","to_path": "/folder2/testfile2.txt"}],
"allow_shared_folder": false,"autorename": false,"allow_ownership_transfer": false}
--
RelocationBatchArg
#--entries List of (RelocationPath) List of entries to be moved or copied. Each entry is RelocationPath.
RelocationPath
#--#--from_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox to be copied or moved.
#--#--to_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox that is the destination.
#--allow_shared_folder Boolean If true, copy_batch will copy contents in shared folder, 
otherwise RelocationError.cant_copy_shared_folder will be returned if RelocationPath.from_path contains shared folder. 
This field is always true for move_batch. The default for this field is False.
#--autorename Boolean If there's a conflict with any file, have the Dropbox server try to autorename that file to avoid the conflict. 
The default for this field is False.
#--allow_ownership_transfer Boolean Allow moves by owner even if it would result in an ownership transfer for the content being moved.
This does not apply to copies. The default for this field is False.
--
Returns
{".tag": "async_job_id","async_job_id": "dbjid:AADbBuGMGuQR8HMu6ExQTN76VLXewIyGs_EXN-30DPct-TsoQicIHmQfsjbCIy4t7DjKgTIrbQlBHc8O2XI-xmlT"}
--
RelocationBatchLaunch (open union)
Result returned by copy_batch or move_batch that may either launch an asynchronous job or complete synchronously. The value will be one of the following datatypes. New values may be introduced as our API evolves.
async_job_id String(min_length=1) This response indicates that the processing is asynchronous. The string is an id that can be used to obtain the status of the asynchronous job.
complete RelocationBatchResult
RelocationBatchResult
entries List of (RelocationBatchResultData)
*/

function db2_copy_batch pAccessToken,pPathFromAndToArray,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
   local tHeader,tPost,tUrl
   put db2_copy_batch_HEADER(pAccessToken) into tHeader
   put db2_copy_batch_POST(pPathFromAndToArray,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer) into tPost
   put db2_copy_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_copy_batch

/**
db2_copy_batch_check pAccessToken,pAsyncJobId
--
Description
Returns the status of an asynchronous job for copy_batch.
If success, it returns list of results for each entry. 
--
for POST
{"async_job_id": "dbjid:AACRVLHU9sKoS1_d9gfifc4vWNYqePsXAlk7UMv8fTfjLJu8oFvqcRgqrTte_BbCfGUL-MgO02RfJPWovkPu9RNE}
--
PollArg
Arguments for methods that poll the status of an asynchronous job. This datatype comes from an imported namespace originally defined in the async namespace.
async_job_id String(min_length=1) Id of the asynchronous job. This is the value of a response returned from the method that launched the job.
--
Returns
RelocationBatchJobStatus (union)
The value will be one of the following datatypes:
in_progress Void The asynchronous job is still in progress.
complete RelocationBatchResult The copy or move batch job has finished.
failed RelocationBatchError The copy or move batch job has failed with exception.
*/

function db2_copy_batch_check pAccessToken,pAsyncJobId 
   put db2_copy_batch_check_HEADER(pAccessToken) into tHeader
   put db2_copy_batch_check_POST(pAsyncJobId) into tPost
   put db2_copy_batch_check_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_copy_batch_check

/**
db2_copy_reference_get pAccessToken,pPath
--
Description
Get a copy reference to a file or folder. 
This reference string can be used to save that file or folder to another user's Dropbox by passing it to copy_reference/save. 
--
GetCopyReferenceArg
path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") 
The path to the file or folder you want to get a copy reference to.
--
for POST
{"path": "/folder1"}
{"path": "/folder1/testfile2.txt"}
--
Returns
GetCopyReferenceResult
metadata Metadata 
Metadata for a file or folder. This datatype will be one of the following subtypes:
file FileMetadata
folder FolderMetadata
deleted DeletedMetadata
copy_reference String A copy reference to the file or folder.
expires Timestamp(format="%Y-%m-%dT%H:%M:%SZ") The expiration date of the copy reference. 
This value is currently set to be far enough in the future so that expiration is effectively not an issue. 
*/

function db2_copy_reference_get pAccessToken,pPath
   local tHeader,tPost,tUrl
   put db2_copy_reference_get_HEADER(pAccessToken) into tHeader
   put db2_copy_reference_get_POST(pPath) into tPost
   put db2_copy_reference_get_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_copy_reference_get

/**
db2_copy_reference_save pAccessToken,pCopyReference,pPath
--
Description
Save a copy reference returned by copy_reference/get to the user's Dropbox. 
--
for POST
{"copy_reference":"AAAAAErJ_Yk5YWJlbmtweWVrZm0","path":"/folder1/testfile1a.txt"}
{"copy_reference":"AAAAAErJ_Yk3ampvZGg3MDN4anY","path":"/folder1b"}
--
SaveCopyReferenceArg
#--copy_reference String A copy reference returned by copy_reference/get.
#--path String(pattern="/(.|[\r\n])*") Path in the user's Dropbox that is the destination. 
--
Returns
SaveCopyReferenceResult
#--metadata Metadata The metadata of the saved file or folder in the user's Dropbox.
Metadata for a file or folder. This datatype will be one of the following subtypes:
file FileMetadata
folder FolderMetadata
deleted DeletedMetadata
*/

function db2_copy_reference_save pAccessToken,pCopyReference,pPath
   local tHeader,tPost,tUrl
   put db2_copy_reference_save_HEADER(pAccessToken) into tHeader
   put db2_copy_reference_save_POST(pCopyReference,pPath) into tPost
   put db2_copy_reference_save_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_copy_reference_save


/**
db2_copy_v2 pAccessToken,pPathFrom,pPathTo,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
--
Description
Copy a file or folder to a different location in the user's Dropbox.
If the source path is a folder all its contents will be copied.
--
for POST
{"from_path":"/folder1","to_path":"/folder1d"}
{"from_path":"/folder1/testfile1.txt","to_path":"/folder1/testfile3.txt"}
{"from_path":"/folder1","to_path":"/folder1d","allow_shared_folder":false,"autorename":false,"allow_ownership_transfer":false}
--
RelocationArg
#--from_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox to be copied or moved.
#--to_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox that is the destination.
#--allow_shared_folder Boolean If true, copy will copy contents in shared folder, otherwise RelocationError.cant_copy_shared_folder will be returned if from_path contains shared folder. This field is always true for move. The default for this field is False.
#--autorename Boolean If there's a conflict, have the Dropbox server try to autorename the file to avoid the conflict. The default for this field is False.
#--allow_ownership_transfer Boolean Allow moves by owner even if it would result in an ownership transfer for the content being moved. This does not apply to copies. The default for this field is False.
--
Returns
Metadata (datatype with subtypes)
Metadata for a file or folder. This datatype will be one of the following subtypes:
file FileMetadata
folder FolderMetadata
deleted DeletedMetadata
*/

function db2_copy_v2 pAccessToken,pPathFrom,pPathTo,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
   local tHeader,tPost,tUrl
   put db2_copy_v2_HEADER(pAccessToken) into tHeader
   put db2_copy_v2_POST(pPathFrom,pPathTo,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer) into tPost
   put db2_copy_v2_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_copy_v2

/**
db2_create_folder_v2 pAccessToken,pPath
--
Description
Create a folder at a given path.
With autorename true, folders will be renamed with a suffix such as folder1 renamed to folder1 (1) or  folder1 (2) etc
--
for POST
{"path": "/folder1"}
{"path": "/folder1","autorename": false}
{"path": "/folder1","autorename": true}
--
CreateFolderArg
#--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") Path in the user's Dropbox to create.
#--autorename Boolean If there's a conflict, have the Dropbox server try to autorename the folder to avoid the conflict. 
The default for this field is False.
--
Returns
FolderMetadata
*/

function db2_create_folder_v2 pAccessToken,pPath,pAutorename
   local tHeader,tPost,tUrl
   put db2_create_folder_v2_HEADER(pAccessToken) into tHeader
   put db2_create_folder_v2_POST(pPath,pAutorename) into tPost
   put db2_create_folder_v2_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_create_folder_v2

/**
db2_delete_batch pAccessToken,pPaths
--
Description
Delete multiple files/folders at once.
This route is asynchronous, which returns a job ID immediately and runs the delete batch asynchronously. 
Use delete_batch/check to check the job status. 
--
pPaths would be list of paths with each path on separate lines
--
for POST
{"entries": [{"path": "/folder1a"},{"path": "/folder2a"}]}
--
DeleteBatchArg
entries List of (DeleteArg)
DeleteArg
path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox to delete.
--
Returns
DeleteBatchLaunch (open union)
Result returned by delete_batch that may either launch an asynchronous job or complete synchronously. The value will be one of the following datatypes. New values may be introduced as our API evolves.
async_job_id String(min_length=1) This response indicates that the processing is asynchronous. The string is an id that can be used to obtain the status of the asynchronous job.
complete DeleteBatchResult
DeleteBatchResult 
*/

function db2_delete_batch pAccessToken,pPaths
   local tHeader,tPost,tUrl
   put db2_delete_batch_HEADER(pAccessToken) into tHeader
   put db2_delete_batch_POST(pPaths) into tPost
   put db2_delete_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_delete_batch

/**
db2_delete_batch_check pAccessToken,pAsyncJobId
--
Description
Returns the status of an asynchronous job for delete_batch. If success, it returns list of result for each entry. 
--
for POST
{"async_job_id": "dbjid:AACZPZ6ZCm-9l0ynjxbExgOXLrfMHPUgveBmvjhJLQkgXjUrz68s40lOelG__gIDFAdVS-44UJ9KDhhe2wQMNxZF"}
--
DeleteArg
path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox to delete.
--
Returns
DeleteResult
metadata Metadata Metadata of the deleted object.
Metadata (datatype with subtypes)
Metadata for a file or folder. This datatype will be one of the following subtypes:
file FileMetadata
folder FolderMetadata
deleted DeletedMetadata
*/

function db2_delete_batch_check pAccessToken,pAsyncJobId
   local tHeader,tPost,tUrl
   put db2_delete_batch_check_HEADER(pAccessToken) into tHeader
   put db2_delete_batch_check_POST(pAsyncJobId) into tPost
   put db2_delete_batch_check_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_delete_batch_check

/**
db2_delete_v2 pAccessToken,pPath
--
Description
Delete the file or folder at a given path.
If the path is a folder, all its contents will be deleted too.
A successful response indicates that the file or folder was deleted. 
The returned metadata will be the corresponding FileMetadata or FolderMetadata for the item at time of deletion, 
and not a DeletedMetadata object. 
--
for POST
{"path": "/folder1"}
--
DeleteArg
path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox to delete.
--
Returns
DeleteResult
metadata Metadata Metadata of the deleted object.
Metadata (datatype with subtypes)
Metadata for a file or folder. This datatype will be one of the following subtypes:
file FileMetadata
folder FolderMetadata
deleted DeletedMetadata
*/

function db2_delete_v2 pAccessToken,pPath
   local tHeader,tPost,tUrl
   put db2_delete_v2_HEADER(pAccessToken) into tHeader
   put db2_delete_v2_POST(pPath) into tPost
   put db2_delete_v2_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_delete_v2

/**
db2_download pAccessToken,pPath
--
Description
Download a file from a user's Dropbox.
The contents of the file are returned.
--
for header:
{"path":"/folder1/testfile1.txt"}
{"path":"rev:934ac9fd89"}
{"path":"id:a1XparO6B8AAAAAAAAAAAQ"}
--
DownloadArg
path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path of the file to download. 
Example: string {"path": "/folder1/testfile1.txt"}
Example: id {"path": "id:vPnA7HCkSoAAAAAAAAAAAQ"}
Example: rev  {"path": "rev:c73e457377"}
--
Returns
--contents of the file
*/

function db2_download pAccessToken,pPath
   local tHeader,tPost,tUrl
   put db2_download_HEADER(pAccessToken,pPath) into tHeader
   put db2_download_POST() into tPost
   put db2_download_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_download

/**
db2_download_zip pAccessToken,pPath
--
Description
Download a folder from the user's Dropbox, as a zip file. 
The  folder must be less than 1 GB in size and have fewer than 10,000 total  files. The input cannot be a single file.
--
for header:
{"path":"/folder1"}
{"path":"id:2Vk9dc7iTSAAAAAAAAAAAQ"}
--
DownloadZipArg
path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path of the folder to download.
--
Returns
contents of the file
*/

function db2_download_zip pAccessToken,pPath
   local tHeader,tPost,tUrl
   put db2_download_zip_HEADER(pAccessToken,pPath) into tHeader
   put db2_download_zip_POST() into tPost
   put db2_download_zip_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_download_zip

/**
db2_get_metadata pAccessToken,pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,pIncludePropertyTemplateIDs
--
Description
Returns the metadata for a file or folder.
Note: Metadata for the root folder is unsupported.
--
pIncludePropertyTemplateIDs needs to be a list of templates one per line; e.g. ptid:562VTx1rtSMAAAAAAAACYg
--
for POST
{"path":"/folder1/testfile1.txt"}
{"path": "/folder1/testfile1.txt","include_media_info": false,"include_deleted": false,"include_has_explicit_shared_members": false}
{"path":"/Apps/AppTesterAppFolderUser2/TestFolder/testfile.txt","include_media_info": false,"include_deleted": true,"include_has_explicit_shared_members": true,
"include_property_groups":{".tag":"filter_some","filter_some":["ptid:562VTx1rtSMAAAAAAAACYg"]}}
--
GetMetadataArg
#--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") 
The path of a file or folder on Dropbox.
#--include_media_info Boolean 
If true, FileMetadata.media_info is set for photo and video. The default for this field is False.
#--include_deleted Boolean 
If true, DeletedMetadata will be returned for deleted file or folder, otherwise LookupError.not_found will be returned. The default for this field is False.
#--include_has_explicit_shared_members Boolean 
If true, the results will include a flag for each file indicating whether or not that file has any explicit members. The default for this field is False.
#--include_property_groups TemplateFilterBase? 
If set to a valid list of template IDs, FileMetadata.property_groups is set if there exists property data associated with the file and each of the listed templates. This field is optional.
TemplateFilterBase (open union)
This datatype comes from an imported namespace originally defined in the file_properties namespace. 
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--filter_some List of (String(min_length=1, pattern="(/|ptid:).*"), min_items=1) 
Only templates with an ID in the supplied list will be returned (a subset of templates will be returned).
--
Returns
Metadata (datatype with subtypes)
Metadata for a file or folder. This datatype will be one of the following subtypes:
file FileMetadata
folder FolderMetadata
deleted DeletedMetadata
*/

function db2_get_metadata pAccessToken,pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,pIncludePropertyTemplateIDs
   local tHeader,tPost,tUrl
   put db2_get_metadata_HEADER(pAccessToken) into tHeader
   put db2_get_metadata_POST(pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,pIncludePropertyTemplateIDs) into tPost
   put db2_get_metadata_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_metadata

/**
db2_get_preview pAccessToken,pPath
--
Description
Get a preview for a file.
Currently, PDF previews are generated  for files with the following extensions: .ai, .doc, .docm, .docx, .eps,  .odp, .odt, .pps, .ppsm, .ppsx, .ppt, .pptm, .pptx, .rtf.
HTML previews are generated for files with the following extensions: .csv, .ods, .xls, .xlsm, .xlsx.
Other formats will return an unsupported extension error.
File contents are returned, not a file.
--
in header
Dropbox-API-Arg: {"path":"/TestFolder/testfile.docx"}
other forms for path:
{"path":"rev:934ac9fd89"}
{"path":"id:a1XparO6B8AAAAAAAAAAAQ"}
--
PreviewArg
path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path of the file to preview. --
--
Returns
PDF version of contents of file
*/

function db2_get_preview pAccessToken,pPath
   local tHeader,tPost,tUrl
   put db2_get_preview_HEADER(pAccessToken,pPath) into tHeader
   put db2_get_preview_POST() into tPost
   put db2_get_preview_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_preview

/**
db2_get_temporary_link pAccessToken,pPath
--
Description
Get a temporary link to stream content of a file. 
This link will  expire in four hours and afterwards you will get 410 Gone. 
Content-Type of the link is determined automatically by the file's mime type.
--
{"path": "/folder1/testfile1.txt"}
--
GetTemporaryLinkArg
path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") 
The path to the file you want a temporary link to.
--
Returns
GetTemporaryLinkResult
#--metadata FileMetadata
#--link String The temporary link which can be used to stream content the file. 
*/

function db2_get_temporary_link pAccessToken,pPath
   local tHeader,tPost,tUrl
   put db2_get_temporary_link_HEADER(pAccessToken) into tHeader
   put db2_get_temporary_link_POST(pPath) into tPost
   put db2_get_temporary_link_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_temporary_link

/**
db2_get_thumbnail pAccessToken,pPath,pFormat,pSize
--
Description
Get a thumbnail for an image.
This method currently supports files with the following file extensions: jpg, jpeg, png, tiff, tif, gif and bmp. 
Photos that are larger than 20MB in size won't be converted to a thumbnail.
The image data can be saved to file to create an image file.
File contents are returned, not a file.
--
for header
Dropbox-API-Arg: {"path":"/TestFolder/testpic.jpg","format": "jpeg","size": "w64h64"}
--
ThumbnailArg
#--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path to the image file you want to thumbnail.
#--format ThumbnailFormat The format for the thumbnail image, jpeg (default) or png. For images that are photos, jpeg should be preferred, while png is better for screenshots and digital arts. The default for this union is jpeg.
ThumbnailFormat (union)
The value will be one of the following datatypes:
#--#--jpeg Void
#--#--png Void
#--size ThumbnailSize The size for the thumbnail image. The default for this union is w64h64.
ThumbnailSize (union)
The value will be one of the following datatypes:
#--#--w32h32 Void 32 by 32 px.
#--#--w64h64 Void 64 by 64 px.
#--#--w128h128 Void 128 by 128 px.
#--#--w640h480 Void 640 by 480 px.
#--#--w1024h768 Void 1024 by 768.
--
Returns
contents of file
*/

function db2_get_thumbnail pAccessToken,pPath,pFormat,pSize
   local tHeader,tPost,tUrl
   put db2_get_thumbnail_HEADER(pAccessToken,pPath,pFormat,pSize) into tHeader
   put db2_get_thumbnail_POST() into tPost
   put db2_get_thumbnail_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_thumbnail

/**
db2_get_thumbnail_batch pAccessToken,pPathFormatSizeArray
--
Description
Get thumbnails for a list of images. We allow up to 25 thumbnails in a single batch.
This method currently supports files with the following file extensions:  jpg, jpeg, png, tiff, tif, gif and bmp. 
Photos that are larger than 20MB in size won't be converted to a thumbnail.
The thumbnail is returned in a string for "thumbnail":
To save the thumbnail as an image the returned thumbnail string needs to be converted from a string to raw jpeg data via base64Decode.
--
pPathFormatSizeArray is an array 
pPathFormatSizeArrray[1][path]=	/TestFolder/testpic.jpg
pPathFormatSizeArrray[1][format]=	jpeg
pPathFormatSizeArrray[1][size]=	w64h64
pPathFormatSizeArrray[2][path]=	/TestFolder/testpic.jpg
pPathFormatSizeArrray[2][format]=	png
pPathFormatSizeArrray[2][size]=	w32h32
--
for POST
{"entries": [{"path": "/testpic.jpg","format": "jpeg","size": "w64h64"}]}
{"entries": [{"path":"/TestFolder/testpic.jpg","format": "jpeg","size": "w64h64"},{"path":"/TestFolder/testpic (1).jpg","format": "png","size": "w32h32"}]}
--
GetThumbnailBatchArg
Arguments for get_thumbnail_batch.
#--entries List of (ThumbnailArg) List of files to get thumbnails.
ThumbnailArg
#--path String(pattern="(/(.|[\r\n])*|id:.*)|(rev:[0-9a-f]{9,})|(ns:[0-9]+(/.*)?)") The path to the image file you want to thumbnail.
#--format ThumbnailFormat The format for the thumbnail image, jpeg (default) or png. 
For images that are photos, jpeg should be preferred, while png is better for screenshots and digital arts. The default for this union is jpeg.
ThumbnailFormat (union)
The value will be one of the following datatypes:
#--#--jpeg Void
#--#--png Void
#--size ThumbnailSize The size for the thumbnail image. The default for this union is w64h64.
ThumbnailSize (union)
The value will be one of the following datatypes:
#--#--w32h32 Void 32 by 32 px.
#--#--w64h64 Void 64 by 64 px.
#--#--w128h128 Void 128 by 128 px.
#--#--w640h480 Void 640 by 480 px.
#--#--w1024h768 Void 1024 by 768.
--
Returns
GetThumbnailBatchResult
entries List of (GetThumbnailBatchResultEntry) List of files and their thumbnails.
GetThumbnailBatchResultEntry (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
success
The thumbnail is returned in a string for "thumbnail":
failure ThumbnailError The result for this file if it was an error.
ThumbnailError (union)
The value will be one of the following datatypes:
path LookupError An error occurs when downloading metadata for the image.
*/

function db2_get_thumbnail_batch pAccessToken,pPathFormatSizeArray
   local tHeader,tPost,tUrl
   put db2_get_thumbnail_batch_HEADER(pAccessToken) into tHeader
   put db2_get_thumbnail_batch_POST(pPathFormatSizeArray) into tPost
   put db2_get_thumbnail_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_get_thumbnail_batch

/**
db2_list_folder pAccessToken,pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember,IncludeMountedFolders,pLimit,pIncludePropertyTemplateIDs
-- 
shared_link parameter is not implemented here
--
Description
Starts returning the contents of a folder. 
If the result's ListFolderResult.has_more field is true, call list_folder/continue with the returned ListFolderResult.cursor to retrieve more entries.
--
for POST
{"path":"","recursive":true,"include_media_info":true,"include_deleted":true,"include_has_explicit_shared_members":true,"include_mounted_folders":true,"limit":50,"include_property_groups":{".tag":"filter_some","filter_some":["ptid:562VTx1rtSMAAAAAAAACYg"]}}
--
ListFolderArg
#--path String(pattern="(/(.|[\r\n])*)?|id:.*|(ns:[0-9]+(/.*)?)") A unique identifier for the file.
#--recursive Boolean 
If true, the list folder operation will be applied recursively to all subfolders and the response will contain contents of all subfolders. 
The default for this field is False.
#--include_media_info Boolean 
If true, FileMetadata.media_info is set for photo and video. 
The default for this field is False.
#--include_deleted Boolean 
If true, the results will include entries for files and folders that used to exist but were deleted. 
The default for this field is False.
#--include_has_explicit_shared_members Boolean 
If true, the results will include a flag for each file indicating whether or not that file has any explicit members. The default for this field is False.
#--include_mounted_folders Boolean 
If true, the results will include entries under mounted folders which includes app folder, shared folder and team folder. The default for this field is True.
#--limit UInt32? 
The maximum number of results to return per request. ##testing has shown that [1,2000] for values; suggest 50 arbirarily as a useful default
Note: This is an approximate number and there can be slightly more entries returned in some cases. This field is optional.
#--shared_link SharedLink? 
A shared link to list the contents of. If the link is password-protected, the password must be provided. 
If this field is present, ListFolderArg.path will be relative to root of the shared link. Only non-recursive mode is supported for shared link. This field is optional.
SharedLink
#--#--url String Shared link url.
#--#--password String? Password for the shared link. This field is optional.
#--include_property_groups TemplateFilterBase? If set to a valid list of template IDs, 
FileMetadata.property_groups is set if there exists property data associated with the file and each of the listed templates. This field is optional.
--
Returns
ListFolderResult
entries List of (Metadata) The files and (direct) subfolders in the folder.
Metadata for a file or folder. This datatype will be one of the following subtypes:
file FileMetadata
folder FolderMetadata
deleted DeletedMetadata
cursor String Pass the cursor into list_folder/continue to see what's changed in the folder since your previous query.
has_more Boolean If true, then there are more entries available. Pass the cursor to list_folder/continue to retrieve the rest.
*/

function db2_list_folder pAccessToken,pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember,IncludeMountedFolders,pLimit,pIncludePropertyTemplateIDs
  local tHeader,tPost,tUrl
   put db2_list_folder_HEADER(pAccessToken) into tHeader
   put db2_list_folder_POST(pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember,IncludeMountedFolders,pLimit,pIncludePropertyTemplateIDs) into tPost
   put db2_list_folder_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder

/**
db2_list_folder_continue pAccessToken,pCursor
--
Description
Once a cursor has been retrieved from list_folder, use this to paginate through all files and retrieve updates to the folder, following the same rules as documented for list_folder.  
ListFolderContinueArg
#--cursor String(min_length=1) 
The cursor returned by your last call to list_folder or list_folder/continue.
--
for POST
{"cursor":"AAHEpzweiWf8iB_AM5jSYMvG-PXj8GJMWZTKT_-z-QYhP5yHTBRf6N-nT6uyCxcrYfgpsvbC1Xyhoax3SSl2tuRQJdM57eIF9wviYADJ9cp6Mc8UVoVQ7JFEI1oJC4nqEQOm3Q1DnyH56BA7tk_eO05gZKl154Kdp-EoyEHp3pyDGF7KPKE1sh_97VmJChvUeeHD_G3hvMlFTswzu6hKu_8mlZfnS1hlR0QUxD7xTiJo7w"}
--
Returns
ListFolderResult
#--entries List of (Metadata) The files and (direct) subfolders in the folder.
Metadata for a file or folder. This datatype will be one of the following subtypes:
file FileMetadata
folder FolderMetadata
deleted DeletedMetadata
#--cursor String(min_length=1) 
Pass the cursor into list_folder/continue to see what's changed in the folder since your previous query.
#--has_more 
Boolean If true, then there are more entries available. Pass the cursor to list_folder/continue to retrieve the rest. 
*/

function db2_list_folder_continue pAccessToken,pCursor
    local tHeader,tPost,tUrl
   put db2_list_folder_continue_HEADER(pAccessToken) into tHeader
   put db2_list_folder_continue_POST(pCursor) into tPost
   put db2_list_folder_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder_continue

/**
db2_list_folder_get_latest_cursor pAccessToken,pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember
--
Description
A way to quickly get a cursor for the folder's state. Unlike list_folder, list_folder/get_latest_cursor doesn't return any entries. 
This endpoint is for app which only needs to know about new files and modifications and doesn't need to know about files that already exist in Dropbox. 
--
ListFolderArg
#--path String(pattern="(/(.|[\r\n])*)?|id:.*|(ns:[0-9]+(/.*)?)") 
A unique identifier for the file.
#--recursive Boolean 
If true, the list folder operation will be applied recursively to all subfolders and the response will contain contents of all subfolders. The default for this field is False.
#--include_media_info Boolean 
If true, FileMetadata.media_info is set for photo and video. The default for this field is False.
#--include_deleted Boolean 
If true, the results will include entries for files and folders that used to exist but were deleted. The default for this field is False.
#--include_has_explicit_shared_members Boolean 
If true, the results will include a flag for each file indicating whether or not that file has any explicit members. The default for this field is False.
#--include_mounted_folders Boolean 
If true, the results will include entries under mounted folders which includes app folder, shared folder and team folder. The default for this field is True.
#--limit UInt32? 
The maximum number of results to return per request. Note: This is an approximate number and there can be slightly more entries returned in some cases. This field is optional.
#--shared_link SharedLink? A shared link to list the contents of. 
If the link is password-protected, the password must be provided. If this field is present, ListFolderArg.path will be relative to root of the shared link. Only non-recursive mode is supported for shared link. This field is optional.
SharedLink
#--url String Shared link url.
#--password String? Password for the shared link. This field is optional.
#--include_property_groups TemplateFilterBase? If set to a valid list of template IDs, FileMetadata.property_groups is set if there exists property data associated with the file and each of the listed templates. This field is optional.
--
Returns
ListFolderGetLatestCursorResult
cursor String(min_length=1) Pass the cursor into list_folder/continue to see what's changed in the folder since your previous query.
*/

function db2_list_folder_get_latest_cursor pAccessToken,pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember,IncludeMountedFolders,pLimit,pIncludePropertyTemplateIDs
   local tHeader,tPost,tUrl
   put db2_list_folder_get_latest_cursor_HEADER(pAccessToken) into tHeader
   put db2_list_folder_get_latest_cursor_POST(pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMember) into tPost
   put db2_list_folder_get_latest_cursor_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder_get_latest_cursor

/**
db2_list_folder_longpoll pCursor,pTimeout
--
Description
A longpoll endpoint to wait for changes on an account. 
In conjunction with list_folder/continue, this call gives you a low-latency way to monitor an account for file changes. 
The connection will block until there are changes available or a timeout occurs. 
This endpoint is useful mostly for client-side apps. If you're looking for server-side notifications, check out our webhooks documentation. 
--
Notes:
timeout in range [30, 480]
A dialog is opened at the end of the timeout
Need to set socketTimeoutInterval > 30000 millisec
No Authorization header is used
--
for POST
{"cursor":"1AAGnnWDvEOO2b9xOCXEfhAdJVQeR8jk43Bn2GlNIamvCI2gqCP_Qa129jmJSlbVyIyH6XCEuTjRXUjO-j1jgbk9Lytw0PgEfiq1wartuO9M-kqlfHhRqmu08N-3WD-qNNYs","timeout":30}
--
ListFolderLongpollArg
#--cursor String(min_length=1) 
A cursor as returned by list_folder or list_folder/continue. 
Cursors retrieved by setting ListFolderArg.include_media_info to true are not supported.
#--timeout UInt64 A timeout in seconds. 
The request will block for at most this length of time, plus up to 90 seconds of random jitter added to avoid the thundering herd problem. 
Care should be taken when using this parameter, as some network infrastructure does not support long timeouts. 
The default for this field is 30.
##Must be in range 30 to 480
--
Returns
   ListFolderLongpollResult
   #--changes Boolean Indicates whether new changes are available. If true, call list_folder/continue to retrieve the changes.
   #--backoff UInt64? If present, backoff for at least this many seconds before calling list_folder/longpoll again. 
   This field is optional.
*/

function db2_list_folder_longpoll pCursor,pTimeout
   local tHeader,tPost,tUrl
   put db2_list_folder_longpoll_HEADER() into tHeader
   put db2_list_folder_longpoll_POST(pCursor,pTimeout) into tPost
   put db2_list_folder_longpoll_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_folder_longpoll

/**
db2_list_revisions pAccessToken,pPath,pMode,pLimit
--
Description
Returns revisions for files based on a file path or a file id. The  file path or file id is identified from the latest file entry at the  given file path or id. 
This end point allows your app to query either by  file path or file id by setting the mode parameter appropriately.
In  the ListRevisionsMode.path (default) mode, all revisions at the same  file path as the latest file entry are returned. 
If revisions with the  same file id are desired, then mode must be set to ListRevisionsMode.id.  
The ListRevisionsMode.id mode is useful to retrieve revisions for a  given file across moves or renames.
--
for POST
{"path":"/folder3/testfile1.txt","mode":"path","limit": 2}
--
ListRevisionsArg
ListRevisionsArg
#--path String(pattern="/(.|[\r\n])*|id:.*|(ns:[0-9]+(/.*)?)") 
The path to the file you want to see the revisions of.
#--mode ListRevisionsMode 
Determines the behavior of the API in listing the revisions for a given file path or id. The default for this union is path.
ListRevisionsMode (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--path Void 
Returns revisions with the same file path as identified by the latest file entry at the given file path or id.
#--#--id Void 
Returns revisions with the same file id as identified by the latest file entry at the given file path or id.
#--limit UInt64 
The maximum number of revision entries returned. The default for this field is 10.

The default for this field is 10.
Must be in range 1 to 100
--
Returns
ListRevisionsResult
is_deleted Boolean If the file identified by the latest revision in the response is either deleted or moved.
entries List of FileMetadata
The revisions for the file. Only revisions that are not deleted will show up here. This field is optional.
server_deleted Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? The time of deletion if the file was deleted. This field is optional. 
*/

function db2_list_revisions pAccessToken,pPath,pMode,pLimit
   local tHeader,tPost,tUrl
   put db2_list_revisions_HEADER(pAccessToken) into tHeader
   put db2_list_revisions_POST(pPath,pLimit) into tPost
   put db2_list_revisions_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_list_revisions

/**
db2_move_batch pAccessToken,pPathFromAndToArray,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer--
Description
Move multiple files or folders to different locations at once in the user's Dropbox.
This route is 'all or nothing', which means if one entry fails, the whole transaction will abort.
This route will return job ID immediately and do the async moving job in background. Please use move_batch/check to check the job status. 
--
for POST
{"entries": [{"from_path": "/folder1","to_path": "/folder1a"},{"from_path": "/folder2","to_path": "/folder2a"}],
"allow_shared_folder": false,"autorename": false,"allow_ownership_transfer": false}
--
RelocationBatchArg
#--entries List of (RelocationPath) List of entries to be moved or copied. Each entry is RelocationPath.
RelocationPath
#--from_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") 
Path in the user's Dropbox to be copied or moved.
#--to_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") 
Path in the user's Dropbox that is the destination.
#--allow_shared_folder Boolean 
If true, copy_batch will copy contents in shared folder, otherwise RelocationError.cant_copy_shared_folder will be returned if RelocationPath.from_path contains shared folder. 
This field is always true for move_batch. The default for this field is False.
#--autorename Boolean 
If there's a conflict with any file, have the Dropbox server try to autorename that file to avoid the conflict. The default for this field is False.
#--allow_ownership_transfer Boolean 
Allow moves by owner even if it would result in an ownership transfer for the content being moved. This does not apply to copies. The default for this field is False.
--
Returns
RelocationBatchLaunch (open union)
Result returned by copy_batch or move_batch that may either launch an asynchronous job or complete synchronously. 
The value will be one of the following datatypes. New values may be introduced as our API evolves.
async_job_id String(min_length=1) This response indicates that the processing is asynchronous. 
The string is an id that can be used to obtain the status of the asynchronous job.
complete RelocationBatchResult
RelocationBatchResult
entries List of (RelocationBatchResultData)
RelocationBatchResultData
metadata Metadata Metadata of the relocated object.
*/

function db2_move_batch pAccessToken,pPathFromAndToArray,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
   local tHeader,tPost,tUrl
   put db2_move_batch_HEADER(pAccessToken) into tHeader
   put db2_move_batch_POST(pPathFromAndToArray,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer) into tPost
   put db2_move_batch_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_move_batch

/**
db2_move_batch_check pAccessToken,pAsyncJobId
--
Description
Returns the status of an asynchronous job for move_batch. If success, it returns list of results for each entry. 
--
for POST
{"async_job_id": "dbjid:AACRVLHU9sKoS1_d9gfifc4vWNYqePsXAlk7UMv8fTfjLJu8oFvqcRgqrTte_BbCfGUL-MgO02RfJPWovkPu9RNE}
--
PollArg
Arguments for methods that poll the status of an asynchronous job. This datatype comes from an imported namespace originally defined in the async namespace.
async_job_id String(min_length=1) Id of the asynchronous job. This is the value of a response returned from the method that launched the job.
--
Returns
RelocationBatchJobStatus (union)
The value will be one of the following datatypes:
in_progress Void The asynchronous job is still in progress.
complete RelocationBatchResult The copy or move batch job has finished.
failed RelocationBatchError The copy or move batch job has failed with exception.
*/

function db2_move_batch_check pAccessToken,pAsyncJobId
   local tHeader,tPost,tUrl
   put db2_move_batch_check_HEADER(pAccessToken) into tHeader
   put db2_move_batch_check_POST(pPathFrom,pPathTo) into tPost
   put db2_move_batch_check_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_move_batch_check


/**
db2_move_v2 pAccessToken,pPathFrom,pPathTo,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
--
Description
Move a file or folder to a different location in the user's Dropbox.
If the source path is a folder all its contents will be moved.
--
for POST
{"from_path":"/folder1/testfile1.txt","to_path":"/folder2/testfile11.txt"}
{"from_path":"/folder1","to_path":"/folder1d","allow_shared_folder":false,"autorename":false,"allow_ownership_transfer":false}
--
RelocationArg
#--from_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") 
Path in the user's Dropbox to be copied or moved.
#--to_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") 
Path in the user's Dropbox that is the destination.
#--allow_shared_folder Boolean 
If true, copy will copy contents in shared folder, otherwise RelocationError.cant_copy_shared_folder will be returned if from_path contains shared folder. 
This field is always true for move. The default for this field is False.
#--autorename Boolean
If there's a conflict, have the Dropbox server try to autorename the file to avoid the conflict. The default for this field is False.
#--allow_ownership_transfer Boolean 
Allow moves by owner even if it would result in an ownership transfer for the content being moved. This does not apply to copies. The default for this field is False.
--
Returns
Metadata (datatype with subtypes)
Metadata for a file or folder. This datatype will be one of the following subtypes:
file FileMetadata
folder FolderMetadata
deleted DeletedMetadata
*/

function db2_move_v2 pAccessToken,pPathFrom,pPathTo,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
   local tHeader,tPost,tUrl
   put db2_move_v2_HEADER(pAccessToken) into tHeader
   put db2_move_v2_POST(pPathFrom,pPathTo,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer) into tPost
   put db2_move_v2_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_move_v2

/**
db2_permanently_delete pAccessToken,pPath
--
Description
Permanently delete the file or folder at a given path (see https://www.dropbox.com/en/help/40).
Note: This endpoint is only available for Dropbox Business apps.
--
for POST
{"path": "/folder2/testfile1.txt"}
{"path": "/MySharedFolder2"}
--
DeleteArg
#--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox to delete.
--
Returns
No return values. 
*/

function db2_permanently_delete pAccessToken,pPath
   local tHeader,tPost,tUrl
   put db2_permanently_delete_HEADER(pAccessToken) into tHeader
   put db2_permanently_delete_POST(pPath) into tPost
   put db2_permanently_delete_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_permanently_delete

/**
db2_restore pAccessToken,pPath,pRevision
--
Description
Restore a file to a specific revision.
--
{"path":"/folder3/testfile1.txt","rev":"f04ac9fd89"}
--
RestoreArg
#--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)") 
The path to the file you want to restore. 
#--rev String(min_length=9, pattern="[0-9a-f]+")? 
The revision to restore for the file.
--
Returns
FileMetadata
*/

function db2_restore pAccessToken,pPath,pRevision
   local tHeader,tPost,tUrl
   put db2_restore_HEADER(pAccessToken) into tHeader
   put db2_restore_POST(pPath,pRevision) into tPost
   put db2_restore_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_restore

/**
db2_save_url pAccessToken,pPath,pUrlToSave
--
Description
Save a specified URL into a file in user's Dropbox. 
If the given path already exists, the file will be renamed to avoid the conflict (e.g. myfile (1).txt).    
--
for POST
{"path": "/folder3/testfile2.txt","url": "https://wordpress.org/plugins/about/readme.txt"}
{"path": "/folder3/testfile3.xlsx","url": "http://www.exinfm.com/excel files/What-If Analysis Template.xls"}
--
SaveUrlArg
#--path String(pattern="/(.|[\r\n])*") 
The path in Dropbox where the URL will be saved to. 
#--url String 
The URL to be saved.
--
Returns
SaveUrlResult (union)
The value will be one of the following datatypes:
async_job_id String(min_length=1) This response indicates that the processing is asynchronous. The string is an id that can be used to obtain the status of the asynchronous job.
complete FileMetadata Metadata of the file where the URL is saved to.
*/

function db2_save_url pAccessToken,pPath,pUrlToSave
 local tHeader,tPost,tUrl
   put db2_save_url_HEADER(pAccessToken) into tHeader
   put db2_save_url_POST(pPath,pUrlToSave) into tPost
   put db2_save_url_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_save_url

/**
db2_save_url_check_job_status pAccessToken,pAsyncJobId
--
Description
Check the status of a save_url job. 
--
for POST
{"async_job_id":"562VTx1rtSMAAAAAAAACjw"}
--
PollArg
Arguments for methods that poll the status of an asynchronous job. 
This datatype comes from an imported namespace originally defined in the async namespace.
#--async_job_id String(min_length=1) 
Id of the asynchronous job. This is the value of a response returned from the method that launched the job.
--
Returns
*/

function db2_save_url_check_job_status pAccessToken,pAsyncJobId
   local tHeader,tPost,tUrl
   put db2_save_url_check_job_status_HEADER(pAccessToken) into tHeader
   put db2_save_url_check_job_status_POST(pAsyncJobId) into tPost
   put db2_save_url_check_job_status_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_save_url_check_job_status

/**
db2_search pAccessToken,pPath,pQuery,pStart,pMaxResults,pMode
Description
Searches for files and folders.
Note: Recent changes may not immediately be reflected in search results due to a short delay in indexing.
Note that searching file content is only available for Dropbox Business accounts.
--
for POST
{"path": "/apps/MyApp","query": "mytext","start": 0,"max_results": 100,"mode": "filename"}
--
SearchArg
#--path String(pattern="(/(.|[\r\n])*)?|id:.*|(ns:[0-9]+(/.*)?)") 
The path in the user's Dropbox to search. Should probably be a folder.
#--query String 
The string to search for. The search string is split on spaces into multiple tokens. 
For file name searching, the last token is used for prefix matching (i.e. "bat c" matches "bat cave" but not "batman car").
#--start UInt64 
The starting index within the search results (used for paging). The default for this field is 0.
#--max_results UInt64 
The maximum number of search results to return. The default for this field is 100.
#--mode SearchMode 
The search mode (filename, filename_and_content, or deleted_filename). 
Note that searching file content is only available for Dropbox Business accounts. The default for this union is filename.
SearchMode (union)
The value will be one of the following datatypes:
#--#--filename Void Search file and folder names.
#--#--filename_and_content Void Search file and folder names as well as file contents.
#--#--deleted_filename Void Search for deleted file and folder names.
--
Returns
matches List of (SearchMatch) A list (possibly empty) of matches for the query.
SearchMatch
match_type SearchMatchType The type of the match.
SearchMatchType (union)
Indicates what type of match was found for a given item. The value will be one of the following datatypes:
filename Void This item was matched on its file or folder name.
content Void This item was matched based on its file contents.
both Void This item was matched based on both its contents and its file name.
metadata Metadata The metadata for the matched file or folder.
more Boolean Used for paging. If true, indicates there is another page of results available that can be fetched by calling search again.
start UInt64 Used for paging. Value to set the start argument to when calling search to fetch the next page of results.
*/

function db2_search pAccessToken,pPath,pQuery,pStart,pMaxResults,pMode
  local tHeader,tPost,tUrl
   put db2_search_HEADER(pAccessToken) into tHeader
   put db2_search_POST(pPath,pQuery,pStart,pMaxResults,pMode) into tPost
   put db2_search_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_search

/**
db2_upload pAccessToken,pPath,pData,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray
--
Description
Create a new file with the contents provided in the request.
Do not use this to upload a file larger than 150 MB. Instead, create an upload session with upload_session/start. 
--
if mode is update also need string for the rev value for the file    "mode": {".tag": "update", "update": "a1c10ce0dd78" }
pass Mode as 2 line string if update eg: update & cr & a1c10ce0dd78
--
pPropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pPropertyGroupsArray[1][fields][1][name]=	Name
pPropertyGroupsArray[1][fields][1][value]=	me
--
for header
Dropbox-API-Arg: {"path":"/folder3/testfile1.txt","mode":"overwrite","autorename":false,"mute":true}
Dropbox-API-Arg: {"path":"/folder3/testfile1.txt","mode":"overwrite","autorename":false, \
      "client_modified": "2017-12-24T20:58:03Z","mute":false,"property_groups": [{"template_id": "ptid:562VTx1rtSMAAAAAAAACaA", \
      "fields": [{"name": "name","value": "gmc"},{"name": "age","value": "21"},{"name": "gender","value": "M"}]}]}
--
CommitInfo
#--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") 
Path in the user's Dropbox to save the file.
#--mode WriteMode 
Selects what to do if the file already exists. The default for this union is add.
WriteMode (union)
Your intent when writing a file to some path. This is used to determine what constitutes a conflict and what the autorename strategy is.
In some situations, the conflict behavior is identical: (a) If the target path doesn't refer to anything, the file is always written; no conflict. 
(b) If the target path refers to a folder, it's always a conflict. (c) If the target path refers to a file with identical contents, nothing gets written; no conflict.
The conflict checking differs in the case where there's a file at the target path with contents different from the contents you're trying to write. 
The value will be one of the following datatypes:
#--#--add Void Do not overwrite an existing file if there is a conflict. The autorename strategy is to append a number to the file name. 
For example, "document.txt" might become "document (2).txt".
#--#--overwrite Void Always overwrite the existing file. The autorename strategy is the same as it is for add.
#--#--update String(min_length=9, pattern="[0-9a-f]+") Overwrite if the given "rev" matches the existing file's "rev". 
The autorename strategy is to append the string "conflicted copy" to the file name. 
For example, "document.txt" might become "document (conflicted copy).txt" or "document (Panda's conflicted copy).txt".
#--autorename Boolean If there's a conflict, as determined by mode, have the Dropbox server try to autorename the file to avoid conflict. 
The default for this field is False.
#--client_modified Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? The value to store as the client_modified timestamp. 
Dropbox automatically records the time at which the file was written to the Dropbox servers. 
It can also record an additional timestamp, provided by Dropbox desktop clients, mobile clients, 
and API apps of when the file was actually created or modified. This field is optional.
#--mute Boolean Normally, users are made aware of any file modifications in their Dropbox account via notifications in the client software. 
If true, this tells the clients that this modification shouldn't result in a user notification. The default for this field is False.
#--property_groups List of (PropertyGroup)? List of custom properties to add to file. This field is optional.
PropertyGroup
A subset of the property fields described by the corresponding PropertyGroupTemplate. Properties are always added to a Dropbox file as a PropertyGroup. 
The possible key names and value types in this group are defined by the corresponding PropertyGroupTemplate. 
This datatype comes from an imported namespace originally defined in the file_properties namespace.
#--#--template_id String(min_length=1, pattern="(/|ptid:).*") A unique identifier for the associated template.
#--#--fields List of (PropertyField) The actual properties associated with the template. There can be up to 32 property types per template.
PropertyField
Raw key/value data to be associated with a Dropbox file. Property fields are added to Dropbox files as a PropertyGroup. 
This datatype comes from an imported namespace originally defined in the file_properties namespace.
#--#--#--name String Key of the property field associated with a file and template. Keys can be up to 256 bytes.
#--#--#--value String Value of the property field associated with a file and template. Values can be up to 1024 bytes.
--
Returns
FileMetadata
*/

function db2_upload pAccessToken,pPath,pData,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray
   local tHeader,tPost,tUrl
   put db2_upload_HEADER(pAccessToken,pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray) into tHeader
   put db2_upload_POST(pData) into tPost
   put db2_upload_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload

/**
db2_upload_session_append_v2 pAccessToken,pSessionID,pOffset,pClose,pData
--
Description
Append more data to an upload session.
When the parameter close is set, this call will close the session.
A single request should not upload more than 150 MB.
--
for header
Dropbox-API-Arg: {"cursor": {"session_id": "AAAAAAAAApUz1Z-pUXNJqw","offset": 69},"close": false}
--
UploadSessionAppendArg
#--cursor UploadSessionCursor Contains the upload session ID and the offset.
UploadSessionCursor
#--session_id String The upload session ID (returned by upload_session/start).
#--offset UInt64 The amount of data that has been uploaded so far. We use this to make sure upload data isn't lost or duplicated in the event of a network error.
#--close Boolean If true, the current session will be closed, at which point you won't be able to call upload_session/append_v2 anymore with the current session. 
The default for this field is False.
--
Returns
No return values. 
*/

function db2_upload_session_append_v2 pAccessToken,pSessionID,pOffset,pClose,pData
   local tHeader,tPost,tUrl
   put db2_upload_session_append_v2_HEADER(pAccessToken,pSessionID,pOffset,pClose) into tHeader
   put db2_upload_session_append_v2_POST(pData) into tPost
   put db2_upload_session_append_v2_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload_session_append_v2

/**
db2_upload_session_finish pAccessToken,pSessionID,pOffset,pPath,pMode,pAutorename,pMute,pData,pClientModified,pPropertyGroupsArray
--
Description
Finish an upload session and save the uploaded data to the given file path.
A single request should not upload more than 150 MB.
--
pPropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pPropertyGroupsArray[1][fields][1][name]=	Name
pPropertyGroupsArray[1][fields][1][value]=	me
--
if mode is update, also need string for the rev value for the file    "mode": {".tag": "update", "update": "a1c10ce0dd78" }
for update, pass Mode as 2 line string eg: update & cr & a1c10ce0dd78
--
Dropbox-API-Arg: {"cursor":{"session_id":"AAAAAAAAApUz1Z-pUXNJqw","offset":102},"commit":{"path":"/folder3/testfile1.txt", \
      "mode":"overwrite","autorename":false,"mute":false}}
--
{"cursor":{"session_id":"AAAAAAAAApUz1Z-pUXNJqw","offset":102},"commit":{"path":"/folder3/testfile1.txt","mode":"overwrite", \
      "autorename":false,"client_modified": "2017-12-24T20:58:03Z","mute":false,"property_groups": [{"template_id":"ptid:562VTx1rtSMAAAAAAAACaA", \
      "fields": [{"name": "name","value": "gmc"},{"name": "age","value": "21"},{"name": "gender","value": "M"}]}]}}
--
UploadSessionFinishArg
#--cursor UploadSessionCursor 
Contains the upload session ID and the offset.
UploadSessionCursor
#--#--session_id String 
The upload session ID (returned by upload_session/start).
#--#--offset UInt64 
The amount of data that has been uploaded so far. 
We use this to make sure upload data isn't lost or duplicated in the event of a network error.
#--commit CommitInfo 
Contains the path and other optional modifiers for the commit.
CommitInfo
#--#--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox to save the file.
#--#--mode WriteMode Selects what to do if the file already exists. The default for this union is add.
WriteMode (union)
Your intent when writing a file to some path. This is used to determine what constitutes a conflict and what the autorename strategy is.
In some situations, the conflict behavior is identical: 
(a) If the target path doesn't refer to anything, the file is always written; no conflict. 
(b) If the target path refers to a folder, it's always a conflict. 
(c) If the target path refers to a file with identical contents, nothing gets written; no conflict.
The conflict checking differs in the case where there's a file at the target path with contents different from the contents you're trying to write. The value will be one of the following datatypes:
#--#--#--add Void 
Do not overwrite an existing file if there is a conflict. The autorename strategy is to append a number to the file name. For example, "document.txt" might become "document (2).txt".
#--#--#--overwrite Void 
Always overwrite the existing file. The autorename strategy is the same as it is for add.
#--#--#--update String(min_length=9, pattern="[0-9a-f]+") 
Overwrite if the given "rev" matches the existing file's "rev". The autorename strategy is to append the string "conflicted copy" to the file name. 
For example, "document.txt" might become "document (conflicted copy).txt" or "document (Panda's conflicted copy).txt".
#--#--autorename Boolean 
If there's a conflict, as determined by mode, have the Dropbox server try to autorename the file to avoid conflict. The default for this field is False.
#--#--client_modified 
Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? The value to store as the client_modified timestamp. 
Dropbox automatically records the time at which the file was written to the Dropbox servers.
It can also record an additional timestamp, provided by Dropbox desktop clients, mobile clients, 
and API apps of when the file was actually created or modified. This field is optional.
#--#--mute Boolean 
Normally, users are made aware of any file modifications in their Dropbox account via notifications in the client software. 
If true, this tells the clients that this modification shouldn't result in a user notification. The default for this field is False.
#--#--property_groups List of (PropertyGroup)? 
List of custom properties to add to file. This field is optional.
PropertyGroup
A subset of the property fields described by the corresponding PropertyGroupTemplate.
Properties are always added to a Dropbox file as a PropertyGroup. 
The possible key names and value types in this group are defined by the corresponding PropertyGroupTemplate. 
This datatype comes from an imported namespace originally defined in the file_properties namespace.
#--#--#--template_id String(min_length=1, pattern="(/|ptid:).*") 
A unique identifier for the associated template.
#--#--#--fields List of (PropertyField) 
The actual properties associated with the template. There can be up to 32 property types per template.
PropertyField
Raw key/value data to be associated with a Dropbox file. Property fields are added to Dropbox files as a PropertyGroup. This datatype comes from an imported namespace originally defined in the file_properties namespace.
#--#--#--#--name String 
Key of the property field associated with a file and template. Keys can be up to 256 bytes.
#--#--#--#--value String 
Value of the property field associated with a file and template. Values can be up to 1024 bytes.
--
Returns
FileMetadata
*/

function db2_upload_session_finish pAccessToken,pSessionID,pOffset,pPath,pMode,pAutorename,pMute,pData,pClientModified,pPropertyGroupsArray
   local tHeader,tPost,tUrl
   put db2_upload_session_finish_HEADER(pAccessToken,pSessionID,pOffset,pPath,pMode,pAutorename,pMute,pClientModified,pPropertyGroupsArray) into tHeader
   put db2_upload_session_finish_POST(pData) into tPost
   put db2_upload_session_finish_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload_session_finish

/**
db2_upload_session_finish_batch pAccessToken,pEntriesArray
--
#USAGE NOTES: set "close":true either in the session start or in append_v2 to enable finish_batch for each session. 
If using append_v2, the session start needs close set to false so the data can be appended.
The size of the data uploaded must be kept track of so the offset can be set correctly; otherwise finish of finish_batch will not save the file.
--
Description
This route helps you commit many files at once into a user's Dropbox. Use upload_session/start and upload_session/append_v2 to upload file contents. 
We recommend uploading many files in parallel to increase throughput. 
Once the file contents have been uploaded, rather than calling upload_session/finish, use this route to finish all your upload sessions in a single request.
UploadSessionStartArg.close or UploadSessionAppendArg.close needs to be true for the last upload_session/start or upload_session/append_v2 call.
This route will return a job_id immediately and do the async commit job in background. Use upload_session/finish_batch/check to check the job status.
For the same account, this route should be executed serially. That means you should not start the next job before current job finishes. 
We allow up to 1000 entries in a single request. 
--
array of pEntriesArray
{"entries":[{"cursor":{"session_id":"1234faaf0678bcde","offset":123},"commit":{"path":"/folder3/testfile3.txt"}, \
{"cursor":{"session_id":"1234faaf0678bdfg","offset": 343},"commit":{"path":"/folder4/testfile4.txt"}]}
--
{"entries":[{"cursor":{"session_id":"AAAAAAAAApUz1Z-pUXNJqw","offset":102},"commit":{"path":"/folder3/testfile1.txt","mode":"overwrite", \
      "autorename":false,"client_modified": "2017-12-24T20:58:03Z","mute":false,"property_groups": [{"template_id":"ptid:562VTx1rtSMAAAAAAAACaA", \
      "fields": [{"name": "name","value": "gmc"},{"name": "age","value": "21"},{"name": "gender","value": "M"}]}]}}, \
      {"cursor":{"session_id":"AAAAAAAAApUz1Z-pUXNJqX","offset":102},"commit":{"path":"/folder3/testfile2.txt","mode":"overwrite", \
      "autorename":false,"client_modified": "2017-12-24T20:58:03Z","mute":false,"property_groups": [{"template_id":"ptid:562VTx1rtSMAAAAAAAACaA", \
      "fields": [{"name": "name","value": "gmc"},{"name": "age","value": "21"},{"name": "gender","value": "M"}]}]}}]}
--
pEntriesArray[1]session_id
pEntriesArray[1]offset
pEntriesArray[1]path
pEntriesArray[1]mode  --single line; two lines for update
pEntriesArray[1]autorename
pEntriesArray[1]client_modified
pEntriesArray[1]pPropertyGroupsArray
--
pPropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pPropertyGroupsArray[1][fields][1][name]=	Name
pPropertyGroupsArray[1][fields][1][value]=	me
--
if mode is update, also need string for the rev value for the file    "mode": {".tag": "update", "update": "a1c10ce0dd78" }
for update, pass Mode as 2 line string eg: update & cr & a1c10ce0dd78
--
UploadSessionFinishBatchArg
#--entries List of (UploadSessionFinishArg, max_items=1000) 
Commit information for each file in the batch.
UploadSessionFinishArg
#--#--cursor UploadSessionCursor 
Contains the upload session ID and the offset.
UploadSessionCursor
#--#--#--session_id String 
The upload session ID (returned by upload_session/start).
#--#--#--offset UInt64 
The amount of data that has been uploaded so far. We use this to make sure upload data isn't lost or duplicated in the event of a network error.
#--#--commit CommitInfo 
Contains the path and other optional modifiers for the commit.
CommitInfo
#--#--#--path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") 
Path in the user's Dropbox to save the file.
#--#--#--mode WriteMode 
Selects what to do if the file already exists. The default for this union is add.
WriteMode (union)
Your intent when writing a file to some path. This is used to determine what constitutes a conflict and what the autorename strategy is.
In some situations, the conflict behavior is identical: (a) If the target path doesn't refer to anything, the file is always written; no conflict. (b) If the target path refers to a folder, it's always a conflict. (c) If the target path refers to a file with identical contents, nothing gets written; no conflict.
The conflict checking differs in the case where there's a file at the target path with contents different from the contents you're trying to write. The value will be one of the following datatypes:
#--#--#--#--add Void 
Do not overwrite an existing file if there is a conflict. The autorename strategy is to append a number to the file name. For example, "document.txt" might become "document (2).txt".
#--#--#--#--overwrite Void 
Always overwrite the existing file. The autorename strategy is the same as it is for add.
#--#--#--#--update String(min_length=9, pattern="[0-9a-f]+") 
Overwrite if the given "rev" matches the existing file's "rev". The autorename strategy is to append the string "conflicted copy" to the file name. For example, "document.txt" might become "document (conflicted copy).txt" or "document (Panda's conflicted copy).txt".
#--#--#--autorename Boolean 
If there's a conflict, as determined by mode, have the Dropbox server try to autorename the file to avoid conflict. The default for this field is False.
#--#--#--client_modified Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? 
The value to store as the client_modified timestamp. Dropbox automatically records the time at which the file was written to the Dropbox servers. It can also record an additional timestamp, provided by Dropbox desktop clients, mobile clients, and API apps of when the file was actually created or modified. This field is optional.
#--#--#--mute Boolean 
Normally, users are made aware of any file modifications in their Dropbox account via notifications in the client software. If true, this tells the clients that this modification shouldn't result in a user notification. The default for this field is False.
#--#--#--property_groups List of (PropertyGroup)? 
List of custom properties to add to file. This field is optional.
PropertyGroup
A subset of the property fields described by the corresponding PropertyGroupTemplate. Properties are always added to a Dropbox file as a PropertyGroup. The possible key names and value types in this group are defined by the corresponding PropertyGroupTemplate. This datatype comes from an imported namespace originally defined in the file_properties namespace.
#--#--#--#--template_id String(min_length=1, pattern="(/|ptid:).*") 
A unique identifier for the associated template.
#--#--#--#--fields List of (PropertyField) 
The actual properties associated with the template. There can be up to 32 property types per template.
PropertyField
Raw key/value data to be associated with a Dropbox file. Property fields are added to Dropbox files as a PropertyGroup. This datatype comes from an imported namespace originally defined in the file_properties namespace.
#--#--#--#--#--name String 
Key of the property field associated with a file and template. Keys can be up to 256 bytes.
#--#--#--#--#--value String 
Value of the property field associated with a file and template. Values can be up to 1024 bytes.
--
Returns
UploadSessionFinishBatchLaunch (open union)
Result returned by upload_session/finish_batch that may either launch an asynchronous job or complete synchronously. 
The value will be one of the following datatypes. New values may be introduced as our API evolves.
async_job_id String(min_length=1) This response indicates that the processing is asynchronous. 
The string is an id that can be used to obtain the status of the asynchronous job.
complete UploadSessionFinishBatchResult
*/

function db2_upload_session_finish_batch pAccessToken,pEntriesArray
   local tHeader,tPost,tUrl
   put db2_upload_session_finish_HEADER(pAccessToken) into tHeader
   put db2_upload_session_finish_POST(pEntriesArray) into tPost
   put db2_upload_session_finish_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload_session_finish_batch

/**
db2_upload_session_finish_batch_check pAccessToken,pAsyncJobId
--
Description
Returns the status of an asynchronous job for upload_session/finish_batch. If success, it returns list of result for each entry. 
--
for POST
{"async_job_id": "34g93hh34h04y384084"}
--
PollArg
Arguments for methods that poll the status of an asynchronous job. 
This datatype comes from an imported namespace originally defined in the async namespace.
#--async_job_id String(min_length=1) 
Id of the asynchronous job. This is the value of a response returned from the method that launched the job.
--
Returns
UploadSessionFinishBatchJobStatus (union)
The value will be one of the following datatypes:
in_progress Void The asynchronous job is still in progress.
complete UploadSessionFinishBatchResult The upload_session/finish_batch has finished.
UploadSessionFinishBatchResult
entries List of (UploadSessionFinishBatchResultEntry) Commit result for each file in the batch.
UploadSessionFinishBatchResultEntry (union)
The value will be one of the following datatypes:
success FileMetadata
failure UploadSessionFinishError
*/

function db2_upload_session_finish_batch_check pAccessToken,pAsyncJobId
   local tHeader,tPost,tUrl
   put db2_upload_session_finish_HEADER(pAccessToken) into tHeader
   put db2_upload_session_finish_POST(pAsyncJobId) into tPost
   put db2_upload_session_finish_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload_session_finish_batch_check

/**
db2_upload_session_start pAccessToken,pClose,pData
--
#USAGE NOTES: set "close":true either in the session start or in append_v2 to enable finish_batch for each session. 
If using append_v2, the session start needs close set to false so the data can be appended.
The size of the data uploaded must be kept track of so the offset can be set correctly; otherwise finish of finish_batch will not save the file.
--
Description
Upload sessions allow you to upload a single file in one or more requests, for example where the size of the file is greater than 150 MB. 
This call starts a new upload session with the given data. 
You can then use upload_session/append_v2 to add more data and upload_session/finish to save all the data to a file in Dropbox.
A single request should not upload more than 150 MB.
An upload session can be used for a maximum of 48 hours. 
Attempting to use an UploadSessionStartResult.session_id with upload_session/append_v2 or upload_session/finish
more than 48 hours after its creation will return a UploadSessionLookupError.not_found. 
--
for header
Dropbox-API-Arg: {"close":false}
--
UploadSessionStartArgUploadSessionStartArg
#--close Boolean 
If true, the current session will be closed, at which point you won't be able to call upload_session/append_v2 anymore with the current session. 
The default for this field is False.
--
Returns
{"session_id": "1234faaf0678bcde"}
UploadSessionStartResult
session_id String A unique identifier for the upload session. Pass this to upload_session/append_v2 and upload_session/finish.
*/

function db2_upload_session_start pAccessToken,pClose,pData
  local tHeader,tPost,tUrl
   put db2_upload_session_start_HEADER(pAccessToken,pClose) into tHeader
   put db2_upload_session_start_POST(pData) into tPost
   put db2_upload_session_start_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_upload_session_start

-----------------------------------------------------------------------------
------paper------------------------------------------------------
-----------------------------------------------------------------------------

/**
db2_docs_archive pAccessToken,pDocID
--
Description
Marks the given Paper doc as archived.
Note: This action can be performed or undone by anyone with edit permissions to the doc.
--
for POST
{"doc_id": "VWGwn3oEsoA3tIL0QIj2h"}
--
RefPaperDoc
doc_id String The Paper doc ID.
--
Returns
No return values. 
*/

function db2_docs_archive pAccessToken,pDocID
   local tHeader,tPost,tUrl
   put db2_docs_archive_HEADER(pAccessToken) into tHeader
   put db2_docs_archive_POST(pDocID) into tPost
   put db2_docs_archive_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_archive

/**
db2_docs_create pAccessToken,pImportFormat,pParentFolderID,pData
--
Description
Creates a new Paper doc with the provided content.
--
for header
{"import_format": "html","parent_folder_id": "e.gGYT6HSafpMej9bUv306GarglI7GGeAM3yvfZvXHO9u4mV"}
--
PaperDocCreateArgs
#--import_format ImportFormat 
The format of provided data.
ImportFormat (open union)
The import format of the incoming data. The value will be one of the following datatypes. 
New values may be introduced as our API evolves.
#--#--html Void 
The provided data is interpreted as standard HTML.
#--#--markdown Void 
The provided data is interpreted as markdown.
Note: The first line of the provided document will be used as the doc title.
#--#--plain_text Void 
The provided data is interpreted as plain text.
Note: The first line of the provided document will be used as the doc title.
#--parent_folder_id String? 
The Paper folder ID where the Paper document should be created. 
The API user has to have write access to this folder or error is thrown. This field is optional.
--
Returns
PaperDocCreateUpdateResult
doc_id String Doc ID of the newly created doc.
revision Int64 The Paper doc revision. Simply an ever increasing number.
title String The Paper doc title.
*/

function db2_docs_create pAccessToken,pImportFormat,pParentFolderID,pData
  local tHeader,tPost,tUrl
   put db2_docs_create_HEADER(pAccessToken,pImportFormat,pParentFolderID) into tHeader
   put db2_docs_create_POST(pData) into tPost
   put db2_docs_create_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_create

/**
db2_docs_download pAccessToken,pDocID,pExportFormat
--
Description
Exports and downloads Paper doc either as HTML or markdown.
--
for header
{"doc_id": "VWGwn3oEsoA3tIL0QIj2h","export_format": "html"}
{"doc_id": "VWGwn3oEsoA3tIL0QIj2h","export_format": "markdown"}
--
PaperDocExport
#--doc_id String 
The Paper doc ID.
#--export_format ExportFormat
ExportFormat (open union)
The desired export format of the Paper doc. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--html Void The HTML export format.
#--#--markdown Void The markdown export format.
--
Returns
The content of teh export
--
PaperDocExportResult
owner String The Paper doc owner's email address.
title String The Paper doc title.
revision Int64 The Paper doc revision. Simply an ever increasing number.
mime_type String MIME type of the export. This corresponds to ExportFormat specified in the request.
*/

function db2_docs_download pAccessToken,pDocID,pExportFormat
   local tHeader,tPost,tUrl
   put db2_docs_download_HEADER(pAccessToken,pDocID,pExportFormat) into tHeader
   put db2_docs_download_POST() into tPost
   put db2_docs_download_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_download

/**
db2_docs_folder_users_list pAccessToken,pDocID,pLimit
--
Description
Lists the users who are explicitly invited to the Paper folder in  which the Paper doc is contained. 
For private folders all users  (including owner) shared on the folder are listed and for team folders
all non-team users shared on the folder are returned.
--
for POST
{"doc_id": "uaSvRuxvnkFa12PTkBv5q","limit": 100}
--
ListUsersOnFolderArgs
doc_id String 
The Paper doc ID.
limit Int32 
Size limit per batch. 
The maximum number of users that can be retrieved per batch is 1000. Higher value results in invalid arguments error. The default for this field is 1000.
--
Returns
ListUsersOnFolderResponse
invitees List of (InviteeInfo) List of email addresses that are invited on the Paper folder.
InviteeInfo (open union)
Information about the recipient of a shared content invitation. This datatype comes from an imported namespace originally defined in the sharing namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
email String(max_length=255, pattern="^['&A-Za-z0-9._%+-]+@[A-Za-z0-9-][A-Za-z0-9.-]*.[A-Za-z]{2,15}$") E-mail address of invited user.
users List of (UserInfo) List of users that are invited on the Paper folder.
UserInfo
Basic information about a user. Use users.get_account and users.get_account_batch to obtain more detailed information. This datatype comes from an imported namespace originally defined in the sharing namespace.
account_id String(min_length=40, max_length=40) The account ID of the user.
same_team Boolean If the user is in the same team as current user.
team_member_id String? The team member ID of the shared folder member. Only present if same_team is true. This field is optional.
cursor Cursor Pass the cursor into docs/folder_users/list/continue to paginate through all users. The cursor preserves all properties as specified in the original call to docs/folder_users/list.
Cursor
value String The actual cursor value.
expiration Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time of value.
Some cursors might have expiration time assigned. This is a UTC value after which the cursor is no longer valid and the API starts returning an error. If cursor expires a new one needs to be obtained and pagination needs to be restarted. Some cursors might be short-lived some cursors might be long-lived.
This really depends on the sorting type and order, e.g.:
1. on one hand, listing docs created by the user, sorted by the created time ascending will have undefinite expiration because the results cannot change while the iteration is happening. This cursor would be suitable for long term polling.
2. on the other hand, listing docs sorted by the last modified time will have a very short expiration as docs do get modified very often and the modified time can be changed while the iteration is happening thus altering the results. This field is optional.
has_more Boolean Will be set to True if a subsequent call with the provided cursor to docs/folder_users/list/continue returns immediately with some results. If set to False please allow some delay before making another call to docs/folder_users/list/continue.
*/

function db2_docs_folder_users_list pAccessToken,pDocID,pLimit
   local tHeader,tPost,tUrl
   put db2_docs_folder_users_list_HEADER(pAccessToken) into tHeader
   put db2_docs_folder_users_list_POST(pDocID,pLimit) into tPost
   put db2_docs_folder_users_list_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_folder_users_list

/**
db2_docs_folder_users_list_continue pAccessToken,pDocID,pCursor
--
Description
Once a cursor has been retrieved from docs/folder_users/list, use this to paginate through all users on the Paper folder. 
--
for POST
{"doc_id": "uaSvRuxvnkFa12PTkBv5q","cursor": "U60b6BxT43ySd5sAVQbbIvoteSnWLjUdLU7aR25hbt3ySd5sAVQbbIvoteSnWLjUd"}
--
ListUsersOnFolderContinueArgs
#--doc_id String The Paper doc ID.
#--cursor String The cursor obtained from docs/folder_users/list or docs/folder_users/list/continue. Allows for pagination.
--
Returns
ListUsersOnFolderResponse
invitees List of (InviteeInfo) List of email addresses that are invited on the Paper folder.
InviteeInfo (open union)
Information about the recipient of a shared content invitation. This datatype comes from an imported namespace originally defined in the sharing namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
email String(max_length=255, pattern="^['&A-Za-z0-9._%+-]+@[A-Za-z0-9-][A-Za-z0-9.-]*.[A-Za-z]{2,15}$") E-mail address of invited user.
users List of (UserInfo) List of users that are invited on the Paper folder.
UserInfo
Basic information about a user. Use users.get_account and users.get_account_batch to obtain more detailed information. This datatype comes from an imported namespace originally defined in the sharing namespace.
account_id String(min_length=40, max_length=40) The account ID of the user.
same_team Boolean If the user is in the same team as current user.
team_member_id String? The team member ID of the shared folder member. Only present if same_team is true. This field is optional.
cursor Cursor Pass the cursor into docs/folder_users/list/continue to paginate through all users. The cursor preserves all properties as specified in the original call to docs/folder_users/list.
Cursor
value String The actual cursor value.
expiration Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time of value.
Some cursors might have expiration time assigned. This is a UTC value after which the cursor is no longer valid and the API starts returning an error. If cursor expires a new one needs to be obtained and pagination needs to be restarted. Some cursors might be short-lived some cursors might be long-lived.
This really depends on the sorting type and order, e.g.:
1. on one hand, listing docs created by the user, sorted by the created time ascending will have undefinite expiration because the results cannot change while the iteration is happening. This cursor would be suitable for long term polling.
2. on the other hand, listing docs sorted by the last modified time will have a very short expiration as docs do get modified very often and the modified time can be changed while the iteration is happening thus altering the results. This field is optional.
has_more Boolean Will be set to True if a subsequent call with the provided cursor to docs/folder_users/list/continue returns immediately with some results. If set to False please allow some delay before making another call to docs/folder_users/list/continue.
*/

function db2_docs_folder_users_list_continue pAccessToken,pDocID,pCursor
   local tHeader,tPost,tUrl
   put db2_docs_folder_users_list_continue_HEADER(pAccessToken) into tHeader
   put db2_docs_folder_users_list_continue_POST(pDocID,pCursor) into tPost
   put db2_docs_folder_users_list_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_folder_users_list_continue

/**
db2_docs_get_folder_info pAccessToken,pDocID
--
Description
Retrieves folder information for the given Paper doc. This includes:
- folder sharing policy; permissions for subfolders are set by the top-level folder.
- full 'filepath', i.e. the list of folders (both folderId and  folderName) from the root folder to the folder directly containing the  Paper doc.
Note: If the Paper doc is not in any folder (aka unfiled) the response will be empty.
--
for POST
{"doc_id": "VWGwn3oEsoA3tIL0QIj2h"}
--
RefPaperDoc
#--doc_id String 
The Paper doc ID.
--
Returns
FoldersContainingPaperDoc
Metadata about Paper folders containing the specififed Paper doc.
folder_sharing_policy_type FolderSharingPolicyType? The sharing policy of the folder containing the Paper doc. This field is optional.
FolderSharingPolicyType (union)
The sharing policy of a Paper folder.
Note: The sharing policy of subfolders is inherited from the root folder. The value will be one of the following datatypes:
team Void Everyone in your team and anyone directly invited can access this folder.
invite_only Void Only people directly invited can access this folder.
folders List of (Folder)? The folder path. If present the first folder is the root folder. This field is optional.
*/

function db2_docs_get_folder_info pAccessToken,pDocID
  local tHeader,tPost,tUrl
   put db2_docs_get_folder_info_HEADER(pAccessToken) into tHeader
   put db2_docs_get_folder_info_POST(pDocID) into tPost
   put db2_docs_get_folder_info_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_get_folder_info

/**
db2_docs_list pAccessToken,pFilterBy,pSortBy,pSortOrder,pLimit
--
Description
Return the list of all Paper docs according to the argument specifications. 
To iterate over through the full pagination, pass the cursor to docs/list/continue. 
--
for POST
{"filter_by": "docs_created","sort_by": "modified","sort_order": "descending","limit": 100}
--
ListPaperDocsArgs
#--filter_by ListPaperDocsFilterBy Allows user to specify how the Paper docs should be filtered. The default for this union is docs_accessed.
ListPaperDocsFilterBy (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--docs_accessed Void 
Fetches all Paper doc IDs that the user has ever accessed.
#--#--docs_created Void 
Fetches only the Paper doc IDs that the user has created.
#--sort_by ListPaperDocsSortBy 
Allows user to specify how the Paper docs should be sorted. The default for this union is accessed.
ListPaperDocsSortBy (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--accessed Void 
Sorts the Paper docs by the time they were last accessed.
#--#--modified Void 
Sorts the Paper docs by the time they were last modified.
#--#--created Void 
Sorts the Paper docs by the creation time.
#--sort_order ListPaperDocsSortOrder 
Allows user to specify the sort order of the result. The default for this union is ascending.
ListPaperDocsSortOrder (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--ascending Void 
Sorts the search result in ascending order.
#--#--descending Void 
Sorts the search result in descending order.
#--limit Int32 
Size limit per batch. The maximum number of docs that can be retrieved per batch is 1000. 
Higher value results in invalid arguments error. The default for this field is 1000.
--
Returns
ListPaperDocsResponse
doc_ids List of (String) The list of Paper doc IDs that can be used to access the given Paper docs or supplied to other API methods. The list is sorted in the order specified by the initial call to docs/list.
cursor Cursor Pass the cursor into docs/list/continue to paginate through all files. The cursor preserves all properties as specified in the original call to docs/list.
Cursor
value String The actual cursor value.
expiration Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time of value.
Some cursors might have expiration time assigned. This is a UTC value after which the cursor is no longer valid and the API starts returning an error. If cursor expires a new one needs to be obtained and pagination needs to be restarted. Some cursors might be short-lived some cursors might be long-lived.
This really depends on the sorting type and order, e.g.:
1. on one hand, listing docs created by the user, sorted by the created time ascending will have undefinite expiration because the results cannot change while the iteration is happening. This cursor would be suitable for long term polling.
2. on the other hand, listing docs sorted by the last modified time will have a very short expiration as docs do get modified very often and the modified time can be changed while the iteration is happening thus altering the results. This field is optional.
has_more Boolean Will be set to True if a subsequent call with the provided cursor to docs/list/continue returns immediately with some results. If set to False please allow some delay before making another call to docs/list/continue.
*/

function db2_docs_list pAccessToken,pFilterBy,pSortBy,pSortOrder,pLimit
  local tHeader,tPost,tUrl
   put db2_docs_list_HEADER(pAccessToken) into tHeader
   put db2_docs_list_POST(pFilterBy,pSortBy,pSortOrder,pLimit) into tPost
   put db2_docs_list_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_list

/**
db2_docs_list_continue pAccessToken,pCursor
--
Description
Once a cursor has been retrieved from docs/list, use this to paginate through all Paper doc. 
--
for POST
{"cursor": "U60b6BxT43ySd5sAVQbbIvoteSnWLjUdLU7aR25hbt3ySd5sAVQbbIvoteSnWLjUd"}
--
ListPaperDocsContinueArgs
cursor String 
The cursor obtained from docs/list or docs/list/continue. Allows for pagination.
--
Returns
ListPaperDocsResponse
doc_ids List of (String) The list of Paper doc IDs that can be used to access the given Paper docs or supplied to other API methods. The list is sorted in the order specified by the initial call to docs/list.
cursor Cursor Pass the cursor into docs/list/continue to paginate through all files. The cursor preserves all properties as specified in the original call to docs/list.
Cursor
value String The actual cursor value.
expiration Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time of value.
Some cursors might have expiration time assigned. This is a UTC value after which the cursor is no longer valid and the API starts returning an error. If cursor expires a new one needs to be obtained and pagination needs to be restarted. Some cursors might be short-lived some cursors might be long-lived.
This really depends on the sorting type and order, e.g.:
1. on one hand, listing docs created by the user, sorted by the created time ascending will have undefinite expiration because the results cannot change while the iteration is happening. This cursor would be suitable for long term polling.
2. on the other hand, listing docs sorted by the last modified time will have a very short expiration as docs do get modified very often and the modified time can be changed while the iteration is happening thus altering the results. This field is optional.
has_more Boolean Will be set to True if a subsequent call with the provided cursor to docs/list/continue returns immediately with some results. If set to False please allow some delay before making another call to docs/list/continue.
*/

function db2_docs_list_continue pAccessToken,pCursor
  local tHeader,tPost,tUrl
   put db2_docs_list_continue_HEADER(pAccessToken) into tHeader
   put db2_docs_list_continue_POST(pCursor) into tPost
   put db2_docs_list_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_list_continue

/**
db2_docs_permanently_delete pAccessToken,pDocID
--
Description
Permanently deletes the given Paper doc. This operation is final as the doc cannot be recovered.
Note: This action can be performed only by the doc owner. 
--
for POST
{"doc_id": "VWGwn3oEsoA3tIL0QIj2h"}
--
RefPaperDoc
#--doc_id String 
The Paper doc ID.
--
Returns
No return values.
*/

function db2_docs_permanently_delete pAccessToken,pDocID
  local tHeader,tPost,tUrl
   put db2_docs_permanently_delete_HEADER(pAccessToken) into tHeader
   put db2_docs_permanently_delete_POST(pDocID) into tPost
   put db2_docs_permanently_delete_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_permanently_delete

/**
db2_docs_sharing_policy_get pAccessToken
--
Description
Gets the default sharing policy for the given Paper doc.
--
for POST
{"doc_id": "VWGwn3oEsoA3tIL0QIj2h"}
--
RefPaperDoc
doc_id String 
The Paper doc ID.
--
Returns
SharingPolicy
Sharing policy of Paper doc.
public_sharing_policy SharingPublicPolicyType? This value applies to the non-team members. This field is optional.
SharingPublicPolicyType (union)
The value will be one of the following datatypes:
people_with_link_can_edit Void Users who have a link to this doc can edit it.
people_with_link_can_view_and_comment Void Users who have a link to this doc can view and comment on it.
invite_only Void Users must be explicitly invited to this doc.
disabled Void Value used to indicate that doc sharing is enabled only within team.
team_sharing_policy SharingTeamPolicyType? This value applies to the team members only. The value is null for all personal accounts. This field is optional.
SharingTeamPolicyType (union)
The sharing policy type of the Paper doc. The value will be one of the following datatypes:
people_with_link_can_edit Void Users who have a link to this doc can edit it.
people_with_link_can_view_and_comment Void Users who have a link to this doc can view and comment on it.
invite_only Void Users must be explicitly invited to this doc.
*/

function db2_docs_sharing_policy_get pAccessToken,pDocID
  local tHeader,tPost,tUrl
   put db2_docs_sharing_policy_get_HEADER(pAccessToken) into tHeader
   put db2_docs_sharing_policy_get_POST(pFilterBy,pSortBy,pSortOrder,pLimit) into tPost
   put db2_docs_sharing_policy_get_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_sharing_policy_get

/**
db2_docs_sharing_policy_set pAccessToken,pDocId,pPublicSharingPolicy
--
Don't inlcude pTeamSharingPolicy
Description
Sets the default sharing policy for the given Paper doc. 
The  default 'team_sharing_policy' can be changed only by teams, omit this field for personal accounts.
Note: 'public_sharing_policy' cannot  be set to the value 'disabled' because this setting can be changed only via the team admin console.
--
for POST
{"doc_id": "uaSvRuxvnkFa12PTkBv5q","sharing_policy": {
"public_sharing_policy": "people_with_link_can_edit"}}
--
--don't include team sharing which would look like:
{"doc_id": "uaSvRuxvnkFa12PTkBv5q","sharing_policy": {
"public_sharing_policy": "people_with_link_can_edit",
"team_sharing_policy": "people_with_link_can_edit"}}
--
PaperDocSharingPolicy
#--doc_id String The Paper doc ID.
#--sharing_policy SharingPolicy The default sharing policy to be set for the Paper doc.
SharingPolicy
Sharing policy of Paper doc.
#--#--public_sharing_policy SharingPublicPolicyType? This value applies to the non-team members. This field is optional.
SharingPublicPolicyType (union)
The value will be one of the following datatypes:
#--#--#--people_with_link_can_edit Void Users who have a link to this doc can edit it.
#--#--#--people_with_link_can_view_and_comment Void Users who have a link to this doc can view and comment on it.
#--#--#--invite_only Void Users must be explicitly invited to this doc.
#--#--#--disabled Void Value used to indicate that doc sharing is enabled only within team.
#--#--team_sharing_policy SharingTeamPolicyType? This value applies to the team members only. The value is null for all personal accounts. This field is optional.
SharingTeamPolicyType (union)
The sharing policy type of the Paper doc. The value will be one of the following datatypes:
#--#--#--people_with_link_can_edit Void Users who have a link to this doc can edit it.
#--#--#--people_with_link_can_view_and_comment Void Users who have a link to this doc can view and comment on it.
#--#--#--invite_only Void Users must be explicitly invited to this doc.
--
Returns
No return values. 
*/

function db2_docs_sharing_policy_set pAccessToken,pDocId,pPublicSharingPolicy
   local tHeader,tPost,tUrl
   put db2_docs_sharing_policy_set_HEADER(pAccessToken) into tHeader
   put db2_docs_sharing_policy_set_POST(pDocId,pPublicSharingPolicy) into tPost
   put db2_docs_sharing_policy_set_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_sharing_policy_set

/**
db2_docs_update pAccessToken,pDocID,pDocUpdatePolicy,pRevision,pImportFormat,pData
--
Description
Updates an existing Paper doc with the provided content. 
--
for POST
{"doc_id": "uaSvRuxvnkFa12PTkBv5q",
"doc_update_policy": "prepend",
"revision": 56556,
"import_format": "plain_text"}
--
PaperDocUpdateArgs
#--doc_id String 
The Paper doc ID.
#--doc_update_policy PaperDocUpdatePolicy 
The policy used for the current update call.
PaperDocUpdatePolicy (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--append Void 
The content will be appended to the doc.
#--#--prepend Void 
The content will be prepended to the doc.
Note: the doc title will not be affected.
#--#--overwrite_all Void 
The document will be overwitten at the head with the provided content.
#--revision Int64 
The latest doc revision. This value must match the head revision or an error code will be returned. This is to prevent colliding writes.
#--import_format ImportFormat 
The format of provided data.
ImportFormat (open union)
The import format of the incoming data. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--html Void The provided data is interpreted as standard HTML.
#--#--markdown Void The provided data is interpreted as markdown.
Note: The first line of the provided document will be used as the doc title.
#--#--plain_text Void The provided data is interpreted as plain text.
Note: The first line of the provided document will be used as the doc title.
--
Returns
PaperDocCreateUpdateResult
doc_id String Doc ID of the newly created doc.
revision Int64 The Paper doc revision. Simply an ever increasing number.
title String The Paper doc title.
*/

function db2_docs_update pAccessToken,pDocID,pDocUpdatePolicy,pRevision,pImportFormat,pData
   local tHeader,tPost,tUrl
   put db2_docs_update_HEADER(pAccessToken,pDocID,pDocUpdatePolicy,pRevision,pImportFormat) into tHeader
   put db2_docs_update_POST(pData) into tPost
   put db2_docs_update_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_update

/**
db2_docs_users_add pAccessToken
--
Description
Allows an owner or editor to add users to a Paper doc or change their permissions using their email address or Dropbox account ID.
Note: The Doc owner's permissions cannot be changed. 
--
pMemberArray[1][selector]  =email   or   dropbox_id
pMemberArray[1][member]   =me@myemail.com     or   dbid:......
pMemberArray[1][permissionlevel]   =edit   or    view_and_comment
--
for POST
{"doc_id": "Tqc33wHI46s1oo4U1teWx",
"members": [{"member": {".tag": "email","email": "me@myemail.com"},"permission_level": "edit"}],
"custom_message": "Welcome to Paper.","quiet": false}
--
AddPaperDocUser
#--doc_id String 
The Paper doc ID.
#--members List of (AddMember, max_items=20) 
User which should be added to the Paper doc. Specify only email address or Dropbox account ID.
AddMember
#--#--member MemberSelector 
User which should be added to the Paper doc. Specify only email address or Dropbox account ID.
MemberSelector (open union)
Includes different ways to identify a member of a shared folder. 
This datatype comes from an imported namespace originally defined in the sharing namespace. 
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--dropbox_id String(min_length=1) Dropbox account, team member, or group ID of member.
#--email String(max_length=255, pattern="^['&A-Za-z0-9._%+-]+@[A-Za-z0-9-][A-Za-z0-9.-]*.[A-Za-z]{2,15}$") E-mail address of member.
#--permission_level PaperDocPermissionLevel Permission for the user. The default for this union is edit.
PaperDocPermissionLevel (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--edit Void User will be granted edit permissions.
#--view_and_comment Void User will be granted view and comment permissions.
#--custom_message String? A personal message that will be emailed to each successfully added member. This field is optional.
#--quiet Boolean Clients should set this to true if no email message shall be sent to added users. The default for this field is False.
--
Returns
This route returns a list. This means the route can accept a homogenous list of the following types:
AddPaperDocUserMemberResult
Per-member result for docs/users/add.
member MemberSelector One of specified input members.
MemberSelector (open union)
Includes different ways to identify a member of a shared folder. This datatype comes from an imported namespace originally defined in the sharing namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
dropbox_id String(min_length=1) Dropbox account, team member, or group ID of member.
email String(max_length=255, pattern="^['&A-Za-z0-9._%+-]+@[A-Za-z0-9-][A-Za-z0-9.-]*.[A-Za-z]{2,15}$") E-mail address of member.
result AddPaperDocUserResult The outcome of the action on this member.
AddPaperDocUserResult (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
success Void User was successfully added to the Paper doc.
unknown_error Void Something unexpected happened when trying to add the user to the Paper doc.
sharing_outside_team_disabled Void The Paper doc can be shared only with team members.
daily_limit_reached Void The daily limit of how many users can be added to the Paper doc was reached.
user_is_owner Void Owner's permissions cannot be changed.
failed_user_data_retrieval Void User data could not be retrieved. Clients should retry.
permission_already_granted Void This user already has the correct permission to the Paper doc.
*/

function db2_docs_users_add pAccessToken,pDocID,pMemberArray,pCustomMessage,pQuiet
   local tHeader,tPost,tUrl
   put db2_docs_users_add_HEADER(pAccessToken) into tHeader
   put db2_docs_users_add_POST(pDocID,pMemberArray,pCustomMessage,pQuiet) into tPost
   put db2_docs_users_add_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_users_add

/**
db2_docs_users_list pAccessToken,pDocId,pLimit,pFilterBy
--
Description
Lists all users who visited the Paper doc or users with explicit access. This call excludes users who have been removed. 
The list is sorted by the date of the visit or the share date.
The list will include both users, the explicitly shared ones as well as those who came in using the Paper url link.
--
for POST
{"doc_id": "Tqc33wHI46s1oo4U1teWx","limit": 100,"filter_by": "shared"}
--
ListUsersOnPaperDocArgs
#--doc_id String 
The Paper doc ID.
#--limit Int32 
Size limit per batch. The maximum number of users that can be retrieved per batch is 1000. Higher value results in invalid arguments error. The default for this field is 1000.
#--filter_by UserOnPaperDocFilter 
Specify this attribute if you want to obtain users that have already accessed the Paper doc. The default for this union is shared.
UserOnPaperDocFilter (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--#--visited Void 
All users who have visited the Paper doc.
#--#--shared Void 
All uses who are shared on the Paper doc. This includes all users who have visited the Paper doc as well as those who have not.
--
Returns
ListUsersOnPaperDocResponse
invitees List of (InviteeInfoWithPermissionLevel) List of email addresses with their respective permission levels that are invited on the Paper doc.
InviteeInfoWithPermissionLevel
invitee InviteeInfo Email address invited to the Paper doc.
InviteeInfo (open union)
Information about the recipient of a shared content invitation. This datatype comes from an imported namespace originally defined in the sharing namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
email String(max_length=255, pattern="^['&A-Za-z0-9._%+-]+@[A-Za-z0-9-][A-Za-z0-9.-]*.[A-Za-z]{2,15}$") E-mail address of invited user.
permission_level PaperDocPermissionLevel Permission level for the invitee.
PaperDocPermissionLevel (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
edit Void User will be granted edit permissions.
view_and_comment Void User will be granted view and comment permissions.
users List of (UserInfoWithPermissionLevel) List of users with their respective permission levels that are invited on the Paper folder.
UserInfoWithPermissionLevel
user UserInfo User shared on the Paper doc.
UserInfo
Basic information about a user. Use users.get_account and users.get_account_batch to obtain more detailed information. This datatype comes from an imported namespace originally defined in the sharing namespace.
account_id String(min_length=40, max_length=40) The account ID of the user.
same_team Boolean If the user is in the same team as current user.
team_member_id String? The team member ID of the shared folder member. Only present if same_team is true. This field is optional.
permission_level PaperDocPermissionLevel Permission level for the user.
PaperDocPermissionLevel (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
edit Void User will be granted edit permissions.
view_and_comment Void User will be granted view and comment permissions.
doc_owner UserInfo The Paper doc owner. This field is populated on every single response.
UserInfo
Basic information about a user. Use users.get_account and users.get_account_batch to obtain more detailed information. This datatype comes from an imported namespace originally defined in the sharing namespace.
account_id String(min_length=40, max_length=40) The account ID of the user.
same_team Boolean If the user is in the same team as current user.
team_member_id String? The team member ID of the shared folder member. Only present if same_team is true. This field is optional.
cursor Cursor Pass the cursor into docs/users/list/continue to paginate through all users. The cursor preserves all properties as specified in the original call to docs/users/list.
Cursor
value String The actual cursor value.
expiration Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time of value.
Some cursors might have expiration time assigned. This is a UTC value after which the cursor is no longer valid and the API starts returning an error. If cursor expires a new one needs to be obtained and pagination needs to be restarted. Some cursors might be short-lived some cursors might be long-lived.
This really depends on the sorting type and order, e.g.:
1. on one hand, listing docs created by the user, sorted by the created time ascending will have undefinite expiration because the results cannot change while the iteration is happening. This cursor would be suitable for long term polling.
2. on the other hand, listing docs sorted by the last modified time will have a very short expiration as docs do get modified very often and the modified time can be changed while the iteration is happening thus altering the results. This field is optional.
has_more Boolean Will be set to True if a subsequent call with the provided cursor to docs/users/list/continue returns immediately with some results. If set to False please allow some delay before making another call to docs/users/list/continue.
*/

function db2_docs_users_list pAccessToken,pDocId,pLimit,pFilterBy
   local tHeader,tPost,tUrl
   put db2_docs_users_list_HEADER(pAccessToken) into tHeader
   put db2_docs_users_list_POST(pDocId,pLimit,pFilterBy) into tPost
   put db2_docs_users_list_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_users_list

/**
db2_docs_users_list_continue pAccessToken,pDocID,pCursor
--
Description
Once a cursor has been retrieved from docs/users/list, use this to paginate through all users on the Paper doc. 
--
for POST
{"doc_id": "Tqc33wHI46s1oo4U1teWx","cursor": "AA6u4s/z3kMjcSUkEOQYPQoTSJZ/Atq1ZPk1Psfkyra1ppVljDbHXGxbXh8Q5pMvrBi4TUCMDTDo0E31gY0+nGbN+FALDW35fm1pGcHcqmQrym9GcLG6wrpiY8nfcbR3gGIe05EfCoZKNHAhk4G2RwWuKR7aKp6GsKVNsv17oVfnV/N0pg0MzrWwOr5O2KWDEF5SWHlqwBdxG2fUeHzmdXYjkjVyph+h0byKKYEdFg12FiCreAq3VMVIV4ZFp3bhpxi3Ozy6+gwimNZll79ovEDAJdD2uCVKYwTUQvaDYmwlFQ=="}
--
ListUsersOnPaperDocContinueArgs
#--doc_id String The Paper doc ID.
#--cursor String The cursor obtained from docs/users/list or docs/users/list/continue. Allows for pagination.
--
Returns
ListUsersOnPaperDocResponse
invitees List of (InviteeInfoWithPermissionLevel) List of email addresses with their respective permission levels that are invited on the Paper doc.
InviteeInfoWithPermissionLevel
invitee InviteeInfo Email address invited to the Paper doc.
InviteeInfo (open union)
Information about the recipient of a shared content invitation. This datatype comes from an imported namespace originally defined in the sharing namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
email String(max_length=255, pattern="^['&A-Za-z0-9._%+-]+@[A-Za-z0-9-][A-Za-z0-9.-]*.[A-Za-z]{2,15}$") E-mail address of invited user.
permission_level PaperDocPermissionLevel Permission level for the invitee.
PaperDocPermissionLevel (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
edit Void User will be granted edit permissions.
view_and_comment Void User will be granted view and comment permissions.
users List of (UserInfoWithPermissionLevel) List of users with their respective permission levels that are invited on the Paper folder.
UserInfoWithPermissionLevel
user UserInfo User shared on the Paper doc.
UserInfo
Basic information about a user. Use users.get_account and users.get_account_batch to obtain more detailed information. This datatype comes from an imported namespace originally defined in the sharing namespace.
account_id String(min_length=40, max_length=40) The account ID of the user.
same_team Boolean If the user is in the same team as current user.
team_member_id String? The team member ID of the shared folder member. Only present if same_team is true. This field is optional.
permission_level PaperDocPermissionLevel Permission level for the user.
PaperDocPermissionLevel (open union)
The value will be one of the following datatypes. New values may be introduced as our API evolves.
edit Void User will be granted edit permissions.
view_and_comment Void User will be granted view and comment permissions.
doc_owner UserInfo The Paper doc owner. This field is populated on every single response.
UserInfo
Basic information about a user. Use users.get_account and users.get_account_batch to obtain more detailed information. This datatype comes from an imported namespace originally defined in the sharing namespace.
account_id String(min_length=40, max_length=40) The account ID of the user.
same_team Boolean If the user is in the same team as current user.
team_member_id String? The team member ID of the shared folder member. Only present if same_team is true. This field is optional.
cursor Cursor Pass the cursor into docs/users/list/continue to paginate through all users. The cursor preserves all properties as specified in the original call to docs/users/list.
Cursor
value String The actual cursor value.
expiration Timestamp(format="%Y-%m-%dT%H:%M:%SZ")? Expiration time of value.
Some cursors might have expiration time assigned. This is a UTC value after which the cursor is no longer valid and the API starts returning an error. If cursor expires a new one needs to be obtained and pagination needs to be restarted. Some cursors might be short-lived some cursors might be long-lived.
This really depends on the sorting type and order, e.g.:
1. on one hand, listing docs created by the user, sorted by the created time ascending will have undefinite expiration because the results cannot change while the iteration is happening. This cursor would be suitable for long term polling.
2. on the other hand, listing docs sorted by the last modified time will have a very short expiration as docs do get modified very often and the modified time can be changed while the iteration is happening thus altering the results. This field is optional.
has_more Boolean Will be set to True if a subsequent call with the provided cursor to docs/users/list/continue returns immediately with some results. If set to False please allow some delay before making another call to docs/users/list/continue.
*/

function db2_docs_users_list_continue pAccessToken,pDocID,pCursor
  local tHeader,tPost,tUrl
   put db2_docs_users_list_continue_HEADER(pAccessToken) into tHeader
   put db2_docs_users_list_continue_POST(pDocID,pCursor) into tPost
   put db2_docs_users_list_continue_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_users_list_continue

/**
db2_docs_users_remove pAccessToken,pDocID,pMemberSelector,pMember
--
Description
Allows an owner or editor to remove users from a Paper doc using their email address or Dropbox account ID.
Note: Doc owner cannot be removed.
--
for POST
{"doc_id": "Tqc33wHI46s1oo4U1teWx","member": {".tag": "email","email": "me@myemail.com"}}
--
RemovePaperDocUser
#--doc_id String The Paper doc ID.
#--member MemberSelector User which should be removed from the Paper doc. Specify only email address or Dropbox account ID.
MemberSelector (open union)
Includes different ways to identify a member of a shared folder. This datatype comes from an imported namespace originally defined in the sharing namespace. The value will be one of the following datatypes. New values may be introduced as our API evolves.
#--dropbox_id String(min_length=1) Dropbox account, team member, or group ID of member.
#--email String(max_length=255, pattern="^['&A-Za-z0-9._%+-]+@[A-Za-z0-9-][A-Za-z0-9.-]*.[A-Za-z]{2,15}$") E-mail address of member.
--
Returns
No return values. 
*/

function db2_docs_users_remove pAccessToken,pDocID,pMemberSelector,pMember
  local tHeader,tPost,tUrl
   put db2_docs_users_remove_HEADER(pAccessToken) into tHeader
   put db2_docs_users_remove_POST(pDocID,pMemberSelector,pMember) into tPost
   put db2_docs_users_remove_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
end db2_docs_users_remove

-----------------------------------------------------------------------------
-----------sharing---------------------------------------------------------
-----------------------------------------------------------------------------

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
   local tHeader,tPost,tUrl
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

function db2_update_file_member pAccessToken,pFile,pMemberArray,pAccessLevel
   /*
   ChangeFileMemberAccessArgs
   Arguments for update_file_member.
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
   local tHeader,tPost,tUrl
   put db2_update_file_member_HEADER(pAccessToken) into tHeader
   put db2_update_file_member_POST(pFile,pMemberArray,pAccessLevel) into tPost
   put db2_update_file_member_URL() into tUrl
   return db2_API2(tHeader,tPost,tUrl)
   /*
   FileMemberActionResult
   Per-member result for remove_file_member_2 or add_file_member or update_file_member.
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
end db2_update_file_member

function db2_check_remove_member_job_status pAccessToken,pPath
   /*
   
   */
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   db2_remove_file_member_2 pAccessToken,pPath
   --
   
   */
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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

function db2_create_shared_link_with_settings pAccessToken,pPath,pSettings
   /*
   
   */
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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

function db2_list_folder_members pAccessToken,pSharedFolderId,pActions,pLimit
   /*
   
   */
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   {"limit": 100,"actions": []}
   --
   ListFoldersArgs
   #--limit UInt32 The maximum number of results to return per request. The default for this field is 1000.
   #--actions List of (FolderAction)? A list of `FolderAction`s corresponding to `FolderPermission`s that should appear in the response's SharedFolderMetadata.permissions field describing the actions the authenticated user can perform on the folder. This field is optional.
   FolderAction (open union)
   Actions that may be taken on shared folders. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--#--change_options Void Change folder options, such as who can be invited to join the folder.
   #--#--disable_viewer_info Void Disable viewer information for this folder.
   #--#--edit_contents Void Change or edit contents of the folder.
   #--#-- enable_viewer_info Void Enable viewer information on the folder.
   #--#--invite_editor Void Invite a user or group to join the folder with read and write permission.
   #--#--invite_viewer Void Invite a user or group to join the folder with read permission.
   #--#--invite_viewer_no_comment Void Invite a user or group to join the folder with read permission but no comment permissions.
   #--#--relinquish_membership Void Relinquish one's own membership in the folder.
   #--#--unmount Void Unmount the folder.
   #--#--unshare Void Stop sharing this folder.
   #--#--leave_a_copy Void Keep a copy of the contents upon leaving or being kicked from the folder.
   #--#--create_link Void Create a shared link for folder.
   */
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   #--cursor String? Present if there are additional shared folders that have not been returned yet. 
   Pass the cursor into the corresponding continue endpoint (either list_folders/continue or list_mountable_folders/continue) to list additional folders. 
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tHeader,tPost,tUrl
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
   local tPostReturn
   global gError
   --global error for checking manually
   set socketTimeoutInterval to 30000  --30 seconds
   put the httpHeaders into oldHTTPHeaders
   --put cr & db2_Header_Close() after pHeader  --gmc july 2016
   set the httpHeaders to pHeader
   put textencode(pPost,"UTF-8") into pPost --gmc july 2016
   post pPost to URL pURL
   put it into tPostReturn
   put the result into gError
   set the httpHeaders to oldHTTPHeaders
   --return tPostReturn
   if gError is empty then
      return tPostReturn for value
   else
      return gError for error
   end if
end db2_API2

function db2_Header_Close
   return "connection: close"
end db2_Header_Close

function fReplaceUserAccountIDInPost pPost
   --used by all eg buttons for each each API call 
   local tUserAccountID
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

/* 
db2_Header_EmptyContent
--
needed for get_thumbnail and get_preview (which dont set a Content Type) to clear standard value in headers
*/

function db2_Header_EmptyContent
   return "Content-Type:"
end db2_Header_EmptyContent

/* 
db2_Header_APIDownload
--
Dropbox-API-Arg: {"path":"/apps/MyApp/seasons.txt"}
path can be a path string, an id or a revision
"path": "/apps/MyApp/seasons.txt"
"path": "id:a4ayc_80_OEAAAAAAAAAYa"
"path": "rev:a1c10ce0dd78"
*/

function db2_Header_APIDownload pPath
   return "Dropbox-API-Arg: " & db2_CB(db2_Q("path") & ": " & db2_Q(pPath))
end db2_Header_APIDownload

/* 
db2_Header_APISessionStart
--
Dropbox-API-Arg: {"close": false}
*/

function db2_Header_APISessionStart pClose
   return "Dropbox-API-Arg: " & db2_CB(db2_Q("close") & ": " & (pClose))
end db2_Header_APISessionStart

/* 
db2_Header_APISessionAppend_v2 pSession,pOffset,pClose
--
Dropbox-API-Arg: {"cursor": {"session_id": "1234faaf0678bcde","offset": 0},"close": false}
*/

function db2_Header_APISessionAppend_v2 pSession,pOffset,pClose
   return "Dropbox-API-Arg: " & db2_CB(db2_Q("cursor") & ": " &  \
         db2_CB(db2_Q("session_id") & ": " & db2_Q(pSession)& "," & db2_Q("offset") & ": " & pOffset) & "," &  \
         db2_Q("close") & ": " & pClose)
end db2_Header_APISessionAppend_v2

/* 
db2_Header_APISessionFinish pSession,pOffset,pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray
--
Dropbox-API-Arg: 
{"cursor":{"session_id":"AAAAAAAAAYSEAI0qRJ7GMg","offset":358},"commit":{"path":"/apps/MyApp/seasons.txt","mode":"add"}}
{"cursor":{"session_id":"AAAAAAAAApUz1Z-pUXNJqw","offset":102},"commit": \
      {"path":"/folder3/testfile1.txt","mode":"overwrite","autorename":false,"client_modified": "2017-12-24T20:58:03Z","mute":false, \
      "property_groups": [{"template_id":"ptid:562VTx1rtSMAAAAAAAACaA", \
      "fields": [{"name": "name","value": "gmc"},{"name": "age","value": "21"},{"name": "gender","value": "M"}]}]}}
--
pPropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pPropertyGroupsArray[1][fields][1][name]=	Name
pPropertyGroupsArray[1][fields][1][value]=	me
--
if mode is update, also need string for the rev value for the file    "mode": {".tag": "update", "update": "a1c10ce0dd78" }
for update, pass Mode as 2 line string eg: update & cr & a1c10ce0dd78
*/

function db2_Header_APISessionFinish pSession,pOffset,pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray
   local tCursorToCommitString
   put db2_Q("cursor") & ": " & db2_CB(db2_Q("session_id") & ": " & db2_Q(pSession) & "," &  \
         db2_Q("offset") & ": " & pOffset) & "," & db2_Q("commit") & ": " into tCursorToCommitString
   return "Dropbox-API-Arg: " & db2_CB(tCursorToCommitString & db2_UploadString(pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray))
end db2_Header_APISessionFinish

function db2_Header_APIUpload pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray
    return "Dropbox-API-Arg: " & db2_UploadString(pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray)
end db2_Header_APIUpload

/* 
db2_UploadString pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray
--
{"path":"/folder3/testfile5.txt","mode":"overwrite","autorename":false,"client_modified": "2016-07-24T20:58:03Z","mute":false}
--
{"path":"/folder3/testfile1.txt","mode":"overwrite","autorename":false,"client_modified": "2017-12-24T20:58:03Z","mute":false, \
      "property_groups": [{"template_id":"ptid:562VTx1rtSMAAAAAAAACaA","fields":  \
      [{"name": "name","value": "gmc"},{"name": "age","value": "21"},{"name": "gender","value": "M"}]}]}
--
pPropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pPropertyGroupsArray[1][fields][1][name]=	SecurityPolicy
--
if mode is update, also need string for the rev value for the file    "mode": {".tag": "update", "update": "a1c10ce0dd78" }
for update, pass Mode as 2 line string eg: update & cr & a1c10ce0dd78
*/

function db2_UploadString pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray
   local tPropertyGroupString,tModeString
   if pMode contains "update" then 
      put db2_Q("mode") & ": " & db2_CB(db2_Q(".tag") & ": " & db2_Q("update") & ", " & db2_Q("update") & ": " & line 2 of pMode) into tModeString
   else
      put db2_Q("mode") & ": " & db2_Q(pMode) into tModeString
   end if
   --
   if pPropertyGroupsArray is not empty then
      put db2_PropertyGroupsString(pPropertyGroupsArray) into tPropertyGroupString
      --
      if pClientModified is empty then
         return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
               tModeString & "," &  \
               db2_Q("autorename") & ": " & pAutorename & "," &  \
               db2_Q("mute") & ": " & pMute & "," &  \
               tPropertyGroupString)
      else
         return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
               tModeString & "," &  \
               db2_Q("autorename") & ": " & pAutorename & "," &  \
               db2_Q("client_modified") & ": " & pClientModified & "," &  \
               db2_Q("mute") & ": " & pMute  & "," &  \
               tPropertyGroupString)
      end if
   else
      if pClientModified is empty then
         return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
               tModeString & "," &  \
               db2_Q("autorename") & ": " & pAutorename & "," &  \
               db2_Q("mute") & ": " & pMute)
      else
         return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
               tModeString & "," &  \
               db2_Q("autorename") & ": " & pAutorename & "," &  \
               db2_Q("client_modified") & ": " & pClientModified & "," &  \
               db2_Q("mute") & ": " & pMute)
      end if
   end if
end db2_UploadString

/* 
db2_Header_APIThumb pPath,pFormat,pSize
--
Dropbox-API-Arg: {"path":"/apps/MyApp/RCsubmitter.jpg","format": "jpeg","size": "w64h64"}
Dropbox-API-Arg: {"path":"/TestFolder/testpic.jpg","format":{".tag":"jpeg"},"size":{".tag":"w64h64"}}
*/

function db2_Header_APIThumb pPath,pFormat,pSize
   return "Dropbox-API-Arg: " & db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
         db2_Q("format") & ": " & db2_Q(pFormat)& "," & db2_Q("size") & ": " & db2_Q(pSize))
end db2_Header_APIThumb

/* 
db2_Header_APIPreview pPath
--
Dropbox-API-Arg: {"path":"/apps/MyApp/seasons.txt"}
*/

function db2_Header_APIPreview pPath
   return "Dropbox-API-Arg: " & db2_CB(db2_Q("path") & ": " & db2_Q(pPath))
end db2_Header_APIPreview

/* 
db2_Header_APISharedLinkFile pUrl,pPath,pLinkPassword
--
Dropbox-API-Arg: {"url": "https://www.dropbox.com/s/2sn712vy1ovegw8/Prime_Numbers.txt?dl=0","path": "/Prime_Numbers.txt"}"
*/

function db2_Header_APISharedLinkFile pUrl,pPath,pLinkPassword
   if pPath is not empty then
      if pLinkPassword is not empty then
         return "Dropbox-API-Arg: " & db2_CB(db2_Q("url") & ": " & db2_Q(pUrl) & "," & db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
         db2_Q("link_password") & ": " & db2_Q(pLinkPassword))
      else
         return "Dropbox-API-Arg: " & db2_CB(db2_Q("url") & ": " & db2_Q(pUrl) & "," & db2_Q("path") & ": " & db2_Q(pPath))
      end if
   else
      return "Dropbox-API-Arg: " & db2_CB(db2_Q("url") & ": " & db2_Q(pUrl))
   end if
end db2_Header_APISharedLinkFile

-----------------------------------------------------------------------------
------------individual headers for all API---------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-------auth--------------------------------------------------------------
-----------------------------------------------------------------------------

function db2_token_revoke_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_token_revoke_HEADER

-----------------------------------------------------------------------------
-------users--------------------------------------------------------------
-----------------------------------------------------------------------------

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

-----------------------------------------------------------------------------
-------file properties--------------------------------------------------------------
-----------------------------------------------------------------------------

function db2_properties_add_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_add_HEADER

function db2_properties_overwrite_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_overwrite_HEADER

function db2_properties_remove_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_remove_HEADER

function db2_properties_search_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_search_HEADER

function db2_properties_search_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_search_continue_HEADER

function db2_properties_update_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_properties_update_HEADER

-----------------------------------------------------------------------------
-------file properties templates--------------------------------------------------------------
-----------------------------------------------------------------------------

function db2_templates_add_for_user_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_templates_add_for_user_HEADER

function db2_templates_get_for_user_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_templates_get_for_user_HEADER

function db2_templates_list_for_user_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_templates_list_for_user_HEADER

function db2_templates_remove_for_user_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_templates_remove_for_user_HEADER

function db2_templates_update_for_user_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_templates_update_for_user_HEADER

-----------------------------------------------------------------------------
---------file requests-------------------------------------------
/* see https://www.dropbox.com/help/files-folders/create-file-request */
-----------------------------------------------------------------------------

function db2_create_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_create_HEADER

function db2_get_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_HEADER

function db2_list_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_list_HEADER

function db2_update_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_update_HEADER

-----------------------------------------------------------------------------
-------files--------------------------------------------------------------
-----------------------------------------------------------------------------

function db2_copy_batch_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_copy_batch_HEADER

function db2_copy_batch_check_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_copy_batch_check_HEADER

function db2_copy_reference_get_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_copy_reference_get_HEADER

function db2_copy_reference_save_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_copy_reference_save_HEADER

function db2_copy_v2_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_copy_v2_HEADER

function db2_create_folder_v2_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_create_folder_v2_HEADER

function db2_delete_batch_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_delete_batch_HEADER

function db2_delete_batch_check_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_delete_batch_check_HEADER

function db2_delete_v2_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_delete_v2_HEADER

function db2_download_HEADER pAccessToken,pPath
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIDownload(pPath)
end db2_download_HEADER

function db2_download_zip_HEADER pAccessToken,pPath
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIDownload(pPath)
end db2_download_zip_HEADER

function db2_get_metadata_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_metadata_HEADER

function db2_get_preview_HEADER pAccessToken,pPath
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIPreview(pPath)
end db2_get_preview_HEADER

function db2_get_temporary_link_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_temporary_link_HEADER

function db2_get_thumbnail_HEADER pAccessToken,pPath,pFormat,pSize
   if pFormat is empty then put "jpeg" into pFormat
   if pSize is empty then put "w64h64" into pSize
   return db2_Header_Auth(pAccessToken) & cr & db2_Header_EmptyContent() & cr & db2_Header_APIThumb(pPath,pFormat,pSize)
end db2_get_thumbnail_HEADER

function db2_get_thumbnail_batch_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_get_thumbnail_batch_HEADER

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

function db2_move_batch_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_move_batch_HEADER

function db2_move_batch_check_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_move_batch_check_HEADER

function db2_move_v2_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_move_v2_HEADER

function db2_permanently_delete_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_permanently_delete_HEADER

function db2_restore_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_restore_HEADER

function db2_save_url_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_save_url_HEADER

function db2_save_url_check_job_status_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_save_url_check_job_status_HEADER

function db2_search_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_search_HEADER

function db2_upload_HEADER pAccessToken,pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray
   if pMode is empty then put "add" into pMode
   if pAutorename is empty then put "false" into pAutorename
   if pMute is empty then put "false" into pMute
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APIUpload(pPath,pMode,pAutorename,pClientModified,pMute,pPropertyGroupsArray)
end db2_upload_HEADER

function db2_upload_session_append_v2_HEADER pAccessToken,pSessionID,pOffset,pClose
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionAppend_v2(pSessionID,pOffset,pClose)
end db2_upload_session_append_v2_HEADER

function db2_upload_session_finish_HEADER pAccessToken,pSessionID,pOffset,pPath,pMode,pAutorename,pMute,pClientModified,pPropertyGroupsArray
   if pMode is empty then put "add" into pMode
   if pAutorename is empty then put "false" into pAutorename
   if pMute is empty then put "false" into pMute
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionFinish(pSessionID,pOffset,pPath,pMode,pAutorename,pMute,pClientModified,pPropertyGroupsArray)
end db2_upload_session_finish_HEADER

function db2_upload_session_finish_batch_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_upload_session_finish_batch_HEADER

function db2_upload_session_finish_batch_check_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_upload_session_finish_batch_check_HEADER

function db2_upload_session_start_HEADER pAccessToken,pClose
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APISessionStart(pClose)
end db2_upload_session_start_HEADER

----------------------------------------------------------------
------paper-----------------------------------------------
----------------------------------------------------------------

function db2_docs_archive_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_archive_HEADER

function db2_docs_create_HEADER pAccessToken,pImportFormat,pParentFolderID
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APIDocsCreate(pImportFormat,pParentFolderID)
end db2_docs_create_HEADER

function db2_Header_APIDocsCreate pImportFormat,pParentFolderID
   if pParentFolderID is empty then 
      return "Dropbox-API-Arg: " & db2_CB(db2_Q("import_format") & ": " & db2_Q(pImportFormat))
   else
      return "Dropbox-API-Arg: " & db2_CB(db2_Q("import_format") & ": " & db2_Q(pImportFormat) & "," &  \
            db2_Q("parent_folder_id") & ": " & db2_Q(pParentFolderID))
   end if
end db2_Header_APIDocsCreate

function db2_Header_APIDocsDownload pDocID,pExportFormat
   return "Dropbox-API-Arg: " & db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocID) & "," &  \
         db2_Q("export_format") & ": " & db2_Q(pExportFormat))
end db2_Header_APIDocsDownload

function db2_docs_download_HEADER pAccessToken,pDocID,pExportFormat
   return db2_Header_Standard(pAccessToken) & cr & db2_Header_APIDocsDownload(pDocID,pExportFormat)
end db2_docs_download_HEADER

function db2_docs_folder_users_list_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_folder_users_list_HEADER

function db2_docs_folder_users_list_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_folder_users_list_continue_HEADER

function db2_docs_get_folder_info_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_get_folder_info_HEADER

function db2_docs_list_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_list_HEADER

function db2_docs_list_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_list_continue_HEADER

function db2_docs_permanently_delete_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_permanently_delete_HEADER

function db2_docs_sharing_policy_get_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_sharing_policy_get_HEADER

function db2_docs_sharing_policy_set_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_sharing_policy_set_HEADER

function db2_docs_update_HEADER pAccessToken,pDocID,pDocUpdatePolicy,pRevision,pImportFormat
   return db2_Header_AuthOctet(pAccessToken) & cr & db2_Header_APIDocsUpdate(pDocID,pDocUpdatePolicy,pRevision,pImportFormat)
end db2_docs_update_HEADER

function db2_Header_APIDocsUpdate pDocID,pDocUpdatePolicy,pRevision,pImportFormat
   return "Dropbox-API-Arg: " &  \
         db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocID) & "," &  \
         db2_Q("doc_update_policy") & ": " & db2_Q(pDocUpdatePolicy) & "," &  \
         db2_Q("revision") & ": " & pRevision & "," &  \
         db2_Q("import_format") & ": " & pImportFormat)
end db2_Header_APIDocsUpdate

function db2_docs_users_add_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_users_add_HEADER

function db2_docs_users_list_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_users_list_HEADER

function db2_docs_users_list_continue_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_users_list_continue_HEADER

function db2_docs_users_remove_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_docs_users_remove_HEADER


----------------------------------------------------------------
------sharing-----------------------------------------------
----------------------------------------------------------------

function db2_add_file_member_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_add_file_member_HEADER

function db2_update_file_member_HEADER pAccessToken
   return db2_Header_Standard(pAccessToken)
end db2_update_file_member_HEADER

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
----------------------------------------------------------------

function db2_token_revoke_URL
   return "https://api.dropboxapi.com/2/auth/token/revoke"
end db2_token_revoke_URL 

----------------------------------------------------------------
---------users------------------------------------------------
----------------------------------------------------------------

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
---------file properties------------------------------------------------
----------------------------------------------------------------

function db2_properties_add_URL
   return "https://api.dropboxapi.com/2/file_properties/properties/add"
end db2_properties_add_URL 

function db2_properties_overwrite_URL
   return "https://api.dropboxapi.com/2/file_properties/properties/overwrite"
end db2_properties_overwrite_URL 

function db2_properties_remove_URL
   return "https://api.dropboxapi.com/2/file_properties/properties/remove"
end db2_properties_remove_URL 

function db2_properties_search_URL
   return "https://api.dropboxapi.com/2/file_properties/properties/search"
end db2_properties_search_URL 

function db2_properties_search_continue_URL
   return "https://api.dropboxapi.com/2/file_properties/properties/search/continue"
end db2_properties_search_continue_URL 

function db2_properties_update_URL
   return "https://api.dropboxapi.com/2/file_properties/properties/update"
end db2_properties_update_URL 

----------------------------------------------------------------
---------file properties templates------------------------------------------------
----------------------------------------------------------------

function db2_templates_add_for_user_URL
   return "https://api.dropboxapi.com/2/file_properties/templates/add_for_user"
end db2_templates_add_for_user_URL 

function db2_templates_get_for_user_URL
   return "https://api.dropboxapi.com/2/file_properties/templates/get_for_user"
end db2_templates_get_for_user_URL 

function db2_templates_list_for_user_URL
   return "https://api.dropboxapi.com/2/file_properties/templates/list_for_user"
end db2_templates_list_for_user_URL 

function db2_templates_remove_for_user_URL
   return "https://api.dropboxapi.com/2/file_properties/templates/remove_for_user"
end db2_templates_remove_for_user_URL 

function db2_templates_update_for_user_URL
   return "https://api.dropboxapi.com/2/file_properties/templates/update_for_user"
end db2_templates_update_for_user_URL 

-----------------------------------------------------------------------------
---------file requests-------------------------------------------
/* see https://www.dropbox.com/help/files-folders/create-file-request */
-----------------------------------------------------------------------------

function db2_create_URL
   return "https://api.dropboxapi.com/2/file_requests/create"
end db2_create_URL

function db2_get_URL
   return "https://api.dropboxapi.com/2/file_requests/get"
end db2_get_URL

function db2_list_URL
   return "https://api.dropboxapi.com/2/file_requests/list"
end db2_list_URL

function db2_update_URL
   return "https://api.dropboxapi.com/2/file_requests/update"
end db2_update_URL

-----------------------------------------------------------------------------
---------files------------------------------------------------
-----------------------------------------------------------------------------

function db2_copy_batch_URL
   return "https://api.dropboxapi.com/2/files/copy_batch"
end db2_copy_batch_URL 

function db2_copy_batch_check_URL
   return "https://api.dropboxapi.com/2/files/copy_batch/check"
end db2_copy_batch_check_URL 

function db2_copy_reference_get_URL
   return "https://api.dropboxapi.com/2/files/copy_reference/get"
end db2_copy_reference_get_URL 

function db2_copy_reference_save_URL
   return "https://api.dropboxapi.com/2/files/copy_reference/save"
end db2_copy_reference_save_URL 

function db2_copy_v2_URL
   return "https://api.dropboxapi.com/2/files/copy_v2"
end db2_copy_v2_URL 

function db2_create_folder_v2_URL
   return "https://api.dropboxapi.com/2/files/create_folder_v2"
end db2_create_folder_v2_URL 

function db2_delete_batch_URL
   return "https://api.dropboxapi.com/2/files/delete_batch"
end db2_delete_batch_URL 

function db2_delete_batch_check_URL
   return "https://api.dropboxapi.com/2/files/delete_batch/check"
end db2_delete_batch_check_URL 

function db2_delete_v2_URL
   return "https://api.dropboxapi.com/2/files/delete_v2"
end db2_delete_v2_URL 

function db2_download_URL
   return "https://content.dropboxapi.com/2/files/download"
end db2_download_URL 

function db2_download_zip_URL
   return "https://content.dropboxapi.com/2/files/download_zip"
end db2_download_zip_URL 

function db2_get_metadata_URL
   return "https://api.dropboxapi.com/2/files/get_metadata"
end db2_get_metadata_URL 

function db2_get_preview_URL
   return "https://content.dropboxapi.com/2/files/get_preview"
end db2_get_preview_URL

function db2_get_temporary_link_URL
   return "https://api.dropboxapi.com/2/files/get_temporary_link"
end db2_get_temporary_link_URL 

function db2_get_thumbnail_URL
   return "https://content.dropboxapi.com/2/files/get_thumbnail"
end db2_get_thumbnail_URL

function db2_get_thumbnail_batch_URL
  return "https://content.dropboxapi.com/2/files/get_thumbnail_batch"
end db2_get_thumbnail_batch_URL

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
   return "https://notify.dropboxapi.com/2/files/list_folder/longpoll"
end db2_list_folder_longpoll_URL

function db2_list_revisions_URL
   return "https://api.dropboxapi.com/2/files/list_revisions"
end db2_list_revisions_URL

function db2_move_batch_URL
   return "https://api.dropboxapi.com/2/files/move_batch"
end db2_move_batch_URL

function db2_move_batch_check_URL
   return "https://api.dropboxapi.com/2/files/move_batch/check"
end db2_move_batch_check_URL 

function db2_move_v2_URL
   return "https://api.dropboxapi.com/2/files/move_v2"
end db2_move_v2_URL

function db2_permanently_delete_URL
  return "https://api.dropboxapi.com/2/files/permanently_delete"
end db2_permanently_delete_URL

function db2_restore_URL
   return "https://api.dropboxapi.com/2/files/restore"
end db2_restore_URL 

function db2_save_url_URL
   return "https://api.dropboxapi.com/2/files/save_url"
end db2_save_url_URL 

function db2_save_url_check_job_status_URL
   return "https://api.dropboxapi.com/2/files/save_url/check_job_status"
end db2_save_url_check_job_status_URL 

function db2_search_URL
   return "https://api.dropboxapi.com/2/files/search"
end db2_search_URL 

function db2_upload_URL
   return "https://content.dropboxapi.com/2/files/upload"
end db2_upload_URL 

function db2_upload_session_append_v2_URL
   return "https://content.dropboxapi.com/2/files/upload_session/append_v2"
end db2_upload_session_append_v2_URL 

function db2_upload_session_finish_URL
   return "https://content.dropboxapi.com/2/files/upload_session/finish"
end db2_upload_session_finish_URL 

function db2_upload_session_finish_batch_URL
   return "https://api.dropboxapi.com/2/files/upload_session/finish_batch"
end db2_upload_session_finish_batch_URL 

function db2_upload_session_finish_batch_check_URL
   return "https://api.dropboxapi.com/2/files/upload_session/finish_batch/check"
end db2_upload_session_finish_batch_check_URL 

function db2_upload_session_start_URL
   return "https://content.dropboxapi.com/2/files/upload_session/start"
end db2_upload_session_start_URL 

----------------------------------------------------------------
------paper-----------------------------------------------
----------------------------------------------------------------

function db2_docs_archive_URL
   return "https://api.dropboxapi.com/2/paper/docs/archive"
end db2_docs_archive_URL 

function db2_docs_create_URL
   return "https://api.dropboxapi.com/2/paper/docs/create"
end db2_docs_create_URL 

function db2_docs_download_URL
   return "https://api.dropboxapi.com/2/paper/docs/download"
end db2_docs_download_URL 

function db2_docs_folder_users_list_URL
   return "https://api.dropboxapi.com/2/paper/docs/folder_users/list"
end db2_docs_folder_users_list_URL 

function db2_docs_folder_users_list_continue_URL
   return "https://api.dropboxapi.com/2/paper/docs/folder_users/list/continue"
end db2_docs_folder_users_list_continue_URL 

function db2_docs_get_folder_info_URL
   return "https://api.dropboxapi.com/2/paper/docs/get_folder_info"
end db2_docs_get_folder_info_URL 

function db2_docs_list_URL
    return "https://api.dropboxapi.com/2/paper/docs/list"
 end db2_docs_list_URL 

function db2_docs_list_continue_URL
 return "https://api.dropboxapi.com/2/paper/docs/list/continue"
end db2_docs_list_continue_URL 

function db2_docs_permanently_delete_URL
   return "https://api.dropboxapi.com/2/paper/docs/permanently_delete"
end db2_docs_permanently_delete_URL 

function db2_docs_sharing_policy_get_URL
   return "https://api.dropboxapi.com/2/paper/docs/sharing_policy/get"
end db2_docs_sharing_policy_get_URL 

function db2_docs_sharing_policy_set_URL
   return "https://api.dropboxapi.com/2/paper/docs/sharing_policy/set"
end db2_docs_sharing_policy_set_URL 

function db2_docs_update_URL
   return "https://api.dropboxapi.com/2/paper/docs/update"
end db2_docs_update_URL 

function db2_docs_users_add_URL
   return "https://api.dropboxapi.com/2/paper/docs/users/add"
end db2_docs_users_add_URL 

function db2_docs_users_list_URL
   return "https://api.dropboxapi.com/2/paper/docs/users/list"
end db2_docs_users_list_URL 

function db2_docs_users_list_continue_URL
   return "https://api.dropboxapi.com/2/paper/docs/users/list/continue"
end db2_docs_users_list_continue_URL 

function db2_docs_users_remove_URL
   return "https://api.dropboxapi.com/2/paper/docs/users/remove"
end db2_docs_users_remove_URL 

----------------------------------------------------------------
---------sharing---------------------------------------------
----------------------------------------------------------------

function db2_add_file_member_URL
   return "https://api.dropboxapi.com/2/sharing/add_file_member"
end db2_add_file_member_URL 

function db2_update_file_member_URL
   return "https://api.dropboxapi.com/2/sharing/update_file_member"
end db2_update_file_member_URL 

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
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-------auth--------------------------------------------------------------
-----------------------------------------------------------------------------

/*
db2_token_revoke_POST
No parameters. Null used in https://dropbox.github.io/dropbox-api-v2-explorer/#auth_token/revoke
*/

function db2_token_revoke_POST
   return "null"
end db2_token_revoke_POST

----------------------------------------------------------------
---------users------------------------------------------------
----------------------------------------------------------------

function db2_get_account_POST pUserAccountID
   return db2_CB(db2_Q("account_id") & ": " & db2_Q(pUserAccountID))
end db2_get_account_POST

function db2_get_account_batch_POST pUserAccountIDs
   if pUserAccountIDs is empty then 
      return db2_CB(db2_Q("account_ids") & ": " & db2_SB())
   else
      return db2_CB(db2_Q("account_ids") & ": " & db2_SBQListFromCRList(pUserAccountIDs))
   end if
end db2_get_account_batch_POST

/*
db2_get_current_account_POST
No parameters. Null required; empty value fails. See https://dropbox.github.io/dropbox-api-v2-explorer/#users_get_current_account
*/

function db2_get_current_account_POST
   return "null"
end db2_get_current_account_POST

/*
db2_get_space_usage_POST
No parameters. Null required; empty value fails. See https://dropbox.github.io/dropbox-api-v2-explorer/#users_get_space_usage
*/

function db2_get_space_usage_POST
   return "null"
end db2_get_space_usage_POST

-----------------------------------------------------------------------------
---------file requests-------------------------------------------
/* see https://www.dropbox.com/help/files-folders/create-file-request */
-----------------------------------------------------------------------------

function db2_create_POST pTitle,pDestination,pOpenBoolean
   if pOpenBoolean is empty then put "true" into pOpenBoolean
   return db2_CB(db2_Q("title") & ": " & db2_Q(pTitle) & "," &  \
         db2_Q("destination") & ": " & db2_Q(pDestination ) & "," &  \
         db2_Q("open") & ": " & pOpenBoolean)
end db2_create_POST

function db2_get_POST pRequestID
   return db2_CB(db2_Q("id") & ": " & db2_Q(pRequestID))
end db2_get_POST

/*
db2_list_POST
No parameters. Null is used at https://dropbox.github.io/dropbox-api-v2-explorer/#file_requests_list
Note: this seems to require Apps to have full Dropbox access to use this endpoint.
For App folder apps, a 500 server error results including in the API explorer (url above)
*/

function db2_list_POST
   return "null"
end db2_list_POST

/*
db2_update_POST pRequestID,pTitle,pDestination,pOpenBoolean
omit optional fields; don't implement deadline which requires Business
{"id": "aRN7o6xjpwkI3KJ26oaD","title": "Homework1","destination": "/AppFileRequests/Homework1"}
*/

function db2_update_POST pRequestID,pTitle,pDestination,pOpenBoolean
    local tString
   put db2_Q("id") & ": " & db2_Q(pRequestID) into tString
   if pTitle is not empty then
      put "," & db2_Q("title") & ": " & db2_Q(pTitle) after tString
   end if
   if pDestination is not empty then
      put "," & db2_Q("destination") & ": " & db2_Q(pDestination) after tString
   end if
   if pOpenBoolean is not empty then
      put "," & db2_Q("open") & ": " & pOpenBoolean after tString
   end if
   return db2_CB(tString)
end db2_update_POST

-----------------------------------------------------------------------------
---------files-------------------------------------------
-----------------------------------------------------------------------------

function db2_get_metadata_POST pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,pIncludePropertyTemplateIDs
   if pIncludeMediaInfo is empty then put "false" into pIncludeMediaInfo
   if pIncludeDeleted is empty then put "false" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "false" into pIncludeHasExplicitSharedMembers
   if pIncludePropertyTemplateIDs is empty then
      return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
            db2_Q("include_media_info") & ": " & pIncludeMediaInfo & "," &  \
            db2_Q("include_deleted") & ": " & pIncludeDeleted & "," &  \
            db2_Q("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers)
   else
      return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
            db2_Q("include_media_info") & ": " & pIncludeMediaInfo & "," &  \
            db2_Q("include_deleted") & ": " & pIncludeDeleted & "," &  \
            db2_Q("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers & "," &  \
            db2_Q("include_property_groups") & ":" & db2_CB(db2_Q(".tag") & ":" &  \
            db2_Q("filter_some") & "," & db2_Q("filter_some") & ":" & \
            db2_SBQListFromCRList(pIncludePropertyTemplateIDs)))
   end if
end db2_get_metadata_POST

/*
db2_upload_POST pData
data-binary @local_file.png
*/

function db2_upload_POST pData
   return pData
end db2_upload_POST

function db2_copy_reference_get_POST pPath
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath))
end db2_copy_reference_get_POST

function db2_copy_reference_save_POST pCopyReference,pPath
    return db2_CB(db2_Q("copy_reference") & ": " & db2_Q(pCopyReference) & "," & db2_Q("path") & ": " & db2_Q(pPath))
end db2_copy_reference_save_POST

function db2_get_temporary_link_POST pPath
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath))
end db2_get_temporary_link_POST

function db2_properties_add_POST pPath,pPropertyGroupsArray
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_PropertyGroupsString(pPropertyGroupsArray))
end db2_properties_add_POST

function db2_properties_overwrite_POST pPath,pPropertyGroupsArray
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_PropertyGroupsString(pPropertyGroupsArray))
end db2_properties_overwrite_POST

function db2_properties_remove_POST pPath,pTemplateIDs
   if pTemplateIDs is empty then 
      return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
            db2_Q("property_template_ids") & ": " & db2_SB())
   else
      return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," &  \
      db2_Q("property_template_ids") & ": " & db2_SBQListFromCRList(pTemplateIDs))
   end if
end db2_properties_remove_POST

function db2_properties_update_POST pPath,pUpdatePropertyGroupsArray
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_UpdatePropertyGroupsString(pUpdatePropertyGroupsArray))
end db2_properties_update_POST

/*
db2_properties_search_POST pQueryText,pQueryField,pQueryMode,pLogicalOperator,pFilterTemplateIDs
Only one search query is implemented here 
To implement multiple queries need to have an array of first 4 params: text, filed, mode, logical operators
--default filternone
*/

function db2_properties_search_POST pQueryText,pQueryField,pQueryMode,pLogicalOperator,pFilterTemplateIDs
   if pQueryMode is empty then put "field_name" into pQueryMode
   if pLogicalOperator is empty then put "or_operator" into pLogicalOperator
   if pFilterTemplateIDs is empty then 
      return db2_CB(db2_Q("queries") & ": " & \
            db2_SB(db2_CB(db2_Q("query") & ": " & db2_Q(pQueryText) & "," & \
            db2_Q("mode") & ": " & db2_CB(db2_Q(".tag") & ": " & db2_Q(pQueryMode) & "," & db2_Q(pQueryMode) & ": " & db2_Q(pQueryField)) & "," & \
            db2_Q(".logical_operator") & ": " & db2_Q(pLogicalOperator))) & "," & \
            db2_Q("template_filter") & ": " & db2_CB(db2_Q(".tag") & ": " & db2_Q("filter_none")))
   else
      return db2_CB(db2_Q("queries") & ": " & \
            db2_SB(db2_CB(db2_Q("query") & ": " & db2_Q(pQueryText) & "," & \
            db2_Q("mode") & ": " & db2_CB(db2_Q(".tag") & ": " & db2_Q(pQueryMode) & "," & db2_Q(pQueryMode) & ": " & db2_Q(pQueryField)) & "," & \
            db2_Q(".logical_operator") & ": " & db2_Q(pLogicalOperator))) & "," & \
            db2_Q("template_filter") & ": " & db2_CB(db2_Q(".tag") & ": " & db2_Q("filter_some") & "," &  \
            db2_Q("filter_some") & ": " & db2_SBQListFromCRList(pFilterTemplateIDs)))
   end if
end db2_properties_search_POST

function db2_properties_search_continue_POST pSearchCursor
   return db2_CB(db2_Q("cursor") & ": " & db2_Q(pSearchCursor))
end db2_properties_search_continue_POST

-----------------------------------------

function db2_save_url_POST pPath,pUrl
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("url") & ": " & db2_Q(pUrl))
end db2_save_url_POST

function db2_save_url_check_job_status_POST pAsyncJobId
   return db2_CB(db2_Q("async_job_id") & ": " & db2_Q(pAsyncJobId))
end db2_save_url_check_job_status_POST

function db2_templates_add_for_user_POST pTemplateName,pTemplateDescription,pFieldsArray
   return db2_CB(db2_Q("name") & ": " & db2_Q(pTemplateName) & "," &  \
         db2_Q("description") & ": " & db2_Q(pTemplateDescription) & "," &  \
         db2_Q("fields") & ": " & db2_FieldsString(pFieldsArray))
end db2_templates_add_for_user_POST

function db2_templates_get_for_user_POST pTemplateID
    return db2_CB(db2_Q("template_id") & ": " & db2_Q(pTemplateID))
end db2_templates_get_for_user_POST

/*
db2_templates_list_for_user_POST
No parameters. Null used in https://dropbox.github.io/dropbox-api-v2-explorer/#file_properties_templates/list_for_user
*/ 

function db2_templates_list_for_user_POST
   return "null"
end db2_templates_list_for_user_POST

function db2_templates_remove_for_user_POST pTemplateID
   return db2_CB(db2_Q("template_id") & ": " & db2_Q(pTemplateID))
end db2_templates_remove_for_user_POST

/*
db2_templates_update_for_user_POST pTemplateID,pTemplateName,pTemplateDescription,pFieldsArray
add_fields: although documentation says it is optional; seems to require empty list to function
*/

function db2_templates_update_for_user_POST pTemplateID,pTemplateName,pTemplateDescription,pFieldsArray
   local tString
   put db2_Q("template_id") & ": " & db2_Q(pTemplateID) into tString
   if pTemplateName is not empty then
      put "," & db2_Q("name") & ": " & db2_Q(pTemplateName) after tString
   end if
   if pTemplateDescription is not empty then
      put "," & db2_Q("description") & ": " & db2_Q(pTemplateDescription) after tString
   end if
   if pFieldsArray is not empty then
      put "," & db2_Q("add_fields") & ": " & db2_FieldsString(pFieldsArray) after tString
   else
      put "," & db2_Q("add_fields") & ": " & db2_SB() after tString
   end if
   return db2_CB(tString)
end db2_templates_update_for_user_POST


----------------------------------------------------------------

function db2_get_metadata_POST pPath,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers
   if pIncludeMediaInfo is empty then put "false" into pIncludeMediaInfo
   if pIncludeDeleted is empty then put "false" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "false" into pIncludeHasExplicitSharedMembers
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("include_media_info") & ": " & pIncludeMediaInfo& "," &  \
   db2_Q("include_deleted") & ": " & pIncludeDeleted & "," & db2_Q("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers)
end db2_get_metadata_POST

function db2_list_folder_longpoll_POST pCursor,pTimeout
     return db2_CB(db2_Q("cursor") & ": " & db2_Q(pCursor) & "," & db2_Q("timeout") & ": " & pTimeout)
end db2_list_folder_longpoll_POST

/*
db2_list_folder_POST pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,IncludeMountedFolders,pLimit,pIncludePropertyTemplateIDs
#--shared_link parameter not implemented here
#--#--url String Shared link url.
#--#--password String? Password for the shared link. This field is optional.
*/

function db2_list_folder_POST pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,IncludeMountedFolders,pLimit,pIncludePropertyTemplateIDs
   if pRecursive is empty then put "false" into pRecursive
   if pIncludeMediaInfo is empty then put "false" into pIncludeMediaInfo
   if pIncludeDeleted is empty then put "false" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "false" into pIncludeHasExplicitSharedMembers
   if IncludeMountedFolders is empty then put "True" into IncludeMountedFolders
   if pLimit is empty then put "1001" into pLimit  --50 chosen arbitrarily; need integer not empty string; range 1 to 2000
   if pIncludePropertyTemplateIDs is empty then
      return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("recursive") & ": " & pRecursive & "," &  \
            db2_Q("include_media_info") & ": " & pIncludeMediaInfo & "," & db2_Q("include_deleted") & ": " & pIncludeDeleted & "," &  \
            db2_Q("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers & "," &  \
            db2_Q("include_mounted_folders") & ": " & IncludeMountedFolders & "," & db2_Q("pLimit") & ": " & pLimit)
   else
      return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("recursive") & ": " & pRecursive & "," &  \
            db2_Q("include_media_info") & ": " & pIncludeMediaInfo & "," & db2_Q("include_deleted") & ": " & pIncludeDeleted & "," &  \
            db2_Q("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers & "," &  \
            db2_Q("include_mounted_folders") & ": " & IncludeMountedFolders & "," & db2_Q("pLimit") & ": " & pLimit & "," &  \      
            db2_Q("include_property_groups") & ":" & db2_CB(db2_Q(".tag") & ":" & db2_Q("filter_some") & "," & db2_Q("filter_some") & ":" & \
            db2_SBQListFromCRList(pIncludePropertyTemplateIDs)))
   end if
end db2_list_folder_POST

function db2_list_folder_continue_POST pCursor
    return db2_CB(db2_Q("cursor") & ": " & db2_Q(pCursor))
end db2_list_folder_continue_POST

/*
db2_list_folder_get_latest_cursor_POST pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,IncludeMountedFolders,pLimit,pIncludePropertyTemplateIDs
#--shared_link parameter not implemented here
#--#--url String Shared link url.
#--#--password String? Password for the shared link. This field is optional.
if pLimit is empty then put "50" into pLimit  --50 chosen arbitrarily; need integer not empty string; range 1 to 2000
*/

function db2_list_folder_get_latest_cursor_POST pPath,pRecursive,pIncludeMediaInfo,pIncludeDeleted,pIncludeHasExplicitSharedMembers,IncludeMountedFolders,pLimit,pIncludePropertyTemplateIDs
   if pRecursive is empty then put "false" into pRecursive
   if pIncludeMediaInfo is empty then put "false" into pIncludeMediaInfo
   if pIncludeDeleted is empty then put "false" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "false" into pIncludeHasExplicitSharedMembers
   if IncludeMountedFolders is empty then put "True" into IncludeMountedFolders
   if pLimit is empty then put "50" into pLimit
   if pIncludePropertyTemplateIDs is empty then
      return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("recursive") & ": " & pRecursive & "," &  \
            db2_Q("include_media_info") & ": " & pIncludeMediaInfo & "," & db2_Q("include_deleted") & ": " & pIncludeDeleted & "," &  \
            db2_Q("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers & "," &  \
            db2_Q("include_mounted_folders") & ": " & IncludeMountedFolders & "," & db2_Q("pLimit") & ": " & pLimit)
   else
      return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("recursive") & ": " & pRecursive & "," &  \
            db2_Q("include_media_info") & ": " & pIncludeMediaInfo & "," & db2_Q("include_deleted") & ": " & pIncludeDeleted & "," &  \
            db2_Q("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers & "," &  \
            db2_Q("include_mounted_folders") & ": " & IncludeMountedFolders & "," & db2_Q("pLimit") & ": " & pLimit & "," &  \      
            db2_Q("include_property_groups") & ":" & db2_CB(db2_Q(".tag") & ":" & db2_Q("filter_some") & "," & db2_Q("filter_some") & ":" & \
            db2_SBQListFromCRList(pIncludePropertyTemplateIDs)))
   end if
end db2_list_folder_get_latest_cursor_POST

/*
db2_download_POST
No parameters. Path in header instead.
*/

function db2_download_POST
   return ""
end db2_download_POST

/*
db2_download_zip_POST
No parameters. Path in header instead.
*/

function db2_download_zip_POST
   return ""
end db2_download_zip_POST

/*
db2_upload_session_start_POST pData
data-binary @local_file.png
*/

function db2_upload_session_start_POST pData
   return pData
end db2_upload_session_start_POST

/*
db2_upload_session_append_v2_POST pData
data-binary @local_file.png
*/

function db2_upload_session_append_v2_POST pData
   return pData
end db2_upload_session_append_v2_POST

/*
db2_upload_session_finish_POST pData
data-binary @local_file.png
*/

function db2_upload_session_finish_POST pData
   return pData
end db2_upload_session_finish_POST

/*
db2_upload_session_finish_batch_POST pEntriesArray
--
array of pEntriesArray
{"entries":[{"cursor":{"session_id":"AAAAAAAAAqmMzYTjTMgRuA","offset":69},"commit":{"path":"/folder3/testfile3.txt"}}]}
--
{"entries":[{"cursor":{"session_id":"AAAAAAAAAqmMzYTjTMgRuA","offset":69},"commit":{"path":"/folder3/testfile3.txt"}}, \
      {"cursor":{"session_id":"AAAAAAAAAqjhzQx-HRnpjg","offset":69},"commit":{"path":"/folder4/testfile4.txt"}}]}
--
{"entries":[{"cursor":{"session_id":"AAAAAAAAAqmMzYTjTMgRuA","offset":69}, \
      "commit": {"path":"/folder3/testfile1.txt","mode":"overwrite","autorename":false,"client_modified": "2017-12-24T20:58:03Z","mute":false, \
      "property_groups": [{"template_id":"ptid:562VTx1rtSMAAAAAAAACaA",  \
      "fields": [{"name": "name","value": "gmc"},{"name": "age","value":"21"},{"name":"gender","value":"M"}]}]}}, \
      {"cursor": {"session_id":"AAAAAAAAAqjhzQx-HRnpjg","offset":69}, \
      "commit": {"path":"/folder3/testfile2.txt","mode":"overwrite", "autorename":false,"client_modified":"2017-12-24T20:58:03Z","mute":false, \
      "property_groups":[{"template_id":"ptid:562VTx1rtSMAAAAAAAACaA", \
      "fields": [{"name": "name","value": "gmc"},{"name":"age","value": "21"},{"name": "gender","value": "M"}]}]}}]}
--
pEntriesArray[rEntryKeyNum]["sessionid"]
pEntriesArray[rEntryKeyNum]["offset"]
pEntriesArray[rEntryKeyNum]["path"]
pEntriesArray[rEntryKeyNum]["mode"]
pEntriesArray[rEntryKeyNum]["autorename"]
pEntriesArray[rEntryKeyNum]["clientmodified"]
pEntriesArray[rEntryKeyNum]["PropertyGroupsArray"]
--
PropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
PropertyGroupsArray[1][fields][1][name]=	Name
PropertyGroupsArray[1][fields][1][value]=	me
--
Pattern:
{"entries":[{tCursorToCommitString:{db2_UploadString},.........]
*/

function db2_upload_session_finish_batch_POST pEntriesArray
   local tEntriesListString,tCursorToCommitString
   if pEntriesArray is not empty then
      put empty into tEntriesListString
      repeat for each key rEntryKeyNum in pEntriesArray
         put db2_Q("cursor") & ": " & db2_CB(db2_Q("session_id") & ": " & db2_Q(EntriesArray[rEntryKeyNum]["sessionid"]) & "," &  \
               db2_Q("offset") & ": " & pEntriesArray[rEntryKeyNum]["offset"]) & "," & db2_Q("commit") & ": " into tCursorToCommitString
         put db2_CB(tCursorToCommitString &  \
         db2_UploadString(pEntriesArray[rEntryKeyNum]["path"],pEntriesArray[rEntryKeyNum]["mode"],pEntriesArray[rEntryKeyNum]["autorename"],pEntriesArray[rEntryKeyNum]["clientmodified"],pEntriesArray[rEntryKeyNum]["PropertyGroupsArray"]))& "," after tEntriesListString
      end repeat
      if last char of tEntriesListString is comma then delete last char of tEntriesListString  --delete trailing comma
      return db2_CB(db2_Q("entries") & ": " & db2_SB(tEntriesListString))
   else
      return db2_CB(db2_Q("entries") & ": " & db2_SB())
   end if
end db2_upload_session_finish_batch_POST

function db2_upload_session_finish_batch_check_POST pAsyncJobId
   return db2_CB(db2_Q("async_job_id") & ": " & db2_Q(pAsyncJobId))
end db2_upload_session_finish_batch_check_POST

/*
db2_upload_POST pData
data-binary @local_file.png
*/

function db2_upload_POST pData
   return pData
end db2_upload_POST

function db2_search_POST pPath,pQuery,pStart,pMaxResults,pMode
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("query") & ": " & db2_Q(pQuery) & "," &  \
   db2_Q("start") & ": " & pStart & "," & db2_Q("max_results") & ": " & pMaxResults & "," & db2_Q("mode") & ": " & db2_Q(pMode))
end db2_search_POST

function db2_create_folder_v2_POST pPath,pAutorename
   if pAutorename is empty then put "false" into pAutorename
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("autorename") & ": " & (pAutoRename))
end db2_create_folder_v2_POST

function db2_delete_v2_POST pPath
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath))
end db2_delete_v2_POST

function db2_delete_batch_POST pPaths
   if pPaths is empty then
      return db2_CB(db2_Q("entries") & ": " & db2_SB())
   else
      put empty into tEntriesString
      repeat for each line rPath in pPaths
         put db2_CB(db2_Q("path") & ":" & db2_Q(rPath)) & "," after tEntriesString
      end repeat
      if last char of tEntriesString is comma then delete last char of tEntriesString
      return db2_CB(db2_Q("entries") & ": " & db2_SB(tEntriesString))
   end if
end db2_delete_batch_POST

function db2_delete_batch_check_POST pAsyncJobId
   return db2_CB(db2_Q("async_job_id") & ": " & db2_Q(pAsyncJobId))
end db2_delete_batch_check_POST

function db2_permanently_delete_POST pPath
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath))
end db2_permanently_delete_POST

function db2_copy_v2_POST pPathFrom,pPathTo,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
   if pAllowSharedFolder is empty then put "false" into pAllowSharedFolder
   if pAutorename is empty then put "false" into pAutorename
   if pAlowOwnershipTransfer is empty then put "false" into pAlowOwnershipTransfer
   return db2_CB(db2_Q("from_path") & ": " & db2_Q(pPathFrom) & "," & db2_Q("to_path") & ": " & db2_Q(pPathTo)& "," &  \
   db2_Q("allow_shared_folder") & ": " & (pAllowSharedFolder) & "," & db2_Q("autorename") & ": " & (pAutoRename) & "," &  \
   db2_Q("allow_ownership_transfer") & ": " & (pAllowOwnershipTransfer))
end db2_copy_v2_POST

function db2_copy_batch_POST pPathFromAndToArray,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
   if pAllowSharedFolder is empty then put "false" into pAllowSharedFolder
   if pAutorename is empty then put "false" into pAutorename
   if pAlowOwnershipTransfer is empty then put "false" into pAlowOwnershipTransfer
   --
   put empty into tEntriesString
   repeat for each key rKey in pPathFromAndToArray
      put db2_CB(db2_Q("from_path") & ":" & db2_Q(pPathFromAndToArray[rKey]["from_path"]) & "," &  \
            db2_Q("to_path") & ":" & db2_Q(pPathFromAndToArray[rKey]["to_path"])) & "," after tEntriesString
   end repeat
   if last char of tEntriesString is comma then delete last char of tEntriesString
   --
   return db2_CB(db2_Q("entries") & ": " & db2_SB(tEntriesString) & "," &  \
         db2_Q("allow_shared_folder") & ": " & (pAllowSharedFolder) & "," &  \
         db2_Q("autorename") & ": " & (pAutoRename) & "," &  \
         db2_Q("allow_ownership_transfer") & ": " & (pAllowOwnershipTransfer))
end db2_copy_batch_POST

function db2_copy_batch_check_POST pAsyncJobId
   return db2_CB(db2_Q("async_job_id") & ": " & db2_Q(pAsyncJobId))
end db2_copy_batch_check_POST

function db2_move_v2_POST pPathFrom,pPathTo,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
   if pAllowSharedFolder is empty then put "false" into pAllowSharedFolder
   if pAutorename is empty then put "false" into pAutorename
   if pAlowOwnershipTransfer is empty then put "false" into pAlowOwnershipTransfer
   return db2_CB(db2_Q("from_path") & ": " & db2_Q(pPathFrom) & "," & db2_Q("to_path") & ": " & db2_Q(pPathTo)& "," &  \
   db2_Q("allow_shared_folder") & ": " & (pAllowSharedFolder) & "," & db2_Q("autorename") & ": " & (pAutoRename) & "," &  \
   db2_Q("allow_ownership_transfer") & ": " & (pAllowOwnershipTransfer))
end db2_move_v2_POST

function db2_move_batch_POST pPathFromAndToArray,pAllowSharedFolder,pAutoRename,pAllowOwnershipTransfer
   if pAllowSharedFolder is empty then put "false" into pAllowSharedFolder
   if pAutorename is empty then put "false" into pAutorename
   if pAlowOwnershipTransfer is empty then put "false" into pAlowOwnershipTransfer
   --
   put empty into tEntriesString
   repeat for each key rKey in pPathFromAndToArray
      put db2_CB(db2_Q("from_path") & ":" & db2_Q(pPathFromAndToArray[rKey]["from_path"]) & "," &  \
            db2_Q("to_path") & ":" & db2_Q(pPathFromAndToArray[rKey]["to_path"])) & "," after tEntriesString
   end repeat
   if last char of tEntriesString is comma then delete last char of tEntriesString
   --
   return db2_CB(db2_Q("entries") & ": " & db2_SB(tEntriesString) & "," &  \
         db2_Q("allow_shared_folder") & ": " & (pAllowSharedFolder) & "," &  \
         db2_Q("autorename") & ": " & (pAutoRename) & "," &  \
         db2_Q("allow_ownership_transfer") & ": " & (pAllowOwnershipTransfer))
end db2_move_batch_POST

function db2_move_batch_check_POST pAsyncJobId
   return db2_CB(db2_Q("async_job_id") & ": " & db2_Q(pAsyncJobId))
 end db2_move_batch_check_POST

/*
db2_get_thumbnail_POST
No parameters. Parameters in header instead. Must be empty POST
*/

function db2_get_thumbnail_POST
    return ""
end db2_get_thumbnail_POST

function db2_get_thumbnail_batch_POST pPathFormatSizeArrray
   put empty into tEntriesString
   repeat for each key rKey in pPathFormatSizeArrray
      put db2_CB(db2_Q("path") & ":" & db2_Q(pPathFormatSizeArrray[rKey]["path"]) & "," &  \
            db2_Q("format") & ":" & db2_Q(pPathFormatSizeArrray[rKey]["format"]) & "," & \
            db2_Q("size") & ":" & db2_Q(pPathFormatSizeArrray[rKey]["size"])) & "," after tEntriesString
   end repeat
   if last char of tEntriesString is comma then delete last char of tEntriesString
   --
   return db2_CB(db2_Q("entries") & ": " & db2_SB(tEntriesString))
end db2_get_thumbnail_batch_POST

/*
db2_get_preview_POST
No parameters. Parameters in header instead. Must be empty POST
*/

function db2_get_preview_POST
   return ""
end db2_get_preview_POST

function db2_list_revisions_POST pPath,pMode,pLimit
   if pMode is empty then put "path" into pMode
   if pLimit is empty then put "10" into pLimit
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("mode") & ": " & pMode & "," & db2_Q("limit") & ": " & pLimit)
end db2_list_revisions_POST

function db2_restore_POST pPath,pRevision
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("rev") & ": " & db2_Q(pRevision))
end db2_restore_POST

----------------------------------------------------------------
------paper-----------------------------------------------
----------------------------------------------------------------

function db2_docs_archive_POST pDocID
 return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocID))
end db2_docs_archive_POST

/*
db2_docs_create_POST
Binary data
*/

function db2_docs_create_POST pData
   return pData
end db2_docs_create_POST

/*
db2_get_preview_POST
No parameters. Parameters in header instead. Must be empty POST
*/

function db2_docs_download_POST 
   return ""
end db2_docs_download_POST

function db2_docs_folder_users_list_POST pDocID,pLimit
   if pLimit is empty then put "1000" into pLimit
   return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocID) & "," &  \
         db2_Q("limit") & ": " & db2_Q(pLimit))
end db2_docs_folder_users_list_POST

function db2_docs_folder_users_list_continue_POST pDocID,pCursor
   return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocID) & "," &  \
         db2_Q("cursor") & ": " & db2_Q(pCursor))
end db2_docs_folder_users_list_continue_POST

function db2_docs_get_folder_info_POST pDocID
   return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocID))
end db2_docs_get_folder_info_POST

function db2_docs_list_POST pFilterBy,pSortBy,pSortOrder,pLimit
   if pFilterBy is empty then put "docs_accessed" into pFilterBy
   if pSortBy is empty then put "accessed" into pSortBy
   if pSortOrder is empty then put "ascending" into pSortOrder
   if pLimit is empty then put "1000" into pLimit
   return db2_CB(db2_Q("filter_by") & ": " & db2_Q(pFilterBy) & "," &  \
         db2_Q("sort_by") & ": " & db2_Q(pSortBy) & "," &  \
         db2_Q("sort_order") & ": " & db2_Q(pSortOrder) & "," &  \
         db2_Q("limit") & ": " & db2_Q(pLimit))
end db2_docs_list_POST

function db2_docs_list_continue_POST pCursor
   return db2_CB(db2_Q("cursor") & ": " & db2_Q(pCursor))
end db2_docs_list_continue_POST

function db2_docs_permanently_delete_POST p
   return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocID))
end db2_docs_permanently_delete_POST

function db2_docs_sharing_policy_get_POST pDocID
   return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocID))
end db2_docs_sharing_policy_get_POST

function db2_docs_sharing_policy_set_POST pDocId,pPublicSharingPolicy
   return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocId) & "," &  \
         db2_Q("sharing_policy") & ": " & db2_CB(db2_Q("public_sharing_policy") & ": " & db2_Q(pPublicSharingPolicy)))
end db2_docs_sharing_policy_set_POST

function db2_docs_update_POST pData
   return pData
end db2_docs_update_POST

/*
db2_docs_users_add_POST pDocID,pMemberArray,pCustomMessage,pQuiet
pMemberArray[1][selector]
pMemberArray[1][member]
pMemberArray[1][permissionlevel]
--
for POST
{"doc_id": "uaSvRuxvnkFa12PTkBv5q",
"members": [{"member": {".tag": "email","email": "justin@example.com"},"permission_level": "view_and_comment"}],
"custom_message": "Welcome to Paper.","quiet": false}
*/

function db2_docs_users_add_POST pDocID,pMemberArray,pCustomMessage,pQuiet
   if pQuiet is empty then put "false" into pQuiet
   --
   put empty into tMembersString
   repeat for each key rKey in pMemberArray
      put db2_CB(db2_Q("member") & ":" &  \
            db2_CB(db2_Q(".tag") & ":" & db2_Q(pMemberArray[rKey]["selector"]) & "," &  \
            db2_Q(pMemberArray[rKey]["selector"]) & ":" & db2_Q(pMemberArray[rKey]["member"])) & "," & \
            db2_Q("permission_level") & ":" & db2_Q(pMemberArray[rKey]["permissionlevel"])) & "," after tMembersString
   end repeat
   if last char of tMembersString is comma then delete last char of tMembersString
   --
   if pCustomMessage is not empty then
      return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocId) & "," &  \
            db2_Q("members") & ": " & db2_SB(tMembersString) & "," &  \
            db2_Q("custom_message") & ": " & db2_Q(pCustomMessage) & "," &  \
            db2_Q("quiet") & ": " & db2_Q(pQuiet))
   else
      return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocId) & "," &  \
            db2_Q("members") & ": " & db2_SB(tMembersString) & "," &  \
            db2_Q("quiet") & ": " & db2_Q(pQuiet))
   end if
end db2_docs_users_add_POST

function db2_docs_users_list_POST pDocId,pLimit,pFilterBy
   if pFilterBy is empty then put "shared" into pFilterBy
   if pLimit is empty then put "1000" into pLimit
   return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocId) & "," &  \
         db2_Q("limit") & ": " & db2_Q(pLimit) & "," &  \
         db2_Q("filter_by") & ": " & db2_Q(pFilterBy))
end db2_docs_users_list_POST

function db2_docs_users_list_continue_POST pDocID,pCursor
   return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocID) & "," &  \
         db2_Q("cursor") & ": " & db2_Q(pCursor))
end db2_docs_users_list_continue_POST

function db2_docs_users_remove_POST pDocID,pMemberSelector,pMember
   return db2_CB(db2_Q("doc_id") & ": " & db2_Q(pDocId) & "," &  \
         db2_Q("member") & ":" &  \
         db2_CB(db2_Q(".tag") & ":" & db2_Q(pMemberSelector) & "," &  \
         db2_Q(pMemberSelector) & ":" & db2_Q(pMember)))
end db2_docs_users_remove_POST

----------------------------------------------------------------
---------sharing-----------------------------------------
----------------------------------------------------------------

function db2_add_file_member_POST pFile,pMembersArray,pMessage,pQuiet,pAccessLevel,pAddMessageAsComment
   /*
   {"file": "/MySharedFolder1/sharedfolder1/testfile1.txt",
   "members": [{".tag": "email","email": "me@myip"}],
   "custom_message": "This is a custom message about this file.",
   "quiet": false,
   "access_level": "viewer",
   "add_message_as_comment": false}
   */
   local tMemberString,tString
   if pQuiet is empty then put "false" into pQuiet
   if pAccessLevel is empty then put "viewer" into pAccessLevel
   if pAddMessageAsComment is empty then put "false" into pAddMessageAsComment
   --
   put db2_Q("file") & ": " & db2_Q(pFile) & "," after tString
   put empty into tMemberString
   repeat for each key rKey in pMembersArray
      if pMembersArray[rKey]["email"] is not empty then 
         put db2_CB(db2_Q(".tag") & ": " & db2_Q("email") & "," & db2_Q("email") & ": " & db2_Q(pMembersArray[rKey]["email"])) & ","after tMemberString
      else
         if pMembersArray[rKey]["id"] is not empty then 
            put db2_CB(db2_Q(".tag") & ": " & db2_Q("id") & "," & db2_Q("id") & ": " & db2_Q(pMembersArray[rKey]["id"])) & "," after tMemberString
         end if
      end if
   end repeat
   if last char of tMemberString is comma then delete last char of tMemberString
   --
   put db2_Q("members") & ": " & db2_SB(tMemberString) after tString
   if pMessage is not empty then put db2_Q("custom_message") & ": " & db2_Q(pMessage) & "," after tString
   put db2_Q("quiet") & ": " & pQuiet & "," after tString
   put db2_Q("access_level") & ": " & db2_Q(pAccessLevel) & "," after tString
   put db2_Q("add_message_as_comment") & ": " &  pAddMessageAsComment after tString
   --
   return db2_CB(tString)
end db2_add_file_member_POST

function db2_update_file_member_POST pFile,pMemberArray,pAccessLevel
   /*
   {"file": "/MySharedFolder1/sharedfolder1/testfile1.txt",
   "member": {".tag": "email","email": "me@myip"},
   "access_level": "viewer"}
   */
   local tString
   if pAccessLevel is empty then put "viewer" into pAccessLevel
   --
   put db2_Q("file") & ": " & db2_Q(pFile) & "," into tString
   put db2_Q("member") & ": " after tString
   if pMembersArray[rKey]["email"] is not empty then 
      put db2_CB(db2_Q(".tag") & ": " & db2_Q("email") & "," & db2_Q("email") & ": " & db2_Q(pMembersArray[rKey]["email"])) & ","after tString
   else
      if pMembersArray[rKey]["id"] is not empty then 
         put db2_CB(db2_Q(".tag") & ": " & db2_Q("id") & "," & db2_Q("id") & ": " & db2_Q(pMembersArray[rKey]["id"])) & "," after tString
      end if
   end if
   put db2_Q("access_level") & ": " & db2_Q(pAccessLevel) after tString
   --
   return db2_CB(tString)
end db2_update_file_member_POST

function db2_check_remove_member_job_status_POST
   /*
   FIX
    "async_job_id": "34g93hh34h04y384084"
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
   if pIncludeInherited is empty then put "false" into pIncludeMediaInfo
   if pLimit is empty then put "false" into pIncludeDeleted
   if pIncludeHasExplicitSharedMembers is empty then put "false" into pIncludeHasExplicitSharedMembers
   --if pIncludePropertyTemplates is empty then put "false" into pIncludePropertyTemplates
   --
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("include_media_info") & ": " & pIncludeMediaInfo & \
         "," & db2_Q("include_deleted") & ": " & pIncludeDeleted & \
         "," & db2_Q("include_has_explicit_shared_members") & ": " & pIncludeHasExplicitSharedMembers)
   --& "," & db2_Q("include_property_groups") & ": " & pIncludePropertyTemplates)
   
   
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
   if pQuiet is empty then put "false" into pQuiet
   if pCustomMessage is empty then put "" into pCustomMessage
   return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId) & "," & db2_Q("members") & ": " & db2_FormatAddFolderMembers(pMembers) & "," & db2_Q("quiet") & ": " & pQuiet & "," & db2_Q("custom_message") & ": " & db2_Q(pCustomMessage))
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
   local tString
   if pMembers is empty then return db2_SB()
   put empty into tString
   repeat for each key rKey in pMembers
      if pMember[rKey]["email"] is not empty then 
         put db2_Q("member") & ":" &  \
               db2_CB(db2_Q(".tag") & ": " & db2_Q("email") & "," & db2_Q("email") & ": " & db2_Q(pMember[rKey]["email"])) & "," &  \
               db2_Q("access_level") & ": " & db2_CB(db2_Q(".tag") & ": " & db2_Q(pMember[rKey]["accesslevel"])) & "," after tString
      else
         if pMember[rKey]["dropbox_id"] is not empty then 
            put db2_Q("member") & ":" & \
                  db2_CB(db2_Q(".tag") & ": " & db2_Q("dropbox_id") & "," & db2_Q("dropbox_id") & ": " & db2_Q(pMember[rKey]["dropbox_id"])) & "," &  \
                  db2_Q("access_level") & ": " & db2_CB(db2_Q(".tag") & ": " & db2_Q(pMember[rKey]["accesslevel"])) & "," after tString
         end if
      end if
   end repeat
   return db2_SB(tString)
end db2_FormatAddFolderMembers

function db2_check_job_status_POST pAsyncJobId
   /*
   PollArg
   Arguments for methods that poll the status of an asynchronous job.
   #--async_job_id String Id of the asynchronous job. This is the value of a response returned from the method that launched the job.
   */
   return db2_CB(db2_Q("async_job_id") & ": " & db2_Q(pAsyncJobId))
end db2_check_job_status_POST

function db2_check_share_job_status_POST pAsyncJobId
   /*
   PollArg
   Arguments for methods that poll the status of an asynchronous job.
   #--async_job_id String Id of the asynchronous job. This is the value of a response returned from the method
   that launched the job. 
   pAsyncJobId from remove_folder_member, share_folder, unshare_folder
   */
   return db2_CB(db2_Q("async_job_id") & ": " & db2_Q(pAsyncJobId))
end db2_check_share_job_status_POST

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
   return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("settings") & ": " & pSettings)
end db2_create_shared_link_with_settings_POST

function db2_get_folder_metadata_POST pSharedFolderId,pActions
   /*
   GetMetadataArgs
   #--shared_folder_id String The ID for the shared folder.
   #--actions List of (FolderAction)? Folder actions to query. 
   This field is optional.
   FolderAction (open union)
   Actions that may be taken on shared folders. The value will be one of the following datatypes. New values may be introduced as our API evolves.
   #--change_options Void Change folder options, such as who can be invited to join the folder.
   #--edit_contents Void Change or edit contents of the folder.
   #--invite_editor Void Invite a user or group to join the folder with read and write permission.
   #--invite_viewer Void Invite a user or group to join the folder with read permission.
   #--relinquish_membership Void Relinquish one's own membership in the folder.
   #--unmount Void Unmount the folder.
   #--unshare Void Stop sharing this folder.
   */
   if pActions is not empty then
      return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId) & "," & db2_Q("actions") & ": " & db2_SB(pActions))
   else
      return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId))
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
         return db2_CB(db2_Q("url") & ": " & db2_Q(pUrl) & "," & db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("link_password") & ": " & db2_Q(pLinkPassword))
      else
         return db2_CB(db2_Q("url") & ": " & db2_Q(pUrl) & "," & db2_Q("path") & ": " & db2_Q(pPath))
      end if
   else
      return db2_CB(db2_Q("url") & ": " & db2_Q(pUrl))
   end if
end db2_get_shared_link_metadata_POST

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
   if pActions is empty then put db2_SB() into pActions
   if pLimit is empty then put "1000" into pLimit
   return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId) & "," & db2_Q("actions") & ": " & db2_SB(pActions)& "," & db2_Q("limit") & ": " & db2_Q(pLimit) )
end db2_list_folder_members_POST

function db2_list_folder_members_continue_POST pCursor
   /*
   ListFolderMembersContinueArg
   #--cursor String The cursor returned by your last call to list_folder_members or list_folder_members/continue.
   */
   return db2_CB(db2_Q("cursor") & ": " & db2_Q(pCursor))
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
      return db2_CB(db2_Q("limit") & ": " &  pLimit)
   else
      return db2_CB(db2_Q("limit") & ": " &  pLimit & "," & db2_Q("actions") & ": " & db2_SB(db2_QItems(pActions)))
   end if
end db2_list_folders_POST

function db2_list_folders_continue_POST pCursor
   /*
   ListFoldersContinueArg
   cursor String The cursor returned by your last call to list_folder_members or list_folder_members/continue.
   */
   return db2_CB(db2_Q("cursor") & ": " & db2_Q(pCursor))
end db2_list_folders_continue_POST

function db2_list_mountable_folders_POST pLimit,pActions
   /*
   {"limit": 100,"actions": []}
   ListFoldersArgs
   limit UInt32 The maximum number of results to return per request.  
   The default for this field is 1000.
   actions List of (FolderAction)? Folder actions to query. 
   This field is optional.
   FolderAction (open union) 
   
   FIX list of actions one per line need to be list formatted
   */
   if pLimit is empty then put "1000" into pLimit
   if pActions is empty then put db2_SB() into pActions
   return db2_CB(db2_Q("limit") & ": " & (pLimit) & "," & db2_Q("actions") & ": " & db2_SB(pActions))
end db2_list_mountable_folders_POST

function db2_list_mountable_folders_continue_POST pCursor
   /*
   ListFoldersContinueArg
   cursor String The cursor returned by the previous API call specified in the endpoint description.
   Apps must have full Dropbox access to use this endpoint. 
   {"cursor": "ZtkX9_EHj3x7PMkVuFIhwKYXEpwpLwyxp9vMKomUhllil9q7eWiAu"}
   */
   return db2_CB(db2_Q("cursor") & ": " & db2_Q(pCursor))
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
         return db2_CB(db2_Q("cursor") & ": " & db2_Q(pCursor)) & " OR " & db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("direct_only") & ": " & db2_Q(pDirectOnly))
      else
         return db2_CB(db2_Q("cursor") & ": " & db2_Q(pCursor))
      end if
   else
      if pDirectOnly is not empty then
         return db2_CB(db2_Q("path") & ": " & db2_Q(pPath) & "," & db2_Q("direct_only") & ": " & db2_Q(pDirectOnly))
      else
         return db2_CB(db2_Q("path") & ": " & db2_Q(pPath))
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
   put db2_Q("url") & ": " & db2_Q(pUrl) into tPost
   put "," & db2_Q("settings") & "{" after tPost
   if pRequestedVisibility is not empty then
      put db2_Q("requested_visibility") & ": " & db2_Q(pRequestedVisibility) after tPost
   else
      --default
      put db2_Q("requested_visibility") & ": " & db2_Q("public") after tPost
   end if
   if pLinkPassword is not empty then
      put "," & db2_Q("link_password") & ": " & db2_Q(pLinkPassword) after tPost
   end if
   if pExpires is not empty then
      put "," & db2_Q("expires") & ": " & db2_Q(pExpires) after tPost
   end if
   put  "}" after tPost
   return db2_CB(tPost)
end db2_modify_shared_link_settings_POST

function db2_mount_folder_POST pSharedFolderId
   /*
   MountFolderArg
   #--shared_folder_id String The ID of the shared folder to mount.
   */
   return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId))
end db2_mount_folder_POST

function db2_relinquish_folder_membership_POST pSharedFolderId
   /*
   RelinquishFolderMembershipArg
   #--shared_folder_id String The ID for the shared folder.
   */
   return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId))
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
   return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId) & "," & db2_Q("member") & ": " & db2_Q(pMember) & "," & db2_Q("leave_a_copy") & ": " & pLeaveACopy)
end db2_remove_folder_member_POST

function db2_revoke_shared_link_POST pURL
   /*
   RevokeSharedLinkArg
   #--url String URL of the shared link.
   --needs to be full url not short url
   {"url":"https://www.dropbox.com/s/xm2rco8624tno9g/seasons.txt?dl=0"}
   */
   return db2_CB(db2_Q("url") & ": " & db2_Q(pURL))
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
   put db2_Q("path") & ": " & db2_Q(pPath) into tPost
   if pMemberPolicy is not empty then
      put "," & db2_Q("member_policy") & ": " & db2_Q(pMemberPolicy) after tPost
   else
      --default
      put "," & db2_Q("member_policy") & ": " & db2_Q("anyone") after tPost
   end if
   if pAclUpdatePolicy is not empty then
      put "," & db2_Q("acl_update_policy") & ": " & db2_Q(pAclUpdatePolicy) after tPost
   else
      --default
      put "," & db2_Q("acl_update_policy") & ": " & db2_Q("owner") after tPost
   end if
   if pSharedLinkPolicy is not empty then
      put "," & db2_Q("shared_link_policy") & ": " & db2_Q(pSharedLinkPolicy) after tPost
   else
      --default
      put "," & db2_Q("shared_link_policy") & ": " & db2_Q("anyone") after tPost
   end if
   if pForceAsync is not empty then
      put "," & db2_Q("force_async") & ": " & db2_Q(pForceAsync) after tPost
   else
      --default false
      put "," & db2_Q("shared_link_policy") & ": " & "false" after tPost
   end if
   return db2_CB(tPost)
end db2_share_folder_POST

function db2_transfer_folder_POST pSharedFolderId,pToDropboxId
   /*
   TransferFolderArg
   #--shared_folder_id String The ID for the shared folder.
   #--to_dropbox_id String A account or team member ID to transfer ownership to.
   */
   return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId) & "," & db2_Q("to_dropbox_id") & ": " & db2_Q(pToDropboxId))
end db2_transfer_folder_POST

function db2_unmount_folder_POST pSharedFolderId
   /*
   UnmountFolderArg
   #--shared_folder_id String The ID for the shared folder.
   */
   return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId))
end db2_unmount_folder_POST

function db2_unshare_folder_POST pSharedFolderId,pLeaveACopy
   /*
   UnshareFolderArg
   #--shared_folder_id String The ID for the shared folder.
   #--leave_a_copy Boolean If true, members of this shared folder will get a copy of this folder after it's unshared. 
   Otherwise, it will be removed from their Dropbox. The current user, who is an owner, will always retain their copy.
   */
   if pLeaveACopy is empty then put "false" into pLeaveACopy
   return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId) & "," & db2_Q("leave_a_copy") & ": " & pLeaveACopy)
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
   return db2_CB(db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId) & "," & db2_Q("member") & ": " & db2_FormatUpdateFolderMember(pMember) & "," & db2_Q("access_level") & ": " & db2_Q(pAccessLevel))
end db2_update_folder_member_POST

function db2_FormatUpdateFolderMember pMember
   -- pMember is an array  pMember["email"] or pMember["dropbox_id"]
   /*
   --{".tag":"email","email":"myemailaddress"}
   --{".tag": "dropbox_id","dropbox_id": "dbid:mydropboxid"}
   */
   if pMember["email"] is not empty then 
      return db2_CB(db2_Q(".tag") & ": " & db2_Q("email") & "," & db2_Q("email") & ": " & db2_Q(pMember["email"]))
   end if
   if pMember["dropbox_id"] is not empty then 
      return db2_CB(db2_Q(".tag") & ": " & db2_Q("dropbox_id") & "," & db2_Q("dropbox_id") & ": " & db2_Q(pMember["dropbox_id"]))
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
   put db2_Q("shared_folder_id") & ": " & db2_Q(pSharedFolderId) into tPost
   if pMemberPolicy is not empty then
      put "," & db2_Q("member_policy") & ": " & db2_Q(pMemberPolicy) after tPost
   end if
   if pAclUpdatePolicy is not empty then
      put "," & db2_Q("acl_update_policy") & ": " & db2_Q(pAclUpdatePolicy) after tPost
   end if
   if pSharedLinkPolicy is not empty then
      put "," & db2_Q("shared_link_policy") & ": " & db2_Q(pSharedLinkPolicy) after tPost
   end if
   return db2_CB(tPost)
end db2_update_folder_policy_POST

#-- ------------------------------------------------------------------------------------------------------------
#-- --------------property groups and fields -------------------------------------------------------

function db2_FieldsString pFieldsArray
   /*
   used by
   db2_templates_add_for_user_POST
   db2_templates_update_for_user_POST
   --
   put db2_FieldsString(pFieldsArray) into tFieldsString
   --
   pFieldsArray[1]["name"]...[2]["name"] etc
   pFieldsArray[1][name]=	Name
   pFieldsArray[1][description]=	Enter name
   pFieldsArray[1][type]=	string
   pFieldsArray[2][name]=	Age
   pFieldsArray[2][description]=	Enter age
   pFieldsArray[2][type]=	string
   --
   --Doesn't include the "fields": 
   "fields": [{"name": "name","description": "Enter name.","type": "string"},
   {"name": "age","description": "Enter age.","type": "string"},
   {"name": "gender","description": "Enter gender.","type": "string"}]
   */
   local tFieldsString
   if pFieldsArray is not empty then
      put empty into tFieldsString
      repeat for each key rFieldNum in pFieldsArray
         --name, description, type
         put db2_CB(db2_Q("name") & ": " & db2_Q(pFieldsArray[rFieldNum]["name"]) & "," & \
               db2_Q("description") & ": " & db2_Q(pFieldsArray[rFieldNum]["description"]) & "," &  \
               db2_Q("type") & ": " & db2_Q(pFieldsArray[rFieldNum]["type"])) & "," after tFieldsString
      end repeat
      if last char of tFieldsString is comma then delete last char of tFieldsString  --delete trailing comma
      return db2_SB(tFieldsString)
   else
      return db2_SB()
   end if
end db2_FieldsString

/*
db2_PropertyGroupsString pPropertyGroupsArray
used by
db2_properties_overwrite_POST
db2_properties_add_POST
db2_Header_APIUpload
--
put db2_PropertyGroupsString(pPropertyGroupsArray) into tPropertyGroupString
--
use pPropertyGroupsArray to store template_id, and field name, value eg:
pPropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pPropertyGroupsArray[1][fields][1][name]=	Name
pPropertyGroupsArray[1][fields][1][value]=	me
pPropertyGroupsArray[1][fields][2][name]=	Age
pPropertyGroupsArray[1][fields][2][value]=	21
pPropertyGroupsArray[2][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAXXb
pPropertyGroupsArray[2][fields][1][name]=	Topic
pPropertyGroupsArray[2][fields][1][value]=	Science
pPropertyGroupsArray[2][fields][2][name]=	SubTopic
pPropertyGroupsArray[2][fields][2][value]=	Biology
--
"property_groups": [
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa","fields": [{"name": "name","value": "me"},{"name": "age","value": "21"}]},
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAXXb","fields": [{"name": "Topic","value": "Science"},{"name": "SubTopic","value": "Biology"}]}
]
--
PropertyGroup
A subset of the property fields described by the corresponding PropertyGroupTemplate. Properties are always added to a Dropbox file as a PropertyGroup. 
The possible key names and value types in this group are defined by the corresponding PropertyGroupTemplate.
#--#--template_id String(min_length=1, pattern="(/|ptid:).*") A unique identifier for the associated template.
#--#--fields List of (PropertyField) The actual properties associated with the template. There can be up to 32 property types per template.
PropertyField
Raw key/value data to be associated with a Dropbox file. Property fields are added to Dropbox files as a PropertyGroup.
#--#--#--name String Key of the property field associated with a file and template. Keys can be up to 256 bytes.
#--#--#--value String Value of the property field associated with a file and template. Values can be up to 1024 bytes.
*/

function db2_PropertyGroupsString pPropertyGroupsArray
   local tTemplateStrings,tFieldStrings
   if pPropertyGroupsArray is not empty then
      put empty into tTemplateStrings
      repeat for each key rTemplateKeyNum in pPropertyGroupsArray
         put empty into tFieldStrings
         repeat for each key rFieldNum in pPropertyGroupsArray[rTemplateKeyNum]["fields"]
            put db2_CB(db2_Q("name") & ": " & db2_Q(pPropertyGroupsArray[rTemplateKeyNum]["fields"][rFieldNum]["name"]) & "," & \
                  db2_Q("value") & ": " & db2_Q(pPropertyGroupsArray[rTemplateKeyNum]["fields"][rFieldNum]["value"])) & "," after tFieldStrings
         end repeat
         if last char of tFieldStrings is comma then delete last char of tFieldStrings  --delete trailing comma
         put db2_CB(db2_Q("template_id") & ": " & db2_Q(pPropertyGroupsArray[rTemplateKeyNum]["template_id"]) & "," &  \
               db2_Q("fields") & ": " & db2_SB(tFieldStrings)) & "," after tTemplateStrings
      end repeat
      if last char of tTemplateStrings is comma then delete last char of tTemplateStrings  --delete trailing comma
      return db2_Q("property_groups") & ": " & db2_SB(tTemplateStrings)
   else
      return db2_Q("property_groups") & ": " & db2_SB()
   end if
end db2_PropertyGroupsString

/*
used by
db2_properties_update_POST
--
put db2_UpdatePropertyGroupsString(pUpdatePropertyGroupsArray) into tPropertyGroupString
--
use pUpdatePropertyGroupsArray to store template_id, name, value  eg:
pUpdatePropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pUpdatePropertyGroupsArray[1][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAAYa
pUpdatePropertyGroupsArray[1][add_or_update_fields][1][name]=	Name
pUpdatePropertyGroupsArray[1][add_or_update_fields][1][value]=	me
pUpdatePropertyGroupsArray[1][add_or_update_fields][2][name]=	Age
pUpdatePropertyGroupsArray[1][add_or_update_fields][2][value]=	21
pUpdatePropertyGroupsArray[1][remove_fields]=	Gender & cr & Race  cr delimited list of fields to remove
pUpdatePropertyGroupsArray[2][template_id]=	ptid:1a5n2i6d3OYEAAAAAAAAXXb
pUpdatePropertyGroupsArray[2][add_or_update_fields][1][name]=	Topic
pUpdatePropertyGroupsArray[2][add_or_update_fields][1][value]=	Science
pUpdatePropertyGroupsArray[2][remove_fields]=	SubTopic
--
"update_property_groups": [
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAAYa",
"add_or_update_fields": [{"name": "name","value": "me"},{"name": "age","value": "21"}],
"remove_fields": ["Gender","Race"]},
{"template_id": "ptid:1a5n2i6d3OYEAAAAAAAAXXb",
add_or_update_fields": [{"name": "Topic","value": "Science"}],
"remove_fields": ["SubTopic"]}
]
*/

function db2_UpdatePropertyGroupsString pUpdatePropertyGroupsArray
   local tTemplateStrings,tFieldStrings,tRemoveFieldStrings
   if pUpdatePropertyGroupsArray is not empty then
      put empty into tTemplateStrings
      repeat for each key rTemplateKeyNum in pUpdatePropertyGroupsArray
         put empty into tFieldStrings
         repeat for each key rFieldNum in pUpdatePropertyGroupsArray[rTemplateKeyNum]["add_or_update_fields"]
            put db2_CB(db2_Q("name") & ": " & db2_Q(pUpdatePropertyGroupsArray[rTemplateKeyNum]["add_or_update_fields"][rFieldNum]["name"]) & "," & \
                  db2_Q("value") & ": " & db2_Q(pUpdatePropertyGroupsArray[rTemplateKeyNum]["add_or_update_fields"][rFieldNum]["value"])) & "," after tFieldStrings
         end repeat
         if last char of tFieldStrings is comma then delete last char of tFieldStrings  --delete trailing comma
         --
         if pUpdatePropertyGroupsArray[rTemplateKeyNum]["remove_fields"] is empty then 
            put db2_CB(db2_Q("template_id") & ": " & db2_Q(pUpdatePropertyGroupsArray[rTemplateKeyNum]["template_id"]) & "," &  \
                  db2_Q("add_or_update_fields") & ": " & db2_SB(tFieldStrings) & "," &  \
                  db2_Q("remove_fields") & ": " & db2_SB()) & "," after tTemplateStrings
         else
            put db2_CB(db2_Q("template_id") & ": " & db2_Q(pUpdatePropertyGroupsArray[rTemplateKeyNum]["template_id"]) & "," &  \
                  db2_Q("add_or_update_fields") & ": " & db2_SB(tFieldStrings) & "," &  \
                  db2_Q("remove_fields") & ": " & db2_SBQListFromCRList(pUpdatePropertyGroupsArray[rTemplateKeyNum]["remove_fields"])) & "," after tTemplateStrings
         end if
         --
      end repeat
      if last char of tTemplateStrings is comma then delete last char of tTemplateStrings  --delete trailing comma
      return db2_Q("update_property_groups") & ": " & db2_SB(tTemplateStrings)
   else
      return db2_Q("update_property_groups") & ": " & db2_SB()
   end if
end db2_UpdatePropertyGroupsString

--------------------------------------------------------------------
--------common strings--------------------------------

function db2_QItems pString
   replace comma with quote & comma & quote in pString
   return quote & pString & quote
end db2_QItems

function db2_Q pString
   return quote & pString & quote
end db2_Q

function db2_CB pString
   return "{" & pString & "}"
end db2_CB

function db2_SB pString
   return "[" & pString & "]"
end db2_SB

function db2_B pString
   return "(" & pString & ")"
end db2_B

function db2_SBQListFromCRList pLineList
   replace cr with quote & comma & quote in pLineList
   return db2_SB(quote & pLineList & quote)
end db2_SBQListFromCRList

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
------db2 Library end--------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
