 <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SubscriptIQ — AI-Powered Subscription & Revenue Intelligence</title>
  <meta name="description" content="SubscriptIQ is an intelligent subscription management platform that automates billing, detects anomalies, forecasts revenue and eliminates subscription waste for Brightloop Software." />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="styles.css" />
</head>
<body>
  <!-- Login Page -->
  <div id="page-login" class="page active">
    <div class="login-bg">
      <div class="login-orb orb-1"></div>
      <div class="login-orb orb-2"></div>
      <div class="login-orb orb-3"></div>
    </div>
    <div class="login-container">
      <div class="login-card glass-card">
        <div class="login-logo">
          <div class="logo-icon"><span>S</span></div>
          <span class="logo-text">SubscriptIQ</span>
        </div>
        <p class="login-tagline">Beyond Billing. Intelligent Subscription Management.</p>
        <form id="login-form" class="login-form" onsubmit="handleLogin(event)">
          <div class="form-group">
            <label for="login-email">Email Address</label>
            <input type="email" id="login-email" placeholder="admin@brightloop.io" value="admin@brightloop.io" required />
          </div>
          <div class="form-group">
            <label for="login-password">Password</label>
            <input type="password" id="login-password" placeholder="password" value="password" required />
          </div>
          <div class="login-options">
            <label class="checkbox-label"><input type="checkbox" checked /> Remember me</label>
            <a href="#" class="forgot-link">Forgot password?</a>
          </div>
          <button type="submit" class="btn btn-primary btn-full" id="login-btn">
            <span>Sign In</span>
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
          </button>
        </form>
        <div class="login-divider"><span>Quick Access</span></div>
        <div class="quick-logins">
          <button class="quick-btn" onclick="quickLogin('admin')">&#x1F451; Admin</button>
          <button class="quick-btn" onclick="quickLogin('staff')">&#x1F464; Staff</button>
          <button class="quick-btn" onclick="quickLogin('customer')">&#x1F3E2; Customer</button>
        </div>
        <p class="login-footer">Brightloop Software &copy; 2025 &middot; SubscriptIQ v1.0</p>
      </div>
    </div>
  </div>
  <!-- Main App Shell -->
  <div id="page-app" class="page">
    <aside class="sidebar" id="sidebar">
      <div class="sidebar-header">
        <div class="logo-wrap">
          <div class="logo-icon"><span>S</span></div>
          <span class="logo-text sidebar-logo-text">SubscriptIQ</span>
        </div>
        <button class="sidebar-toggle" onclick="toggleSidebar()">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>
        </button>
      </div>
      <nav class="sidebar-nav" id="sidebar-nav"></nav>
      <div class="sidebar-footer">
        <div class="sidebar-user">
          <div class="user-avatar" id="sidebar-avatar">A</div>
          <div class="user-info">
            <span class="user-name" id="sidebar-name">Admin User</span>
            <span class="user-role" id="sidebar-role">Administrator</span>
          </div>
        </div>
        <button class="btn-logout" onclick="logout()">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
          <span>Logout</span>
        </button>
      </div>
    </aside>
