# Simple CI/CD Guide

## What's Been Set Up for You

4 CI/CD files have been created:

1. **`simple.yml`** - Simplest (test + build APK only)
2. **`test.yml`** - Testing only
3. **`build.yml`** - Building only
4. **`ci_cd.yml`** - Comprehensive (test + build + iOS)

## Start with simple.yml

This simplest file will:
- ✅ Run tests
- ✅ Build APK
- ✅ Upload APK for download

## How to Use

### 1. Push Code
```bash
git add .
git commit -m "First CI/CD trial"
git push origin main
```

### 2. Watch Result
- Go to GitHub repository
- Click on "Actions"
- You'll find workflow running

### 3. Download APK
- Wait for process completion (green checkmark)
- Click on workflow
- Click on "app-release"
- Download APK

## If Process Fails

### Check:
1. **Tests work locally**:
   ```bash
   flutter test
   ```

2. **Code builds locally**:
   ```bash
   flutter build apk --release
   ```

3. **All dependencies are specified in pubspec.yaml**

## Quick Tips

- Use `simple.yml` to start
- Make sure code works locally first
- Check logs if process fails
- You can delete other files if you don't need them

## FAQ

**Q: When does CI/CD run?**
A: On every push to main branch

**Q: Where do I find APK?**
A: In Actions tab → latest workflow → Artifacts

**Q: Why did process fail?**
A: Check tests and code locally first 