# Bootable container demo

A bootable container is just a... container!

```
podman run --pull=newer --rm -it quay.io/centos-boot/fedora-tier-1:eln
```

But a weird one:

```
rpm -q kernel
```

Can we boot it?

```
sudo ./osbuild-deploy-container --store ~/osbuild-store --config config.json -imageref quay.io/centos-boot/fedora-tier-1:eln
```

`osbuild-deploy-container is based on the [Achilleas' experimental `osbuild/images` branch](https://github.com/achilleas-k/images/tree/bifrost-image).

Let's boot it!

```
qemu-system-x86_64 -M accel=kvm -cpu host  -smp 2 -m 4096 -net nic,model=virtio -net user,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80 -snapshot image/disk.img
```

Now let's customize (show Containerfile) and build!

```
podman build -t bootable-caddy .
```

Now I have a customized container. Building on a developer's machine is definitely not a thing that you should do in prod.

Let's use GitHub for my building needs (create a repo, show the workflow, push).
```
git add .
git commit
git remote add origin git@github.com:ondrejbudai/bootable-webserver.git
git push origin main
```

Now this is the greatest advantage of bootable containers imho: Everyone nowadays have a pipeline for building containers and a container registry (or you can just use GitHub/GitLab for free).

```
sudo bootc switch --no-signature-verification ghcr.io/ondrejbudai/bootable-webserver
sudo shutdown -r now
``` 

Voilà! Now we have a working VM with a webserver and I basically just used standard container tooling.

FROM in a Containerfile can be very simply changed! Imagine going from CentOS Stream to RHEL and just getting support!
