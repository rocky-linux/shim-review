FROM --platform=linux/amd64 quay.io/rockylinux/rockylinux:8.9.20231119 AS amd64
ENV EL_PLATFORM el8
ENV SHIM_VERSION 15.8-2.$EL_PLATFORM

COPY rpmmacros /root/.rpmmacros
COPY shim-unsigned-x64-$SHIM_VERSION.src.rpm /
RUN rm -rfv /etc/yum.repos.d/*
COPY kickstart.repo /etc/yum.repos.d/
RUN rpm -ivh shim-unsigned-x64-$SHIM_VERSION.src.rpm
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec
RUN dnf install -y dnf-plugins-core rpm-build
RUN dnf builddep -y /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-x64.spec

FROM --platform=linux/arm64 quay.io/rockylinux/rockylinux:8.9.20231119 AS arm64
ENV EL_PLATFORM el8
ENV SHIM_VERSION 15.8-2.$EL_PLATFORM

COPY rpmmacros /root/.rpmmacros
COPY shim-unsigned-aarch64-$SHIM_VERSION.src.rpm /
RUN rm -rfv /etc/yum.repos.d/*
COPY kickstart.repo /etc/yum.repos.d/
RUN rpm -ivh shim-unsigned-aarch64-$SHIM_VERSION.src.rpm
RUN dnf install -y dnf-plugins-core rpm-build
RUN dnf builddep -y /builddir/build/SPECS/shim-unsigned-aarch64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-aarch64.spec

RUN mkdir /built_shim/
COPY shimx64.efi /
COPY shimaa64.efi /
COPY shimia32.efi /
COPY --from=amd64 /builddir/build/RPMS/x86_64/shim-unsigned-x64-$SHIM_VERSION.x86_64.rpm /built_shim/
COPY --from=amd64 /builddir/build/RPMS/x86_64/shim-unsigned-ia32-$SHIM_VERSION.x86_64.rpm /built_shim/

RUN rpm2cpio /builddir/build/RPMS/aarch64/shim-unsigned-aarch64-$SHIM_VERSION.aarch64.rpm | cpio -diu -D /built_shim
RUN rpm2cpio /built_shim/shim-unsigned-x64-$SHIM_VERSION.x86_64.rpm | cpio -diu -D /built_shim
RUN rpm2cpio /built_shim/shim-unsigned-ia32-$SHIM_VERSION.x86_64.rpm | cpio -diu -D /built_shim
RUN ls -l /*.efi /built_shim/usr/share/shim/$SHIM_VERSION/*/shim*.efi

RUN sha256sum /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi /shimx64.efi
RUN sha256sum /built_shim/usr/share/shim/$SHIM_VERSION/ia32/shimia32.efi /shimia32.efi
RUN sha256sum /built_shim/usr/share/shim/$SHIM_VERSION/aa64/shimaa64.efi /shimaa64.efi

RUN hexdump -Cv /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi > built-x64.hex
RUN hexdump -Cv /built_shim/usr/share/shim/$SHIM_VERSION/ia32/shimia32.efi > built-ia32.hex
RUN hexdump -Cv /built_shim/usr/share/shim/$SHIM_VERSION/aa64/shimaa64.efi > built-aa64.hex

RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN hexdump -Cv /shimia32.efi > orig-ia32.hex
RUN hexdump -Cv /shimaa64.efi > orig-aa64.hex

RUN diff -u orig-x64.hex built-x64.hex
RUN diff -u orig-ia32.hex built-ia32.hex
RUN diff -u orig-aa64.hex built-aa64.hex

RUN cmp /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi /shimx64.efi
RUN cmp /built_shim/usr/share/shim/$SHIM_VERSION/ia32/shimia32.efi /shimia32.efi
RUN cmp /built_shim/usr/share/shim/$SHIM_VERSION/aa64/shimaa64.efi /shimaa64.efi

RUN pesign -h -P -i /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi
RUN pesign -h -P -i /built_shim/usr/share/shim/$SHIM_VERSION/ia32/shimia32.efi
RUN pesign -h -P -i /built_shim/usr/share/shim/$SHIM_VERSION/aa64/shimaa64.efi

RUN pesign -h -P -i /shimx64.efi
RUN pesign -h -P -i /shimia32.efi
RUN pesign -h -P -i /shimaa64.efi

RUN sha256sum /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi /shimx64.efi
RUN sha256sum /built_shim/usr/share/shim/$SHIM_VERSION/ia32/shimia32.efi /shimia32.efi
RUN sha256sum /built_shim/usr/share/shim/$SHIM_VERSION/aa64/shimaa64.efi /shimaa64.efi
