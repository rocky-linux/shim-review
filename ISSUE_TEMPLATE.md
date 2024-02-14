Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
`https://github.com/rocky-linux/shim-review/tree/rockylinux-9-shim-15.8-x86_64-aarch64-20240214`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
e48af33e1efd1e87100aa920ed7c9cb797943796f9d2fcbea064b6c0bc168b9a  shimaa64.efi
5abb4d7ae6b549be1193dbd0c5a61ede7235dafa9f627539379319ca139184c9  shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
Accepted shim reviews for Rocky Linux 9 is:
* #273 : MSFT submission ID 14607686334015979
