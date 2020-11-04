sbuild using QEMU
=================

These are a set of scripts that facilitate building Debian packages in a QEMU
instance using sbuild's `--chroot-mode=autopkgtest`.

While it may seem like overkill to launch a QEMU instance just to build a
package, the overhead in relation to total build time is negligible, and there
are numerous advantages:

* **Diverse environments**. You can build on any architecture for which a
  bootable image can be created (although you might not be able to use
  acceleration, for example when booting an `arm64` image on an `amd64` host).
  You can use any distribution by `debootstrap`.
* **Isolation**. You can go crazy within the instance without affecting the
  host on which it is launched (barring security vulnerabilities in QEMU, of
  course). Test suites that modify the system can be run without concern.
* **Snapshots**. You can save and reload the state of any running instance.
  This is especially useful when attempting to reproduce something: you don't
  need to _recreate_ a particular environment, you can just _save_ it.

As one might have guessed by the mode name, the very same images can also be
used to run [autopkgtest](https://salsa.debian.org/ci-team/autopkgtest) tests,
for the build result, including those with the `breaks-testbed` or
`isolation-machine` restrictions.

**Work for architectures other than `amd64` and `i386` is still in progress,
although I expect it will be added soon.**


Utilities
---------

### qemu-sbuild

A light-weight wrapper around `sbuild`. It understands a few VM-specific
arguments (CPUs, RAM, etc.), and passes all remaining arguments through to
`sbuild`. Images are used in snapshot mode, so changes are not persisted. This
not only makes the VMs fast, the image can also be used concurrently by
multiple processes.

Note that some `sbuild` options don't work in `autopkgtest` mode yet. For
example, it is not yet possible to drop into a shell after a failed build (the
bridge code does not support this yet).

See `qemu-sbuild -h` for more info.


### qemu-sbuild-update

An `sbuild-update` analog. Launches an image, and runs `apt-get update`,
`upgrade`, `clean`, an `autoremove`.

Expects only the image name as argument.


### qemu-sbuild-create

A light-weight wrapper around `autopkgtest-build-qemu` that simplifies setting
some of the options, and also generated the desired `sources.list`. Ships with
a script `modscript` that is used by `autopkgtest-build-qemu` to implement some
of the modifications.

See `qemu-sbuild-create -h` for more info.


Acceleration
------------

By adding the build user to the `kvm` group, `qemu-sbuild` can operate with
near-native performance on systems where KVM is supported:

```
$ sudo gpasswd -a <build-user> kvm
# Logout, and login
```
