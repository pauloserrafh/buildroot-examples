# buildroot-examples

[BR]
Esse projeto provê exemplos para adicionar seus projetos ao buildroot, tanto modificando diretamente a árvore do buildroot quanto fora dela, utilizando o qemu como plataforma.
[Instruções em português](README.pt-br.md)

**NOTA:** As instruções em BR podem estar desatualizadas. [A página em EN](README.md) deve ser a referência oficial. Verifique o hash/tag que o README aponta.
Sempre que forem feitas mudanças, atualize o hash/tag caso o README também tenha sido atualizado.

[EN]
This projects aims to provide examples for adding your project to buildroot, inside and outside the tree, using qemu.
[Instructions in english](README.md)

**NOTE:** This should be always up to date. All the changes must be reflected AT LEAST on this README and on as many of the other languages as possible.
Always update the hash/tag on README when making changes.

# Índice
- [buildroot-examples](#buildroot-examples)
- [Índice](#índice)
- [Configuração do ambiente](#configuração-do-ambiente)
- [Fazendo o build dentro da árvore do buildroot](#fazendo-o-build-dentro-da-árvore-do-buildroot)
- [Execute/Grave a imagem](#executegrave-a-imagem)
  - [qemu](#qemu)
  - [Usando um pen-drive USB](#usando-um-pen-drive-usb)

# Configuração do ambiente
Independente da abordagem usada, é preciso clonar o repositório do buildroot.
Caso não deseje clonar o repositório dentro deste diretório, modifique os caminhos dos comandos no restante do tutorial apropriadamente.

1. Clone o buildroot do repositório oficial ou do github:
```bash
git clone https://git.buildroot.net/buildroot/ buildroot
```
OU
```bash
git clone https://github.com/buildroot/buildroot.git buildroot
```

2. É aconselhável usar a versão LTS (Long-Term Suport), ao invés da versão mais recente, pois a última pode ser ainda instável (veja o [LTS mais recente](https://buildroot.org/download.html)):
```bash
cd buildroot

git checkout 2021.02.3 -b simon_game_buildroot

cd -
```

# Fazendo o build dentro da árvore do buildroot
1. Copie o diretório `package/simon-game/` para `buildroot/package`:
```bash
cp -r package/simon-game/ buildroot/package/
```

2. Entre no diretório `buildroot/`:
```bash
cd buildroot
```

3. Edite o arquivo `package/Config.in`, adicionando `source "package/simon-game/Config.in"` na lista `menu "Games"`.

4. Crie o arquivo de configuração base:
```bash
make qemu_x86_64_defconfig
```

5. Abra o menu interativo para configurar as opções customizadas:
```bash
make menuconfig
```

   1. Para adicionar o pacote `simon-game`, navegue para `Target packages > Games` e selecione `simon-game`.

   2. Para definir o tamanho da imagem, retorne à página inicial (pressione `esc` duas vezes para voltar uma página), navegue para `Filesystem images > exact size` e configure para `120M`.

6. Faça build da distribuição
```bash
make
```
O processo de build leva algum tempo (algumas horas), quando finalizado siga para a seção [Execute/Grave a imagem](#executegrave-a-imagem).

# Execute/Grave a imagem

A imagem ficará disponível no diretório `output/images`. Veja o [manual do buildroot](https://buildroot.org/downloads/manual/manual.html#_boot_the_generated_images) para instruções adicionais.

## qemu

Para executar utilizando o qemu (o `defconfig` usado nesse tutorial), é necessário ter a ferramenta instalada.
No Ubuntu e outros sistemas baseados no Debian:
```bash
sudo apt install qemu
```

A imagem provê um script em bash para executar o `qemu`:
```bash
./output/images/start-qemu.sh
```

Ao iniciar o `qemu`, o ambiente será carregado e uma tela de login apresentada. O usuário padrão é `root` e não é necessário senha.
```
Welcome to Buildroot
buildroot login:
```

Inicie o jogo. Ele está localizado em `/usr/local/bin/simon-game-<PACKAGE_VERSION>/simon.py`.
```
# python /usr/local/bin/simon-game-1.0.1/simon.py
```

## Usando um pen-drive USB
Caso algum outro `defconfig` tenha sido utilizado, i.e, uma placa diferente foi o *build target*, um arquivo `.iso` será gerado e pode ser copiado para o dispositivo utilizando `dd`.

**NOTA:** Substitua `<nome_da_imagem>` pelo nome do arquivo apropriado.

**NOTE2:** Substitua `<caminho_do_arquivo>` pelo caminho para o dispositivo USB a ser gravado. Normalmente, o dispositivo USB é montado em `/dev/sdX` onde `X` é um entre `b, c, d...` **(NÃO USE sda pois esse é o ponto de montagem do seu sistema)** ou `/dev/mmcblkN` onde `N` é um entre `0, 1, 2...`.
```bash
dd if=output/images/<nome_da_imagem>.iso of=<caminho_do_arquivo>
```
