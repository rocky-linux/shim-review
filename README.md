This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch
- approval is ready when you have accepted tag

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
Rocky Enterprise Software Foundation

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Rocky Linux 8

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
Rocky Linux is a community enterprise operating system designed to be 100% bug-for-bug compatible with RHEL and replacing CentOS 8 since it will be EOL this year

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Rob Felsburg
- Position: Security Manager
- Email address: rfelsburg@resf.org
- PGP key: https://github.com/rocky-linux/shim-review/blob/master/rfelsburg.pub

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Sherif Nagy
- Position: Release Engineer
- Email address: sherif@rockylinux.org
- PGP key: https://github.com/rocky-linux/shim-review/blob/master/sherif.pub 

-------------------------------------------------------------------------------
Please create your shim binaries starting with the 15.4 shim release tar file:
https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
the appropriate gnu-efi source.
-------------------------------------------------------------------------------
Yes, we are using shim 15.4 release tarball

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
Shim SRPM is here: https://github.com/rocky-linux/shim-review/raw/master/shim-unsigned-x64-15.4-4.el8.1.2.src.rpm
Repos are here: https://dl.rockylinux.org/stg/rocky/8/

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Few patch based on issue https://github.com/rhboot/shim-review/issues/165:

- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0001-Fix-handling-of-ignore_db-and-user_insecure_mode.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0002-shim-15.4-branch-update-.gitmodules-to-point-at-shim.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0003-Fix-a-broken-file-header-on-ia32.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0004-mok-allocate-MOK-config-table-as-BootServicesData.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0005-Don-t-call-QueryVariableInfo-on-EFI-1.10-machines.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0006-Post-process-our-PE-to-be-sure.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0007-Relax-the-check-for-import_mok_state.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0008-SBAT.md-trivial-fixes.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0009-SBAT.md-fix-will-should.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0010-shim-another-attempt-to-fix-load-options-handling.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0011-.gitignore-ignore-.gdb-not-just-.gdbinit.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0012-shim-rename-pause-to-wait_for_debug.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0013-test.h-make-some-of-the-asserts-a-little-more-friend.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0014-test.h-add-some-decls-for-some-of-the-stuff-in-efili.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0015-test.c-Conditionally-do-not-declare-stuff-that-s-in-.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0016-Make-test-cases-link-against-libefi.a.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0017-test.c-add-some-simple-mock-functions-for-BS-Allocat.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0018-test.h-add-assert_not_equal_.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0019-test-Add-a-basic-traceback-printer.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0020-shim-move-the-bulk-of-set_second_stage-to-its-own-fi.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0021-Add-a-tester-for-parse_load_options.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0022-shim-don-t-fail-on-the-odd-LoadOptions-length.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0023-arm-aa64-fix-the-size-of-.rela-sections.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0024-mok-fix-potential-buffer-overrun-in-import_mok_state.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0025-mok-relax-the-maximum-variable-size-check.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/0026-Don-t-unhook-ExitBootServices-when-EBS-protection-is.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/PR393-1.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/PR393-2.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/PR396.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/PR399-1.patch
- https://git.rockylinux.org/staging/rpms/shim-unsigned-x64/-/blob/r8/SOURCES/PR399-2.patch

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2: is CVE-2020-14372, CVE-2020-25632,
 CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233,
 CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311,
 CVE-2020-15705, and if you are shipping the shim_lock module CVE-2021-3418
-------------------------------------------------------------------------------
All those exists and the signed bootloaders are derived from grub 2.02 with all of the relevant patches.

-------------------------------------------------------------------------------
What exact implementation of Secureboot in GRUB2 ( if this is your bootloader ) you have ?
* Upstream GRUB2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
-------------------------------------------------------------------------------
RHEL like implementation

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2, and previous shims were trusting affected
by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-14372,
  CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2 builds ?
-------------------------------------------------------------------------------
This is our first shim submission

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
We have validated that all those commits present:

```
475fb4e8b2f4444d1d7b406ff3a7d21bc89a1e6f
1957a85b0032a81e6482ca4aab883643b8dae06e
612bd01fc6e04c3ce9eb59587b4a7e4ebd6aff35
75b0cea7bf307f362057cc778efe89af4c615354
435d1a471598752446a72ad1201b3c980526d869
```

And the configuration setting CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is disabled.

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are allow-listed hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
We don't use vendor_db functionality in this build

-------------------------------------------------------------------------------
If you are re-using a previously used (CA) certificate, you will need
to add the hashes of the previous GRUB2 binaries to vendor_dbx in shim
in order to prevent GRUB2 from being able to chainload those older GRUB2
binaries. If you are changing to a new (CA) certificate, this does not
apply. Please describe your strategy.
-------------------------------------------------------------------------------
We are not reusing any previously used CA, this is our first submission

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and the differences would be.
-------------------------------------------------------------------------------
Dockerfile is provided to reproduce this build

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
root.log and build.log

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
New vendor - First submission
