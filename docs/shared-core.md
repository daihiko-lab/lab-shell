# Shared Core (配布用)

研究室・ゼミ用のカスタムプロンプトです。

## 含むもの

- `starship`によるPrompt
- 安全な最小alias (`gs`,`gd`,`ga`,`gc`,`gp`,`ll`,`..`,`...`,`r`)
- macOS: `zsh`
- Windows: `PowerShell 7` (公式対象)
- 旧`Windows PowerShell 5.1`からbootstrap実行可能 (内部で`pwsh`を利用)
- WSL2: `bash` (Windows bootstrapから連携可能)

## 導入 (1コマンド)

### macOS (zsh)

```bash
curl -fsSL https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-mac.sh | zsh
```

### Windows (PowerShell 5.1 / PowerShell 7)

```powershell
irm https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-win.ps1 | iex
```

- 旧`Windows PowerShell 5.1`でも実行できます
- `PowerShell 7`が無ければ`winget`で導入を試行します
- `WSL`のインストールと`bash`側への適用は、プロンプトで **yes** と入力したときだけ実行します
- 非対話環境では `$env:LAB_SHELL_WSL='yes'` を設定すると同じ内容を実行します
- `WSL`未設定で管理者でない場合は、案内メッセージのみになります

## 導入 (clone済みの場合)

### macOS

```bash
zsh ~/lab-shell/.lab-shell/scripts/install-shared-core-mac.sh
```

### Windows (PowerShell 7)

```powershell
& "$HOME\lab-shell\.lab-shell\scripts\install-shared-core-win.ps1"
```

`install-shared-core-win.ps1`自体は`PowerShell 7`で実行してください。  
`Windows PowerShell 5.1`から導入する場合はbootstrapを利用します。

### Linux / WSL2 (bash)

```bash
curl -fsSL https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-linux.sh | bash
```

## アンインストール

### macOS

```bash
zsh ~/lab-shell/.lab-shell/scripts/uninstall-shared-core-mac.sh
```

### Windows (PowerShell 7)

```powershell
& "$HOME\lab-shell\.lab-shell\scripts\uninstall-shared-core-win.ps1"
```

## VSCode / Cursor の注意

- 統合ターミナルで使うシェルと、インストール先を合わせてください  
  - macOSは`zsh`  
  - Windowsは`PowerShell 7`
- 既に開いているターミナルには設定が反映されません。新規ターミナルを開いてください
- 反映されない場合は、`Developer: Reload Window`でウィンドウ再読み込み
- WindowsではPowerShell向けに`starship.windows.toml`を適用します

## 補足

- Nerd Font推奨 (記号表示用)
- `ll`は`eza`があれば`eza -la --git`、なければ`ls -lah`
- Promptを調整したい場合は`.lab-shell/core/starship.toml`を編集

