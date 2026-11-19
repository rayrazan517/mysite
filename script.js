document.getElementById('year').textContent = new Date().getFullYear();

let count = 0;
const btn = document.getElementById('btn');
const out = document.getElementById('out');

btn.addEventListener('click', () => {
  count++;
  out.textContent = `你点了 ${count} 次。`;
});
