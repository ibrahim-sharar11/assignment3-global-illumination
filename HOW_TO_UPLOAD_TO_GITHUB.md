# How to Upload This Repository to GitHub - Step by Step

## 🎯 Simple Steps to Get Your Code on GitHub

### Step 1: Create a GitHub Account (if you don't have one)
1. Go to [github.com](https://github.com)
2. Click "Sign up"
3. Follow the instructions to create your account

---

### Step 2: Create a New Repository on GitHub

1. **Log into GitHub** in your web browser
2. Click the **"+"** icon in the top right corner
3. Click **"New repository"**

4. **Fill in the details:**
   - **Repository name:** `assignment3-global-illumination` (or whatever you want)
   - **Description:** "CSCI 3090 Assignment 3 - Faking Global Illumination on GPU"
   - **Visibility:** Choose **Private** (if you want) or **Public**
   - ⚠️ **DO NOT** check "Initialize with README" (we already have one!)
   - ⚠️ **DO NOT** add .gitignore or license (we already have them!)

5. Click the green **"Create repository"** button

---

### Step 3: Copy the Repository URL

After creating the repo, GitHub will show you a page with instructions. You'll see something like:

```
https://github.com/YOUR_USERNAME/assignment3-global-illumination.git
```

**Copy this URL!** You'll need it in the next step.

---

### Step 4: Push Your Code from Your Mac

Open Terminal and run these commands:

```bash
# Navigate to your project (if not already there)
cd /Users/ibrahimsharar/Downloads/Example12

# Add GitHub as a remote (replace YOUR_USERNAME and REPO_NAME with yours)
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git

# Push everything to GitHub
git push -u origin main
```

**Example:**
If your GitHub username is `ibrahimsharar` and repo name is `assignment3-global-illumination`:

```bash
git remote add origin https://github.com/ibrahimsharar/assignment3-global-illumination.git
git push -u origin main
```

You'll be asked for your GitHub username and password (or use a Personal Access Token).

---

### Step 5: Verify It's on GitHub

1. Go back to your GitHub repository page in your browser
2. Refresh the page
3. You should see all your files there! ✅

---

## 🔐 Authentication Issues?

GitHub might ask for authentication. Here are options:

### Option A: Use Personal Access Token (Recommended)

1. Go to GitHub.com → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token"
3. Give it a name like "Assignment3"
4. Select scopes: check **"repo"**
5. Click "Generate token"
6. **Copy the token** (you'll only see it once!)
7. When git asks for password, paste the token instead

### Option B: Use GitHub Desktop (Easier!)

1. Download [GitHub Desktop](https://desktop.github.com)
2. Sign in with your GitHub account
3. Click "File" → "Add Local Repository"
4. Navigate to `/Users/ibrahimsharar/Downloads/Example12`
5. Click "Publish repository"
6. Done! ✅

---

## 📥 Accessing on Another Device

Once it's on GitHub:

### On Your Other Device (or another computer):

1. **Open terminal/command prompt**

2. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/assignment3-global-illumination.git
   ```

3. **Navigate into it:**
   ```bash
   cd assignment3-global-illumination
   ```

4. **Check it worked:**
   ```bash
   git log
   ls -la
   ```

You'll have everything! ✅

---

## 🚀 Quick Commands Reference

### Check if remote is set up:
```bash
git remote -v
```

### If you need to change the remote URL:
```bash
git remote set-url origin https://github.com/YOUR_USERNAME/REPO_NAME.git
```

### Push updates later:
```bash
git add .
git commit -m "Description of changes"
git push
```

### Pull updates on another device:
```bash
git pull
```

---

## ❓ Troubleshooting

### "Repository not found" error
- Make sure the repository exists on GitHub
- Check the URL is correct
- Make sure you're logged in

### "Authentication failed"
- Use a Personal Access Token instead of password
- Or use GitHub Desktop

### "Permission denied"
- Make sure the repository is yours (or you have access)
- Check your GitHub username is correct

---

## ✅ Checklist

- [ ] Created GitHub account
- [ ] Created new repository on GitHub
- [ ] Copied the repository URL
- [ ] Added remote: `git remote add origin <URL>`
- [ ] Pushed code: `git push -u origin main`
- [ ] Verified files appear on GitHub
- [ ] Tested cloning on another device

---

## 💡 Alternative: Just Copy the Folder

If GitHub seems complicated, you can also:

1. **Compress the folder:**
   ```bash
   cd /Users/ibrahimsharar/Downloads
   zip -r Assignment3.zip Example12
   ```

2. **Transfer via:**
   - USB drive
   - Cloud storage (Dropbox, Google Drive, iCloud)
   - Email (if zip is small enough)

3. **On other device:**
   - Extract the zip
   - Navigate to Example12 folder
   - Everything is there! (including .git folder)

---

**Need help? Just ask! The repository is ready to go! 🚀**

