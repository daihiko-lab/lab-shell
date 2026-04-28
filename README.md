# lab-shell

研究室向けの共通シェル設定です。  
目的は、初期セットアップを簡単にし、最低限の操作をそろえることです。

## 含むもの

- `starship`によるPrompt設定
- 最小alias (`gs`,`gd`,`ga`,`gc`,`gp`,`ll`,`..`,`...`,`r`)
- macOS (`zsh`) と Windows (`PowerShell 7`) 向け導入スクリプト

## 導入

### macOS (zsh)

```bash
curl -fsSL https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/scripts/bootstrap-shared-core-mac.sh | zsh
```

### Windows (PowerShell 7)

```powershell
irm https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/scripts/bootstrap-shared-core-win.ps1 | iex
```

## アンインストール

### macOS (zsh)

```bash
~/lab-shell/scripts/uninstall-shared-core-mac.sh
```

### Windows (PowerShell 7)

```powershell
& "$HOME\lab-shell\scripts\uninstall-shared-core-win.ps1"
```

詳細は`docs/shared-core.md`を参照してください。
