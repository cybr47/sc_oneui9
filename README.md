# One UI 9 — SystemUI and One UI Home decompilation workspace

This workspace is designed for reading reconstructed code from two One UI 9 APKs originally supplied for research. Decompiled Java is **not Samsung's original source code**.

| Directory | APK | Generated output |
| --- | --- | --- |
| `SystemUI9/` | `SystemUI.apk` | `jadx/sources/` Java; `apktool/` manifest and decoded resources |
| `HomeUI9/` | `TouchWizHome_2017.apk` | `jadx/sources/` Java; `apktool/` manifest and decoded resources |

The folder placeholders are committed already. The [decompilation workflow](.github/workflows/decompile.yml) will fill them automatically **after the two APKs are uploaded as release assets**.

## Complete the upload

1. Go to **[Draft a new GitHub release](https://github.com/cybr47/sc_oneui9/releases/new)**.
2. Set the release tag to **`oneui9-inputs`** (create the tag if offered).
3. Attach both files with these exact names: **`SystemUI.apk`** and **`TouchWizHome_2017.apk`**.
4. Keep the release as a draft until **both** uploads are complete, then select **Publish release**.
5. The [Decompile One UI 9 Action](https://github.com/cybr47/sc_oneui9/actions/workflows/decompile.yml) starts on publishing. Wait for it to finish; it commits the Java and decoded resources to `main` in one commit.

For retries, open the workflow above and choose **Run workflow**, leaving the tag `oneui9-inputs`.

## Decompilation details

- [JADX 1.5.6](https://github.com/skylot/jadx/releases/tag/v1.5.6) reconstructs searchable Java classes.
- [Apktool 3.0.3](https://github.com/iBotPeaches/Apktool/releases/tag/v3.0.3) decodes Android resources and the manifest without duplicating every class as Smali.
- The workflow verifies both source APK SHA-256 hashes against the original supplied files.
- Original APKs, raw DEX, shared libraries, fonts and bulky images are not committed.
- Some JADX methods can be incomplete, and Samsung-specific resources may need additional framework files to decode. For exact LSPosed hook signatures, check the original DEX as well.

**Public-repository warning:** Published APK release assets and generated source in this repository will be accessible to everyone. If this is intended only for personal research, consider switching the repository to private before publishing, and review Samsung's licensing and redistribution terms.
