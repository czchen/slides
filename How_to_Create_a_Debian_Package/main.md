# How to Create a Debian Package

ChangZhuo Chen (陳昌倬) <czchen@debian.org>

---

# License

This slide is licensed under [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

---

# Who am I

*   Debian Maintainer since 2013-09-11.
*   Debian Developer since 2015-09-11.
*   Maintain or comaintain [60+ packages](https://qa.debian.org/developer.php?login=czchen) in Debian.

---

# Agenda

---

# What is Debian Package

*   A file with `.deb` extension name in Debian binary package format.
    *   See `man 5 deb` in Debian based distribution.

???

*   <http://www.iana.org/assignments/media-types/application/vnd.debian.binary-package>
*   <http://manpages.debian.org/cgi-bin/man.cgi?query=deb&manpath=Debian+unstable+sid>

---

# Source of Debian package

*   Source of Debian package is in Debian source package descriptions format (extension name is `.dsc`).
*   `.dsc` contains the following information:
    *   Package information.
    *   URL of original upstream tarball with MD5, SHA1, SHA256 digest.
    *   URL of `debian` directory with MD5, SHA1, SHA256 digest.
*   Most Debian package source are maintained in version control system.
    *   Use `debcheckout <package name>` to checkout source package.

???

*   <https://wiki.debian.org/SourcePackage>

---

# Content in `debian` Directory

*   `changelog`
*   `control`
*   `copyright`
*   `rules`
*   And more ...

---

# `debian/changelog`

*   The changelog for Debian package.
*   Use `dch` to edit `changelog` to ensure the format is correct.

---

# `debian/control`

*   Contain the information of the package:
    *   `Source`: The source package name.
    *   `Maintainer`/`Uploaders`: People who maintain this package.
    *   `Standards-Version`: The Debian Policy version for this package.
    *   `Build-Depends`: The other packages used to build this package.
    *   `Package`: Binary package name. A single source package can produce many binary packages.
    *   `Depends`: The execute time dependencies for this package.
    *   `Descrption`: Description for others to find this package.

---

# `debian/copyright`

*   A copyright for the upstream and `debian` directory. Usually in <https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/> format.
*   This file is extreme important for official Debian package.
    *   You shall check copyright header for __every__ file and list them all in `copyright`.

???

*   <https://ftp-master.debian.org/REJECT-FAQ.html>

---

# `debian/rules`

*   An executable script in make format. The first line is shebang `#!/usr/bin/make -f`.
*   Mandatory targets:
    *   `build`, `build-arch`, `build-indep`, `binary`, `binary-arch`, `binary-indep`, `clean`.
*   Optional targets:
    *   `get-orig-source`, `patch`.
*   Use `debhelper` can save lots of time. For most of the package, the following is sufficient.
    ```
    %:
        dh $@
    ```

???

*   <https://www.debian.org/doc/debian-policy/ch-source.html#s-debianrules>

---

# Use `debhelper`

*   Build-Depends on `debhelper (>= ?)`. The version constraint is mandatory.
*   Split build process into many `dh_???` helper scripts.
*   Use `override_dh_???` to change helper script behavior.

---

# Create Debian Package from Upstream Source

1.  Ensure there is no `debian` directory in upstream source.
    *   Ask upstream to remove/rename `debian` in their release tarball.
2.  Use `debmake` or `dh_make` to generate Debian package template.
3.  Use `debuild` to build Debian package.
4.  Fix build error.

---

# Reference

*   [Debian -- The Universal Operating System](https://www.debian.org/)
*   [Debian New Maintainers' Guide](https://www.debian.org/doc/manuals/maint-guide/)
*   [Debian Policy Manual](https://www.debian.org/doc/debian-policy/)
kk
