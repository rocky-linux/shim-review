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
`https://github.com/rocky-linux/shim-review/tree/rockylinux-8-shim-15.8-ia32-x86_64-aarch64-20240214`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
b5fdf63484a107873da10b27a8e0f6dc8a551ba75383ffcce73d8094a7468629  shimaa64.efi
f6e74fd1480c862668b2b0365941b68bca98cfff24b012dd4c730ac57838e1f5  shimia32.efi
b2ef8d3f2c0112a2bceda8d166567a14a68cceadc9338275afbd0310f82118da  shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
Accepted shim reviews for Rocky Linux 8 are:
* #274 : MSFT submission ID 14460228699919626
* #194 : MSFT submission ID 13765341761864248 
