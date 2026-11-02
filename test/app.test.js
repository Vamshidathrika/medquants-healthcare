const test = require('node:test');
const assert = require('node:assert');
const fs = require('node:fs');
const path = require('node:path');

const projectRoot = path.resolve(__dirname, '..');
const indexPath = path.join(projectRoot, 'index.html');
const logoPath = path.join(projectRoot, 'medquants_logo.png');

test('MedQuants Core Asset Integrity', async (t) => {
  await t.test('index.html exists and is non-empty', () => {
    assert.ok(fs.existsSync(indexPath), 'index.html must exist');
    const stats = fs.statSync(indexPath);
    assert.ok(stats.size > 10000, 'index.html must have substantive content');
  });

  await t.test('Official MedQuants logo asset exists and is valid', () => {
    assert.ok(fs.existsSync(logoPath), 'medquants_logo.png must exist');
    const stats = fs.statSync(logoPath);
    assert.ok(stats.size > 5000, 'medquants_logo.png must be non-empty');
  });
});

test('Design System & UI Requirements', async (t) => {
  const html = fs.readFileSync(indexPath, 'utf8');

  await t.test('Zero emojis in index.html (Strict Iconographic Cohesion)', () => {
    const emojiRegex = /[\u{1F000}-\u{1FFFF}]|[\u{2600}-\u{27BF}]/u;
    const matches = html.match(emojiRegex);
    assert.strictEqual(matches, null, `Found forbidden emoji: ${matches ? matches[0] : ''}`);
  });

  await t.test('All 10 required Master Prototype screens exist in DOM', () => {
    const requiredScreens = [
      'screen-splash',
      'screen-home',
      'screen-doctor-hub',
      'screen-doctor-booking',
      'screen-pharmacy-home',
      'screen-medicines',
      'screen-lab-hub',
      'screen-tests',
      'screen-booking',
      'screen-profile'
    ];

    for (const screenId of requiredScreens) {
      assert.ok(
        html.includes(`id="${screenId}"`),
        `Screen container with id="${screenId}" must exist in index.html`
      );
    }
  });

  await t.test('Seamless Shutter Up splash overlay and HUD components exist', () => {
    assert.ok(html.includes('id="shutter-splash-overlay"'), 'shutter-splash-overlay must exist');
    assert.ok(html.includes('id="wireframe-hud"'), 'wireframe-hud must exist');
    assert.ok(html.includes('id="shutter-progress-bar"'), 'shutter-progress-bar must exist');
  });

  await t.test('JavaScript controller functions are properly defined', () => {
    assert.ok(html.includes('function triggerShutterUp()'), 'triggerShutterUp must be defined');
    assert.ok(html.includes('function replayShutterAnimation()'), 'replayShutterAnimation must be defined');
    assert.ok(html.includes('function switchScreen('), 'switchScreen must be defined');
    assert.ok(html.includes('function startUserPath('), 'startUserPath must be defined');
  });
});
