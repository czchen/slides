# Introduction to PGP

*   ChangZhuo Chen (陳昌倬) <czchen@czchen.org>
*   PGP Key: [EC9F 905D 866D BE46 A896 C827 BE0C 9242 03F4 552D](http://pgp.mit.edu:11371/pks/lookup?op=vindex&search=0xBE0C924203F4552D)

---

# License

*   This slide is licensed under [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

---

# The Purpose of PGP

*   To verify a digital signature of message.
*   To send an encrypted message.

???

The characteristics of digital signature are:
*   Authentication
*   Integrity
*   Non-repudiation

---

# Digital Signature

*   Alice signs the message with __Alice's private key__.
*   Bob verifies the message with __Alice's public key__.

---

# Encryption

*   Alice encrypts the message with __Bob's public key__.
*   Bob decrypts the message with __Bob's private key__.

---

# Generate a PGP Key

*   Use [GNU Private Guard (GnuPG)](http://www.gnupg.org/) to generate a PGP key.

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
*   Generally it require 2 forms of government-issued photo ID to prove your identity in key signing party.
*   Others might reject to certify your key due to inproperly UID.

---

# Key Server

*   Stores public keys for other to download.
*   Once a key pair is generated, it shall be upload to key server for others to download.

---

# Example: Generate a PGP Key

*   Use `gpg --gen-key --expert` to create a master key with only `certify capability.

```sh
% gpg --gen-key --expert
gpg (GnuPG) 1.4.20; Copyright (C) 2015 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
Your selection? 8
```

---

# Example: Select Key Size

*   Select the longest possible keysize to ensure its safety.

```sh
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 4096
```

---

# Example: Set Expired Date

*   Select properly expired date (1 year).

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

# Key Signing Party

*   An event at which people present their public keys to others in person, who, if they are confident the key actually belongs to the person who claims it, digitally sign the certificate containing that public key and the person's name, etc. (from [wiki](https://en.wikipedia.org/wiki/Key_signing_party))
