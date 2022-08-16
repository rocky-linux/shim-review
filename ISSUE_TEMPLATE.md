Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

-------------------------------------------------------------------------------
### What is the link to your tag in a repo cloned from rhboot/shim-review?
-------------------------------------------------------------------------------
`https://github.com/rocky-linux/shim-review/tree/refs/tags/rockylinux-9-shim-15.6-x86_64-20220816`

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------
3a1cd2e7836a49de591057f23ae6deaa755453f97dd5be6b283ba3cea0fa107e  shimx64.efi

-------------------------------------------------------------------------------
### What is the link to your previous shim review request (if any, otherwise N/A)?
-------------------------------------------------------------------------------
For Rocky Linux 8 we have #194 , this is our 1st submission for Rocky Linux 9
