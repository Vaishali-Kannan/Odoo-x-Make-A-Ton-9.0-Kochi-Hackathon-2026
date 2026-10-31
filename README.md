@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

/* 1. Global Variables */

:root {
    --primary: #6477d9;
    --primary-dark: #4e60bf;
    --primary-light: #eef0ff;

    --background: #f7f8fc;
    --surface: #ffffff;

    --text-primary: #252b3b;
    --text-secondary: #7c8499;

    --border: #e9ebf2;

    --success: #39866b;
    --success-bg: #e7f5ee;

    --warning: #b78335;
    --warning-bg: #fff4df;

    --danger: #c85c65;
    --danger-bg: #fdebed;

    --info: #527bc1;
    --info-bg: #eaf1ff;

    --sidebar-width: 250px;

    --radius-sm: 8px;
    --radius-md: 12px;
    --radius-lg: 18px;

    --shadow: 0 4px 20px rgba(35, 45, 80, 0.04);
}

/* 2. Reset */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: 'Inter', sans-serif;
    background: var(--background);
    color: var(--text-primary);
    font-size: 14px;
    line-height: 1.6;
}

button,
input,
select,
textarea {
    font: inherit;
}

button {
    cursor: pointer;
}

a {
    color: inherit;
    text-decoration: none;
}

img {
    max-width: 100%;
}

/* 3. Main Application Layout */

.app-container {
    display: flex;
    min-height: 100vh;
}

.main-content {
    flex: 1;
    min-width: 0;
    margin-left: var(--sidebar-width);
    padding: 30px 34px;
}

/* 4. Sidebar */

.sidebar {
    width: var(--sidebar-width);
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    background: var(--surface);
    border-right: 1px solid var(--border);
    padding: 26px 18px;
    display: flex;
    flex-direction: column;
    overflow-y: auto;
    z-index: 100;
}

.brand {
    display: flex;
    align-items: center;
    gap: 11px;
    padding: 0 10px;
    margin-bottom: 38px;
}

.brand-icon {
    width: 40px;
    height: 40px;
    background: var(--primary-light);
    color: var(--primary);
    border-radius: 12px;
    display: grid;
    place-items: center;
    font-size: 21px;
    font-weight: 700;
}

.brand-name {
    font-size: 19px;
    font-weight: 700;
    letter-spacing: -0.7px;
}

.brand-name span {
    color: var(--primary);
}

.nav-section {
    margin-bottom: 26px;
}

.nav-heading {
    font-size: 10px;
    font-weight: 700;
    color: #a2a8b8;
    letter-spacing: 1.2px;
    padding: 0 12px;
    margin-bottom: 10px;
}

.nav-link {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 11px 13px;
    margin: 3px 0;
    border-radius: var(--radius-sm);
    color: var(--text-secondary);
    font-size: 13px;
    font-weight: 500;
    transition: background 0.2s ease, color 0.2s ease;
}

.nav-link:hover {
    background: #f5f6fc;
    color: var(--primary);
}

.nav-link.active {
    background: var(--primary-light);
    color: var(--primary-dark);
    font-weight: 600;
}

.nav-icon {
    width: 20px;
    text-align: center;
    font-size: 16px;
}

.nav-badge {
    margin-left: auto;
    padding: 2px 7px;
    background: var(--danger-bg);
    color: var(--danger);
    border-radius: 20px;
    font-size: 10px;
    font-weight: 600;
}

.sidebar-bottom {
    margin-top: auto;
    padding-top: 20px;
    border-top: 1px solid var(--border);
}

/* 5. Top Header */

.topbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
    margin-bottom: 32px;
}

.page-title {
    font-size: 25px;
    font-weight: 700;
    letter-spacing: -0.8px;
}

.page-subtitle {
    margin-top: 5px;
    color: var(--text-secondary);
    font-size: 13px;
}

.topbar-actions {
    display: flex;
    align-items: center;
    gap: 12px;
}

.search-box {
    display: flex;
    align-items: center;
    gap: 9px;
    padding: 10px 14px;
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius-sm);
    width: 240px;
}

.search-box input {
    width: 100%;
    border: none;
    outline: none;
    background: transparent;
    color: var(--text-primary);
}

.search-box input::placeholder {
    color: #a2a8b8;
}

.icon-button {
    width: 40px;
    height: 40px;
    display: grid;
    place-items: center;
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius-sm);
    position: relative;
}

.notification-dot {
    position: absolute;
    top: 8px;
    right: 8px;
    width: 7px;
    height: 7px;
    background: var(--danger);
    border: 2px solid white;
    border-radius: 50%;
}

.avatar {
    width: 39px;
    height: 39px;
    border-radius: 50%;
    background: #e8eaff;
    color: var(--primary-dark);
    display: grid;
    place-items: center;
    font-weight: 700;
}

/* 6. Buttons */

.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    padding: 10px 16px;
    border: 1px solid transparent;
    border-radius: var(--radius-sm);
    font-weight: 600;
    font-size: 12px;
    transition: all 0.2s ease;
}

.btn-primary {
    background: var(--primary);
    color: white;
}

.btn-primary:hover {
    background: var(--primary-dark);
}

.btn-secondary {
    background: white;
    color: var(--text-primary);
    border-color: var(--border);
}

.btn-secondary:hover {
    background: #f7f8fc;
}

.btn-danger {
    background: var(--danger-bg);
    color: var(--danger);
}

.btn-success {
    background: var(--success-bg);
    color: var(--success);
}

.btn-sm {
    padding: 7px 11px;
    font-size: 11px;
}

/* 7. Dashboard Welcome Section */

.welcome-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
    margin-bottom: 25px;
}

.welcome-title {
    font-size: 21px;
    font-weight: 700;
}

.welcome-text {
    color: var(--text-secondary);
    font-size: 13px;
    margin-top: 4px;
}

/* 8. Statistics Cards */

.stats-grid {
    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 18px;
    margin-bottom: 25px;
}

.stat-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius-md);
    padding: 22px;
    box-shadow: var(--shadow);
    transition: transform 0.2s ease;
}

.stat-card:hover {
    transform: translateY(-2px);
}

.stat-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    margin-bottom: 18px;
}

.stat-label {
    font-size: 12px;
    color: var(--text-secondary);
    font-weight: 500;
}

.stat-icon {
    width: 38px;
    height: 38px;
    display: grid;
    place-items: center;
    border-radius: 11px;
    font-size: 18px;
}

.stat-icon.purple {
    background: #efedff;
    color: #7769cf;
}

.stat-icon.green {
    background: var(--success-bg);
    color: var(--success);
}

.stat-icon.orange {
    background: var(--warning-bg);
    color: var(--warning);
}

.stat-icon.blue {
    background: var(--info-bg);
    color: var(--info);
}

.stat-value {
    font-size: 26px;
    font-weight: 700;
    letter-spacing: -0.8px;
}

.stat-change {
    margin-top: 8px;
    font-size: 11px;
    color: var(--success);
}

.stat-change.negative {
    color: var(--danger);
}

.stat-caption {
    color: var(--text-secondary);
}

/* 9. General Cards */

.card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: var(--radius-md);
    padding: 23px;
    box-shadow: var(--shadow);
    min-width: 0;
}

.card-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    margin-bottom: 22px;
}

.card-title {
    font-size: 15px;
    font-weight: 700;
}

.card-description {
    margin-top: 4px;
    color: var(--text-secondary);
    font-size: 12px;
}

/* 10. Dashboard Grid */

.dashboard-grid {
    display: grid;
    grid-template-columns: minmax(0, 1.6fr) minmax(280px, 1fr);
    gap: 22px;
    margin-bottom: 24px;
}

.dashboard-grid.equal {
    grid-template-columns: repeat(2, minmax(0, 1fr));
}

.full-width {
    grid-column: 1 / -1;
}

/* 11. Revenue Chart Container */

.chart-container {
    width: 100%;
    min-height: 260px;
    position: relative;
}

.chart-container canvas,
.chart-container svg {
    max-width: 100%;
}

/* 12. Tables */

.table-container {
    width: 100%;
    overflow-x: auto;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
    white-space: nowrap;
}

.data-table th {
    padding: 13px 15px;
    text-align: left;
    background: #fafbfe;
    color: var(--text-secondary);
    font-size: 10px;
    text-transform: uppercase;
    letter-spacing: 0.6px;
    font-weight: 600;
    border-bottom: 1px solid var(--border);
}

.data-table td {
    padding: 16px 15px;
    border-bottom: 1px solid #f0f1f6;
    font-size: 12px;
    vertical-align: middle;
}

.data-table tbody tr:hover {
    background: #fafbff;
}

.data-table tbody tr:last-child td {
    border-bottom: none;
}

.table-primary {
    font-weight: 600;
    color: var(--text-primary);
}

.table-secondary {
    color: var(--text-secondary);
    font-size: 11px;
}

.table-actions {
    display: flex;
    gap: 8px;
}

/* 13. Status Badges */

.badge {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 5px 9px;
    border-radius: 20px;
    font-size: 10px;
    font-weight: 600;
}

.badge::before {
    content: "";
    width: 5px;
    height: 5px;
    border-radius: 50%;
    background: currentColor;
}

.badge.active,
.badge.paid,
.badge.success {
    background: var(--success-bg);
    color: var(--success);
}

.badge.pending,
.badge.upcoming {
    background: var(--warning-bg);
    color: var(--warning);
}

.badge.overdue,
.badge.failed,
.badge.cancelled {
    background: var(--danger-bg);
    color: var(--danger);
}

.badge.draft {
    background: #f0f1f5;
    color: #737b8e;
}

.badge.processing {
    background: var(--info-bg);
    color: var(--info);
}

/* 14. Forms */

.form-group {
    margin-bottom: 20px;
}

.form-label {
    display: block;
    margin-bottom: 8px;
    font-size: 12px;
    font-weight: 600;
}

.form-control {
    width: 100%;
    padding: 11px 13px;
    background: white;
    border: 1px solid #dfe2ec;
    border-radius: var(--radius-sm);
    outline: none;
    color: var(--text-primary);
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.form-control:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(100, 119, 217, 0.1);
}

.form-control::placeholder {
    color: #a2a8b8;
}

.form-help {
    display: block;
    color: var(--text-secondary);
    font-size: 11px;
    margin-top: 6px;
}

.form-row {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 18px;
}

/* 15. Automatic Billing & Automation Center */

.automation-banner {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 20px;
    padding: 23px;
    background: linear-gradient(120deg, #f0efff, #f5f8ff);
    border: 1px solid #e5e4ff;
    border-radius: var(--radius-md);
    margin-bottom: 24px;
}

.automation-banner h3 {
    font-size: 16px;
    margin-bottom: 7px;
}

.automation-banner p {
    color: var(--text-secondary);
    font-size: 12px;
    max-width: 520px;
}

.automation-status {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    padding: 7px 11px;
    border-radius: 20px;
    background: var(--success-bg);
    color: var(--success);
    font-size: 11px;
    font-weight: 600;
    white-space: nowrap;
}

.status-indicator {
    width: 7px;
    height: 7px;
    background: currentColor;
    border-radius: 50%;
}

.automation-setting {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    padding: 17px 0;
    border-bottom: 1px solid var(--border);
}

.automation-setting:last-child {
    border-bottom: none;
}

.automation-setting h4 {
    font-size: 12px;
    font-weight: 600;
}

.automation-setting p {
    font-size: 11px;
    color: var(--text-secondary);
    margin-top: 4px;
}

/* Toggle Switch */

.toggle {
    position: relative;
    width: 42px;
    height: 24px;
    flex-shrink: 0;
}

.toggle input {
    opacity: 0;
    width: 0;
    height: 0;
}

.toggle-slider {
    position: absolute;
    inset: 0;
    background: #d8dce7;
    border-radius: 20px;
    cursor: pointer;
    transition: 0.2s;
}

.toggle-slider::before {
    content: "";
    position: absolute;
    width: 18px;
    height: 18px;
    left: 3px;
    top: 3px;
    background: white;
    border-radius: 50%;
    transition: 0.2s;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.15);
}

.toggle input:checked + .toggle-slider {
    background: var(--primary);
}

.toggle input:checked + .toggle-slider::before {
    transform: translateX(18px);
}

/* 16. Renewal Notifications */

.notification-list {
    display: flex;
    flex-direction: column;
}

.notification-item {
    display: flex;
    gap: 13px;
    padding: 17px 0;
    border-bottom: 1px solid var(--border);
}

.notification-item:last-child {
    border-bottom: none;
}

.notification-icon {
    width: 39px;
    height: 39px;
    border-radius: 11px;
    display: grid;
    place-items: center;
    flex-shrink: 0;
    font-size: 17px;
}

.notification-icon.reminder {
    background: var(--info-bg);
    color: var(--info);
}

.notification-icon.warning {
    background: var(--warning-bg);
    color: var(--warning);
}

.notification-icon.success {
    background: var(--success-bg);
    color: var(--success);
}

.notification-content {
    flex: 1;
    min-width: 0;
}

.notification-title {
    font-size: 12px;
    font-weight: 600;
}

.notification-message {
    font-size: 11px;
    color: var(--text-secondary);
    margin-top: 4px;
}

.notification-time {
    font-size: 10px;
    color: #a0a6b6;
    margin-top: 6px;
}

/* 17. Billing Anomaly Alerts */

.alert-card {
    padding: 17px;
    border: 1px solid #f2dfbd;
    background: #fffbf3;
    border-radius: var(--radius-sm);
    margin-bottom: 12px;
}

.alert-card:last-child {
    margin-bottom: 0;
}

.alert-card.critical {
    background: #fff6f6;
    border-color: #f3d6d8;
}

.alert-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    margin-bottom: 8px;
}

.alert-title {
    font-size: 12px;
    font-weight: 700;
}

.alert-description {
    color: var(--text-secondary);
    font-size: 11px;
    line-height: 1.7;
}

.alert-amount {
    font-size: 17px;
    font-weight: 700;
    margin-top: 10px;
}

/* 18. Subscription Time Machine */

.simulator-card {
    background: linear-gradient(135deg, #f5f3ff, #f1f7ff);
    border: 1px solid #e6e4ff;
    border-radius: var(--radius-md);
    padding: 25px;
}

.simulator-result {
    margin-top: 22px;
    padding: 20px;
    background: white;
    border: 1px solid var(--border);
    border-radius: var(--radius-sm);
}

.simulator-value {
    font-size: 27px;
    font-weight: 700;
    color: var(--primary-dark);
}

.simulator-label {
    font-size: 11px;
    color: var(--text-secondary);
}

.simulator-controls {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 18px;
    margin-top: 20px;
}

/* 19. Usage / Waste Detector */

.usage-item {
    padding: 16px 0;
    border-bottom: 1px solid var(--border);
}

.usage-item:last-child {
    border-bottom: none;
}

.usage-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    margin-bottom: 10px;
}

.usage-name {
    font-size: 12px;
    font-weight: 600;
}

.usage-percentage {
    font-size: 11px;
    color: var(--text-secondary);
}

.progress-track {
    width: 100%;
    height: 7px;
    background: #edf0f6;
    border-radius: 20px;
    overflow: hidden;
}

.progress-fill {
    height: 100%;
    width: 0;
    background: var(--primary);
    border-radius: 20px;
    transition: width 0.5s ease;
}

.progress-fill.green {
    background: #65ae8e;
}

.progress-fill.orange {
    background: #e0ad61;
}

/* 20. Invoice Details */

.invoice-summary {
    max-width: 400px;
    margin-left: auto;
    margin-top: 25px;
}

.invoice-summary-row {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    padding: 10px 0;
    color: var(--text-secondary);
    font-size: 12px;
}

.invoice-summary-row.total {
    border-top: 1px solid var(--border);
    padding-top: 17px;
    margin-top: 5px;
    color: var(--text-primary);
    font-size: 17px;
    font-weight: 700;
}

.invoice-note {
    background: #f8f9fd;
    border: 1px solid var(--border);
    padding: 15px;
    border-radius: var(--radius-sm);
    color: var(--text-secondary);
    font-size: 11px;
    margin-top: 22px;
}

/* 21. Search and Filters */

.filter-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    flex-wrap: wrap;
    margin-bottom: 22px;
}

.filter-group {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}

.filter-select {
    padding: 9px 12px;
    border: 1px solid var(--border);
    background: white;
    color: var(--text-primary);
    border-radius: var(--radius-sm);
    outline: none;
    font-size: 12px;
}

/* 22. Pagination */

.pagination {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    padding-top: 20px;
    color: var(--text-secondary);
    font-size: 11px;
}

.pagination-buttons {
    display: flex;
    gap: 6px;
}

.page-button {
    width: 31px;
    height: 31px;
    border: 1px solid var(--border);
    background: white;
    border-radius: 7px;
    color: var(--text-secondary);
}

.page-button.active {
    background: var(--primary);
    color: white;
    border-color: var(--primary);
}

/* 23. Empty State */

.empty-state {
    text-align: center;
    padding: 55px 20px;
}

.empty-state-icon {
    font-size: 34px;
    margin-bottom: 12px;
}

.empty-state h3 {
    font-size: 15px;
    margin-bottom: 7px;
}

.empty-state p {
    font-size: 12px;
    color: var(--text-secondary);
    max-width: 360px;
    margin: 0 auto 18px;
}

/* 24. Toast Notifications */

.toast-container {
    position: fixed;
    top: 22px;
    right: 22px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.toast {
    min-width: 280px;
    padding: 15px 18px;
    background: white;
    border: 1px solid var(--border);
    border-radius: var(--radius-md);
    box-shadow: 0 10px 35px rgba(35, 45, 80, 0.12);
    display: flex;
    align-items: center;
    gap: 12px;
    animation: toast-in 0.3s ease;
}

.toast.success {
    border-left: 4px solid var(--success);
}

.toast.error {
    border-left: 4px solid var(--danger);
}

.toast-message {
    font-size: 12px;
    font-weight: 500;
}

@keyframes toast-in {
    from {
        opacity: 0;
        transform: translateY(-8px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* 25. Modal */

.modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(30, 36, 58, 0.4);
    display: none;
    align-items: center;
    justify-content: center;
    padding: 20px;
    z-index: 500;
}

.modal-overlay.open {
    display: flex;
}

.modal {
    width: 100%;
    max-width: 550px;
    max-height: 90vh;
    overflow-y: auto;
    padding: 27px;
    background: white;
    border-radius: var(--radius-lg);
    box-shadow: 0 20px 60px rgba(30, 36, 58, 0.18);
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
}

.modal-title {
    font-size: 18px;
    font-weight: 700;
}

.modal-close {
    border: none;
    background: transparent;
    color: var(--text-secondary);
    font-size: 22px;
}

/* 26. Login Page */

.login-page {
    min-height: 100vh;
    display: grid;
    grid-template-columns: 1fr 1fr;
    background: white;
}

.login-brand-panel {
    background: linear-gradient(145deg, #e9eaff, #f2f5ff);
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 60px;
}

.login-brand-panel h1 {
    font-size: clamp(30px, 4vw, 46px);
    line-height: 1.2;
    letter-spacing: -1.5px;
    max-width: 450px;
}

.login-brand-panel p {
    margin-top: 18px;
    color: var(--text-secondary);
    max-width: 400px;
}

.login-form-panel {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 35px;
}

.login-form {
    width: 100%;
    max-width: 380px;
}

.login-form h2 {
    font-size: 25px;
    margin-bottom: 8px;
}

.login-form > p {
    color: var(--text-secondary);
    margin-bottom: 30px;
}

/* 27. Utility Classes */

.text-primary {
    color: var(--primary);
}

.text-success {
    color: var(--success);
}

.text-danger {
    color: var(--danger);
}

.text-muted {
    color: var(--text-secondary);
}

.text-right {
    text-align: right;
}

.text-center {
    text-align: center;
}

.font-bold {
    font-weight: 700;
}

.mt-10 {
    margin-top: 10px;
}

.mt-20 {
    margin-top: 20px;
}

.mb-20 {
    margin-bottom: 20px;
}

.flex {
    display: flex;
}

.flex-between {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.gap-10 {
    gap: 10px;
}

.w-full {
    width: 100%;
}

.hidden {
    display: none !important;
}

/* 28. Responsive Design */

@media (max-width: 1200px) {
    .stats-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }

    .main-content {
        padding: 25px;
    }

    .dashboard-grid {
        grid-template-columns: minmax(0, 1fr);
    }
}

@media (max-width: 900px) {
    :root {
        --sidebar-width: 210px;
    }

    .sidebar {
        padding: 22px 12px;
    }

    .main-content {
        padding: 22px 18px;
    }

    .search-box {
        width: 180px;
    }

    .login-page {
        grid-template-columns: 1fr;
    }

    .login-brand-panel {
        display: none;
    }
}

@media (max-width: 640px) {
    .sidebar {
        width: 65px;
        padding: 20px 8px;
    }

    .brand {
        justify-content: center;
        padding: 0;
        margin-bottom: 28px;
    }

    .brand-name,
    .nav-heading,
    .nav-link span:not(.nav-icon),
    .sidebar-bottom .nav-link span:not(.nav-icon) {
        display: none;
    }

    .nav-link {
        justify-content: center;
        padding: 13px 5px;
    }

    .nav-icon {
        font-size: 19px;
    }

    .main-content {
        margin-left: 65px;
        padding: 20px 12px;
    }

    .topbar {
        align-items: flex-start;
        flex-wrap: wrap;
        margin-bottom: 24px;
    }

    .page-title {
        font-size: 21px;
    }

    .topbar-actions {
        width: 100%;
        flex-wrap: wrap;
    }

    .search-box {
        flex: 1;
        width: auto;
        min-width: 120px;
    }

    .stats-grid {
        grid-template-columns: 1fr;
        gap: 12px;
    }

    .stat-card {
        padding: 17px;
    }

    .stat-value {
        font-size: 23px;
    }

    .card {
        padding: 16px;
    }

    .card-header,
    .welcome-section {
        align-items: flex-start;
        flex-direction: column;
    }

    .dashboard-grid.equal {
        grid-template-columns: 1fr;
    }

    .form-row,
    .simulator-controls {
        grid-template-columns: 1fr;
    }

    .automation-banner {
        flex-direction: column;
    }

    .filter-bar {
        align-items: stretch;
    }

    .filter-group {
        width: 100%;
    }

    .pagination {
        align-items: flex-start;
        flex-direction: column;
    }

    .invoice-summary {
        max-width: 100%;
    }

    .toast-container {
        left: 12px;
        right: 12px;
        top: 12px;
    }

    .toast {
        min-width: 0;
    }
}

/* 29. Accessibility */

button:focus-visible,
a:focus-visible,
input:focus-visible,
select:focus-visible {
    outline: 3px solid rgba(100, 119, 217, 0.4);
    outline-offset: 2px;
}

@media (prefers-reduced-motion: reduce) {
    *,
    *::before,
    *::after {
        scroll-behavior: auto !important;
        animation-duration: 0.01ms !important;
        transition-duration: 0.01ms !important;
    }
}
