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
