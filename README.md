# 🟣 MedQuants Healthcare

> **Integrated Telemedicine, 10-Minute Pharmacy & Doorstep Diagnostics Mobile Prototype**
> Powered by an Amethyst Purple Glassmorphism Design System with a physical "Shutter-Up" curtain reveal.

---

## ✨ Features

- **Seamless Shutter-Up Splash Screen**:
  - Official MedQuants white logo with specular glow on Amethyst Purple (`#8E2DA8` to `#5E1473`).
  - Animated pulsing radar ripples and glowing heart monitor divider.
  - Smooth 0% to 100% simulated connection progress bar.
  - Hardware-accelerated physical curtain shutter that smoothly slides up (`cubic-bezier(0.16, 1, 0.3, 1)`) and docks into the Home Screen wave header.
  - Top header `Replay Shutter Up` button to re-trigger the animation anytime.

- **10 Complete Master Prototype Screens**:
  1. **Loading Splash Screen**: White logo on deep purple with automated shutter transition.
  2. **Interactive Flow Paths Navigator**: 4 step-by-step wireframe journeys with live HUD navigation.
  3. **Master Home Screen**: Amethyst wave header, glass consultation cards, next appointment widget, and quick services.
  4. **Doctor Consultation Hub**: Specialty grid (Cardiology, Neurology, Pediatrics), second opinion banner, verified doctors.
  5. **Doctor Details & Video Booking**: Dr. Rahul (Cardiology), calendar date picker, time slot selector, language choices, file attachment.
  6. **Pharmacy Store Landing**: 10-minute medicine delivery, category grid, prescription upload.
  7. **Medicines 2-Column Catalog**: Tab filters (OTC, Prescription, Generics), pricing cards, Add to Cart actions.
  8. **Lab Tests Hub**: Doorstep phlebotomy booking, CBC & Thyroid packages, FAQ accordion.
  9. **Lab Tests Catalog**: Comprehensive diagnostic packages with turnaround times and sample instructions.
  10. **Account Settings & Profile**: Health records, consultations history, orders, wallet, addresses, and HIPAA compliance badge.

- **Strict Design Standards**:
  - **Zero Emojis**: 100% Lucide SVG icon family with consistent 1.75px stroke weights.
  - **Amethyst Purple Core**: Dominant `#8E2DA8` primary, `#5E1473` deep purple, and ultra-subtle airy background tint.
  - **Double-Bezel Glassmorphism**: Frosted translucency (`backdrop-blur-xl`), 1px specular white top-rim borders, and ambient purple drop-shadows.

---

## 🚀 Getting Started

### Local Development

```bash
# Clone the repository
git clone https://github.com/Vamshidathrika/medquants-healthcare.git
cd medquants-healthcare

# Install dev dependencies
npm install

# Run automated tests
npm run test

# Run TypeScript typecheck
npm run typecheck

# Start local server
npx serve .
# Or with Python
python3 -m http.server 3333
```

---

## 🛠️ Tech Stack

- **HTML5 & Vanilla JavaScript**: Zero runtime framework dependencies for maximum performance.
- **Tailwind CSS**: Hardware-accelerated utility styling and glassmorphism filters.
- **Lucide Icons**: Unified iconography.
- **Node.js Test Runner**: Built-in zero-flake test suite (`node --test`).
- **TypeScript**: Static type verification.

---

## 📄 License

MIT © [Vamshi Dathrika](https://github.com/Vamshidathrika)
