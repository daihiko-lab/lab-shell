# Shared Core (配布用)

研究室メンバー向けの共通プロンプト/最低限プロファイルです。

## 含むもの

- `starship`によるPrompt
- 安全な最小alias (`gs`,`gd`,`ga`,`gc`,`gp`,`ll`,`..`,`...`,`r`)
- macOS: `zsh`
- Windows: `PowerShell 7` (公式対象)

## 導入 (1コマンド)

### macOS (zsh)

```bash
curl -fsSL https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/scripts/bootstrap-shared-core-mac.sh | zsh
```

### Windows (PowerShell 7)

```powershell
irm https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/scripts/bootstrap-shared-core-win.ps1 | iex
```

## 導入 (clone済みの場合)

### macOS

```bash
chmod +x ~/lab-shell/scripts/install-shared-core-mac.sh
~/lab-shell/scripts/install-shared-core-mac.sh
```

### Windows (PowerShell 7)

```powershell
& "$HOME\lab-shell\scripts\install-shared-core-win.ps1"
```

## アンインストール

### macOS

```bash
~/lab-shell/scripts/uninstall-shared-core-mac.sh
```

### Windows (PowerShell 7)

```powershell
& "$HOME\lab-shell\scripts\uninstall-shared-core-win.ps1"
```

## 補足

- Nerd Font推奨 (記号表示用)
- `ll`は`eza`があれば`eza -la --git`、なければ`ls -lah`
- Promptを調整したい場合は`profiles/shared/core/starship.toml`を編集

