INSERT INTO user_account(
  user_account_id, 
  username, 
  email, 
  email_confirmed, 
  passwordHash, 
  passwordSalt, 
  status, 
  two_factor_enabled, 
  concurrency_stamp, 
  access_failed_count, 
  lockout_end, 
  lockout_enabled
) VALUES (
  $1, 
  $2, 
  $3, 
  $4, 
  $5, 
  $6, 
  $7, 
  $8, 
  $9, 
  $10, 
  $11, 
  $12
);

DELETE FROM user_account WHERE user_account_id = $1;

SELECT 
  user_account.user_account_id, 
  user_account.username, 
  user_account.email, 
  user_account.email_confirmed, 
  user_account.passwordHash, 
  user_account.passwordSalt, 
  user_account.status, 
  user_account.two_factor_enabled, 
  user_profile.phone_number, 
  user_profile.phone_number_confirmed, 
  user_account.concurrency_stamp, 
  user_account.access_failed_count, 
  user_account.lockout_end, 
  user_account.lockout_enabled 
  FROM user_account
    LEFT OUTER JOIN common.user_role ON (
      user_account.user_account_id = common.user_role.user_account_id
    )
    LEFT OUTER JOIN common.user_profile ON (
      user_account.user_account_id = common.user_profile.user_account_id
    )
    WHERE user_account.user_account_id = ($1);

SELECT * FROM user_account;

UPDATE user_account SET 
  username = ($2), 
  email = ($3), 
  email_confirmed = ($4), 
  passwordHash = ($5), 
  passwordSalt = ($6), 
  status = ($7), 
  two_factor_enabled = ($8), 
  concurrency_stamp = ($9), 
  access_failed_count = ($10), 
  lockout_end = ($11), 
  lockout_enabled = ($12) 
  WHERE user_account_id = ($1);

