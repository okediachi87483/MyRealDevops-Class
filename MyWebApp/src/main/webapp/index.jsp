<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Color Splash Web App</title>
  <style>
    /* Reset */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: "Poppins", Arial, sans-serif;
    }

    body {
      min-height: 100vh;
      background: linear-gradient(135deg, #ff6ec4, #7873f5);
      display: flex;
      align-items: center;
      justify-content: center;
      color: #ffffff;
    }

    .app-container {
      width: 90%;
      max-width: 900px;
      background: rgba(255, 255, 255, 0.12);
      border-radius: 24px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
      backdrop-filter: blur(12px);
      padding: 30px 40px;
      position: relative;
      overflow: hidden;
    }

    /* Decorative circles */
    .circle {
      position: absolute;
      border-radius: 50%;
      filter: blur(2px);
      opacity: 0.7;
      z-index: -1;
      animation: float 10s infinite alternate ease-in-out;
    }

    .circle.c1 {
      width: 180px;
      height: 180px;
      background: radial-gradient(circle, #ffdd00, #ff6a00);
      top: -40px;
      left: -40px;
    }

    .circle.c2 {
      width: 220px;
      height: 220px;
      background: radial-gradient(circle, #00f5a0, #00d9ff);
      bottom: -60px;
      right: -60px;
    }

    .circle.c3 {
      width: 140px;
      height: 140px;
      background: radial-gradient(circle, #ff3cac, #784ba0);
      bottom: 20%;
      left: 10%;
    }

    @keyframes float {
      0% { transform: translateY(0px) translateX(0px); }
      100% { transform: translateY(-20px) translateX(20px); }
    }

    header {
      text-align: center;
      margin-bottom: 25px;
    }

    header h1 {
      font-size: 2.6rem;
      letter-spacing: 2px;
      text-transform: uppercase;
      background: linear-gradient(90deg, #ffdd00, #ff6ec4, #00f5a0, #00d9ff);
      -webkit-background-clip: text;
      color: transparent;
    }

    header p {
      font-size: 1rem;
      margin-top: 8px;
      opacity: 0.9;
    }

    .content {
      display: grid;
      grid-template-columns: 1.4fr 1fr;
      gap: 25px;
      align-items: stretch;
    }

    .card {
      background: rgba(0, 0, 0, 0.18);
      border-radius: 18px;
      padding: 20px;
      border: 1px solid rgba(255, 255, 255, 0.25);
    }

    .card h2 {
      font-size: 1.4rem;
      margin-bottom: 10px;
    }

    .card p {
      font-size: 0.95rem;
      line-height: 1.5;
      margin-bottom: 15px;
    }

    .color-display {
      height: 160px;
      border-radius: 14px;
      background: linear-gradient(135deg, #ff9a9e, #fad0c4);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.2rem;
      font-weight: 600;
      text-shadow: 0 2px 6px rgba(0, 0, 0, 0.4);
      margin-bottom: 15px;
      transition: background 0.6s ease, transform 0.3s ease;
    }

    .color-display.pop {
      transform: scale(1.03);
    }

    .controls {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }

    .btn {
      flex: 1 1 120px;
      padding: 10px 14px;
      border-radius: 999px;
      border: none;
      cursor: pointer;
      font-size: 0.9rem;
      font-weight: 600;
      color: #ffffff;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
      transition: transform 0.2s ease, box-shadow 0.2s ease, opacity 0.2s ease;
    }

    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 18px rgba(0, 0, 0, 0.3);
      opacity: 0.95;
    }

    .btn:active {
      transform: translateY(0px) scale(0.98);
      box-shadow: none;
    }

    .btn-random {
      background: linear-gradient(135deg, #ff6a00, #ff3cac);
    }

    .btn-pastel {
      background: linear-gradient(135deg, #ff9a9e, #fecfef);
    }

    .btn-neon {
      background: linear-gradient(135deg, #00f5a0, #00d9ff);
    }

    .btn-dark {
      background: linear-gradient(135deg, #141e30, #243b55);
    }

    .info-card ul {
      list-style: none;
      margin-top: 10px;
    }

    .info-card li {
      margin-bottom: 6px;
      font-size: 0.9rem;
    }

    .info-tag {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 999px;
      background: rgba(255, 255, 255, 0.18);
      font-size: 0.75rem;
      margin-right: 6px;
    }

    footer {
      text-align: center;
      margin-top: 25px;
      font-size: 0.8rem;
      opacity: 0.8;
    }

    footer span {
      font-weight: 600;
    }

    @media (max-width: 720px) {
      .content {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
  <div class="app-container">
    <!-- Decorative circles -->
    <div class="circle c1"></div>
    <div class="circle c2"></div>
    <div class="circle c3"></div>

    <header>
      <h1>Color Splash Studio</h1>
      <p>Click the buttons to explore different moods and colour palettes. Designed for a web class project.</p>
    </header>

    <main class="content">
      <!-- Interactive color panel -->
      <section class="card">
        <h2>Interactive Colour Panel</h2>
        <p>Use the buttons below to change the background style of this panel. Each mode shows a different vibe.</p>

        <div id="colorDisplay" class="color-display">
          Click a button to change my colours!
        </div>

        <div class="controls">
          <button class="btn btn-random" onclick="setRandomGradient()">
            🎨 Random
          </button>
          <button class="btn btn-pastel" onclick="setPastelGradient()">
            🌸 Pastel
          </button>
          <button class="btn btn-neon" onclick="setNeonGradient()">
            ⚡ Neon
          </button>
          <button class="btn btn-dark" onclick="setDarkGradient()">
            🌙 Night
          </button>
        </div>
      </section>

      <!-- Info / description card -->
      <section class="card info-card">
        <h2>About This Mini Web App</h2>
        <p>
          This colourful page is built with pure HTML, CSS, and a little JavaScript.
          It demonstrates:
        </p>
        <ul>
          <li><span class="info-tag">Gradients</span>Multiple bright background gradients</li>
          <li><span class="info-tag">Buttons</span>Interactive buttons that change styles</li>
          <li><span class="info-tag">Animations</span>Floating shapes and smooth transitions</li>
          <li><span class="info-tag">Layout</span>Responsive grid layout for different screen sizes</li>
        </ul>
        <p style="margin-top: 10px;">
          You can customize the colours, text, and effects to match your own style or class requirements.
        </p>
      </section>
    </main>

    <footer>
      Made with <span>HTML + CSS + JavaScript</span> • Perfect for a colourful web class project
    </footer>
  </div>

  <script>
    const colorDisplay = document.getElementById("colorDisplay");

    function animatePanel() {
      colorDisplay.classList.add("pop");
      setTimeout(() => colorDisplay.classList.remove("pop"), 250);
    }

    function setRandomGradient() {
      const colors = [
        "#ff6ec4", "#7873f5", "#ffdd00", "#ff6a00",
        "#00f5a0", "#00d9ff", "#ff3cac", "#784ba0",
        "#ff9a9e", "#fecfef", "#f6d365", "#fda085"
      ];

      function randomColor() {
        return colors[Math.floor(Math.random() * colors.length)];
      }

      const c1 = randomColor();
      const c2 = randomColor();
      const c3 = randomColor();

      colorDisplay.style.background = `linear-gradient(135deg, ${c1}, ${c2}, ${c3})`;
      colorDisplay.textContent = "Random Colour Splash!";
      animatePanel();
    }

    function setPastelGradient() {
      colorDisplay.style.background =
        "linear-gradient(135deg, #ff9a9e, #fecfef, #fad0c4)";
      colorDisplay.textContent = "Soft Pastel Vibes 🌸";
      animatePanel();
    }

    function setNeonGradient() {
      colorDisplay.style.background =
        "linear-gradient(135deg, #00f5a0, #00d9ff, #ff6ec4)";
      colorDisplay.textContent = "Neon Energy ⚡";
      animatePanel();
    }

    function setDarkGradient() {
      colorDisplay.style.background =
        "linear-gradient(135deg, #141e30, #243b55, #000000)";
      colorDisplay.textContent = "Night Mode 🌙";
      animatePanel();
    }
  </script>
</body>
</html>
