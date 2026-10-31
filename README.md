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
    <main class="main-content" id="main-content">
      <header class="topbar">
        <div class="topbar-left">
          <button class="mobile-menu-btn" onclick="toggleSidebar()">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>
          </button>
          <h1 class="page-title" id="page-title">Dashboard</h1>
        </div>
        <div class="topbar-right">
          <div class="search-wrap">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
            <input type="text" placeholder="Search..." class="global-search" id="global-search" />
          </div>
          <button class="icon-btn notification-btn" onclick="toggleNotifications()">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
            <span class="badge" id="notif-badge">3</span>
          </button>
          <div class="topbar-avatar" id="topbar-avatar">A</div>
        </div>
      </header>
      <div class="notif-drawer" id="notif-drawer">
        <div class="notif-header">
          <span>Notifications</span>
          <button onclick="toggleNotifications()">&#x2715;</button>
        </div>
        <div class="notif-list" id="notif-list"></div>
      </div>
      <div class="content-area" id="content-area"></div>
    </main>
  </div>
  <!-- Modal -->
  <div class="modal-overlay" id="modal-overlay" onclick="closeModal()">
    <div class="modal-box glass-card" onclick="event.stopPropagation()" id="modal-box">
      <div class="modal-header">
        <h3 id="modal-title">Modal</h3>
        <button onclick="closeModal()">&#x2715;</button>
      </div>
      <div id="modal-body"></div>
    </div>
  </div>
  <!-- Toast -->
  <div class="toast-container" id="toast-container"></div>
  <script src="data.js"></script>
  <script src="app.js"></script>
</body>
</html>

