# Introduction to GPG

*   ChangZhuo Chen (陳昌倬) <czchen@czchen.org>
*   GPG Key: [EC9F 905D 866D BE46 A896 C827 BE0C 9242 03F4 552D](http://pgp.mit.edu:11371/pks/lookup?op=vindex&search=0xBE0C924203F4552D)

---

# License

*   This slide is licensed under [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

---

# The Purposes of GPG

*   To verify a digital signature of data.
    *   Authentication
    *   Integrity
    *   Non-repudiation
*   To send an encrypted data.

???

The characteristics of digital signature are:
*   Authentication
    *   A valid signature shows that the message was sent by the particular
        user.
*   Integrity:
    *   No efficient way to modify a message and its signature to produce a new
        message with a valid signature.
*   Non-repudiation:
    *   An entity that has signed some information cannot at a later time deny
        having signed it.

References:
*   https://en.wikipedia.org/wiki/Digital_signature#Applications_of_digital_signatures

---

# When to Use

*   To verify a software downloaded from Internet.
*   To send signed messages so other can verify it.
*   To store credential information likes password manager.
*   To send encrypted messages to others.

---

# Digital Signature

*   Alice signs the message with __Alice's private key__.
*   Bob verifies the message with __Alice's public key__.

---

# Encryption

*   Alice encrypts the message with __Bob's public key__.
*   Bob decrypts the message with __Bob's private key__.

---

# Generate a GPG Key

*   Use [GNU Private Guard (GnuPG)](http://www.gnupg.org/) to generate a GPG
    key.

---

# GnuPG Terminology

*   Master Key
*   Subkey
*   Capability
*   Fingerprint
*   Revoke Certificate
*   Expired Date
*   UID
*   Key Server

---

# Master Key

*   Key of key.
    *   All subkey, UID are certified by master key.
*   Only key that can certify other's key.
*   Shall be stored in offline media.

---

# Subkey

*   The key pairs managed by master key.
*   Can be used to sign digital signature and/or encryption.

---

# Capability

*   S: The key is good for signatures.
*   E: The key is good for encryption.
*   C: The key is good to certify other keys.
    *   Only appears in master key.
*   A: The key is good for authentication (no used).

---

# Suggested Configuration

*   Master key is set to `C` only.
*   One subkey is set to `S` only.
*   One subkey is set to `E` only.

---

# Fingerprint

*   Use to identify a key (e.g. EC9F 905D 866D BE46 A896  C827 BE0C 9242 03F4 552D).
*   The last 8 characters is called short key id (e.g. 03F4 552D).
    *   Do NOT use it because it takes only 4 seconds to generate a colliding
        32bit key id.
    *   See: https://evil32.com/
*   The last 16 characters is called long key id (e.g. BE0C 9242 03F4 552D).
*   Both short key id and long key id can be used to identify a key, but they
    are not as good as fingerprint.

---

# Revoke Certificate

*   Use to revoke a key.
*   Once the key is revoked, it cannot be used anymore. Revoke certificate is
    not reversible.

---

# Expired Date

*   Can be adjust via master key.
*   It is good to set an expired date so that a key will be expired if it is
    lost and there is no revoke certificate.

---

# UID

*   UID is your identity (name + email, photo).
*   UID is certified by master key.
*   A key can have many UID for different email.
*   Generally it require 2 forms of government-issued photo ID to prove your
    identity in key signing party.
*   Others might reject to certify your key due to improperly UID.

---

# Key Server

*   Stores public keys for others to download.
*   Once a key pair is generated, it shall be upload to key server for others to download.

---

# Generate a GPG Key

*   Use `gpg --gen-key --expert` to create a master key with only `certify capability`.

```
% gpg --full-gen-key --expert
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
   (9) ECC and ECC
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)

Your selection? 8
```

---

# Select Key Size

*   Select the longest possible keysize to ensure its safety.

```
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 4096
```

---

# Set Expired Date

*   Select properly expired date (e.g. 1 year).

```sh
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 1y
```

---

# Key Exchange

*   After GPG key is generated, it is essential to let others link you with your
    key.
*   The easiest way is to join key signing party.

---

# Key Signing Party

*   An event at which people present their public keys to others in person, who,
    if they are confident the key actually belongs to the person who claims it,
    digitally sign the certificate containing that public key and the person's
    name, etc. (from [wiki](https://en.wikipedia.org/wiki/Key_signing_party))

---

# Before Key Signing Party

*   Send the public key to key server / coordinator.
*   Ensure your key fingerprint is correct.
*   Bring the government-issued photo ID. Ensure the name of UID match the name
    in government-issued photo ID.

---

# During Key Signing Party

*   Check if the person match the government-issued photo ID and the GPG key.

---

# After Key Signing Party

*   Download these keys that need to be certified (`gpg --recv-keys $KEYID`).
*   Certify these keys (`gpg --sign-key $KEYID`).
*   Export these keys (`gpg --armor -o $SIGNATURE --export $KEYID`).
*   Encrypt these keys with their encryption key (`gpg -r $KEYID $SIGNATURE`).
*   Email `$SIGNATURE` to its owner.
*   Remove all imported keys (`gpg --delete-key $KEYID`).

---

# Caff

*   In Debian based distro, there is a tool called `caff` in `signing-party`
    package that can do all the stuff.

---

# Caff Configuration Using GMail

*   Install required packages via `apt install signing-party msmtp`
*   Add the following configuration to `.caffrc` (https://wiki.debian.org/caff/msmtp):

    ```perl
    $ENV{'PERL_MAILERS'} = 'sendmail:/usr/bin/msmtp';
    $CONFIG{'mailer-send'} = ['sendmail'];
    ```

---

# Caff Configuration Using GMail (Cont.)

*   Add the following configuration to `.msmtprc` (https://wiki.debian.org/msmtp)

    ```
    defaults
    port 587
    tls on
    tls_trust_file /etc/ssl/certs/ca-certificates.crt

    account gmail
    host smtp.gmail.com
    from <username>@gmail.com
    auth on
    user <username>
    passwordeval gpg --no-tty -q -d <path/to/encrypted/app_passwords>

    account default : gmail
    ```

---

# Receive Signature from Others

*   Decrypt it (`gpg -o $SIGNATURE -d $MSG`).
*   Import it (`gpg --import $SIGNATURE`).
*   Check if the signature is correctly signature to you by sender.
*   Upload your key to key server (`gpg --send-keys $PGPKEY`).

---

# References

*   [Using OpenPGP subkeys in Debian development](https://wiki.debian.org/Subkeys).
*   [How to change the expiration date of a GPG key](https://www.g-loaded.eu/2010/11/01/change-expiration-date-gpg-key/).
*   [OpenPGP User ID Comments considered harmful](https://www.debian-administration.org/users/dkg/weblog/97)
