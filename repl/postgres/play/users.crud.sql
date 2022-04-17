
SET myvar.id = 2;


INSERT INTO user_account(
  user_account_id, 
  username
) VALUES (
  current_setting('myvar.id')::int,
  'susan'
);

INSERT INTO role(role_id, name) VALUES (1, 'user');
INSERT INTO role(role_id, name) VALUES (2, 'admin');


INSERT INTO user_role(user_account_id, role_id) VALUES (1, 1);
INSERT INTO user_role(user_account_id, role_id) VALUES (1, 2);

DELETE FROM user_account WHERE user_account_id = 1;

SELECT * FROM user_account;

SELECT * FROM role;

SELECT * FROM user_role;

SELECT 
  user_account.user_account_id, 
  user_account.username,
  user_role.role_id,
  role.name
  FROM user_account
    LEFT OUTER JOIN user_role ON ( user_account.user_account_id = user_role.user_account_id)
    INNER JOIN role ON ( user_role.role_id = role.role_id)
    WHERE user_account.user_account_id = 1;


UPDATE user_account SET username = 'remi' WHERE user_account_id = 1;

