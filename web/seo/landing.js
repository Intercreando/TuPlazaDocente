(function () {
  var letters = ['A', 'B', 'C', 'D', 'E', 'F'];

  function markItem(item, chosen) {
    if (item.classList.contains('is-locked')) return;
    var correct = parseInt(item.getAttribute('data-correct') || '-1', 10);
    var opts = item.querySelectorAll('.opt');
    opts.forEach(function (btn, i) {
      btn.classList.remove('is-correct', 'is-wrong');
      if (i === correct) btn.classList.add('is-correct');
      else if (i === chosen) btn.classList.add('is-wrong');
    });
    item.classList.add('is-locked');
    item.setAttribute('data-chosen', String(chosen));
  }

  function maybeFinishQuiz(root) {
    var items = root.querySelectorAll('.item');
    var answered = 0;
    var hits = 0;
    items.forEach(function (item) {
      if (!item.classList.contains('is-locked')) return;
      answered += 1;
      var correct = parseInt(item.getAttribute('data-correct') || '-1', 10);
      var chosen = parseInt(item.getAttribute('data-chosen') || '-1', 10);
      if (chosen === correct) hits += 1;
    });
    if (answered < items.length) return;
    root.classList.add('is-done');
    var score = root.querySelector('.score-value');
    if (score) score.textContent = hits + ' / ' + items.length;
  }

  document.querySelectorAll('.opt').forEach(function (btn) {
    var ltr = btn.querySelector('.ltr');
    if (ltr) {
      var item = btn.closest('.item');
      var opts = item ? Array.prototype.indexOf.call(item.querySelectorAll('.opt'), btn) : -1;
      if (opts >= 0) ltr.textContent = letters[opts] || '';
    }
    btn.addEventListener('click', function () {
      var item = btn.closest('.item');
      var root = btn.closest('main');
      if (!item || !root) return;
      var idx = Array.prototype.indexOf.call(item.querySelectorAll('.opt'), btn);
      markItem(item, idx);
      if (root.classList.contains('quiz')) maybeFinishQuiz(root);
    });
  });
})();
