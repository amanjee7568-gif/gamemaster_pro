#!/bin/bash

# GameMaster Pro Release Creation Script
# This script helps create GitHub releases with proper versioning

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
SRC_DIR="$PROJECT_DIR/src"

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in a git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log_error "This script must be run from within a git repository"
        exit 1
    fi
}

# Check if Flutter src directory exists
check_flutter_project() {
    if [ ! -f "$SRC_DIR/pubspec.yaml" ]; then
        log_error "Flutter project not found at $SRC_DIR"
        log_error "Please ensure the Flutter project is in the 'src' directory"
        exit 1
    fi
}

# Get current version from pubspec.yaml
get_current_version() {
    if [ -f "$SRC_DIR/pubspec.yaml" ]; then
        grep "version:" "$SRC_DIR/pubspec.yaml" | cut -d ' ' -f2 | tr -d '\r\n'
    else
        echo "1.0.0"
    fi
}

# Validate version format
validate_version() {
    local version=$1
    if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+(\+[0-9]+)?$ ]]; then
        log_error "Invalid version format. Expected: X.Y.Z or X.Y.Z+BUILD"
        return 1
    fi
    return 0
}

# Update version in pubspec.yaml
update_version() {
    local new_version=$1
    log_info "Updating version to $new_version in pubspec.yaml"
    
    # Create backup
    cp "$SRC_DIR/pubspec.yaml" "$SRC_DIR/pubspec.yaml.backup"
    
    # Update version
    sed -i.tmp "s/version: .*/version: $new_version/" "$SRC_DIR/pubspec.yaml"
    rm -f "$SRC_DIR/pubspec.yaml.tmp"
    
    log_success "Version updated successfully"
}

# Create git tag
create_git_tag() {
    local version=$1
    local tag_name="v$version"
    
    log_info "Creating git tag: $tag_name"
    
    # Check if tag already exists
    if git tag -l | grep -q "^$tag_name$"; then
        log_error "Tag $tag_name already exists"
        return 1
    fi
    
    # Commit version change
    git add "$SRC_DIR/pubspec.yaml"
    git commit -m "chore: bump version to $version"
    
    # Create tag
    git tag -a "$tag_name" -m "Release $tag_name"
    
    log_success "Git tag $tag_name created successfully"
}

# Generate release notes
generate_release_notes() {
    local version=$1
    local previous_tag=$(git describe --tags --abbrev=0 HEAD~1 2>/dev/null || echo "")
    
    cat > /tmp/release_notes.md << EOF
# GameMaster Pro v$version

## 🚀 What's New

### Features
- Flutter app with Bloc/Cubit architecture
- Support for both Development and Production flavors  
- Modern UI with responsive design
- AI-powered support chat integration
- Games management system

### Technical Details
- **Flutter Version**: 3.24.1
- **Architecture**: Bloc/Cubit state management
- **Build Type**: Release APK
- **Target SDK**: Android API 34

## 📱 Downloads

Choose the appropriate APK for your needs:

- **Production APK**: Optimized release build for end users
- **Development APK**: Debug build with additional logging for testing

## 📋 Installation Instructions

1. Download the appropriate APK file from the assets below
2. On your Android device, enable "Unknown Sources" in Settings > Security
3. Tap the downloaded APK file to install
4. Launch GameMaster Pro and enjoy!

## 🔄 Changes Since Last Release

EOF

    if [ -n "$previous_tag" ]; then
        echo "### Commits since $previous_tag:" >> /tmp/release_notes.md
        git log --pretty=format:"- %s (%an)" "$previous_tag"..HEAD >> /tmp/release_notes.md
        echo "" >> /tmp/release_notes.md
    fi

    cat >> /tmp/release_notes.md << EOF

---

**Full Changelog**: [View all changes](https://github.com/\$GITHUB_REPO/compare/$previous_tag...v$version)

**Auto-generated release created by GitHub Actions**
EOF

    echo "/tmp/release_notes.md"
}

# Main release creation flow
create_release() {
    local release_type=$1
    local custom_version=$2
    
    log_info "Starting release creation process..."
    
    # Check prerequisites
    check_git_repo
    check_flutter_project
    
    # Get current version
    local current_version=$(get_current_version)
    log_info "Current version: $current_version"
    
    # Determine new version
    local new_version
    if [ -n "$custom_version" ]; then
        new_version="$custom_version"
    else
        case $release_type in
            "major")
                # Increment major version (X.0.0)
                new_version=$(echo "$current_version" | awk -F. '{printf "%d.0.0", $1+1}')
                ;;
            "minor")
                # Increment minor version (X.Y.0)
                new_version=$(echo "$current_version" | awk -F. '{printf "%d.%d.0", $1, $2+1}')
                ;;
            "patch")
                # Increment patch version (X.Y.Z)
                new_version=$(echo "$current_version" | awk -F. '{printf "%d.%d.%d", $1, $2, $3+1}')
                ;;
            *)
                log_error "Invalid release type. Use: major, minor, patch, or provide custom version"
                exit 1
                ;;
        esac
    fi
    
    # Validate new version
    if ! validate_version "$new_version"; then
        exit 1
    fi
    
    log_info "New version will be: $new_version"
    
    # Confirm with user
    echo -n "Do you want to proceed with version $new_version? (y/N): "
    read -r confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        log_info "Release cancelled by user"
        exit 0
    fi
    
    # Update version in pubspec.yaml
    update_version "$new_version"
    
    # Create git tag (this will trigger GitHub Actions)
    create_git_tag "$new_version"
    
    # Generate release notes
    local release_notes_file=$(generate_release_notes "$new_version")
    
    log_success "Release preparation completed!"
    log_info "Next steps:"
    echo "  1. Push the tag to GitHub: git push origin v$new_version"
    echo "  2. GitHub Actions will automatically build the APKs"
    echo "  3. A release will be created with the built APKs"
    echo ""
    echo "  Or push both commits and tags: git push && git push --tags"
    echo ""
    echo "Release notes generated at: $release_notes_file"
}

# Script usage
show_usage() {
    echo "GameMaster Pro Release Creation Script"
    echo ""
    echo "Usage: $0 <release-type> [custom-version]"
    echo ""
    echo "Release Types:"
    echo "  major    - Increment major version (1.0.0 -> 2.0.0)"
    echo "  minor    - Increment minor version (1.0.0 -> 1.1.0)"
    echo "  patch    - Increment patch version (1.0.0 -> 1.0.1)"
    echo ""
    echo "Custom Version:"
    echo "  You can specify a custom version instead of auto-increment"
    echo "  Format: X.Y.Z or X.Y.Z+BUILD"
    echo ""
    echo "Examples:"
    echo "  $0 patch                    # Create patch release"
    echo "  $0 minor                    # Create minor release"
    echo "  $0 major                    # Create major release"
    echo "  $0 custom 2.1.0+42         # Create custom version release"
    echo ""
}

# Main script execution
main() {
    if [ $# -eq 0 ]; then
        show_usage
        exit 1
    fi
    
    local release_type=$1
    local custom_version=$2
    
    case $release_type in
        "major"|"minor"|"patch")
            create_release "$release_type" "$custom_version"
            ;;
        "custom")
            if [ -z "$custom_version" ]; then
                log_error "Custom version required when using 'custom' release type"
                show_usage
                exit 1
            fi
            create_release "custom" "$custom_version"
            ;;
        "help"|"-h"|"--help")
            show_usage
            ;;
        *)
            log_error "Unknown release type: $release_type"
            show_usage
            exit 1
            ;;
    esac
}

# Run main function
main "$@"