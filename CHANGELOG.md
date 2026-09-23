# Changelog

## [1.0.0] - 2026-09-XX

First stable release of this fork.

### Changed (vs. upstream snackon/Witchmacs)
- Replaced `irony` + `company-irony` with `eglot` + `clangd` for C/C++ completion
- Replaced `meghanada` (unmaintained) with `eglot` + `jdtls` for Java completion
- Replaced `spaceline`/`powerline` with `doom-modeline`
- Replaced `ido`/`ido-vertical-mode` with `vertico` + `orderless` + `marginalia`
- Confirmed compatibility with Emacs 30+

### Fixed
- Added missing `lexical-binding` cookies to `init.el`, `config.org`'s
  tangled output, and `Witchmacs-theme.el`
- Removed dead/unreachable use-package bootstrap code for Emacs <29
- Removed stale packages (`spaceline`, `ido-vertical-mode`,
  `tron-legacy-theme`) from `package-selected-packages`
- Replaced hardcoded `~/.emacs.d/` paths with `user-emacs-directory`
  for portability with alternate init-directory setups
