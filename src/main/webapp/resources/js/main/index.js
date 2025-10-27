window.addEventListener('load', function() {
    (function() {
        const track = document.getElementById('adsTrack');
        const viewport = document.getElementById('adsViewport');
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const pauseBtn = document.getElementById('pauseBtn');

        let items = Array.from(track.children);
        const originalCount = items.length;
        let currentIndex = 0;
        let itemFullWidth = 0;
        let isTransitioning = false;
        let isPaused = false;
        let timer = null;
        const intervalMs = 3000;

        function setupClones() {
            if (originalCount <= 1) {
                // 0개 또는 1개면 복제 없이 그대로
                window.itemsAll = items;
                return;
            }

            track.innerHTML = '';
            const originals = items.map(n => n.cloneNode(true));

            for (let i = originalCount - 2; i < originalCount; i++) {
                const clone = originals[i].cloneNode(true);
                clone.classList.add('clone');
                track.appendChild(clone);
            }

            originals.forEach(n => track.appendChild(n));

            for (let i = 0; i < 2; i++) {
                const clone = originals[i].cloneNode(true);
                clone.classList.add('clone');
                track.appendChild(clone);
            }

            window.itemsAll = Array.from(track.children);
        }

        function computeItemWidth() {
            if (!window.itemsAll || window.itemsAll.length === 0) return;
            const first = window.itemsAll[0];
            const gap = parseFloat(getComputedStyle(track).gap) || 0;
            const width = first.getBoundingClientRect().width;
            itemFullWidth = width + gap;
        }

        function setTranslateX(px) {
            track.style.transform = 'translateX(' + px + 'px)';
        }

        function centerOnIndex(index) {
            if (!window.itemsAll || window.itemsAll.length === 0) return;

            const viewportWidth = viewport.offsetWidth;
            const offset = (viewportWidth / 2) - (itemFullWidth / 2);
            const translateX = -index * itemFullWidth + offset;
            setTranslateX(translateX);

            window.itemsAll.forEach((el, i) => {
                el.classList.remove('active', 'inactive');
                if (i === index) el.classList.add('active');
                else el.classList.add('inactive');
            });
        }

        function refresh() {
            computeItemWidth();
            track.style.transition = 'none';
            currentIndex = originalCount <= 1 ? 0 : 2; // 1개 이하이면 0, 아니면 2
            centerOnIndex(currentIndex);
            void track.offsetWidth;
            track.style.transition = 'transform 0.8s ease-in-out';
        }

        function moveNext() {
            if (isTransitioning) return;
            isTransitioning = true;
            currentIndex++;
            centerOnIndex(currentIndex);
        }

        function movePrev() {
            if (isTransitioning) return;
            isTransitioning = true;
            currentIndex--;
            centerOnIndex(currentIndex);
        }

        track.addEventListener('transitionend', () => {
            isTransitioning = false;
            if (originalCount > 1) {
                if (currentIndex >= originalCount + 2) {
                    track.style.transition = 'none';
                    currentIndex = 2;
                    centerOnIndex(currentIndex);
                    void track.offsetWidth;
                    track.style.transition = 'transform 0.8s ease-in-out';
                }
                if (currentIndex < 2) {
                    track.style.transition = 'none';
                    currentIndex = originalCount + 1;
                    centerOnIndex(currentIndex);
                    void track.offsetWidth;
                    track.style.transition = 'transform 0.8s ease-in-out';
                }
            }
        });

        function startAuto() {
            stopAuto();
            timer = setInterval(() => { if (!isPaused) moveNext(); }, intervalMs);
        }

        function stopAuto() {
            if (timer) clearInterval(timer);
        }

        pauseBtn.addEventListener('click', () => {
            isPaused = !isPaused;
            pauseBtn.textContent = isPaused ? '▶' : '⏸';
        });
        nextBtn.addEventListener('click', moveNext);
        prevBtn.addEventListener('click', movePrev);

        function init() {
            items = Array.from(track.children);
            setupClones();
            refresh();
            startAuto();
        }

        window.addEventListener('resize', () => {
            track.style.transition = 'none';
            refresh();
            void track.offsetWidth;
            track.style.transition = 'transform 0.8s ease-in-out';
        });

        init();
    })();
});
