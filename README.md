This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
### What organization or people are asking to have this signed?
-------------------------------------------------------------------------------
Rocky Enterprise Software Foundation

-------------------------------------------------------------------------------
### What product or service is this for?
-------------------------------------------------------------------------------
Rocky Linux 9

-------------------------------------------------------------------------------
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
-------------------------------------------------------------------------------
Rocky Linux is a community enterprise operating system designed to be 100% bug-for-bug compatible with RHEL

-------------------------------------------------------------------------------
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.

-------------------------------------------------------------------------------
- Name: Rob Felsburg
- Position: Security Manager
- Email address: rfelsburg@resf.org
- PGP key fingerprint: DB1E 06F8 87BF 1BDB C777 4D1A C622 9FC8 C50D 63A0 keyfile is rfelsburg.pub in this repo and keyserver.ubuntu.com

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

-------------------------------------------------------------------------------
### Who is the secondary contact for security updates, etc.?
-------------------------------------------------------------------------------
- Name: Sherif Nagy
- Position: Release Engineer
- Email address: sherif@rockylinux.org
- PGP key fingerprint: CC59 76F3 3BCA 5502 837D BCB8 59F4 A40E 6CAB 25F2 keyfile is sherif.pub in this repo and keyserver.ubuntu.com

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

-------------------------------------------------------------------------------
### Were these binaries created from the 15.6 shim release tar?
Please create your shim binaries starting with the 15.6 shim release tar file: https://github.com/rhboot/shim/releases/download/15.6/shim-15.6.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.6 and contains the appropriate gnu-efi source.

-------------------------------------------------------------------------------
We are using shim 15.6 release tarball

-------------------------------------------------------------------------------
### URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/15.6
Repos are here: https://dl.rockylinux.org/pub/rocky/9/

-------------------------------------------------------------------------------
### What patches are being applied and why:
-------------------------------------------------------------------------------
No patches

-------------------------------------------------------------------------------
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
-------------------------------------------------------------------------------
Downstream RHEL like implementation

-------------------------------------------------------------------------------
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of grub affected by any of the CVEs in the July 2020 grub2 CVE list, the March 2021 grub2 CVE list, or the June 7th 2022 grub2 CVE list:
* CVE-2020-14372
* CVE-2020-25632
* CVE-2020-25647
* CVE-2020-27749
* CVE-2020-27779
* CVE-2021-20225
* CVE-2021-20233
* CVE-2020-10713
* CVE-2020-14308
* CVE-2020-14309
* CVE-2020-14310
* CVE-2020-14311
* CVE-2020-15705
* CVE-2021-3418 (if you are shipping the shim_lock module)

* CVE-2021-3695
* CVE-2021-3696
* CVE-2021-3697
* CVE-2022-28733
* CVE-2022-28734
* CVE-2022-28735
* CVE-2022-28736
* CVE-2022-28737

### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
-------------------------------------------------------------------------------
This is our 1st submission for Rocky Linux 9, however old shims hashes from Rocky Linux 8 will be provided to Microsoft and older grub is disallowed to boot via the new increased global generation number

-------------------------------------------------------------------------------
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?

-------------------------------------------------------------------------------
The below patches exists in sources
```
1957a85b0032a81e6482ca4aab883643b8dae06e
75b0cea7bf307f362057cc778efe89af4c615354
```
However `eadb2f47a3ced5c64b23b90fd2a3463f63726066` is not ported yet to the RHEL kernel but KDB is disabled by default
And the configuration setting CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is disabled

-------------------------------------------------------------------------------
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
-------------------------------------------------------------------------------
We don't use vendor_db functionality in this build

-------------------------------------------------------------------------------
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
-------------------------------------------------------------------------------
Older grub won't be able to boot due to the increase of global generation number in SBAT

-------------------------------------------------------------------------------
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
-------------------------------------------------------------------------------
Dockerfile is provided to reproduce this build

-------------------------------------------------------------------------------
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.

-------------------------------------------------------------------------------
root.log and build.log

-------------------------------------------------------------------------------
### What changes were made since your SHIM was last signed?
-------------------------------------------------------------------------------
This is our 1st submission for Rocky Linux 9, however we had a previous submission for Rocky Linux 8 #194 which was shim-15.4 + patches requested by the review board

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------
3a1cd2e7836a49de591057f23ae6deaa755453f97dd5be6b283ba3cea0fa107e  shimx64.efi

-------------------------------------------------------------------------------
### How do you manage and protect the keys used in your SHIM?
-------------------------------------------------------------------------------
Keys are stored on FIPS140-2 level 2 HSM

-------------------------------------------------------------------------------
### Do you use EV certificates as embedded certificates in the SHIM?
-------------------------------------------------------------------------------
No

-------------------------------------------------------------------------------
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( grub2, fwupd, fwupdate, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
-------------------------------------------------------------------------------
```
shim:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,2,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.rocky,2,Rocky Linux,shim,15.6,security@rockylinux.org

grub2:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,2,Free Software Foundation,grub,@@VERSION@@,https//www.gnu.org/software/grub/
grub.rhel,2,Red Hat Enterprise Linux,grub2,2.06-27.el9_0.7,mail:secalert@redhat.com
grub.rocky,2,Rocky Linux,grub2,2.06-27.el9_0.7,mail:security@rockylinux.org

fwupd:
sbat,1,UEFI shim,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
fwupd,1,Firmware update daemon,fwupd,1.7.4,https://github.com/fwupd/fwupd
fwupd.rocky,1,Rocky Linux,fwupd,1.7.4,mail:security@rockylinux.org
```
-------------------------------------------------------------------------------
### Which modules are built into your signed grub image?
-------------------------------------------------------------------------------
```
all_video boot blscfg btrfs cat configfile cryptodisk echo ext2 fat font
gcry_rijndael gcry_rsa gcry_serpent gcry_sha256 gcry_twofish gcry_whirlpool
gfxmenu gfxterm gzio halt hfsplus http increment iso9660 jpeg loadenv loopback
linux lvm luks mdraid09 mdraid1x minicmd net normal part_apple part_msdos
part_gpt password_pbkdf2 png reboot regexp search search_fs_uuid search_fs_file
search_label serial sleep syslinuxcfg test tftp video xfs efi_netfs efifwsetup
efinet lsefi lsefimmap connectefi backtrace chain usb usbserial_common
usbserial_pl2303 usbserial_ftdi usbserial_usbdebug keylayouts at_keyboard
```

-------------------------------------------------------------------------------
### What is the origin and full version number of your bootloader (GRUB or other)?
-------------------------------------------------------------------------------
grub2-2.06-27.el9_0.7 https://git.rockylinux.org/staging/rpms/grub2/-/tree/r9 which is comes from RHEL9


-------------------------------------------------------------------------------
### If your SHIM launches any other components, please provide further details on what is launched.
-------------------------------------------------------------------------------
Also launches fwupd

-------------------------------------------------------------------------------
### If your GRUB2 launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
-------------------------------------------------------------------------------
grub2 verifies signatures on booted kernels via shim. fwupd does not include
code to launch other binaries, it can only load UEFI Capsule updates.

-------------------------------------------------------------------------------
### How do the launched components prevent execution of unauthenticated code?
-------------------------------------------------------------------------------
grub2 verifies signatures on booted kernels via shim. fwupd does not include
code to launch other binaries, it can only load UEFI Capsule updates.

-------------------------------------------------------------------------------
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
-------------------------------------------------------------------------------
No

-------------------------------------------------------------------------------
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
-------------------------------------------------------------------------------
Downstream kernel from RHEL9 `kernel-5.14.0-70.22.1.el9_0` which based on 5.14.0, plus a full compliment of patches for Secure Boot and relevant bug fixes.


-------------------------------------------------------------------------------
### Add any additional information you think we may need to validate this shim.
-------------------------------------------------------------------------------
This is our 1st Rocky Linux 9 submission, however have accepted submission before for Rocky Linux 8 #194
