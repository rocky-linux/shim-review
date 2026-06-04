This repo is for review of requests for signing shim. To create a request for review:

- clone this repo (preferably fork it)
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push it to GitHub
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

As of 20 October 2025, shims sent to Microsoft will be signed with the 2011 and 2023 keys. For each shim you submit, you will receive two copies back, each signed by a different key. Here is the latest information from Microsoft: https://techcommunity.microsoft.com/blog/hardware-dev-center/signing-with-the-new-2023-microsoft-uefi-certificates-what-submitters-need-to-kn/4455787

New signing requirements have also taken effect, and are available here: https://techcommunity.microsoft.com/blog/hardware-dev-center/updated-microsoft-uefi-signing-requirements/1062916 Please note that undergoing this shim review exempts you from yearly security audits, as long as your shim only hands off to open source boot loaders.

Hint: check the [docs](./docs/) directory in this repo for guidance on submission and getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
Organization name and website:  

* The Rocky Enterprise Software Foundation
* https://resf.org
* https://rockylinux.org

*******************************************************************************
### What's the legal data that proves the organization's genuineness?
The reviewers should be able to easily verify, that your organization is a legal entity, to prevent abuse.
Provide the information, which can prove the genuineness with certainty.
*******************************************************************************
Company/tax register entries or equivalent:  
(a link to the organization entry in your jurisdiction's register will do)  

* File number: 4429978
* URL: https://icis.corp.delaware.gov/ecorp/entitysearch/NameSearch.aspx
* Also you can search by name

The public details of both your organization and the issuer in the EV certificate used for signing .cab files at Microsoft Hardware Dev Center File Signing Services.  
(**not** the CA certificate embedded in your shim binary)

Example:

```
Issuer: O=MyIssuer, Ltd., CN=MyIssuer EV Code Signing CA
Subject: C=XX, O=MyCompany, Inc., CN=MyCompany, Inc.
```

```
  Public key type:  ECCP384
  Subject DN:       1.3.6.1.4.1.311.60.2.1.3=US,1.3.6.1.4.1.311.60.2.1.2=Delaware,2.5.4.15=Private Organization,CN=The Rocky Enterprise Software Foundation Inc,2.5.4.5=4429978,O=The Rocky Enterprise Software Foundation Inc,L=Albany,ST=California,C=US
  Issuer DN:        CN=SSL.com EV Code Signing Intermediate CA RSA R3,O=SSL Corp,L=Houston,ST=Texas,C=US
  Serial:           00:00:00:00:55:2a:38:00:b5:a4:4d:8c:4f:fe:18:2b:f5:63:85:d4
  Fingerprint:      55f6bc79b9b242f87f03b78d09ff570c01a462138d2283e55107f34a39466375
  Not before:       2025-01-30T09:42:04+00:00
  Not after:        2027-11-19T21:07:04+00:00
```

*******************************************************************************
### What product or service is this for?
*******************************************************************************
Rocky Linux 8 

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
Rocky Linux is a community enterprise operating system designed to be 100% bug-for-bug compatible with RHEL and we sign our kernels and bootlaoder

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
We sign our own SIGs kernel and we will be signing systemd-boot alongside some out-of-tree modules for our users / community

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
Please upload the PGP keys to a well-known keyserver like keyserver.ubuntu.com and/or include them in the review as an .asc file.
*******************************************************************************
- Name: Rob Felsburg
- Position: Security Manager
- Email address: rfelsburg@resf.org
- PGP key fingerprint: DB1E 06F8 87BF 1BDB C777 4D1A C622 9FC8 C50D 63A0

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Sherif Nagy
- Position: Release Engineer
- Email address: sherif@rockylinux.org
- PGP key fingerprint: CC59 76F3 3BCA 5502 837D BCB8 59F4 A40E 6CAB 25F2

*******************************************************************************
### Were these binaries created from the 16.1 shim release tar?
Please create your shim binaries starting with the 16.1 shim release tar file: https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/16.1 and contains the appropriate gnu-efi source.

Make sure the tarball is correct by verifying your download's checksum
(SHA256, SHA512) with the following ones:

```
46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603  shim-16.1.tar.bz2
ca5f80e82f3b80b622028f03ef23105c98ee1b6a25f52a59c823080a3202dd4b9962266489296e99f955eb92e36ce13e0b1d57f688350006bba45f2718f159fb  shim-16.1.tar.bz2
```

Make sure that you've verified that your build process uses that file
as a source of truth (excluding external patches) and its checksum
matches. You can also further validate the release by checking the PGP
signature: there's [a detached
signature](https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2.asc)

The release is signed by the maintainer Peter Jones - his master key
has the fingerprint `B00B48BC731AA8840FED9FB0EED266B70F4FEF10` and the
signing sub-key in the signature here has the fingerprint
`02093E0D19DDE0F7DFFBB53C1FD3F540256A1372`. A copy of his public key
is included here for reference:
[pjones.asc](https://github.com/rhboot/shim-review/blob/main/pjones.asc)

Once you're sure that the tarball you are using is correct and
authentic, please confirm this here with a simple *yes*.

A short guide on verifying public keys and signatures should be available in the [docs](./docs/) directory.
*******************************************************************************
yes

*******************************************************************************
### URL for a repo that contains the exact code which was built to result in your binary:
Hint: If you attach all the patches and modifications that are being used to your application, you can point to the URL of your application here (*`https://github.com/YOUR_ORGANIZATION/shim-review`*).

You can also point to your custom git servers, where the code is hosted.
*******************************************************************************
https://github.com/rhboot/shim/tree/16.1

*******************************************************************************
### What patches are being applied and why:
Mention all the external patches and build process modifications, which are used during your building process, that make your shim binary be the exact one that you posted as part of this application.
*******************************************************************************
None

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************
We are submitting both NX and non-NX versions for Rocky 8 in this build

*******************************************************************************
### What exact implementation of Secure Boot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
Skip this, if you're not using GRUB2.
*******************************************************************************
Downstream RHEL like implementation

*******************************************************************************
### Do you have fixes for all the following GRUB2 CVEs applied?
**Skip this, if you're not using GRUB2, otherwise make sure these are present and confirm with _yes_.**

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
* February 2025
  * Details: https://lists.gnu.org/archive/html/grub-devel/2025-02/msg00024.html, SBAT increase to 5
  * CVE-2024-45774
  * CVE-2024-45775
  * CVE-2024-45776
  * CVE-2024-45777
  * CVE-2024-45778
  * CVE-2024-45779
  * CVE-2024-45780
  * CVE-2024-45781
  * CVE-2024-45782
  * CVE-2024-45783
  * CVE-2025-0622
  * CVE-2025-0624
  * CVE-2025-0677
  * CVE-2025-0678
  * CVE-2025-0684
  * CVE-2025-0685
  * CVE-2025-0686
  * CVE-2025-0689
  * CVE-2025-0690
  * CVE-2025-1118
  * CVE-2025-1125
*******************************************************************************
We have all those patches 

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 5?
Skip this, if you're not using GRUB2, otherwise do you have an entry in your GRUB2 binary similar to:  
`grub,5,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`?
*******************************************************************************
We are still in `grub,3` due to upstream RHEL, see issue #546 , however the grub does have the fixes for all those CVEs and we blocking the affected grubs using dbx in this build, a list of the revoked grubs versions are in the extra info in this readme

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
If you had no previous signed shim, say so here. Otherwise a simple _yes_ will do.
*******************************************************************************
yes to both

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
Hint: upstream kernels should have all these applied, but if you ship your own heavily-modified older kernel version, that is being maintained separately from upstream, this may not be the case.  
If you are shipping an older kernel, double-check your sources; maybe you do not have all the patches, but ship a configuration, that does not expose the issue(s).
*******************************************************************************
All mentioned patches are applied

*******************************************************************************
### How does your signed kernel enforce lockdown when your system runs with Secure Boot enabled?
Hint: If it does not, we are not likely to sign your shim.
*******************************************************************************
Kernel forces lockdown when secureboot is enabled

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
No, it is RHEL kernel

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
Yes, we use ephemeral keys per kernel build

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
We don't use vendor_db for this build

*******************************************************************************
### If you are re-using the CA certificate from your last shim binary, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs mentioned earlier to vendor_dbx in shim. Please describe your strategy.
This ensures that your new shim+GRUB2 can no longer chainload those older GRUB2 binaries with issues.

If this is your first application or you're using a new CA certificate, please say so here.
*******************************************************************************
In this case, GRUB2 revocation is done via dbx and with next release, we will use a recent revocation policy 

*******************************************************************************
### Is the Dockerfile in your repository the recipe for reproducing the building of your shim binary?
A reviewer should always be able to run `docker build .` to get the exact binary you attached in your application.

Hint: Prefer using *frozen* packages for your toolchain, since an update to GCC, binutils, gnu-efi may result in building a shim binary with a different checksum.

If your shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case, what the differences would be and what build environment (OS and toolchain) is being used to reproduce this build? In this case please write a detailed guide, how to setup this build environment from scratch.
*******************************************************************************
Docker filed is provided `Dockerfile_aa64` and `Dockerfile_x64`

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
root_x64.log, build_x64.log and root_aa64.log, build_aa64.log

*******************************************************************************
### What changes were made in the distro's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..

Skip this, if this is your first application for having shim signed.
*******************************************************************************
Nothing changed since our last submission

*******************************************************************************
### What is the SHA256 hash of your final shim binary?
*******************************************************************************
```
012fb27455bb9c4aae989ba41f1199222e4487e98c2413aa8eaf4ef8bb1904cc  shimia32.efi
fc030b730e366f6d8fdfc012bf633cc7327c84d8731d5e1fde5de4fc7a298f76  shimia32.nx.efi
467c5346fe6de8eb3287ec9dc972d1d45eccfb7a6164ee70ae645bff324d76b3  shimx64.efi
a5b95eaa0445fa37c51e24718f5cb8ea518e1aa9fecab147c79fc8b9b8a7daba  shimx64.nx.efi
310b5f0589afbaf5142562bb30a2fc33a8c5e53a11c7955c3d38f173787aaf84  shimaa64.efi
c3fa1527d3d496deba6f2b2b560a749e138432991560ddd29061d36663652d33  shimaa64.nx.efi
```

*******************************************************************************
### How do you manage and protect the keys used in your shim?
Describe the security strategy that is used for key protection. This can range from using hardware tokens like HSMs or Smartcards, air-gapped vaults, physical safes to other good practices.
*******************************************************************************
We are hosting the keys in HSM FIPS 140-2 level 2 module with restricted access

*******************************************************************************
### Do you use EV certificates as embedded certificates in the shim?
A _yes_ or _no_ will do. There's no penalty for the latter.
*******************************************************************************
Currently, we are not providing signed systemd-boot

*******************************************************************************
### Are you embedding a CA certificate in your shim?
A _yes_ or _no_ will do. There's no penalty for the latter. However,
if _yes_: does that certificate include the X509v3 Basic Constraints
to say that it is a CA? See the [docs](./docs/) for more guidance
about this.
*******************************************************************************
Yes, we include a CA and yes it includes X509v3 constraints

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide the exact SBAT entries for all binaries you are booting directly through shim.
Hint: The history of SBAT and more information on how it works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md). That document is large, so for just some examples check out [SBAT.example.md](https://github.com/rhboot/shim/blob/main/SBAT.example.md)

If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), make sure you have their SBAT entries preserved and that you **append** your own (don't replace theirs) to simplify revocation.

**Remember to post the entries of all the binaries. Apart from your bootloader, you may also be shipping e.g. a firmware updater, which will also have these.**

Hint: run `objcopy --dump-section .sbat=/dev/stdout YOUR_EFI_BINARY` to get these entries. Paste them here. Preferably surround each listing with three backticks (\`\`\`), so they render well.
*******************************************************************************
SHIM x86/aa64:
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.rocky,3,Rocky Linux,shim,16.1,mailto:security@rockylinux.org
```
Grub2 x86/aa64 "we have a PR to fix the typo":
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,3,Free Software Foundation,grub,2.02,https//www.gnu.org/software/grub/
grub.rh,2,Red Hat,grub2,2.02-170.el8_10.1,mailto:secalert@redhat.com
grub.rocky,2,Rocky Linux,grub2,2.02-170.el8_10.1.rocky.0.2,mail:security@rockylinux.org
```
Fwupd x68/aa64
```
sbat,1,UEFI shim,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
fwupd-efi,1,Firmware update daemon,fwupd-efi,1.3,https://github.com/fwupd/fwupd-efi
fwupd-efi.rhel,1,Red Hat Enterprise Linux,fwupd,1.7.8,mail:secalert@redhat.com
fwupd-efi.rocky,1,Rocky Linux,fwupd,1.7.8,mail:security@rockylinux.org
```

*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
Skip this, if you're not using GRUB2.

Hint: this is about those modules that are in the binary itself, not the `.mod` files in your filesystem.
*******************************************************************************
For x86:
```
all_video boot blscfg cat configfile cryptodisk echo ext2 fat font gcry_rijndael gcry_rsa gcry_serpent gcry_sha256 gcry_twofish gcry_whirlpool gfxmenu gfxterm gzio halt http increment iso9660 jpeg loadenv loopback linux lvm luks mdraid09 mdraid1x minicmd net normal part_apple part_msdos part_gpt password_pbkdf2 png reboot regexp search search_fs_uuid search_fs_file search_label serial sleep syslinuxcfg test tftp video xfs backtrace chain usb usbserial_common usbserial_pl2303 usbserial_ftdi usbserial_usbdebug keylayouts at_keyboard
```
for aa64:
```
all_video boot blscfg cat configfile cryptodisk echo ext2 fat font gcry_rijndael gcry_rsa gcry_serpent gcry_sha256 gcry_twofish gcry_whirlpool gfxmenu gfxterm gzio halt http increment iso9660 jpeg loadenv loopback linux lvm luks mdraid09 mdraid1x minicmd net normal part_apple part_msdos part_gpt password_pbkdf2 png reboot regexp search search_fs_uuid search_fs_file search_label serial sleep syslinuxcfg test tftp video xfs efi_netfs efifwsetup efinet lsefi lsefimmap connectefi

```

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************
We don't sign systemd-boot

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************
grub2-2.02-170.el8_10.1

*******************************************************************************
### If your shim launches any other components apart from your bootloader, please provide further details on what is launched.
Hint: The most common case here will be a firmware updater like fwupd.
*******************************************************************************
Also launches fwupd

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
Skip this, if you're not using GRUB2 or systemd-boot.
*******************************************************************************
grub2 verifies signatures on booted kernels via shim. fwupd does not include code to launch other binaries, it can only load UEFI Capsule updates.

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
Summarize in one or two sentences, how your secure bootchain works on higher level.
*******************************************************************************
All component has .sbat self checks and secureboot validation

*******************************************************************************
### Does your shim load any loaders that support loading unsigned kernels (e.g. certain GRUB2 configurations)?
*******************************************************************************
No

*******************************************************************************
### What kernel are you using? Which patches and configuration does it include to enforce Secure Boot?
*******************************************************************************
kernel-4.18.0-553.126.1.el8_10 patches mentioned above, enforces lockdown when secureboot is enabled

*******************************************************************************
### What contributions have you made to help us review the applications of other applicants?
The reviewing process is meant to be a peer-review effort and the best way to have your application reviewed faster is to help with reviewing others. We are in most cases volunteers working on this venue in our free time, rather than being employed and paid to review the applications during our business hours. 

A reasonable timeframe of waiting for a review can reach 2-3 months. Helping us is the best way to shorten this period. The more help we get, the faster and the smoother things will go.

For newcomers, the applications labeled as [*easy to review*](https://github.com/rhboot/shim-review/issues?q=is%3Aopen+is%3Aissue+label%3A%22easy+to+review%22) are recommended to start the contribution process.
*******************************************************************************
We always participate in the peer-review process for other distros, usually RHEL based ones.

*******************************************************************************
### Add any additional information you think we may need to validate this shim signing application.
*******************************************************************************
List for the revoked grubs in this build:

Rocky 8:
```
grub2-2.02-99.el8_4.1.1
grub2-2.02-142.el8_7.3.rocky.0.2
grub2-2.02-156.el8.rocky.0.1
grub2-2.02-123.el8_6.8.rocky.0.1
grub2-2.02-142.el8.rocky.0.2
grub2-2.02-99.el8_4.1.2.1.1
grub2-2.02-148.el8.rocky.0.3
grub2-2.02-158.el8_10.rocky.0.1
grub2-2.02-123.el8
grub2-2.02-150.el8.rocky.0.3
grub2-2.02-148.el8_8.1.rocky
grub2-2.02-106.el8.0.2
grub2-2.02-150.el8.rocky
grub2-2.02-150.el8.rocky
grub2-2.02-99.el8
grub2-2.02-123.el8_6.8
grub2-2.02-123.el8_6.8.rocky.0.2
grub2-2.02-142.el8_7.1.rocky.0.2
```
Rocky 9:
```
grub2-2.06-46.el9_1.5.rocky.0.2
grub2-2.06-61.el9_2.1.rocky.0.2
grub2-2.06-70.el9_3.1.rocky.0.2
grub2-2.06-70.el9_3.2.rocky.0.2
grub2-2.06-70.el9_3.2.rocky.0.3
grub2-2.06-70.el9_3.2.rocky.0.4
grub2-2.06-70.el9_3.2.rocky.0.5
grub2-2.06-77.el9
grub2-2.06-80.el9_4
grub2-2.06-82.el9_4
grub2-2.06-92.el9
grub2-2.06-93.el9_5
grub2-2.06-94.el9_5
```
