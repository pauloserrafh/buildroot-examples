# buildroot-examples

[EN]
This projects aims to provide examples for adding your project to buildroot, inside and outside the tree, using qemu.
[Instructions in english](README.md)

**NOTE:** This should be always up to date. All the changes must be reflected AT LEAST on this README and on as many of the other languages as possible.
Always update the hash/tag on README when making changes.

[BR]
Esse projeto provê exemplos para adicionar seus projetos ao buildroot, tanto modificando diretamente a árvore do buildroot quanto fora dela, utilizando o qemu como plataforma.
[Instruções em português](README.pt-br.md)

**NOTA:** As instruções em BR podem estar desatualizadas. [A página em EN](README.md) deve ser a referência oficial. Verifique o hash/tag que o README aponta.
Sempre que forem feitas mudanças, atualize o hash/tag caso o README também tenha sido atualizado.


# Table of Contents
- [buildroot-examples](#buildroot-examples)
- [Table of Contents](#table-of-contents)
- [Setup environment](#setup-environment)
- [Building on buildroot's tree](#building-on-buildroots-tree)
- [Run/Flash image](#runflash-image)
  - [qemu](#qemu)
  - [Using USB flash drive](#using-usb-flash-drive)

# Setup environment
Regardless of the approach to be used, buildroot needs to be cloned.
If you do not wish to clone it inside this directory, change the paths accordingly.

1. Clone buildroot from the oficial repository or from github mirror:
```bash
git clone https://git.buildroot.net/buildroot/ buildroot
```
OR
```bash
git clone https://github.com/buildroot/buildroot.git buildroot
```

2. It is recommended to use the LTS version, rather than the most recent version as it may be unstable (check the [LTS at the time](https://buildroot.org/download.html)):
```bash
cd buildroot

git checkout 2021.02.3 -b simon_game_buildroot

cd -
```

# Building on buildroot's tree
1. Copy the directory `package/simon-game/` into `buildroot/package`:
```bash
cp -r package/simon-game/ buildroot/package/
```

2. Move into the `buildroot/` directory:
```bash
cd buildroot
```

3. Edit the file `package/Config.in`, adding `source "package/simon-game/Config.in"` under the `menu "Games"` list.

4. Create the base configurations:
```bash
make qemu_x86_64_defconfig
```

5. Open the interactive menu to configure the custom options:
```bash
make menuconfig
```

  1. Add the `simon-game` package, navigate to `Target packages > Games` and select `simon-game`.

  2. Set the image size by moving back to the inicial page (press esc twice to go back one page) and entering `Filesystem images > exact size` and set to `120M`.

6. Build the distribution
```bash
make
```
The build process takes some time (a few hours), once it is done check the [Run/Flash imagee](#runflash-image) section.

# Run/Flash image

The image will be available under `output/images` directory. See the [buildroot manual](https://buildroot.org/downloads/manual/manual.html#_boot_the_generated_images) for additional instructions.

## qemu

To run on qemu (which was the defconfig used on this tutorial), it is necessary to have the tool installed.
On Ubuntu and other Debian based systems:
```bash
sudo apt install qemu
```

The image already provides a bash script to run `qemu`:
```bash
./output/images/start-qemu.sh
```

Once `qemu` starts, it will load the environment and prompt to a login screen. The default login is `root` and no password is required.
```
Welcome to Buildroot
buildroot login:
```

Start the game. It is located on `/usr/local/bin/simon-game-<PACKAGE_VERSION>/simon.py`.
```
# python /usr/local/bin/simon-game-1.0.1/simon.py
```

## Using USB flash drive

If some other `defconfig` was used, i.e., a different board was the build target, a `.iso` file will be generated and can be copied to the device using `dd`.

**NOTE:** Replace `<image_name>` with the appropriate name of the file.

**NOTE2:** Replace `<device_path>` with the appropriate path to the USB device to be flased. Usually the device USB device is mounted under `/dev/sdX` where `X` is one of `b, c, d...` **(DO NOT USE sda as this is usually the mount point for your sistem)** or `/dev/mmcblkN` where `N` is one of `0, 1, 2...`.
```bash
dd if=output/images/<image_name>.iso of=<device_path>
```
