# Quick Start - CI/CD Setup

## 🚀 Get Started in 3 Steps

### 1. Push Your Code
```bash
git add .
git commit -m "Add CI/CD"
git push origin main
```

### 2. Check GitHub Actions
- Go to your GitHub repository
- Click on "Actions" tab
- Watch the workflow run automatically

### 3. Download Your APK
- Wait for green checkmark ✅
- Click on the completed workflow
- Click on "Artifacts"
- Download your APK

## 📁 Which File to Use?

- **`simple.yml`** - Start here! (Test + Build APK)
- **`test.yml`** - Testing only
- **`build.yml`** - Building only  
- **`ci_cd.yml`** - Full features (Test + Build + iOS)

## ❓ Common Questions

**Q: When does it run?**
A: Every time you push to main branch

**Q: Where's my APK?**
A: Actions → Latest workflow → Artifacts

**Q: It failed, what now?**
A: Run `flutter test` and `flutter build apk` locally first

## 🛠️ Troubleshooting

If it fails, check:
1. `flutter test` works locally
2. `flutter build apk` works locally
3. No warnings in `flutter analyze`

## 📚 More Info

- [Simple Guide](README_SIMPLE.md) - Detailed simple guide
- [Full Guide](CI_CD_README.md) - Complete documentation
- [Summary](CI_CD_SUMMARY.md) - Everything in one place 