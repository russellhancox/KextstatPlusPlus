kextstat++
==========

`kextstat++`: a better `kextstat`, if you want lots of info about a single kext.

Usage
-----

`./kextstat bundle-id <wanted-key>`

Example Output
--------------

```sh
$ ./kextstat++ com.github.osxfuse.filesystems.osxfusefs
OSBundleWiredSize = 90112
CFBundleIdentifier = com.github.osxfuse.filesystems.osxfusefs
OSBundleUUID = 7DBFEA1C-C986-3A12-9419-C09D25A6F3EA
OSBundleCPUType = 16777223 (Intel x86-64)
CFBundleVersion = 2.8.3
OSBundleStarted = YES
OSKernelResource = NO
OSBundleLoadTag = 144
OSBundleLoadAddress = 0xffffff7f83ca6000
OSBundleExecutablePath = /Library/Filesystems/osxfusefs.fs/Support/osxfusefs.kext/Contents/MacOS/osxfusefs
OSBundleDependencies = (
    1,
    4,
    3,
    7,
    5
)
OSBundlePath = /Library/Filesystems/osxfusefs.fs/Support/osxfusefs.kext
OSBundleRetainCount = 0
OSBundleCPUSubtype = 3
OSBundlePrelinked = NO
OSBundleIsInterface = NO
OSBundleLoadSize = 90112
```

```sh
$ ./kextstat++ com.github.osxfuse.filesystems.osxfusefs osbundleloadaddress
OSBundleLoadAddress = 0xffffff7f83ca6000
```
