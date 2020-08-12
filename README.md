sbuild using QEMU
=================

These are a set of scripts that facilitate building Debian packages in a QEMU
instance using sbuild's `--chroot-mode=autopkgtest`.

While it may seem like overkill to launch a QEMU instance just to build a
package, there are numerous advantanges:

* **Diverse environments**. You can build on any architecture for which a
  bootable image can be created (although you might not be able to use
  acceleration, for example when booting an `arm64` image on an `amd64` host).
  You can use any supported distribution.
* **Isolation**. You can go crazy within the instance without affecting the
  host on which it is launched (barring security vulnerabilities in QEMU, of
  course). Test suites that modify the system can be run free of concern.
* **Snapshots**. You can save and reload the state of any running instance.
  This is especially useful when attempting to reproduce something: you don't
  need to _recreate_ a particular environment, you can just _save_ it.

As one might have guessed by the mode name, the very same images can also be
used to run [autopkgtest](https://salsa.debian.org/ci-team/autopkgtest) tests,
for the build result, including those with the `breaks-testbed` or
`isolation-machine` restrictions.
