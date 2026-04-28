# lab-shell

研究室・ゼミ用のカスタムプロンプトです。

## 含むもの

- `starship`によるPrompt設定
- 最小alias (`gs`,`gd`,`ga`,`gc`,`gp`,`ll`,`..`,`...`,`r`)
- macOS (`zsh`) と Windows (`PowerShell 7`) 向け導入スクリプト
- Windowsでは`Windows PowerShell 5.1`から実行しても`PowerShell 7`導入に対応
- WSL2 (`bash`) への導入にも対応

## ターミナル表示例

![lab-shell prompt example](./assets/images/prompt-example.png)

### 表示の見方

- `tak on hiroshimashu...-3.local` : ユーザー名とホスト名
- `TIME:16:15:46` : 現在時刻
- `TCNashAgents.jl-dev` : カレントディレクトリ
- `main!2` : Gitブランチ (`!2`は未ステージ変更2件)
- `JL:TCNashAgents` : Juliaプロジェクト名
- `❯` : 入力待ちプロンプト (成功時は緑、失敗時は赤)

## 導入

### macOS (zsh)

```bash
curl -fsSL https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-mac.sh | zsh
```

### Windows (PowerShell 5.1 / PowerShell 7)

```powershell
irm https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-win.ps1 | iex
```

- 旧`Windows PowerShell 5.1`から実行してもOKです
- `PowerShell 7`が無い場合は導入を試行します
- `WSL`が利用可能なら、`bash`側にも導入を試行します
- `WSL`が未設定なら、状態チェックと有効化案内を出します

## アップデート

初回導入と同じコマンドを再実行すれば更新できます。

### macOS (zsh)

```bash
curl -fsSL https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-mac.sh | zsh
```

### Windows (PowerShell 5.1 / PowerShell 7)

```powershell
irm https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-win.ps1 | iex
```

## VSCodeで反映されない場合

- 既存ターミナルをすべて閉じて、新規ターミナルを開く
- 反映されない場合は`Developer: Reload Window`を実行
- WSLターミナル側は`exec bash`またはターミナル再起動で反映

## アンインストール

### macOS (zsh)

```bash
zsh ~/lab-shell/.lab-shell/scripts/uninstall-shared-core-mac.sh
```

### Windows (PowerShell 7)

```powershell
& "$HOME\lab-shell\.lab-shell\scripts\uninstall-shared-core-win.ps1"
```

詳細は`docs/shared-core.md`を参照してください。
