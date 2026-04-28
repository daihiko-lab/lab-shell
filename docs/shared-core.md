# Shared Core (配布用)

研究室・ゼミ用のカスタムプロンプトです。

## 含むもの

- `starship`によるPrompt
- 安全な最小alias (`gs`,`gd`,`ga`,`gc`,`gp`,`ll`,`..`,`...`,`r`)
- macOS: `zsh`
- Windows: `PowerShell 7` (公式対象)

## 導入 (1コマンド)

### macOS (zsh)

```bash
curl -fsSL https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-mac.sh | zsh
```

### Windows (PowerShell 7)

```powershell
irm https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-win.ps1 | iex
```

## 導入 (clone済みの場合)

### macOS

```bash
zsh ~/lab-shell/.lab-shell/scripts/install-shared-core-mac.sh
```

### Windows (PowerShell 7)

```powershell
& "$HOME\lab-shell\.lab-shell\scripts\install-shared-core-win.ps1"
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

