// Disable unwanted services
user_pref("app.update.auto", false);
user_pref("identity.fxaccounts.enabled", false);
user_pref("layout.spellcheckDefault", 0);
user_pref("extensions.pocket.enabled", false);

// Control search suggestions
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.trimURLs", false);

// Browsing and Download history
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.history.custom", true);
user_pref("places.history.enabled", false);
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.rememberSignons", false);

// Enforce DNS over HTTPS
user_pref("network.trr.mode", 5);
user_pref("doh-rollout.disable-heuristics", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);

// Enable autofill service only for forms
user_pref("dom.forms.autocomplete.formautofill", true);

// Disable WebRTC
user_pref("media.peerconnection.enabled", false);

// Enable WebGL
user_pref("webgl.disabled", false);

// Disable DRM contents
user_pref("media.eme.enabled", false);
user_pref("browser.eme.ui.enabled", false);

// Isolation
user_pref("browser.download.forbid_open_with", true);
user_pref("browser.download.folderList", 2);

// Control RFP
user_pref("privacy.resistFingerprinting", false);
user_pref('privacy.resistFingerprinting.letterboxing', false);
user_pref('privacy.resistFingerprinting.block_mozAddonManager', true);
user_pref('privacy.donottrackheader.enabled', true);

/* Enable only if RFP is disabled */
user_pref("dom.enable_web_task_scheduling", true);
user_pref("dom.webnotifications.enabled", false);
user_pref("dom.push.enabled", false);
user_pref("dom.push.userAgentID", "");
user_pref("dom.gamepad.enabled", false);
user_pref("device.sensors.enabled", false);
user_pref("dom.w3c_touch_events.enabled", 0);
user_pref("media.ondevicechange.enabled", false);

// Permissions
user_pref("permissions.default.geo", 0);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.xr", 2);
// control websites overriding Firefox's keyboard shortcuts
user_pref("permissions.default.shortcuts", 2);
// control website control over browser right-click context menu
user_pref("dom.event.contextmenu.enabled", true);

// Disable Google Safe Browsing
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);

/* Speed up firefox performance
 * https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js
 */
// notification interval (in microseconds) to avoid layout thrashing
user_pref("content.notify.interval", 100000);
// GPU-accelerated Canvas2D
user_pref("gfx.canvas.accelerated.cache-items", 4096);
user_pref("gfx.canvas.accelerated.cache-size", 512);
user_pref("gfx.content.skia-font-cache-size", 20);
// compression level for cached JavaScript bytecode
user_pref("browser.cache.jsbc_compression_level", 3);
// media memory cache
//user_pref("media.memory_cache_max_size", 65536); // already on arkenfox.js
// adjust video buffering periods when not using MSE
user_pref("media.cache_readahead_limit", 7200);
user_pref("media.cache_resume_threshold", 3600);
// image cache
user_pref("image.mem.decode_bytes_at_a_time", 32768);
// use bigger packets
user_pref('network.buffer.cache.size', 262144);
user_pref('network.buffer.cache.count', 128)
// increase the absolute number of HTTP connections
user_pref("network.http.max-connections", 1800);
user_pref("network.http.max-persistent-connections-per-server", 10);
user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
// pacing requests
user_pref("network.http.pacing.requests.enabled", false);
// adjust DNS expiration time
user_pref("network.dnsCacheExpiration", 3600);
// the number of threads for DNS
user_pref("network.dns.max_high_priority_threads", 8);
// increase TLS token caching
user_pref("network.ssl_tokens_cache_capacity", 10240);

/* Better font rendering(when possible) */
user_pref("gfx.webrender.quality.force-subpixel-aa-where-possible", true);
user_pref("gfx.use_text_smoothing_setting", true);

/* Misc */
user_pref("browser.sessionstore.resume_from_crash", false);
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser,urlbar.resultMenu.keyboard-Accesible", false);
user_pref("browser.chrome.guess_favicon", false);
user_pref("devtools.toolbox.zoomValue", '1.1');
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

user_pref("_user.js.parrot", "SUCCESS: user-overrides.js");
