
INSERT INTO role(role_id, name)
VALUES ($1, $2);

DELETE FROM role WHERE role_id = $1;

SELECT role.role_id, role.name FROM role
    
            WHERE role.role_id = ($1)
            ;

SELECT * FROM role;

UPDATE role SET name = ($2) WHERE role_id = ($1);
