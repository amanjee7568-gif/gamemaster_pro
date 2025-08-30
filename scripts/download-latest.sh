#!/bin/bash

# GameMaster Pro APK Download Script
# Downloads the latest APK from GitHub releases

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration - UPDATE THESE VALUES
GITHUB_REPO="yourusername/gamemaster-pro"  # Replace with your actual repository
DOWNLOAD_DIR="./downloads"

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

# Check if jq is available
check_dependencies() {
    if ! command -v curl &> /dev/null; then
        log_error "curl is required but not installed"
        exit 1
    fi
    
    if ! command -v jq &> /dev/null; then
        log_warning "jq is not installed. Falling back to basic parsing"
        log_info "Install jq for better JSON parsing: sudo apt-get install jq"
    fi
}

# Create download directory
setup_download_dir() {
    if [ ! -d "$DOWNLOAD_DIR" ]; then
        log_info "Creating download directory: $DOWNLOAD_DIR"
        mkdir -p "$DOWNLOAD_DIR"
    fi
}

# Get latest release info
get_latest_release() {
    local api_url="https://api.github.com/repos/$GITHUB_REPO/releases/latest"
    log_info "Fetching latest release info from GitHub..."
    
    if ! curl -s "$api_url" > /tmp/latest_release.json; then
        log_error "Failed to fetch release information"
        exit 1
    fi
    
    # Check if we got an error response
    if grep -q "Not Found" /tmp/latest_release.json; then
        log_error "Repository not found or no releases available"
        log_info "Please check the repository name: $GITHUB_REPO"
        exit 1
    fi
}

# Parse release info with jq if available, otherwise use basic parsing
parse_release_info() {
    if command -v jq &> /dev/null; then
        # Use jq for proper JSON parsing
        RELEASE_TAG=$(jq -r '.tag_name' /tmp/latest_release.json)
        RELEASE_NAME=$(jq -r '.name' /tmp/latest_release.json)
        RELEASE_DATE=$(jq -r '.published_at' /tmp/latest_release.json | cut -d'T' -f1)
        
        # Get APK assets
        jq -r '.assets[] | select(.name | test(".*\\.apk$")) | "\(.name)|\(.browser_download_url)|\(.size)"' /tmp/latest_release.json > /tmp/apk_assets.txt
    else
        # Basic parsing without jq
        RELEASE_TAG=$(grep -o '"tag_name":"[^"]*"' /tmp/latest_release.json | cut -d'"' -f4)
        RELEASE_NAME=$(grep -o '"name":"[^"]*"' /tmp/latest_release.json | cut -d'"' -f4)
        RELEASE_DATE=$(grep -o '"published_at":"[^"]*"' /tmp/latest_release.json | cut -d'"' -f4 | cut -d'T' -f1)
        
        # Basic APK parsing (less reliable)
        grep -o '"name":"[^"]*\.apk"[^}]*"browser_download_url":"[^"]*"[^}]*"size":[0-9]*' /tmp/latest_release.json | \
        sed 's/"name":"//g; s/"browser_download_url":"/ /g; s/"size":/ /g; s/"//g' > /tmp/apk_assets.txt
    fi
    
    if [ -z "$RELEASE_TAG" ]; then
        log_error "Could not parse release information"
        exit 1
    fi
}

# Display release information
show_release_info() {
    echo ""
    log_success "Latest Release Found!"
    echo "  📱 Version: $RELEASE_TAG"
    echo "  📝 Name: $RELEASE_NAME"
    echo "  📅 Date: $RELEASE_DATE"
    echo ""
    
    if [ ! -s /tmp/apk_assets.txt ]; then
        log_warning "No APK files found in this release"
        exit 1
    fi
    
    echo "Available APK files:"
    local counter=1
    while IFS='|' read -r name url size || IFS=' ' read -r name url size; do
        local size_mb=$((size / 1024 / 1024))
        echo "  $counter) $name (${size_mb}MB)"
        counter=$((counter + 1))
    done < /tmp/apk_assets.txt
    echo ""
}

# Download specific APK
download_apk() {
    local selection=$1
    local counter=1
    local selected_name=""
    local selected_url=""
    local selected_size=""
    
    while IFS='|' read -r name url size || IFS=' ' read -r name url size; do
        if [ $counter -eq $selection ]; then
            selected_name="$name"
            selected_url="$url"
            selected_size="$size"
            break
        fi
        counter=$((counter + 1))
    done < /tmp/apk_assets.txt
    
    if [ -z "$selected_name" ]; then
        log_error "Invalid selection"
        return 1
    fi
    
    local output_file="$DOWNLOAD_DIR/$selected_name"
    
    log_info "Downloading: $selected_name"
    log_info "URL: $selected_url"
    log_info "Size: $((selected_size / 1024 / 1024))MB"
    log_info "Destination: $output_file"
    echo ""
    
    if curl -L -o "$output_file" --progress-bar "$selected_url"; then
        log_success "Download completed: $output_file"
        
        # Verify file size
        local actual_size=$(stat -c%s "$output_file" 2>/dev/null || stat -f%z "$output_file" 2>/dev/null || echo "0")
        if [ "$actual_size" -eq "$selected_size" ]; then
            log_success "File size verified: $((actual_size / 1024 / 1024))MB"
        else
            log_warning "File size mismatch. Expected: $((selected_size / 1024 / 1024))MB, Got: $((actual_size / 1024 / 1024))MB"
        fi
        
        return 0
    else
        log_error "Download failed"
        return 1
    fi
}

# Interactive selection menu
interactive_download() {
    show_release_info
    
    # Count available APKs
    local apk_count=$(wc -l < /tmp/apk_assets.txt)
    
    if [ $apk_count -eq 1 ]; then
        log_info "Only one APK available, downloading automatically..."
        download_apk 1
        return
    fi
    
    echo "Which APK would you like to download?"
    echo "  a) All APK files"
    echo "  q) Quit"
    echo ""
    echo -n "Enter your choice (1-$apk_count, a, q): "
    read -r choice
    
    case $choice in
        [1-9]*)
            if [ "$choice" -le "$apk_count" ]; then
                download_apk "$choice"
            else
                log_error "Invalid selection: $choice"
            fi
            ;;
        "a"|"A")
            log_info "Downloading all APK files..."
            local counter=1
            while [ $counter -le $apk_count ]; do
                echo ""
                download_apk $counter
                counter=$((counter + 1))
            done
            ;;
        "q"|"Q")
            log_info "Download cancelled"
            ;;
        *)
            log_error "Invalid choice: $choice"
            ;;
    esac
}

# Non-interactive download (for scripts)
download_all() {
    show_release_info
    
    log_info "Downloading all APK files..."
    local counter=1
    local apk_count=$(wc -l < /tmp/apk_assets.txt)
    
    while [ $counter -le $apk_count ]; do
        echo ""
        download_apk $counter
        counter=$((counter + 1))
    done
}

# Download specific type (production/development)
download_type() {
    local type=$1
    show_release_info
    
    local counter=1
    local found=0
    
    while IFS='|' read -r name url size || IFS=' ' read -r name url size; do
        case $type in
            "production"|"prod")
                if echo "$name" | grep -qi "production\|prod" && ! echo "$name" | grep -qi "development\|dev"; then
                    download_apk $counter
                    found=1
                    break
                fi
                ;;
            "development"|"dev")
                if echo "$name" | grep -qi "development\|dev"; then
                    download_apk $counter
                    found=1
                    break
                fi
                ;;
        esac
        counter=$((counter + 1))
    done < /tmp/apk_assets.txt
    
    if [ $found -eq 0 ]; then
        log_warning "No $type APK found"
        log_info "Available files:"
        show_release_info
    fi
}

# Show usage information
show_usage() {
    echo "GameMaster Pro APK Download Script"
    echo ""
    echo "Usage: $0 [option]"
    echo ""
    echo "Options:"
    echo "  (no option)    - Interactive download menu"
    echo "  --all          - Download all APK files"
    echo "  --production   - Download production APK only"
    echo "  --development  - Download development APK only"
    echo "  --info         - Show release info only (no download)"
    echo "  --help         - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                    # Interactive mode"
    echo "  $0 --all             # Download all APKs"
    echo "  $0 --production      # Download production APK"
    echo "  $0 --development     # Download development APK"
    echo ""
    echo "Configuration:"
    echo "  Repository: $GITHUB_REPO"
    echo "  Download Directory: $DOWNLOAD_DIR"
    echo ""
}

# Main function
main() {
    local option=${1:-"interactive"}
    
    case $option in
        "--help"|"-h")
            show_usage
            exit 0
            ;;
        "--info")
            check_dependencies
            get_latest_release
            parse_release_info
            show_release_info
            ;;
        "--all")
            check_dependencies
            setup_download_dir
            get_latest_release
            parse_release_info
            download_all
            ;;
        "--production"|"--prod")
            check_dependencies
            setup_download_dir
            get_latest_release
            parse_release_info
            download_type "production"
            ;;
        "--development"|"--dev")
            check_dependencies
            setup_download_dir
            get_latest_release
            parse_release_info
            download_type "development"
            ;;
        "interactive"|*)
            check_dependencies
            setup_download_dir
            get_latest_release
            parse_release_info
            interactive_download
            ;;
    esac
    
    # Cleanup
    rm -f /tmp/latest_release.json /tmp/apk_assets.txt
}

# Run main function
main "$@"