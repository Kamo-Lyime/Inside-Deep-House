# Firebase Setup Guide for Inside Deep House

This guide will walk you through setting up Firebase for your Inside Deep House website to enable dynamic album submissions and display functionality.

## Table of Contents
1. [Create Firebase Project](#1-create-firebase-project)
2. [Enable Firebase Services](#2-enable-firebase-services)
3. [Get Firebase Configuration](#3-get-firebase-configuration)
4. [Configure Security Rules](#4-configure-security-rules)
5. [Update Your Website](#5-update-your-website)
6. [Deploy to GitHub Pages](#6-deploy-to-github-pages)
7. [Set Up Custom Domain](#7-set-up-custom-domain-optional)
8. [Testing](#8-testing)
9. [Troubleshooting](#9-troubleshooting)

---

## 1. Create Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"** or **"Create a project"**
3. Enter your project name (e.g., `insidedeephouse`)
4. (Optional) Enable Google Analytics for your project
5. Click **"Create project"** and wait for it to be provisioned
6. Click **"Continue"** when the project is ready

---

## 2. Enable Firebase Services

### 2.1 Enable Firebase Realtime Database

1. In the Firebase Console, click on **"Realtime Database"** in the left sidebar (under "Build")
2. Click **"Create Database"**
3. Choose a database location (select the one closest to your users, e.g., `us-central1`)
4. Select **"Start in test mode"** (we'll configure proper security rules later)
5. Click **"Enable"**

### 2.2 Enable Firebase Storage

1. In the Firebase Console, click on **"Storage"** in the left sidebar (under "Build")
2. Click **"Get started"**
3. Click **"Next"** to accept the default security rules (we'll update these later)
4. Choose a storage location (same as your database location)
5. Click **"Done"**

### 2.3 Enable Firebase Authentication (Recommended)

For better security, enable authentication:

1. Click on **"Authentication"** in the left sidebar (under "Build")
2. Click **"Get started"**
3. Go to the **"Sign-in method"** tab
4. Enable **"Email/Password"** authentication
5. (Optional) Enable **"Google"** sign-in for easier user management

---

## 3. Get Firebase Configuration

1. In the Firebase Console, click on the **gear icon** (⚙️) next to "Project Overview"
2. Select **"Project settings"**
3. Scroll down to **"Your apps"** section
4. Click on the **"</>"** (Web) icon to add a web app
5. Register your app with a nickname (e.g., `Inside Deep House Web`)
6. (Optional) Check **"Also set up Firebase Hosting"** if you want to use Firebase Hosting
7. Click **"Register app"**
8. Copy the Firebase configuration object that looks like this:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  authDomain: "your-project-id.firebaseapp.com",
  databaseURL: "https://your-project-id-default-rtdb.firebaseio.com",
  projectId: "your-project-id",
  storageBucket: "your-project-id.appspot.com",
  messagingSenderId: "123456789012",
  appId: "1:123456789012:web:abcdef1234567890"
};
```

9. Click **"Continue to console"**

---

## 4. Configure Security Rules

### 4.1 Realtime Database Rules

For **development/testing** (allows public read/write):

1. Go to **Realtime Database** > **Rules** tab
2. Replace the rules with:

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

For **production** (recommended - requires authentication):

```json
{
  "rules": {
    "albums": {
      ".read": true,
      ".write": "auth != null"
    }
  }
}
```

This allows anyone to read albums but only authenticated users to write.

3. Click **"Publish"**

### 4.2 Firebase Storage Rules

For **development/testing**:

1. Go to **Storage** > **Rules** tab
2. Replace the rules with:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /album_artworks/{allPaths=**} {
      allow read: if true;
      allow write: if request.resource.size < 5 * 1024 * 1024
                   && request.resource.contentType.matches('image/.*');
    }
  }
}
```

For **production** (requires authentication):

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /album_artworks/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null
                   && request.resource.size < 5 * 1024 * 1024
                   && request.resource.contentType.matches('image/.*');
    }
  }
}
```

This allows:
- Anyone to read images
- Only authenticated users to upload images (production)
- Images must be under 5MB
- Only image file types are allowed

3. Click **"Publish"**

---

## 5. Update Your Website

### 5.1 Update firebase-config.js

1. Open the `firebase-config.js` file in your project
2. Replace the placeholder configuration with your actual Firebase config from Step 3:

```javascript
// Replace these values with your actual Firebase configuration
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
  databaseURL: "https://YOUR_PROJECT_ID-default-rtdb.firebaseio.com",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_PROJECT_ID.appspot.com",
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  appId: "YOUR_APP_ID"
};
```

3. Save the file

### 5.2 Test Locally

Before deploying, test your website locally:

1. Open `submit-album.html` in a web browser
2. Try submitting an album with test data
3. Check the Firebase Console to see if data appears in the Realtime Database
4. Open `albums.html` to see if the album displays correctly

---

## 6. Deploy to GitHub Pages

### 6.1 Prepare Your Repository

1. Ensure all files are in your GitHub repository:
   - `firebase-config.js`
   - `submit-album.html`
   - `albums.html`
   - All other HTML, CSS, and image files

### 6.2 Commit and Push Changes

Open PowerShell in your project directory and run:

```powershell
git add .
git commit -m "Added Firebase integration for album submissions"
git push origin main
```

### 6.3 Enable GitHub Pages

1. Go to your GitHub repository: `https://github.com/Kamo-Lyime/Inside-Deep-House`
2. Click on **Settings** (top right)
3. Scroll down to **Pages** in the left sidebar
4. Under **Source**, select:
   - Branch: `main`
   - Folder: `/ (root)`
5. Click **Save**
6. Your site will be published at: `https://kamo-lyime.github.io/Inside-Deep-House/`

**Note:** It may take a few minutes for changes to appear on GitHub Pages.

---

## 7. Set Up Custom Domain (Optional)

If you want to use your custom domain `www.insidedeephouse.co.za`:

### 7.1 Configure DNS Records

Go to your domain registrar (where you bought your domain) and add these DNS records:

**For apex domain (insidedeephouse.co.za):**
```
Type: A
Name: @
Value: 185.199.108.153
```
```
Type: A
Name: @
Value: 185.199.109.153
```
```
Type: A
Name: @
Value: 185.199.110.153
```
```
Type: A
Name: @
Value: 185.199.111.153
```

**For www subdomain:**
```
Type: CNAME
Name: www
Value: kamo-lyime.github.io
```

### 7.2 Configure GitHub Pages Custom Domain

1. In your GitHub repository, go to **Settings** > **Pages**
2. Under **Custom domain**, enter: `www.insidedeephouse.co.za`
3. Click **Save**
4. Wait for DNS check to complete (this can take up to 24 hours)
5. Once verified, check **"Enforce HTTPS"**

### 7.3 Update Firebase Authorized Domains

1. Go to Firebase Console > **Authentication** > **Settings** > **Authorized domains**
2. Add your custom domain: `www.insidedeephouse.co.za`
3. Click **Add domain**

---

## 8. Testing

### 8.1 Test Album Submission

1. Visit your deployed site: `https://kamo-lyime.github.io/Inside-Deep-House/submit-album.html`
2. Fill out the form with test data:
   - **Album Title:** Test Album
   - **Artist Name:** Test Artist
   - **Release Year:** 2025
   - **Buy Link:** https://example.com
   - **Album Image:** Upload a test image
   - **Social Links:** Add social media URLs
3. Click **"Submit Album"**
4. Check the Firebase Console > Realtime Database to verify the data was saved
5. Check Firebase Storage to verify the image was uploaded

### 8.2 Test Album Display

1. Visit: `https://kamo-lyime.github.io/Inside-Deep-House/albums.html`
2. Verify that the submitted album appears on the page
3. Check that the image loads correctly
4. Test that all links work

---

## 9. Troubleshooting

### Issue: "Permission denied" error when submitting

**Solution:**
- Check your Firebase Realtime Database rules
- Ensure Storage rules allow writes
- If using authentication, make sure users are signed in

### Issue: Images not uploading

**Solution:**
- Check Firebase Storage rules
- Verify file size is under 5MB
- Ensure file is an image format (JPEG, PNG, etc.)
- Check browser console for errors

### Issue: Albums not displaying

**Solution:**
- Open browser console (F12) and check for errors
- Verify Firebase configuration is correct in `firebase-config.js`
- Check that data exists in Firebase Realtime Database
- Ensure internet connection is working

### Issue: CORS errors

**Solution:**
- Firebase should handle CORS automatically
- If issues persist, check that your domain is added to Firebase Authorized Domains
- Clear browser cache and try again

### Issue: Changes not showing on GitHub Pages

**Solution:**
- Wait 5-10 minutes for GitHub Pages to rebuild
- Clear browser cache (Ctrl + Shift + Delete)
- Try incognito/private browsing mode
- Verify files were committed and pushed to the repository

---

## Next Steps

1. **Add Authentication (Recommended):**
   - Implement user sign-in on `submit-album.html`
   - Only allow authenticated users to submit albums
   - This prevents spam and unauthorized submissions

2. **Add Admin Panel:**
   - Create an admin page to review and approve submissions
   - Add ability to edit or delete albums

3. **Improve UI/UX:**
   - Add loading indicators during uploads
   - Show success/error messages
   - Add form validation
   - Implement image preview before upload

4. **Add Features:**
   - Allow users to like/favorite albums
   - Add search and filter functionality
   - Implement pagination for album display
   - Add categories/genres for albums

---

## Support Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [GitHub Pages Documentation](https://docs.github.com/pages)
- [Firebase Console](https://console.firebase.google.com/)
- [Stack Overflow - Firebase Tag](https://stackoverflow.com/questions/tagged/firebase)

---

**Created:** November 19, 2025  
**Website:** www.insidedeephouse.co.za  
**Repository:** https://github.com/Kamo-Lyime/Inside-Deep-House
