# h-pattern

Two-tablet exhibit for testing eye movements (cranial nerves III, IV and VI) with the H pattern.

| File | Tablet | What it shows |
| --- | --- | --- |
| `visitor.html` | Facing the visitor | A bee flying the H pattern. No touch, no camera, no sound. |
| `audience.html` | Facing the audience | Mirrored, zoomed front camera; small H diagram; muscle + nerve captions; "LR6 SO4, the rest are 3". |
| `hpath.js` | Both | The shared 40-second timeline. |
| `index.html` | Either | A launcher to pick which page this tablet shows. |

## How the two tablets stay in sync

They never talk to each other. Each page works out the bee's position from `Date.now()`, and
`Date.now() % 40000` is the same number on every device whose clock is correct. So the tablets
need **correct clocks**, not a connection between them. The cycle position (e.g. `12.3 / 40 s`)
is shown faintly in a corner of both screens so you can check them side by side.

Path: centre → right → up-right → down-right → centre → left → up-left → down-left → centre.
A 2 s hold at each of the six end points (12 s) plus 28 s of movement, split by distance = 40 s.

## Setup walkthrough

### 1. Put the pages on an HTTPS web address (once)

The audience tablet uses the camera, and browsers only allow the camera on `https://` pages.
Opening the file straight from the tablet's storage will not work for the camera.

**GitHub Pages (simplest, free):**
1. Merge this branch into `main`.
2. On GitHub: repository **Settings → Pages**.
3. Under *Build and deployment*, choose **Deploy from a branch**, branch `main`, folder `/ (root)`, and save.
4. After a minute or two the page shows your address, e.g.
   `https://axisavalon33-ai.github.io/h-pattern/`.

(GitHub Pages on a *private* repository needs a paid GitHub plan. Alternatives: make the repository
public, or drag the folder onto Netlify Drop at https://app.netlify.com/drop for an instant HTTPS address.)

Once a tablet has loaded the page, the bee keeps running offline as long as the tab stays open.

### 2. Set both tablets' clocks to automatic

- **iPad:** Settings → General → Date & Time → **Set Automatically** on.
- **Android:** Settings → System → Date & time → **Automatic date & time** on.

Connect both to the internet (venue Wi-Fi or a phone hotspot) at least while you set up, so
the clocks sync. They don't need to be on the same network as each other.

### 3. Keep the screens on

- **iPad:** Settings → Display & Brightness → Auto-Lock → **Never**.
- **Android:** Settings → Display → Screen timeout → longest setting (or keep-awake in Developer options).

The pages also ask the browser to keep the screen awake when you tap the fullscreen button.

### 4. Visitor tablet

1. Open `https://…/h-pattern/visitor.html` in Safari or Chrome.
2. Tap the small fullscreen button (bottom-right).
   On iPad, for a cleaner look you can instead use **Share → Add to Home Screen** and launch it from the icon.
3. Recommended: lock the tablet to this page so visitors can't leave it —
   **iPad:** Settings → Accessibility → **Guided Access** on, then triple-click the side/home button.
   **Android:** Settings → Security → **App pinning** on, then pin the browser from the recents screen.
4. Place it in landscape about 40 cm from the visitor's eyes, at eye level.

### 5. Audience tablet

1. Open `https://…/h-pattern/audience.html`.
2. Tap **Start camera** (top-right) and allow camera access when asked.
3. Use **−** / **+** to zoom until the visitor's eyes fill the upper middle of the screen.
4. Tap the fullscreen button.
5. Angle the tablet so its front camera sees the visitor's face, with the screen visible to the audience.

### 6. Check they match

Put the tablets side by side. The faint `xx.x / 40 s` numbers in the corners should agree to
within a few tenths of a second, and the H-diagram dot should be where the bee is. If one is off by
seconds, its clock isn't synced: toggle automatic time off and on again, then reload the page.

## Notes

- "Right" and "left" in captions always mean the **visitor's** right and left. Because the camera is
  mirrored, the visitor's right eye appears on the right of the audience screen, under the "Right eye" caption.
- No browser storage is used by either page. The visitor page uses no camera and no sound.
