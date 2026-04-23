# Design System Documentation

## Overview

A dark, warm-toned editorial design system built around serif typography and amber/orange accents. Designed for long-form reading experiences.

---

## Color Palette

### CSS Custom Properties (`:root`)

| Token | Value | Usage |
|---|---|---|
| `--bg` | `#1A1714` | Primary background |
| `--bg2` | `#211C18` | Secondary background |
| `--bg3` | `#2A2420` | Tertiary background |
| `--bg4` | `#302A25` | Quaternary background / scrollbar thumb |
| `--orange` | `#CF7B4B` | Primary accent, tip borders |
| `--orange-dim` | `#8A5230` | Dimmed accent |
| `--text` | `#D4CCC4` | Primary body text |
| `--text-dim` | `#8A7F76` | Subdued / secondary text |
| `--text-head` | `#EDE8E2` | Headings and emphasized text |
| `--rule` | `#3D3028` | Dividers and borders |
| `--code-bg` | `#13110F` | Code block background |
| `--code-text` | `#9DC499` | Code block text (green) |
| `--tip-bg` | `#231D18` | Tip/callout block background |
| `--tip-border` | `#CF7B4B` | Tip/callout block border (same as `--orange`) |

---

## Typography

### Font Family

**Primary:** `'Lora'`, Georgia, serif

- A serif font optimized for reading-heavy interfaces.
- Loaded via Google Fonts (`woff2` format with `font-display: swap`).

### Font Variants Loaded

| Style | Weight | Unicode Range |
|---|---|---|
| Italic | 400 | Cyrillic Extended, Ukrainian, Latin Extended |

> Additional weights/styles (normal 400, bold, etc.) are assumed to be loaded — document additional `@font-face` blocks as they are added.

### Base Typography (`body`)

| Property | Value |
|---|---|
| `font-family` | `'Lora', Georgia, serif` |
| `font-size` | `15px` |
| `line-height` | `1.75` |
| `color` | `var(--text)` → `#D4CCC4` |
| `background` | `var(--bg)` → `#1A1714` |

### Paragraph (`p`)

| Property | Value |
|---|---|
| `font-size` | `15px` |
| `color` | `var(--text)` |
| `line-height` | `1.8` |
| `margin-bottom` | `16px` |

---

## Components

### Cover Subtitle (`.cover-sub`)

Used for introductory or hero section subheadings beneath a main cover title.

| Property | Value |
|---|---|
| `font-size` | `18px` |
| `color` | `var(--text-dim)` → `#8A7F76` |
| `font-style` | `italic` |
| `margin-bottom` | `40px` |
| `max-width` | `520px` |
| `line-height` | `1.5` |

```html
<p class="cover-sub">A short, elegant subtitle rendered in muted italic.</p>
```

---

## Global Reset (`*`)

Applied universally to all elements.

```css
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
```

---

## Scrollbar Styling

Custom scrollbar for webkit browsers.

| Part | Property | Value |
|---|---|---|
| Track | `background` | `var(--bg)` → `#1A1714` |
| Thumb | `background` | `var(--bg4)` → `#302A25` |
| Thumb | `border-radius` | `3px` |
| Width | `width` | `6px` |

```css
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: var(--bg); }
::-webkit-scrollbar-thumb { background: var(--bg4); border-radius: 3px; }
```

---

## Design Principles

1. **Dark warmth** — Backgrounds use warm near-blacks (`#1A1714`) rather than cold grays, creating a candlelit editorial atmosphere.
2. **Layered depth** — Four background levels (`--bg` through `--bg4`) allow subtle surface differentiation without harsh contrast.
3. **Readable serif** — Lora at 15px/1.75 line-height prioritizes comfort for long-form content.
4. **Restrained accent** — Orange (`#CF7B4B`) is used sparingly for interactive elements, borders, and emphasis — never for body text.
5. **Muted hierarchy** — Text ranges from `--text-head` (brightest) to `--text-dim` (subtlest), guiding attention without stark white.
