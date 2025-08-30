# 🚀 GitHub Releases Setup for GameMaster Pro

This guide walks you through setting up automated APK builds and downloads for your GameMaster Pro Flutter app using GitHub Actions and Releases.

## 📋 Prerequisites

- GitHub repository for your project
- Flutter project in the `src/` directory
- Basic knowledge of Git and GitHub

## 🔧 Setup Steps

### 1. Repository Configuration

1. **Push your code to GitHub** (if not already done):
   ```bash
   git remote add origin https://github.com/yourusername/gamemaster-pro.git
   git push -u origin main
   ```

2. **Update repository name** in configuration files:
   - Edit `github-download.html` line 185: Update `GITHUB_REPO` constant
   - Edit `scripts/download-latest.sh` line 12: Update `GITHUB_REPO` variable

### 2. GitHub Actions Workflow

The workflow file `.github/workflows/build-and-release.yml` is already created and will:

- ✅ Automatically build APKs when you push a git tag
- ✅ Support both Development and Production flavors
- ✅ Create GitHub releases with APK files attached
- ✅ Allow manual workflow dispatch for testing

**Workflow triggers:**
- **Automatic**: When you push a tag like `v1.0.0`
- **Manual**: Via GitHub Actions tab with workflow_dispatch

### 3. Creating Your First Release

#### Option A: Using the Release Script (Recommended)

```bash
# Create a patch release (1.0.0 -> 1.0.1)
./scripts/create-release.sh patch

# Create a minor release (1.0.0 -> 1.1.0)
./scripts/create-release.sh minor

# Create a major release (1.0.0 -> 2.0.0)
./scripts/create-release.sh major

# Create custom version
./scripts/create-release.sh custom 2.1.0+42
```

The script will:
1. Update version in `pubspec.yaml`
2. Create a git commit
3. Create a git tag
4. Generate release notes

#### Option B: Manual Process

```bash
# 1. Update version in src/pubspec.yaml
cd src
# Edit pubspec.yaml, change version: line

# 2. Commit the version change
git add pubspec.yaml
git commit -m "chore: bump version to 1.0.1"

# 3. Create and push tag
git tag v1.0.1
git push origin v1.0.1
```

### 4. Pushing to Trigger Build

After creating a tag:

```bash
# Push the commits and tags
git push origin main
git push origin --tags

# Or push both at once
git push && git push --tags
```

This will trigger the GitHub Actions workflow to build your APKs automatically.

### 5. Setting Up the Download Page

1. **Host the download page**:
   - Upload `github-download.html` to your web hosting
   - Or use GitHub Pages to serve it directly from your repository

2. **Update repository references**:
   ```javascript
   // In github-download.html, update line 185:
   const GITHUB_REPO = 'yourusername/gamemaster-pro';
   ```

3. **Access your download page**:
   - Direct link: `https://yourdomain.com/github-download.html`
   - GitHub Pages: `https://yourusername.github.io/gamemaster-pro/github-download.html`

## 📱 Download Options

### For End Users

1. **Web Download Page**: Beautiful interface showing all releases
   - Automatic detection of latest releases
   - File size information
   - Download statistics
   - Installation instructions

2. **Direct GitHub Releases**: 
   - Go to `https://github.com/yourusername/gamemaster-pro/releases`
   - Download APK files directly

### For Developers

Use the download script for automated downloads:

```bash
# Interactive download menu
./scripts/download-latest.sh

# Download all APKs
./scripts/download-latest.sh --all

# Download production APK only
./scripts/download-latest.sh --production

# Download development APK only  
./scripts/download-latest.sh --development

# Show release info only
./scripts/download-latest.sh --info
```

## 🔗 Direct Download URLs

Once releases are created, you can use direct URLs:

### Latest Release URLs
```
# Production APK (latest)
https://github.com/yourusername/gamemaster-pro/releases/latest/download/gamemaster-pro-production.apk

# Development APK (latest)
https://github.com/yourusername/gamemaster-pro/releases/latest/download/gamemaster-pro-development.apk
```

### Specific Version URLs
```
# Production APK (specific version)
https://github.com/yourusername/gamemaster-pro/releases/download/v1.0.0/gamemaster-pro-production.apk

# Development APK (specific version)
https://github.com/yourusername/gamemaster-pro/releases/download/v1.0.0/gamemaster-pro-development.apk
```

## 🛠️ Customization

### APK File Names
Edit `.github/workflows/build-and-release.yml` to customize APK names:
```yaml
# Change these lines to customize filenames
mv build/app/outputs/flutter-apk/app-development-release.apk ../gamemaster-pro-development.apk
mv build/app/outputs/flutter-apk/app-production-release.apk ../gamemaster-pro-production.apk
```

### Release Notes
The workflow automatically generates release notes. Customize the template in:
- `.github/workflows/build-and-release.yml` (lines 67-87)
- `scripts/create-release.sh` (generate_release_notes function)

### Build Flavors
If you need different flavors, update the workflow:
```yaml
- name: Build Custom Flavor APK
  run: |
    flutter build apk --flavor custom --target lib/main/main_custom.dart --release
```

## 🔒 Security Considerations

1. **GitHub Token**: Uses `GITHUB_TOKEN` (automatically provided)
2. **No Secrets Required**: Basic setup works without additional secrets
3. **Signing**: For production apps, add Android keystore signing:
   ```yaml
   # Add to workflow if you have signing keys
   - name: Setup Android Signing
     run: |
       echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > android.keystore
   ```

## 📊 Monitoring

### GitHub Actions
- View build logs: `https://github.com/yourusername/gamemaster-pro/actions`
- Monitor workflow runs and debug issues

### Download Analytics
The download page includes basic tracking:
- Download counts from GitHub API
- Release statistics
- File size information

### Custom Analytics
Add to `github-download.html`:
```javascript
function trackDownload(fileName) {
    // Google Analytics
    gtag('event', 'download', { 'file_name': fileName });
    
    // Custom tracking
    fetch('/api/track-download', {
        method: 'POST',
        body: JSON.stringify({ file: fileName })
    });
}
```

## 🚨 Troubleshooting

### Common Issues

1. **Build Fails**:
   - Check Flutter version compatibility
   - Verify `pubspec.yaml` syntax
   - Review GitHub Actions logs

2. **No Releases Created**:
   - Ensure you pushed the tag: `git push --tags`
   - Check workflow permissions in repository settings
   - Verify workflow syntax

3. **APK Download Fails**:
   - Check if release was created successfully
   - Verify APK files were uploaded to release
   - Check file permissions and size

4. **Download Page Shows No Releases**:
   - Update `GITHUB_REPO` constant in the HTML
   - Check repository visibility (public vs private)
   - Verify GitHub API access

### Debug Commands

```bash
# Check git tags
git tag -l

# Check remote repository
git remote -v

# Verify GitHub API access
curl -s https://api.github.com/repos/yourusername/gamemaster-pro/releases/latest

# Test download script
./scripts/download-latest.sh --info
```

## 📚 Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/actions)
- [GitHub Releases API](https://docs.github.com/rest/releases)
- [Flutter Build Documentation](https://docs.flutter.dev/deployment/android)

## 🎯 Next Steps

1. **Test the Complete Workflow**:
   - Create a test release using the script
   - Verify APKs build successfully
   - Test the download page

2. **Customize for Your Needs**:
   - Update branding and styling
   - Add custom build configurations
   - Implement additional analytics

3. **Production Setup**:
   - Add Android app signing
   - Configure proper versioning
   - Set up automated testing

---

**Ready to create your first release?** Run `./scripts/create-release.sh patch` to get started! 🚀