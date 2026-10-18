# One UI 9 decompilation workspace

This public repository is intended to contain reverse-engineered Android code from user-provided Samsung One UI 9 APKs. `SystemUI9/` and `HomeUI9/` will hold generated Java sources and decoded resources. Decompiled files are not official Samsung source code.

**Populate via GitHub Actions**: Draft a release tagged `oneui9-inputs`, attach both `SystemUI.apk` and `TouchWizHome_2017.apk`, then publish. The `Decompile One UI 9` workflow downloads those assets, decompiles them and commits the resulting folders to `main`.

**Privacy/copyright warning:** The repository and any published release assets are public. Make it private before uploading APKs if public redistribution is not intended. Source reconstruction may be incomplete and some OEM resources may fail to decode.

For precise LSPosed hook signatures, check the original DEX/APK rather than relying on reconstructed Java alone.
