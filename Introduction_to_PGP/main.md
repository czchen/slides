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

# Key Signing Party

*   An event at which people present their public keys to others in person, who, if they are confident the key actually belongs to the person who claims it, digitally sign the certificate containing that public key and the person's name, etc. (from [wiki](https://en.wikipedia.org/wiki/Key_signing_party))

---

# Generate a PGP Key

*   Use [GNU Private Guard (GnuPG)](http://www.gnupg.org/) to generate a PGP key.
