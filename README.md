# LensTaggerDrop

![Platform: macOS](https://img.shields.io/badge/Platform-macOS-lightgrey.svg)
![Built with: Automator](https://img.shields.io/badge/Built%20with-Automator-blue.svg)
![Uses: ExifTool](https://img.shields.io/badge/Uses-ExifTool-orange.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

## English　(日本語は下にあります)
A macOS utility to embed manual lens metadata into RAW files using ExifTool.

### Background
I often use multiple vintage lenses for photography, but RAW files do not contain information about them. Once files get mixed up, it becomes difficult to know exactly which lens was used for each image. To solve this, I’ve been using [Lens Tagger](https://www.lenstagger.com/), a Lightroom Classic plugin, to write lens metadata into RAW files.

However, every time I buy a new lens, I have to manually configure the plugin, re-import settings, and rewrite them. This process became a hassle. I wondered if I could inject lens metadata into RAW files more easily, and asked AI to help create a minimal drag-and-drop application. I started with two lenses I use regularly: Leitz Elmar 35mm ƒ/3.5 and Voigtländer Nokton Classic 40mm ƒ/1.4. I plan to gradually expand to more lenses.


## Contents

### Applications
1. `LensName`.app – A simple macOS application that embeds vintage lens metadata into RAW files.
2. `LensName`.command – A shell script used to generate the above `.app`. Can also be used directly in Terminal.

### Supported RAW File Formats
The following RAW formats are supported:

| Manufacturer | Extension         | Supported |
|--------------|------------------|-----------|
| Canon        | `.CR2`, `.CR3`   | ✅         |
| Nikon        | `.NEF`           | ✅         |
| Sony         | `.ARW`           | ✅         |
| Fujifilm     | `.RAF`           | ✅         |
| Panasonic    | `.RW2`           | ✅         |
| Olympus      | `.ORF`           | ✅         |
| Leica, Ricoh | `.DNG`           | ✅         |


## Requirements & Installation

### Requirements
- macOS 11.0 (Big Sur) or later  
- [ExifTool](https://exiftool.org/)  
- Automator (preinstalled on macOS, only needed if converting `.command` to `.app`)

These three are sufficient for using the tool. Lightroom Classic and Lens Tagger are not required, but since this tool is designed with Lens Tagger in mind, it works seamlessly if you already have a similar environment set up.

### Installation
- Install ExifTool. You can install it from the website or via Homebrew with:

```bash
brew install exiftool
```

- The application files `Nokton40_1_4.app` and `Elmar35_3_5.app` are located in the `app` folder. You can move them anywhere and use freely.

---

## Usage

### Option 1: Using `LensName`.app
1. Place the `.app` file corresponding to the lens you used in a convenient location.
2. Drag your RAW files or folders onto the `.app` file.
3. You can drag multiple files, a single folder, or multiple folders at once. The app will recursively scan all contained files and embed lens metadata into any supported RAW files.
4. Once processing is complete, an alert will display the results, including the number of files scanned, processed, and skipped.

### Option 2: Using `LensName`.command

1. Run the `.command` file in Terminal:

```bash
bash LensName.command
```

(If you get a permission error, add executable permission first:)

```bash
chmod +x LensName.command
```

2. Enter the target folder path when prompted to begin processing.

---

### What Gets Written
The following EXIF fields are written using ExifTool, even for manual lenses with no electronic contacts:
- `LensModel`
- `Lens`
- `FocalLength`
- `FocalLengthIn35mmFormat` – focal length in 35mm equivalent
- `MaxApertureValue` – maximum aperture

---

### Supported Lenses
Currently supported lenses (more will be added as needed):
- Leitz Elmar 35mm ƒ/3.5
- Voigtländer Nokton Classic 40mm ƒ/1.4
- Voigtländer COLOR-SKOPAR 35mm F3.5 Aspherical


## Notes & Warnings
- This tool only modifies EXIF metadata. It does **not** affect image data such as quality or colors.
- Once lens data is written to a file, it cannot be undone. Make backups if you are concerned.
- Files can be overwritten multiple times. If you drag a file onto a different lens app, its EXIF metadata will be updated accordingly.
- To support a new lens, simply duplicate an existing `.command` file, modify the lens-specific metadata values near the top, and export a new `.app` using Automator.

---


## 日本語
[ExifTool](https://exiftool.org/)を使って、マニュアルレンズのメタデータをRAWファイルに埋め込むためのmacOS用ユーティリティです。

## 背景
普段オールドレンズをいくつか使い分けて写真を撮影していますが、RAWデータにはオールドレンズの情報は書き込まれません。知らないうちにファイルが混ざってしまうと、どのレンズで撮ったのかを正確に把握することが困難になりがちです。それを解決するために、RAWデータにレンズ情報を書き込むために、普段は[Lens Tagger](https://www.lenstagger.com/)というLightroom Classicのプラグインを使ってきました。

しかし、新しいレンズを買うたびにレンズの設定を書き込み、都度このプラグインを開いて設定を読み込み直すのがとても面倒でした。もっと簡単に、撮ってきたファイルにRAWファイルにレンズ情報を書き込めないかと思いつき、ドラッグ・アンド・ドロップでレンズ情報をRAWデータに埋め込む超絶シンプルなアプリケーションをAIに作ってもらいました。まずは自分が普段よく使用している、Leitz Elmar 35mm ƒ/3.5, Voigtländer Nokton Classic 40mm ƒ/1.4という2つのレンズから。少しずつ増やしていこうと思っています。

## 構成（ファイルの中身）
### アプリケーション 
1. `LensName`.app: オールドレンズのメタデータをRAWファイルに書き込むシンプルなアプリケーション
2. `LensName`.command: 1を作成するためのシェルスクリプトコマンド。ターミナルでシェルスクリプトとして使用することも可能です。


### 対応RAWファイル形式
以下のRAWファイル形式に対応しています。
| カメラメーカー      | 拡張子            | 対応状況 |
| ------------ | -------------- | ---- |
| Canon        | `.CR2`, `.CR3` | ✅    |
| Nikon        | `.NEF`         | ✅    |
| Sony         | `.ARW`         | ✅    |
| Fujifilm     | `.RAF`         | ✅    |
| Panasonic    | `.RW2`         | ✅    |
| Olympus      | `.ORF`         | ✅    |
| Leica, Ricoh | `.DNG`         | ✅    |


## 動作環境とインストール
### 動作環境
- macOS 11.0 (Big Sur) or later  
- [ExifTool](https://exiftool.org/)
- Automator（macOS標準搭載）※ `.command` を `.app` に変換したい場合のみ必要


この3つがあれば動作します。Lightroom Classic, Lens Taggerそのものは必ずしも必要ありませんが、基本的にはLens Taggerを踏襲しているので、Lens Taggerが動作する環境をセットアップできていればすぐに利用可能です。

### インストール方法
- ExifToolをインストールする。Websiteからインストールする方法もありますし、Homebrewを使っていれば、`brew install exiftool` でインストールできます。
- `app`フォルダ内の `Nokton40_1_4.app` や `Elmar35_3_5.app` がアプリケーション本体です。どこにでもおいて使えます。

## 使い方（How it works）
### 利用方法1: `LensName`.app
1. 対象となるレンズの.appファイルを好きな場所に置きます。
2. 撮影した写真のRAWファイルを.appファイルにドラッグ・アンド・ドロップすると処理が開始されます。
3. 複数ファイル同時、1つのフォルダ、複数のフォルダのドラッグアンドドロップに対応しています。ドロップすると、その中に入っているファイルすべてをスキャンし、該当するRAWファイルにレンズ情報を書き込みます。
4. 処理が完了したら、AlertViewに結果が表示されます。（ドラッグ・アンド・ドロップした各フォルダ内のファイル数、総ファイル数、処理済みのファイル数等）

### 利用方法2: `LensName`.command
1. ターミナルで `.command` ファイルを実行します。

```bash
bash LensName.command
```
（実行できない場合は以下のように権限を付与してください）

```bash
chmod +x LensName.command
```

2. 対象フォルダを入力すると上記の処理を開始します。

### 処理の内容
アプリケーションが処理をする対象となるRAWファイルにおいて、ExifToolを活用して、電子接点のないマニュアルレンズでも以下のExif項目が書き込まれます。
- `LensModel`
- `Lens`
- `FocalLength`
- `FocalLengthIn35mmFormat`: 焦点距離（FocalLength / 35mm換算）
- `MaxApertureValue`: 開放F値（MaxApertureValue）

### 対応レンズ
対応しているレンズは、現時点では以下のもののみです。今後、自分が使用しているオールドレンズを追加していきます。
- Leitz Elmar 35mm ƒ/3.5
- Voigtländer Nokton Classic 40mm ƒ/1.4
- Voigtländer COLOR-SKOPAR 35mm F3.5 Aspherical


## 補足説明と注意事項
- このツールはExifメタデータのみを編集します。画像データそのもの（画質や色など）には一切影響しません。
- ファイルにレンズ情報を書き込んだら、元には戻せないので、心配であればバックアップを取ったうえで作業してください。
- 何度でも上書き可能です。他のレンズファイルにRAWファイルをドラッグ・アンド・ドロップすると、そのレンズファイルの情報で更新されます。
- 他のレンズに対応させたい場合は .command ファイルを複製して、上の部分にあるレンズの設定値を記載するブロックを直接編集してください。それをAutomatorアプリを使用して.appとして保存することで、新しいレンズ用のユーティリティが作成できます。
