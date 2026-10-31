/**
 * script.js – Front‑end controller for **SubscriptIQ**
 *
 * Purpose:
 *  • Connect the static HTML UI to the backend REST APIs.
 *  • Manage navigation, dashboards, CRUD forms, automation UI and
 *    intelligence alerts.
 *  • Perform client‑side validation, error handling and user feedback.
 *
 * NOTES
 *  – All business‑critical actions (invoice generation, scheduled
 *    notifications, billing calculations, …) remain on the backend.
 *  – The code is written in vanilla ES‑2022 (no external libraries) so
 *    it works both with the legacy “js” version and alongside the React
 *    implementation.
 *  – All network calls use the native Fetch API with a short timeout
 *    wrapper to avoid hanging requests.
 *  – UI elements are expected to have the IDs & data‑attributes described
 *    in the HTML templates (see the `index.html` skeleton).
 */

/* ------------------------------------------------------------------ */
/*                      GLOBAL CONFIG & UTILITIES                     */
/* ------------------------------------------------------------------ */

const API_BASE = '/api';                // base path for all endpoints
const FETCH_TIMEOUT = 8000;             // ms

/**
 * Helper to wrap fetch with a timeout.
 * Returns a promise that resolves with the response or rejects on timeout.
 */
function fetchWithTimeout(resource, options = {}) {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), FETCH_TIMEOUT);
  const init = { ...options, signal: controller.signal };
  return fetch(resource, init)
    .finally(() => clearTimeout(timeoutId));
}

/**
 * Centralised error handling for fetch responses.
 * Throws an error object {status, message, data} for callers to catch.
 */
async function handleResponse(resp) {
  const contentType = resp.headers.get('content-type') || '';
  let data = null;
  if (contentType.includes('application/json')) {
    data = await resp.json();
  } else {
    data = await resp.text();
  }

  if (!resp.ok) {
    const err = new Error(data?.message ?? resp.statusText);
    err.status = resp.status;
    err.data = data;
    throw err;
  }
  return data;
}

/**
 * Show a toast / alert box.
 * type: 'info' | 'success' | 'warning' | 'error'
 */
function showToast(message, type = 'info') {
  const toastContainer = document.getElementById('toast-container');
  if (!toastContainer) return console.warn('Toast container missing');
  const toast = document.createElement('div');
  toast.className = `toast toast-${type}`;
  toast.textContent = message;
  toastContainer.appendChild(toast);
  setTimeout(() => toast.remove(), 4000);
}

/* ------------------------------------------------------------------ */
/*                       DASHBOARD SECTION                            */
/* ------------------------------------------------------------------ */

async function loadDashboard() {
  try {
    const data = await fetchWithTimeout(`${API_BASE}/dashboard`);
    const json = await handleResponse(data);
    renderDashboard(json);
  } catch (e) {
    showToast(`Dashboard load failed: ${e.message}`, 'error');
  }
}

/**
 * Render the dashboard numbers.
 * Expected json shape:
 * {
 *   mrr: number,
 *   activeSubscriptions: number,
 *   upcomingRenewals: number,
 *   outstandingInvoices: number,
 *   revenueGrowth: number (optional)
 * }
 */
function renderDashboard({ mrr, activeSubscriptions, upcomingRenewals, outstandingInvoices, revenueGrowth }) {
  document.getElementById('stat-mrr').textContent = `₹${Number(mrr).toLocaleString()}`;
  document.getElementById('stat-active-subscriptions').textContent = activeSubscriptions;
  document.getElementById('stat-upcoming-renewals').textContent = upcomingRenewals;
  document.getElementById('stat-outstanding-invoices').textContent = outstandingInvoices;
  if (revenueGrowth !== undefined) {
    const growthEl = document.getElementById('stat-revenue-growth');
    growthEl.textContent = `${revenueGrowth}%`;
    growthEl.classList.toggle('positive', revenueGrowth >= 0);
    growthEl.classList.toggle('negative', revenueGrowth < 0);
  }
}

/* ------------------------------------------------------------------ */
/*                         NAVIGATION SECTION                         */
/* ------------------------------------------------------------------ */

function initNavigation() {
  const sidebar = document.getElementById('sidebar');
  if (!sidebar) return;

  sidebar.addEventListener('click', (e) => {
    const link = e.target.closest('[data-section]');
    if (!link) return;
    e.preventDefault();
    const target = link.dataset.section;
    activateSection(target);
  });
}

/**
 * Show the target section and hide others.
 * Highlights the active link in the sidebar.
 */
function activateSection(sectionId) {
  // hide all sections
  document.querySelectorAll('.section').forEach((el) => {
    el.hidden = true;
  });
  // show the chosen one
  const target = document.getElementById(`section-${sectionId}`);
  if (target) target.hidden = false;

  // update sidebar active class
  document.querySelectorAll('#sidebar a[data-section]').forEach((a) => {
    a.classList.toggle('active', a.dataset.section === sectionId);
  });
}

/* ------------------------------------------------------------------ */
/*                   CUSTOMER MANAGEMENT SECTION                      */
/* ------------------------------------------------------------------ */

async function loadCustomers(page = 1, pageSize = 20) {
  try {
    const resp = await fetchWithTimeout(`${API_BASE}/customers?page=${page}&size=${pageSize}`);
    const { customers, total } = await handleResponse(resp);
    renderCustomerTable(customers);
    renderCustomerPagination(page, Math.ceil(total / pageSize));
  } catch (e) {
    showToast(`Failed to fetch customers: ${e.message}`, 'error');
  }
}

/**
 * Render rows inside <tbody id="customer-table-body">
 */
function renderCustomerTable(customers) {
  const tbody = document.getElementById('customer-table-body');
  tbody.innerHTML = '';
  customers.forEach((c) => {
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${c.code}</td>
      <td>${c.name}</td>
      <td>${c.email}</td>
      <td>${c.phone ?? '-'}</td>
      <td>${c.gstin ?? '-'}</td>
    `;
    tbody.appendChild(tr);
  });
}

/**
 * Simple pagination UI – previous/next.
 */
function renderCustomerPagination(current, totalPages) {
  const container = document.getElementById('customer-pagination');
  container.innerHTML = `
    <button ${current <= 1 ? 'disabled' : ''} data-dir="prev">Prev</button>
    <span>Page ${current} of ${totalPages}</span>
    <button ${current >= totalPages ? 'disabled' : ''} data-dir="next">Next</button>
  `;
  container.querySelectorAll('button').forEach((btn) => {
    btn.onclick = () => {
      const dir = btn.dataset.dir;
      loadCustomers(dir === 'prev' ? current - 1 : current + 1);
    };
  });
}

/**
 * Open the “Create Customer” modal.
 */
function openCustomerModal() {
  const modal = document.getElementById('customer-modal');
  modal.querySelector('form').reset();   // clear previous values
  modal.showModal();
}

/**
 * Validate & submit the customer creation form.
 */
async function submitCustomerForm(e) {
  e.preventDefault();
  const form = e.target;
  const data = {
    code: form.code.value.trim(),
    name: form.name.value.trim(),
    email: form.email.value.trim(),
    phone: form.phone.value.trim(),
    gstin: form.gstin.value.trim(),
  };

  // ---- client‑side validation -------------------------------------------------
  if (!data.code || !data.name || !data.email) {
    showToast('Code, Name and Email are required.', 'warning');
    return;
  }
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(data.email)) {
    showToast('Invalid email address.', 'warning');
    return;
  }
  // ------------------------------------------------------------------------------

  try {
    const resp = await fetchWithTimeout(`${API_BASE}/customers`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    });
    await handleResponse(resp);
    showToast('Customer created successfully.', 'success');
    document.getElementById('customer-modal').close();
    loadCustomers();   // refresh list
  } catch (e) {
    if (e.status === 409) {
      showToast('Customer already exists.', 'warning');
    } else {
      showToast(`Create customer failed: ${e.message}`, 'error');
    }
  }
}

/* ------------------------------------------------------------------ */
/*                SUBSCRIPTION MANAGEMENT SECTION                     */
/* ------------------------------------------------------------------ */

async function loadSubscriptions(page = 1, pageSize = 20) {
  try {
    const resp = await fetchWithTimeout(`${API_BASE}/subscriptions?page=${page}&size=${pageSize}`);
    const { subscriptions, total } = await handleResponse(resp);
    renderSubscriptionTable(subscriptions);
    renderSubscriptionPagination(page, Math.ceil(total / pageSize));
  } catch (e) {
    showToast(`Failed to fetch subscriptions: ${e.message}`, 'error');
  }
}

function renderSubscriptionTable(subs) {
  const tbody = document.getElementById('subscription-table-body');
  tbody.innerHTML = '';
  subs.forEach((s) => {
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${s.subscription_number}</td>
      <td>${s.customer_name}</td>
      <td>${s.plan_name}</td>
      <td>${s.status}</td>
      <td>${s.next_renewal_date ?? '-'}</td>
    `;
    tbody.appendChild(tr);
  });
}

function renderSubscriptionPagination(current, totalPages) {
  const container = document.getElementById('subscription-pagination');
  container.innerHTML = `
    <button ${current <= 1 ? 'disabled' : ''} data-dir="prev">Prev</button>
    <span>Page ${current} of ${totalPages}</span>
    <button ${current >= totalPages ? 'disabled' : ''} data-dir="next">Next</button>
  `;
  container.querySelectorAll('button').forEach((btn) => {
    btn.onclick = () => {
      const dir = btn.dataset.dir;
      loadSubscriptions(dir === 'prev' ? current - 1 : current + 1);
    };
  });
}

/**
 * Opens the “Create Subscription” modal.
 */
function openSubscriptionModal() {
  const modal = document.getElementById('subscription-modal');
  modal.querySelector('form').reset();
  modal.showModal();
}

/**
 * Validate & submit subscription creation.
 */
async function submitSubscriptionForm(e) {
  e.preventDefault();
  const f = e.target;
  const payload = {
    customer_id: f.customer_id.value,
    plan_id: f.plan_id.value,
    seats: Number(f.seats.value),
    billing_cycle: f.billing_cycle.value,
  };

  // ---- validation -----------------------------------------------------------
  if (!payload.customer_id || !payload.plan_id) {
    showToast('Customer and Plan must be selected.', 'warning');
    return;
  }
  if (isNaN(payload.seats) || payload.seats <= 0) {
    showToast('Seats must be a positive number.', 'warning');
    return;
  }
  // ---------------------------------------------------------------------------

  try {
    const resp = await fetchWithTimeout(`${API_BASE}/subscriptions`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
    });
    await handleResponse(resp);
    showToast('Subscription created.', 'success');
    document.getElementById('subscription-modal').close();
    loadSubscriptions();
  } catch (e) {
    showToast(`Create subscription failed: ${e.message}`, 'error');
  }
}

/* ------------------------------------------------------------------ */
/*                     INVOICE MANAGEMENT SECTION                     */
/* ------------------------------------------------------------------ */

async function loadInvoices(page = 1, pageSize = 20) {
  try {
    const resp = await fetchWithTimeout(`${API_BASE}/invoices?page=${page}&size=${pageSize}`);
    const { invoices, total } = await handleResponse(resp);
    renderInvoiceTable(invoices);
    renderInvoicePagination(page, Math.ceil(total / pageSize));
  } catch (e) {
    showToast(`Failed to fetch invoices: ${e.message}`, 'error');
  }
}

function renderInvoiceTable(invoices) {
  const tbody = document.getElementById('invoice-table-body');
  tbody.innerHTML = '';
  invoices.forEach((inv) => {
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${inv.invoice_number}</td>
      <td>${inv.customer_name}</td>
      <td>₹${Number(inv.total_amount).toLocaleString()}</td>
      <td>${inv.status}</td>
      <td>${inv.due_date}</td>
      <td>
        ${inv.status === 'paid'
          ? `<button class="btn-view-receipt" data-id="${inv.id}">Tax Invoice</button>`
          : `<button class="btn-receive-payment" data-id="${inv.id}">Receive Payment</button>`}
        <button class="btn-export-csv" data-id="${inv.id}">Export CSV</button>
      </td>
    `;
    tbody.appendChild(tr);
  });

  // Attach row‑level listeners (delegated)
  tbody.addEventListener('click', async (e) => {
    const btn = e.target.closest('button');
    if (!btn) return;
    const id = btn.dataset.id;
    if (btn.classList.contains('btn-receive-payment')) {
      openPaymentModal(id);
    } else if (btn.classList.contains('btn-view-receipt')) {
      openReceiptModal(id);
    } else if (btn.classList.contains('btn-export-csv')) {
      exportInvoiceCsv(id);
    }
  });
}

function renderInvoicePagination(current, totalPages) {
  const container = document.getElementById('invoice-pagination');
  container.innerHTML = `
    <button ${current <= 1 ? 'disabled' : ''} data-dir="prev">Prev</button>
    <span>Page ${current} of ${totalPages}</span>
    <button ${current >= totalPages ? 'disabled' : ''} data-dir="next">Next</button>
  `;
  container.querySelectorAll('button').forEach((btn) => {
    btn.onclick = () => {
      const dir = btn.dataset.dir;
      loadInvoices(dir === 'prev' ? current - 1 : current + 1);
    };
  });
}

/* ----- Invoice creation -------------------------------------------------- */

function openInvoiceModal() {
  const modal = document.getElementById('invoice-modal');
  modal.querySelector('form').reset();
  modal.showModal();
}

/**
 * Validate & submit draft invoice.
 */
async function submitInvoiceForm(e) {
  e.preventDefault();
  const f = e.target;
  const payload = {
    customer_id: f.customer_id.value,
    subscription_id: f.subscription_id.value || null,
    due_date: f.due_date.value,
    base_price: Number(f.base_price.value),
    additional_seats_cost: Number(f.additional_seats_cost.value) || 0,
    discount_rate: Number(f.discount_rate.value) || 0,
    notes: f.notes.value.trim(),
  };

  // ---- validation -----------------------------------------------------------
  if (!payload.customer_id) {
    showToast('Select a customer.', 'warning');
    return;
  }
  if (!payload.due_date) {
    showToast('Due date required.', 'warning');
    return;
  }
  if (isNaN(payload.base_price) || payload.base_price <= 0) {
    showToast('Base price must be positive.', 'warning');
    return;
  }
  // ---------------------------------------------------------------------------

  try {
    const resp = await fetchWithTimeout(`${API_BASE}/invoices`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
    });
    await handleResponse(resp);
    showToast('Draft invoice created.', 'success');
    document.getElementById('invoice-modal').close();
    loadInvoices();
  } catch (e) {
    showToast(`Create invoice failed: ${e.message}`, 'error');
  }
}

/* ----- Payment receipt modal (used also by React component) ------------- */

function openPaymentModal(invoiceId) {
  const modal = document.getElementById('payment-modal');
  modal.dataset.invoiceId = invoiceId;
  modal.querySelector('form').reset();
  modal.showModal();
}

/**
 * Submit payment receipt – updates invoice status to “paid”.
 * The Supabase trigger will automatically generate a receipt row.
 */
async function submitPaymentForm(e) {
  e.preventDefault();
  const f = e.target;
  const invoiceId = e.target.closest('dialog').dataset.invoiceId;
  const payload = {
    payment_method: f.payment_method.value,
    paid_amount: Number(f.paid_amount.value),
    paid_date: new Date().toISOString().split('T')[0],
  };

  // ---- validation -----------------------------------------------------------
  if (!payload.payment_method) {
    showToast('Select a payment method.', 'warning');
    return;
  }
  if (isNaN(payload.paid_amount) || payload.paid_amount <= 0) {
    showToast('Amount must be positive.', 'warning');
    return;
  }
  // ---------------------------------------------------------------------------

  try {
    const resp = await fetchWithTimeout(`${API_BASE}/invoices/${invoiceId}`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ status: 'paid', ...payload }),
    });
    await handleResponse(resp);
    showToast('Payment recorded.', 'success');
    document.getElementById('payment-modal').close();
    loadInvoices();   // refresh status
  } catch (e) {
    showToast(`Payment update failed: ${e.message}`, 'error');
  }
}

/* ----- Tax invoice receipt modal ---------------------------------------- */

async function openReceiptModal(invoiceId) {
  const modal = document.getElementById('receipt-modal');
  modal.dataset.invoiceId = invoiceId;
  try {
    const resp = await fetchWithTimeout(`${API_BASE}/payment_receipts?invoice_id=${invoiceId}`);
    const receipt = await handleResponse(resp);
    populateReceiptModal(receipt);
    modal.showModal();
  } catch (e) {
    showToast(`Unable to load receipt: ${e.message}`, 'error');
  }
}

/**
 * Fill receipt modal with data and enable printing.
 */
function populateReceiptModal(receipt) {
  const tmpl = document.getElementById('receipt-template');
  const clone = tmpl.content.cloneNode(true);
  clone.querySelector('.rcp-number').textContent = receipt.receipt_number;
  clone.querySelector('.rcp-date').textContent = new Date(receipt.paid_at).toLocaleDateString();
  clone.querySelector('.rcp-amount').textContent = `₹${Number(receipt.amount_paid).toLocaleString()}`;
  clone.querySelector('.rcp-gstin').textContent = receipt.buyer_gstin ?? '-';
  const container = document.getElementById('receipt-body');
  container.innerHTML = '';
  container.appendChild(clone);
}

/* ----- CSV export ------------------------------------------------------- */

function exportInvoiceCsv(invoiceId) {
  // For simplicity, request a pre‑generated CSV from the backend.
  const url = `${API_BASE}/invoices/${invoiceId}/export`;
  // Use an invisible anchor to trigger download.
  const a = document.createElement('a');
  a.href = url;
  a.download = `invoice_${invoiceId}.csv`;
  document.body.appendChild(a);
  a.click();
  a.remove();
}

/* ------------------------------------------------------------------ */
/*                 AUTOMATION CENTER SECTION                          */
/* ------------------------------------------------------------------ */

async function loadAutomationSettings() {
  try {
    const resp = await fetchWithTimeout(`${API_BASE}/automation/settings`);
    const settings = await handleResponse(resp);
    renderAutomationForm(settings);
  } catch (e) {
    showToast(`Failed to load automation settings: ${e.message}`, 'error');
  }
}

function renderAutomationForm(settings) {
  const form = document.getElementById('automation-form');
  form.reminder_interval.value = settings.reminder_interval;
  form.auto_invoice.value = settings.auto_invoice;
  form.notify_on_failure.checked = settings.notify_on_failure;
}

/**
 * Submit updated automation settings.
 */
async function submitAutomationForm(e) {
  e.preventDefault();
  const f = e.target;
  const payload = {
    reminder_interval: Number(f.reminder_interval.value),
    auto_invoice: f.auto_invoice.checked,
    notify_on_failure: f.notify_on_failure.checked,
  };

  // Basic validation
  if (isNaN(payload.reminder_interval) || payload.reminder_interval < 0) {
    showToast('Reminder interval must be a non‑negative number.', 'warning');
    return;
  }

  try {
    const resp = await fetchWithTimeout(`${API_BASE}/automation/settings`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
    });
    await handleResponse(resp);
    showToast('Automation settings saved.', 'success');
  } catch (e) {
    showToast(`Save failed: ${e.message}`, 'error');
  }
}

/* ------------------------------------------------------------------ */
/*                INTELLIGENCE FEATURES SECTION                       */
/* ------------------------------------------------------------------ */

async function loadIntelligenceAlerts() {
  try {
    const resp = await fetchWithTimeout(`${API_BASE}/intelligence/alerts`);
    const alerts = await handleResponse(resp);
    renderAlerts(alerts);
  } catch (e) {
    showToast(`Failed to load alerts: ${e.message}`, 'error');
  }
}

function renderAlerts(alerts) {
  const container = document.getElementById('alerts-container');
  container.innerHTML = '';
  if (alerts.length === 0) {
    container.textContent = 'No alerts at this time.';
    return;
  }
  alerts.forEach((a) => {
    const div = document.createElement('div');
    div.className = `alert alert-${a.severity}`;
    div.innerHTML = `<strong>${a.title}</strong>: ${a.description}`;
    container.appendChild(div);
  });
}

/* ------------------------------------------------------------------ */
/*                        INITIALISATION                               */
/* ------------------------------------------------------------------ */

document.addEventListener('DOMContentLoaded', () => {
  // Navigation
  initNavigation();

  // Dashboard
  loadDashboard();

  // Customers
  loadCustomers();

  // Subscriptions
  loadSubscriptions();

  // Invoices
  loadInvoices();

  // Automation settings
  loadAutomationSettings();

  // Intelligence alerts
  loadIntelligenceAlerts();

  // ---- Form bindings ----------------------------------------------------
  document.getElementById('customer-form')?.addEventListener('submit', submitCustomerForm);
  document.getElementById('subscription-form')?.addEventListener('submit', submitSubscriptionForm);
  document.getElementById('invoice-form')?.addEventListener('submit', submitInvoiceForm);
  document.getElementById('payment-form')?.addEventListener('submit', submitPaymentForm);
  document.getElementById('automation-form')?.addEventListener('submit', submitAutomationForm);

  // ---- Button / modal triggers -----------------------------------------
  document.getElementById('btn-open-customer')?.addEventListener('click', openCustomerModal);
  document.getElementById('btn-open-subscription')?.addEventListener('click', openSubscriptionModal);
  document.getElementById('btn-open-invoice')?.addEventListener('click', openInvoiceModal);
});

/* ------------------------------------------------------------------ */
/*                        SECURITY / PERFORMANCE NOTES                 */
/* ------------------------------------------------------------------ */

/**
 * SECURITY:
 *  – No passwords or secret keys are stored in this file.
 *  – All authenticated endpoints must reject unauthenticated requests
 *    (the server adds JWT/Cookie checks). Front‑end only forwards the
 *    existing session token (browser cookies).
 *  – Responses are never evaluated as HTML; we only inject plain text.
 *
 * PERFORMANCE:
 *  – Every list endpoint supports `page`/`size` query parameters to avoid
 *    pulling the entire data set.
 *  – UI updates are batched (e.g., innerHTML replacements on <tbody>).
 *  – Event listeners are attached once (delegated where possible) to
 *    prevent duplicate bindings on re‑render.
 */
