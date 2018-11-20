--
-- https://www.mediawiki.org/wiki/Manual:SQL_patch_file
-- extension oauth2client_user SQL schema
--
-- Note: null allowed on wiki_user_id to allow user deleting/merging
--

BEGIN;

CREATE TABLE /*_*/`oauth2client_user` (
    `wiki_user_id` INT(10) UNIQUE,
    `auth_user_id` VARCHAR(255) UNIQUE,
    PRIMARY KEY (`auth_user_id`)
);

COMMIT;
