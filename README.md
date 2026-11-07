# x11appjail-base

OCI base image to create AppJails for the x11appjail project.

github.com/DtxdF/x11appjail

<img src="https://avatars.githubusercontent.com/u/124508626?s=200&v=4" width="30%" height="auto" alt="x11appjail-base logo">

## How to use this Makejail

```sh
appjail makejail \
    -j x11appjail \
    -f gh+AppJail-makejails/x11appjail-base \
    -o container="args:--pull"
```

### Arguments (stage: build)

* `x11appjail_from` (default: `ghcr.io/appjail-makejails/x11appjail-base`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `x11appjail_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).


## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.1-x11
      containerfile: Containerfile.x11
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.1"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
    - tag: 15.1-nox11
      containerfile: Containerfile.nox11
      args:
        FREEBSD_RELEASE: "15.1"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
```
