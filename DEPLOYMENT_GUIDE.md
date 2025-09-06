# GitHub Pages Deployment Guide

## Quick Setup

1. **Create a GitHub Repository**
   - Go to [GitHub.com](https://github.com)
   - Click "New repository"
   - Name it `Inside-Deep-House` (or any name you prefer)
   - Make it public
   - Don't initialize with README (since you already have one)

2. **Upload Your Code**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOURUSERNAME/Inside-Deep-House.git
   git push -u origin main
   ```

3. **Enable GitHub Pages**
   - Go to your repository on GitHub
   - Click "Settings" tab
   - Scroll down to "Pages" in the left sidebar
   - Under "Source", select "Deploy from a branch"
   - Choose "main" branch and "/ (root)" folder
   - Click "Save"

4. **Update URLs**
   - Replace `yourusername` in the following files with your actual GitHub username:
     - `README.md`
     - `robots.txt`
     - `sitemap.xml`
     - `_config.yml`
     - Meta tags in `index.html`

5. **Your Site Will Be Available At:**
   `https://YOURUSERNAME.github.io/Inside-Deep-House/`

## Important Notes

- ⚠️ **Audio Files**: The MP3 files in `StreamDownload/` are large and may exceed GitHub's file size limits. Consider:
  - Using a cloud storage service (Google Drive, Dropbox, etc.)
  - Using a CDN
  - Compressing the audio files
  - Using streaming services

- 🔄 **Updates**: Changes pushed to the main branch will automatically update your site

- 📱 **Mobile Friendly**: The site is now optimized for mobile devices

- 🚀 **Performance**: Images have lazy loading and the site is optimized for fast loading

## Troubleshooting

- If audio doesn't work, check that the file paths are correct
- Large files (>100MB) won't work on GitHub Pages
- It may take a few minutes for changes to appear on your live site

## Custom Domain (Optional)

To use a custom domain:
1. Add a `CNAME` file with your domain name
2. Configure DNS settings with your domain provider
3. Enable HTTPS in GitHub Pages settings
