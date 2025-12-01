# VSCode Setup for Testing on Windows

## Quick Answer: **VSCode Won't Run It Directly, But It Can Help with WSL**

VSCode is just an editor - it can't run OpenGL programs on Windows without WSL or a build environment. However, VSCode **can make using WSL easier** if we set it up properly.

---

## What VSCode CAN Do:

1. **Better WSL Integration** - Remote-WSL extension makes WSL easier to use
2. **Terminal Integration** - Access WSL terminal directly in VSCode
3. **Better Editing** - Syntax highlighting, code navigation
4. **Debugging** - Can debug code running in WSL

## What VSCode CAN'T Do:

1. **Run OpenGL programs natively on Windows** - Still needs WSL or libraries
2. **Fix WSL resource errors** - If WSL doesn't work, VSCode won't fix it
3. **Install dependencies** - Still need to install libraries in WSL

---

## Option 1: Use VSCode with WSL (If WSL Works)

### Setup Steps:

1. **Install VSCode Remote-WSL Extension:**
   - Open VSCode
   - Extensions → Search "Remote - WSL"
   - Install it

2. **Open Project in WSL:**
   - Press `F1` or `Ctrl+Shift+P`
   - Type: "WSL: Open Folder in WSL"
   - Navigate to: `/mnt/c/Users/alish/OneDrive/Desktop/assignment3-global-illumination`

3. **Use Integrated Terminal:**
   - Terminal → New Terminal (automatically opens WSL terminal)
   - Run commands: `make`, `./example12 a b`

**This makes WSL easier to use, but WSL still needs to work first!**

---

## Option 2: Test on Another Machine (Recommended)

Since WSL is having issues, **testing on another machine is still the best option**:

### Where to Test:

1. **University Computer Lab** - Usually has Linux/Mac
2. **Friend's Mac/Linux Computer**
3. **Virtual Machine** - Install Ubuntu in VirtualBox (slow but works)
4. **Cloud Instance** - AWS/Azure free tier with Linux (requires X11 forwarding)

### Quick Steps:

```bash
# On Linux/Mac machine:
git clone https://github.com/ibrahim-sharar11/assignment3-global-illumination
cd assignment3-global-illumination
sudo apt-get install libfreeimage-dev libglfw3-dev libglew-dev libgl1-mesa-dev
make
./example12 a b
```

---

## Option 3: Fix WSL First, Then Use VSCode

If you want to try fixing WSL one more time:

### Try These Steps:

1. **Restart Your Computer** - Sometimes fixes resource issues

2. **Update WSL:**
   ```powershell
   # Run as Administrator
   wsl --update
   wsl --shutdown
   # Wait 1 minute
   wsl
   ```

3. **Try Ubuntu Specifically:**
   ```powershell
   wsl --install -d Ubuntu
   wsl -d Ubuntu
   ```

4. **Then set up VSCode Remote-WSL** (as described above)

---

## My Recommendation:

**Don't rely on VSCode to run it** - VSCode is just a tool.

**Best options in order:**

1. ✅ **Test on university lab computer** (easiest - Linux/Mac usually available)
2. ✅ **Test on friend's Mac/Linux computer**
3. ✅ **Submit code as-is** (it's validated and correct!)
4. ⚠️ **Try fixing WSL** (if you have time)
5. ❌ **Native Windows build** (very complex, not worth it)

---

## Quick Check: Does WSL Work Now?

Try this first:
```powershell
wsl echo "Hello"
```

**If that works:** Set up VSCode Remote-WSL extension, then test  
**If that fails:** Use another machine or submit as-is

---

**Bottom line:** VSCode makes WSL easier to use, but you still need WSL to work. If WSL isn't working, testing on another machine is your best bet.


