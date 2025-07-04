// Toggle sidebar aktif/kecil
function toggleSidebar() {
  document.getElementById("sidebar").classList.toggle("active");
  document.querySelector(".navbar").classList.toggle("collapsed");
  document.querySelector(".content").classList.toggle("collapsed");
}

// Toggle dark mode
document.getElementById("darkModeToggle")?.addEventListener("click", function () {
  document.body.classList.toggle("dark-mode");
  const icon = this.querySelector("i");
  icon.classList.toggle("bx-sun");
  icon.classList.toggle("bx-moon");
});

// Jam realtime di navbar
function updateClock() {
  const clock = document.getElementById("clock-time");
  if (!clock) return;

  const now = new Date();
  const hari = ["Minggu","Senin","Selasa","Rabu","Kamis","Jumat","Sabtu"];
  const day = hari[now.getDay()];
  const date = now.getDate().toString().padStart(2, '0');
  const month = now.toLocaleString('id-ID', { month: 'long' });
  const year = now.getFullYear();

  const hours = now.getHours().toString().padStart(2, '0');
  const minutes = now.getMinutes().toString().padStart(2, '0');
  const seconds = now.getSeconds().toString().padStart(2, '0');

  clock.textContent = `${day}, ${date} ${month} ${year} - ${hours}:${minutes}:${seconds}`;
}

setInterval(updateClock, 1000);
document.addEventListener("DOMContentLoaded", updateClock);

// Search filter tabel
function filterTable() {
  const input = document.getElementById("searchInput");
  if (!input) return;

  const filter = input.value.toLowerCase();
  const rows = document.querySelectorAll("table tbody tr");

  rows.forEach(row => {
    const cells = Array.from(row.cells).map(td => td.textContent.toLowerCase()).join(' ');
    row.style.display = cells.includes(filter) ? '' : 'none';
  });
}

document.addEventListener("DOMContentLoaded", () => {
  document.getElementById("searchInput")?.addEventListener("keyup", filterTable);
});

// Validasi form barang
function validateForm() {
  const nama = document.getElementById("nama");
  const jenis = document.getElementById("jenis");
  const stok = document.getElementById("stok");
  const harga = document.getElementById("harga");

  if (!nama || !jenis || !stok || !harga) return true;

  if (
    nama.value.trim() === "" ||
    jenis.value.trim() === "" ||
    stok.value.trim() === "" ||
    harga.value.trim() === ""
  ) {
    alert("Semua field harus diisi!");
    return false;
  }

  if (isNaN(stok.value) || stok.value < 0 || isNaN(harga.value) || harga.value < 0) {
    alert("Stok dan Harga harus berupa angka positif!");
    return false;
  }

  return true;
}

// Sort table universal
let sortDirection = true;
function sortTable(colIndex, tableId = "barangTable") {
  const table = document.getElementById(tableId);
  if (!table) return;

  const rows = Array.from(table.rows).slice(1);
  rows.sort((a, b) => {
    const valA = a.cells[colIndex].innerText.toLowerCase();
    const valB = b.cells[colIndex].innerText.toLowerCase();
    return sortDirection
      ? valA.localeCompare(valB)
      : valB.localeCompare(valA);
  });

  sortDirection = !sortDirection;
  const tbody = table.tBodies[0];
  rows.forEach(row => tbody.appendChild(row));
}

// Auto-hide notifikasi setelah 4 detik
window.addEventListener("DOMContentLoaded", () => {
  const notif = document.querySelector(".notif");
  if (notif) {
    setTimeout(() => notif.remove(), 4000);
  }
});
