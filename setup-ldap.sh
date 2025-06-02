#!/usr/bin/env bash

DOMAIN="dc=xerus-augmented,dc=ts,dc=net"
PEOPLE_BUCKET="ou=people,$DOMAIN"
GROUP_BUCKET="ou=groups,$DOMAIN"

run() {
  nextcloud-occ ldap:set-config s01 "$@"
}

nextcloud-occ app:install user_ldap
nextcloud-occ app:enable user_ldap
nextcloud-occ ldap:create-empty-config

# Initial connection parameters
run ldapHost "ldap://localhost"
run ldapPort 389
run ldapAgentName "uid=nextcloud,$PEOPLE_BUCKET"
read -rsp "What is your password: "
run ldapAgentPassword "$REPLY"

run ldapBase "$DOMAIN"
run ldapBaseUsers "$PEOPLE_BUCKET"
run ldapBaseGroups "$GROUP_BUCKET"
run ldapConfigurationActive 1
run ldapLoginFilter "(&(memberOf=cn=nextcloud_users,$GROUP_BUCKET)(uid=%uid))"
run ldapUserFilter "(memberOf=cn=nextcloud_users,$GROUP_BUCKET)"
run ldapUserFilterMode 0
run ldapUserFilterObjectclass person
run turnOnPasswordChange 0
run ldapCacheTTL 600
run ldapExperiencedAdmin 0
run ldapEmailAttribute "mail"
run ldapLoginFilterEmail 0
run ldapLoginFilterUsername 1
run ldapMatchingRuleInChainState unknown
run ldapNestedGroups 0
run ldapPagingSize 500
run ldapTLS 0
run ldapUserAvatarRule default
run ldapUserDisplayName cn
run ldapuserFilterMode 1
run ldapUuidGroupAttribute auto
run ldapUuidUserAttribute auto
run ldapExpertUsernameAttr uid
