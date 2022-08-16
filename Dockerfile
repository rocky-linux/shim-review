FROM  rockylinux/rockylinux:9

ENV SHIM_VERSION 15.6-1.el9.rocky.1
COPY rpmmacros /root/.rpmmacros
COPY shim-unsigned-x64-$SHIM_VERSION.src.rpm /
RUN rpm -ivh shim-unsigned-x64-$SHIM_VERSION.src.rpm
RUN dnf install -y dnf-plugins-core rpm-build
RUN dnf builddep -y  /builddir/build/SPECS/shim-unsigned-x64.spec
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-x64.spec
COPY shimx64.efi /
RUN mkdir /built_shim/
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-$SHIM_VERSION.x86_64.rpm | cpio -diu -D /built_shim
RUN ls -l /*.efi /built_shim/usr/share/shim/$SHIM_VERSION/*/shim*.efi
RUN sha256sum /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi /shimx64.efi
RUN hexdump -Cv /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi > built-x64.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -h /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi
RUN diff -u orig-x64.hex built-x64.hex
RUN cmp /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi /shimx64.efi
RUN pesign -h -P -i /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /built_shim/usr/share/shim/$SHIM_VERSION/x64/shimx64.efi /shimx64.efi
