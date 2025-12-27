# Mobile Battery Theme

[![GitHub release](https://img.shields.io/github/v/release/NoDataFound/mobile-battery-theme?style=flat-square)](https://github.com/NoDataFound/mobile-battery-theme/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![Steam Deck](https://img.shields.io/badge/Steam%20Deck-Compatible-1a9fff?style=flat-square&logo=steam)](https://store.steampowered.com/steamdeck)
[![CSS Loader](https://img.shields.io/badge/CSS%20Loader-Theme-blueviolet?style=flat-square)](https://deckthemes.com/)
[![DeckThemes](https://img.shields.io/badge/DeckThemes-Available-green?style=flat-square)](https://deckthemes.com/)

A CSS Loader theme for Steam Deck that replaces the default battery icon with customizable battery indicators inspired by Android, iOS, and macOS designs.

<p align="center">
  <img src="screenshots/battery-styles.png" alt="Battery Styles Preview" />
</p>


## Features

- **12 Battery Styles**: Android 16, Android 16 v2, iOS 26, macOS, Pill, and Segmented in both orientations
- **17 Fill Colors**: White, Red, Orange, Amber, Yellow, Lime, Green, Emerald, Teal, Cyan, Sky, Blue, Indigo, Violet, Purple, Magenta, Pink, Rose
- **9 Border Colors**: Separate border color customization
- **Percentage Toggle**: Show or hide battery percentage text
- **Battery Level Display**: Shows current charge with semi-transparent depleted portion
- **State Indicators**: Low battery (orange), critical (red pulse), charging (green with lightning bolt), and full states

## Architecture

```mermaid
graph TB
    subgraph "Theme Structure"
        A[theme.json] --> B[shared.css]
        A --> C[styles/]

        subgraph "Style Files"
            C --> D[android16-vertical.css]
            C --> E[android16-horizontal.css]
            C --> F[android16-v2-vertical.css]
            C --> G[android16-v2-horizontal.css]
            C --> H[ios26-vertical.css]
            C --> I[ios26-horizontal.css]
            C --> J[macos-vertical.css]
            C --> K[macos-horizontal.css]
            C --> L[pill-vertical.css]
            C --> M[pill-horizontal.css]
            C --> N[segmented-vertical.css]
            C --> O[segmented-horizontal.css]
        end

        subgraph "Color Overrides"
            C --> P[color-*.css]
            C --> Q[border-*.css]
        end

        subgraph "Toggles"
            C --> R[show-percentage.css]
            C --> S[hide-percentage.css]
        end
    end
```

## How It Works

```mermaid
flowchart LR
    subgraph "CSS Loader Injection"
        A[Inject shared.css] --> B[Apply selected style]
        B --> C{Color override?}
        C -->|Yes| D[Apply color CSS]
        C -->|No| E[Use default white]
        D --> F{Border override?}
        E --> F
        F -->|Yes| G[Apply border CSS]
        F -->|No| H[Match fill color]
        G --> I{Hide percentage?}
        H --> I
        I -->|Yes| J[Apply hide-percentage.css]
        I -->|No| K[Show percentage]
    end
```

## Battery Element Structure

```mermaid
graph TD
    subgraph "Steam Deck UI Element"
        A["[class*='_3XySI']<br/>Battery Container"] --> B["::before<br/>Fill Level"]
        A --> C["::after<br/>Battery Tip"]
        A --> D["svg (hidden)<br/>Original Icon"]
    end

    subgraph "CSS Styling"
        E[Container] --> F[Semi-transparent background<br/>rgba 255,255,255,0.3]
        E --> G[Solid fill from bottom/left]
        E --> H[Tip extends 1px out]
    end
```

## CSS Variable System

```mermaid
graph TD
    subgraph "shared.css Variables"
        A["--mbt-fill-color"] --> B[Battery fill color]
        C["--mbt-border-color"] --> D[Battery outline]
        E["--mbt-tip-color"] --> F[Tip color]
        G["--mbt-transition-speed"] --> H[Animation timing]
        I["--mbt-pulse-duration"] --> J[Charging pulse]
    end

    subgraph "Color Override Files"
        K[color-red.css] --> A
        L[color-blue.css] --> A
        M[color-green.css] --> A
        N["...17 colors"] --> A
    end

    subgraph "Border Override Files"
        O[border-red.css] --> C
        P[border-blue.css] --> C
        Q["...9 colors"] --> C
    end
```

## State Transitions

```mermaid
stateDiagram-v2
    [*] --> Normal: Battery > 20%
    Normal --> Low: Battery <= 20%
    Low --> Critical: Battery <= 10%
    Critical --> Low: Battery > 10%
    Low --> Normal: Battery > 20%

    Normal --> Charging: Plugged in
    Low --> Charging: Plugged in
    Critical --> Charging: Plugged in

    Charging --> Full: Battery = 100%
    Full --> Normal: Unplugged
    Charging --> Normal: Unplugged

    note right of Normal: White fill
    note right of Low: Orange fill
    note right of Critical: Red + pulse animation
    note right of Charging: Green + pulse animation
    note right of Full: Full height fill
```

## Requirements

- Steam Deck with SteamOS
- [Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader) installed
- [CSS Loader](https://github.com/DeckThemes/SDH-CssLoader) plugin installed

## Installation

### From DeckThemes Store (Recommended)
1. Open Quick Access Menu (... button) in Gaming Mode
2. Navigate to Decky > CSS Loader
3. Go to the Store tab
4. Search for "Mobile Battery Theme"
5. Click Install

### Manual Install

```mermaid
sequenceDiagram
    participant User
    participant PC
    participant Deck as Steam Deck

    User->>PC: Download theme
    PC->>Deck: Copy to ~/homebrew/themes/
    User->>Deck: Open Quick Access Menu
    Deck->>Deck: Navigate to Decky > CSS Loader
    User->>Deck: Press Refresh
    User->>Deck: Enable "Mobile Battery Theme"
    Deck->>Deck: Apply CSS styling
```

1. Copy the `mobile-battery-theme` folder to:
   ```
   /home/deck/homebrew/themes/
   ```
2. In Gaming Mode, open Quick Access Menu
3. Navigate to Decky > CSS Loader
4. Press "Refresh" at the bottom
5. Enable "Mobile Battery Theme"

## Configuration

After enabling the theme, use the dropdown options in CSS Loader to customize:

| Option | Values | Description |
|--------|--------|-------------|
| Battery Style | Android 16 H/V, Android 16 v2 H/V, iOS 26 H/V, macOS H/V, Pill H/V, Segmented H/V | Battery icon style |
| Fill Color | 17 colors | Color of the battery fill |
| Border Color | 9 colors | Color of the battery outline |
| Show Percentage | Yes, No | Toggle percentage text |

## File Structure

```
mobile-battery-theme/
├── theme.json              # Theme manifest with patches
├── shared.css              # CSS variables and animations
└── styles/
    ├── android16-vertical.css      # Android 16 filled style
    ├── android16-horizontal.css
    ├── android16-v2-vertical.css   # Android 16 outlined style
    ├── android16-v2-horizontal.css
    ├── ios26-vertical.css          # iOS 26 style
    ├── ios26-horizontal.css
    ├── macos-vertical.css          # macOS style
    ├── macos-horizontal.css
    ├── pill-vertical.css           # Pill style
    ├── pill-horizontal.css
    ├── segmented-vertical.css      # Segmented style
    ├── segmented-horizontal.css
    ├── color-*.css                 # Fill color overrides (17 colors)
    ├── border-*.css                # Border color overrides (9 colors)
    ├── show-percentage.css         # Show percentage inside battery
    └── hide-percentage.css         # Hide percentage
```

## Style Comparison

| Style | Background | Border | Nub | Charging Indicator |
|-------|------------|--------|-----|-------------------|
| Android 16 | Filled (30% white) | None | Same as background | Blue pulse |
| Android 16 v2 | Transparent | 1.5px white | White, flush | Lightning bolt |
| iOS 26 | Transparent | 1.5px white | White, with gap | Lightning bolt |
| macOS | Transparent | Border | Small nub | Color change |
| Pill | Filled | Rounded | Rounded | Pulse |
| Segmented | Filled | Segments | Segmented | Pulse |

## Customization

### Creating Custom Colors

Create a new file `styles/color-custom.css`:

```css
:root {
    --mbt-fill-color: #YOUR_HEX !important;
}
```

Then add to `theme.json` under "Fill Color" > "values":

```json
"Custom": { "styles/color-custom.css": ["SP", "QuickAccess", "MainMenu"] }
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Theme not appearing | Verify theme.json is valid JSON, refresh CSS Loader |
| Battery unchanged | Check if CSS Loader is enabled and theme is active |
| Colors not applying | Ensure color CSS loads after main style CSS |
| Percentage won't hide | Toggle the option off and refresh |

## License

MIT License - Feel free to modify and redistribute.

## Credits

- [Decky Loader](https://decky.xyz/)
- [DeckThemes/CSS Loader](https://deckthemes.com/)
- Inspired by Android 16, iOS 26, and macOS battery designs
