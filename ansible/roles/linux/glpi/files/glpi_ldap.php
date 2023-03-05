<?php

function encrypt(string $string, ?string $key = null): string
{
        if ($key === null) {
                $key = $this->get();
        }

        if ($key === null) {
                return '';
        }

        $nonce = random_bytes(SODIUM_CRYPTO_AEAD_XCHACHA20POLY1305_IETF_NPUBBYTES);
        $encrypted = sodium_crypto_aead_xchacha20poly1305_ietf_encrypt(
                $string,
                $nonce,
                $nonce,
                $key
        );
        return base64_encode($nonce . $encrypted);
}

if( $argc !== 6 ){
    echo "Error number of arguments\n";
    exit();
}

$db_host = $argv[1];
$db_name = $argv[2];
$db_user = $argv[3];
$db_password = $argv[4];

$glpi_password = $argv[5];

$key = file_get_contents("/var/www/glpi/config/glpicrypt.key");

$conn = new mysqli($db_host, $db_user, $db_password, $db_name);
$sql = "INSERT INTO glpi_authldaps(name,host,basedn,rootdn,port,`condition`,login_field, email1_field,realname_field,firstname_field,phone_field,is_default,is_active,rootdn_passwd) VALUES ('ldap', '10.0.1.20', 'DC=eriador,DC=middle-earth,DC=local', 'glpi@eriador.middle-earth.local', 389, '(&#38;(objectClass=user)(objectCategory=person))', 'samaccountname', 'mail','sn','givenname','telephonenumber', 1, 1, '" . encrypt($glpi_password, $key) . "');";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully\n";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
