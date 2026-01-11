[Github](https://github.com/Cherzing/GestureEarth)
### 📄 单文件 HTML 完整提示词

请生成一个**完整的、自包含的 HTML 文件**（仅一个 `.html` 文件），实现一个基于浏览器摄像头的手势交互 3D 地球可视化系统，要求如下：

#### 🧩 基础结构
- 所有代码（HTML + CSS + JavaScript）必须内联在同一个 HTML 文件中，**不使用任何构建工具、模块系统或框架（如 React）**
- 所有依赖库（Three.js、MediaPipe Hands）**通过 CDN 引入**（如 jsDelivr），确保开箱即用
- 页面包含：
  - **全屏 Three.js 渲染画布**（显示地球）
  - **右下角摄像头预览框**（240×180 像素，带白边和圆角，实时显示用户手部画面，用于反馈手势）

#### 🌍 地球与场景
- 使用 Three.js（r150+）创建带纹理的地球（NASA Blue Marble 贴图，使用公开 HTTPS CDN 链接）
- 相机为 `PerspectiveCamera`，初始位置 `(0, 0, 5)`，目标 `(0, 0, 0)`
- 添加环境光和方向光，开启抗锯齿
- 地球默认缓慢绕 Y 轴自转；一旦检测到有效手势（包括挥手），立即暂停自转

#### ✋ 手势交互逻辑（基于 MediaPipe Hands 关键点）
实现以下四种手势：

1. **大拇指（landmark 4）与食指（landmark 8）捏合**  
   - 条件：指尖距离 < 0.03 且持续 ≥300ms  
   - 行为：从屏幕中心向地球发射射线，计算交点经纬度  
   - 简化国家匹配（硬编码区域，如中国、美国、巴西），命中则高亮（半透明色壳）并在顶部显示国家名

2. **手掌张开**  
   - 条件：四指尖（8,12,16,20）到手腕（0）平均距离 > 0.4  
   - 行为：平滑拉近相机（减小 Z），最小距离限制为 2.0

3. **握拳**  
   - 条件：四指尖到手腕平均距离 < 0.25  
   - 行为：平滑推远相机（增大 Z），最大距离限制为 10.0

4. **挥手控制镜头方向**  
   - 触发条件：手掌张开 **且** 手掌中心（landmark 9）在连续帧中发生明显位移  
   - 方向判断：
     - 若手掌中心 **X 坐标变化 > 阈值**：控制相机绕地球 **Y 轴旋转**（左右看）
     - 若手掌中心 **Y 坐标变化 > 阈值**：控制相机绕地球 **X 轴旋转**（上下看）
   - 实现方式：
     - 记录上一帧手掌中心坐标 `(prevX, prevY)`
     - 当前帧计算位移 `deltaX = currX - prevX`，`deltaY = currY - prevY`
     - 将 `deltaX` 映射为场景根组（或相机）的 `rotation.y` 增量，`deltaY` 映射为 `rotation.x` 增量
     - 使用缓动或比例缩放避免抖动（如 `rotationDelta = deltaX * 2.0`）
   - 注意：挥手期间**不触发放大/缩小**，需优先级高于张开/握拳

#### 🖥️ UI 与体验
- 摄像头预览框固定于右下角，始终可见，用于确认手势是否被捕捉
- 顶部信息栏显示：“当前选中：中国” 或 “请挥动手掌调整视角” 等状态提示
- 若未检测到手部，显示“请将手放入摄像头视野”
- 所有动画（缩放、旋转、高亮）使用 `requestAnimationFrame` + 线性插值实现流畅过渡
- 自动请求摄像头权限，失败时显示错误

#### ⚙️ 技术细节
- MediaPipe Hands 使用 CDN 版本（如 `https://cdn.jsdelivr.net/npm/@mediapipe/hands@0.5.1659255875/`）
- Three.js 使用传统 UMD 构建（如 `three.min.js`）以兼容单文件 script 标签
- 视频元素 `<video>` 设置 `autoplay muted playsinline`，并作为 MediaPipe 输入源
- 射线拾取使用 `THREE.Raycaster`，从屏幕中心 `(window.innerWidth/2, window.innerHeight/2)` 发射
- 国家匹配可简化为经纬度范围判断（无需完整 GeoJSON）
- 所有状态（是否捏合、是否挥手、上一帧手掌位置等）通过全局变量或闭包管理

#### 🧪 可运行性
- 生成的 HTML 应能在支持 WebRTC 的现代浏览器中直接运行（建议通过本地 HTTP 服务器测试摄像头）
- 无语法错误，无未定义变量，所有资源链接有效


```html
<!DOCTYPE html>

<html lang="zh-CN">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Gesture Earth 3D</title>

    <style>

        body {

            margin: 0;

            overflow: hidden;

            background-color: #000;

            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

            user-select: none;

        }

  

        #canvas-container {

            width: 100vw;

            height: 100vh;

            position: absolute;

            top: 0;

            left: 0;

            z-index: 1;

        }

  

        .camera-container {

            position: absolute;

            top: 20px;

            right: 20px;

            width: 240px;

            height: 180px;

            z-index: 100;

            border-radius: 12px;

            overflow: hidden;

            box-shadow: 0 4px 20px rgba(0,0,0,0.5);

            border: 2px solid rgba(255, 255, 255, 0.1);

            background: #000;

        }

  

        #video-input {

            width: 100%;

            height: 100%;

            object-fit: cover;

            transform: scaleX(-1); /* Mirror for natural feel */

        }

  

        #output-canvas {

            position: absolute;

            top: 0;

            left: 0;

            width: 100%;

            height: 100%;

            transform: scaleX(-1); /* Align with mirrored video */

        }

  

        #ui-layer {

            position: absolute;

            top: 0;

            left: 0;

            width: 100%;

            height: 100%;

            z-index: 10;

            pointer-events: none;

            display: flex;

            flex-direction: column;

            align-items: center;

        }

  

        #info-panel {

            margin-top: 40px;

            background: rgba(0, 20, 40, 0.7);

            backdrop-filter: blur(10px);

            border: 1px solid rgba(100, 200, 255, 0.3);

            border-radius: 16px;

            padding: 20px 40px;

            text-align: center;

            color: #fff;

            transition: all 0.3s ease;

            box-shadow: 0 0 30px rgba(0, 150, 255, 0.2);

            max-width: 80%;

        }

  

        #status-text {

            font-size: 24px;

            font-weight: 600;

            letter-spacing: 1px;

            margin: 0;

            text-transform: uppercase;

            text-shadow: 0 0 10px rgba(0, 150, 255, 0.8);

        }

  

        #sub-status {

            font-size: 14px;

            color: #aaa;

            margin-top: 8px;

        }

  

        #gesture-indicator {

            position: absolute;

            bottom: 40px;

            left: 50%;

            transform: translateX(-50%);

            display: flex;

            gap: 20px;

            opacity: 0.8;

            flex-wrap: wrap;

            justify-content: center;

        }

  

        .gesture-badge {

            background: rgba(0, 0, 0, 0.6);

            padding: 8px 16px;

            border-radius: 20px;

            font-size: 12px;

            color: #fff;

            border: 1px solid rgba(255, 255, 255, 0.1);

            transition: all 0.2s;

            white-space: nowrap;

        }

  

        .gesture-badge.active {

            background: rgba(0, 255, 150, 0.2);

            border-color: #00ff96;

            color: #00ff96;

            transform: scale(1.05);

            box-shadow: 0 0 15px rgba(0, 255, 150, 0.4);

        }

  

        #crosshair {

            position: absolute;

            top: 50%;

            left: 50%;

            width: 20px;

            height: 20px;

            transform: translate(-50%, -50%);

            pointer-events: none;

            z-index: 5;

        }

        #crosshair::before, #crosshair::after {

            content: '';

            position: absolute;

            background: rgba(255, 255, 255, 0.5);

        }

        #crosshair::before { top: 9px; left: 0; width: 20px; height: 2px; }

        #crosshair::after { left: 9px; top: 0; height: 20px; width: 2px; }

  

        .loader {

            position: fixed;

            top: 50%;

            left: 50%;

            transform: translate(-50%, -50%);

            color: white;

            font-size: 18px;

            z-index: 100;

            background: rgba(0,0,0,0.8);

            padding: 20px;

            border-radius: 8px;

        }

    </style>

  

    <!-- Import Maps for Three.js (ESM) -->

    <script type="importmap">

        {

            "imports": {

                "three": "https://unpkg.com/three@0.160.0/build/three.module.js",

                "three/addons/": "https://unpkg.com/three@0.160.0/examples/jsm/"

            }

        }

    </script>

  

    <!-- MediaPipe Global Scripts (UMD) -->

    <script src="https://cdn.jsdelivr.net/npm/@mediapipe/camera_utils/camera_utils.js" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/@mediapipe/control_utils/control_utils.js" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/@mediapipe/drawing_utils/drawing_utils.js" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/@mediapipe/hands/hands.js" crossorigin="anonymous"></script>

</head>

<body>

    <div id="loader" class="loader">正在加载资源和模型...</div>

  

    <div class="camera-container">

        <video id="video-input"></video>

        <canvas id="output-canvas"></canvas>

    </div>

  

    <div id="canvas-container"></div>

    <div id="ui-layer">

        <div id="info-panel">

            <h1 id="status-text">初始化中...</h1>

            <div id="sub-status">请允许摄像头权限</div>

        </div>

  

        <div id="crosshair"></div>

  

        <div id="gesture-indicator">

            <div id="badge-open" class="gesture-badge">🖐 张手放大</div>

            <div id="badge-fist" class="gesture-badge">✊ 握拳缩小</div>

            <div id="badge-pan" class="gesture-badge">👋 挥手旋转</div>

            <div id="badge-pinch" class="gesture-badge">👌 捏合识别</div>

        </div>

    </div>

  

    <!-- Main Logic -->

    <script type="module">

        import * as THREE from 'three';

  

        // --- Configuration Constants ---

        const CONFIG = {

            cameraZ: { min: 2.0, max: 10.0, initial: 5.0 },

            zoomSpeed: 0.1,

            autoRotateSpeed: 0.001,

            // Gesture Thresholds

            pinchThreshold: 0.03, // Distance between thumb and index

            pinchDuration: 300, // ms

            openThreshold: 0.35, // Avg distance from wrist to fingertips (0.35 is slightly more forgiving than 0.4)

            fistThreshold: 0.25, // Avg distance from wrist to fingertips

            moveThreshold: 0.008, // Increased slightly to reduce micro-jitter (was 0.005)

            panSpeed: 0.5, // Reduced from 3.0 to 0.5 for smoother control

            textureUrl: 'https://unpkg.com/three-globe/example/img/earth-blue-marble.jpg',

            bumpUrl: 'https://unpkg.com/three-globe/example/img/earth-topology.png'

        };

  

        // --- Simplified Country Data (Bounding Boxes) ---

        const COUNTRIES = [

            [18, 54, 73, 135, "中国 (China)"],

            [24, 49, -125, -67, "美国 (USA)"],

            [-34, 5, -74, -35, "巴西 (Brazil)"],

            [-44, -10, 113, 154, "澳大利亚 (Australia)"],

            [41, 82, 20, 180, "俄罗斯 (Russia)"],

            [8, 37, 68, 97, "印度 (India)"],

            [36, 72, -10, 30, "欧洲 (Europe)"],

            [-35, 37, -17, 51, "非洲 (Africa)"],

            [-90, -60, -180, 180, "南极洲 (Antarctica)"],

            [60, 90, -180, 180, "北极区域 (Arctic)"]

        ];

  

        // --- Global State ---

        const state = {

            targetZ: CONFIG.cameraZ.initial,

            isPinching: false,

            lastPinchTime: 0,

            pinchStartTime: 0,

            handPresent: false,

            gesture: 'NONE', // NONE, OPEN, FIST, PINCH, PAN

            lastPalmPos: null,

            panDelta: { x: 0, y: 0 },

            autoRotate: true,

            highlightedCountry: null

        };

  

        // --- Three.js Variables ---

        let scene, camera, renderer, earthGroup, earthMesh, markerMesh, atmosphereMesh;

        let raycaster = new THREE.Raycaster();

        // --- DOM Elements ---

        const statusText = document.getElementById('status-text');

        const subStatus = document.getElementById('sub-status');

        const badges = {

            open: document.getElementById('badge-open'),

            fist: document.getElementById('badge-fist'),

            pinch: document.getElementById('badge-pinch'),

            pan: document.getElementById('badge-pan')

        };

        const loader = document.getElementById('loader');

        const canvasElement = document.getElementById('output-canvas');

        const canvasCtx = canvasElement.getContext('2d');

  

        // --- Initialization Sequence ---

        async function init() {

            initThree();

            await initMediaPipe();

            loader.style.display = 'none';

            animate();

        }

  

        // --- 1. Three.js Setup ---

        function initThree() {

            const container = document.getElementById('canvas-container');

            // Scene

            scene = new THREE.Scene();

            scene.background = new THREE.Color(0x000000);

  

            // Camera

            camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 100);

            camera.position.z = CONFIG.cameraZ.initial;

  

            // Renderer

            renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });

            renderer.setSize(window.innerWidth, window.innerHeight);

            renderer.setPixelRatio(window.devicePixelRatio);

            container.appendChild(renderer.domElement);

  

            // Lighting

            const ambientLight = new THREE.AmbientLight(0xffffff, 0.2);

            scene.add(ambientLight);

  

            const sunLight = new THREE.DirectionalLight(0xffffff, 1.5);

            sunLight.position.set(5, 3, 5);

            scene.add(sunLight);

  

            // Earth Group (Holds Earth + Atmosphere + Markers)

            earthGroup = new THREE.Group();

            scene.add(earthGroup);

  

            // Earth Mesh

            const textureLoader = new THREE.TextureLoader();

            const earthGeo = new THREE.SphereGeometry(1, 64, 64);

            const earthMat = new THREE.MeshStandardMaterial({

                map: textureLoader.load(CONFIG.textureUrl),

                bumpMap: textureLoader.load(CONFIG.bumpUrl),

                bumpScale: 0.05,

                roughness: 0.8,

                metalness: 0.1

            });

            earthMesh = new THREE.Mesh(earthGeo, earthMat);

            earthGroup.add(earthMesh);

  

            // Atmosphere Glow

            const atmoGeo = new THREE.SphereGeometry(1.02, 64, 64);

            const atmoMat = new THREE.MeshBasicMaterial({

                color: 0x44aaff,

                transparent: true,

                opacity: 0.1,

                side: THREE.BackSide,

                blending: THREE.AdditiveBlending

            });

            atmosphereMesh = new THREE.Mesh(atmoGeo, atmoMat);

            earthGroup.add(atmosphereMesh);

  

            // Marker Mesh

            const markerGeo = new THREE.SphereGeometry(0.02, 16, 16);

            const markerMat = new THREE.MeshBasicMaterial({ color: 0xff0000, transparent: true, opacity: 0.8 });

            markerMesh = new THREE.Mesh(markerGeo, markerMat);

            markerMesh.visible = false;

            earthMesh.add(markerMesh);

  

            // Stars

            addStars();

  

            window.addEventListener('resize', onWindowResize, false);

        }

  

        function addStars() {

            const starGeo = new THREE.BufferGeometry();

            const starCount = 2000;

            const posArray = new Float32Array(starCount * 3);

            for(let i=0; i<starCount * 3; i++) {

                posArray[i] = (Math.random() - 0.5) * 50;

            }

            starGeo.setAttribute('position', new THREE.BufferAttribute(posArray, 3));

            const starMat = new THREE.PointsMaterial({color: 0xffffff, size: 0.05, transparent: true, opacity: 0.8});

            const stars = new THREE.Points(starGeo, starMat);

            scene.add(stars);

        }

  

        function onWindowResize() {

            camera.aspect = window.innerWidth / window.innerHeight;

            camera.updateProjectionMatrix();

            renderer.setSize(window.innerWidth, window.innerHeight);

        }

  

        // --- 2. MediaPipe Setup ---

        async function initMediaPipe() {

            const videoElement = document.getElementById('video-input');

            canvasElement.width = 320;

            canvasElement.height = 240;

  

            const hands = new Hands({locateFile: (file) => {

                return `https://cdn.jsdelivr.net/npm/@mediapipe/hands/${file}`;

            }});

  

            hands.setOptions({

                maxNumHands: 1,

                modelComplexity: 1,

                minDetectionConfidence: 0.5,

                minTrackingConfidence: 0.5

            });

  

            hands.onResults(onHandsResults);

  

            const cameraUtils = new Camera(videoElement, {

                onFrame: async () => {

                    await hands.send({image: videoElement});

                },

                width: 320,

                height: 240

            });

            try {

                await cameraUtils.start();

                statusText.innerText = "请将手放入视野";

                subStatus.innerText = "等待手势...";

            } catch (e) {

                console.error(e);

                statusText.innerText = "摄像头启动失败";

                subStatus.innerText = "请检查权限设置";

            }

        }

  

        // --- 3. Gesture Logic ---

        function onHandsResults(results) {

            canvasCtx.save();

            canvasCtx.clearRect(0, 0, canvasElement.width, canvasElement.height);

            if (results.multiHandLandmarks && results.multiHandLandmarks.length > 0) {

                state.handPresent = true;

                const landmarks = results.multiHandLandmarks[0];

                // Draw connectors and landmarks

                drawConnectors(canvasCtx, landmarks, HAND_CONNECTIONS, {color: '#00FF00', lineWidth: 2});

                drawLandmarks(canvasCtx, landmarks, {color: '#FF0000', lineWidth: 1, radius: 2});

  

                detectGesture(landmarks);

            } else {

                state.handPresent = false;

                state.gesture = 'NONE';

                state.lastPalmPos = null;

                resetUI();

            }

            canvasCtx.restore();

        }

  

        function detectGesture(lm) {

            // Distance helper

            const dist = (i, j) => Math.hypot(lm[i].x - lm[j].x, lm[i].y - lm[j].y);

  

            // --- 1. Pinch Detection ---

            // Thumb Tip(4) to Index Tip(8)

            const pinchDist = dist(4, 8);

            // --- 2. Hand Sizing (Open vs Fist) ---

            // Average distance from Wrist(0) to 4 fingertips (8, 12, 16, 20)

            const d8 = dist(0, 8);

            const d12 = dist(0, 12);

            const d16 = dist(0, 16);

            const d20 = dist(0, 20);

            const avgTipDist = (d8 + d12 + d16 + d20) / 4;

  

            // --- 3. Wave/Pan Detection ---

            const palm = lm[9]; // Middle finger MCP, roughly center of palm

            let deltaX = 0;

            let deltaY = 0;

            let isMoving = false;

  

            if (state.lastPalmPos) {

                deltaX = palm.x - state.lastPalmPos.x;

                deltaY = palm.y - state.lastPalmPos.y;

                const movement = Math.hypot(deltaX, deltaY);

                if (movement > CONFIG.moveThreshold) {

                    isMoving = true;

                }

            }

            state.lastPalmPos = { x: palm.x, y: palm.y };

  

            // --- State Machine ---

            let newGesture = 'NONE';

  

            // Priority 1: Pinch (Raycast)

            if (pinchDist < CONFIG.pinchThreshold) {

                if (!state.isPinching) {

                    state.pinchStartTime = performance.now();

                }

                state.isPinching = true;

                // Only confirm gesture if held for duration

                if (performance.now() - state.pinchStartTime > CONFIG.pinchDuration) {

                    newGesture = 'PINCH';

                }

            } else {

                state.isPinching = false;

                state.pinchStartTime = 0;

  

                // Priority 2: Pan/Wave (Must be open hand AND moving)

                // Note: We use the Open threshold to ensure hand is active/visible

                if (avgTipDist > CONFIG.openThreshold) {

                    if (isMoving) {

                        newGesture = 'PAN';

                        // Store delta for animate loop

                        state.panDelta = { x: deltaX, y: deltaY };

                    } else {

                        // Priority 3: Open (Static Zoom In)

                        newGesture = 'OPEN';

                    }

                }

                // Priority 4: Fist (Zoom Out)

                else if (avgTipDist < CONFIG.fistThreshold) {

                    newGesture = 'FIST';

                }

            }

  

            state.gesture = newGesture;

            updateUIState();

        }

  

        function resetUI() {

            statusText.innerText = "请将手放入视野";

            subStatus.innerText = "未检测到手部";

            Object.values(badges).forEach(b => b.classList.remove('active'));

            markerMesh.visible = false;

        }

  

        function updateUIState() {

            Object.values(badges).forEach(b => b.classList.remove('active'));

  

            if (state.gesture === 'OPEN') {

                badges.open.classList.add('active');

                statusText.innerText = "放大地球";

                subStatus.innerText = "张手保持静止 - 相机拉近";

            } else if (state.gesture === 'FIST') {

                badges.fist.classList.add('active');

                statusText.innerText = "缩小地球";

                subStatus.innerText = "握拳 - 相机推远";

            } else if (state.gesture === 'PINCH') {

                badges.pinch.classList.add('active');

                // Status updated by raycast logic

            } else if (state.gesture === 'PAN') {

                badges.pan.classList.add('active');

                statusText.innerText = "旋转视角";

                subStatus.innerText = "挥手移动 - 控制方向";

            } else {

                statusText.innerText = "准备就绪";

                subStatus.innerText = "等待手势指令";

                markerMesh.visible = false;

            }

        }

  

        // --- 4. Logic & Render Loop ---

        function animate() {

            requestAnimationFrame(animate);

  

            // Auto Rotation (Only if no active interaction)

            if (state.handPresent && state.gesture !== 'NONE') {

                // Pause auto rotation

            } else {

                earthGroup.rotation.y += CONFIG.autoRotateSpeed;

            }

  

            // --- Handle Gestures ---

            // 1. Zoom In (OPEN)

            if (state.gesture === 'OPEN') {

                state.targetZ = Math.max(CONFIG.cameraZ.min, state.targetZ - CONFIG.zoomSpeed);

            }

            // 2. Zoom Out (FIST)

            else if (state.gesture === 'FIST') {

                state.targetZ = Math.min(CONFIG.cameraZ.max, state.targetZ + CONFIG.zoomSpeed);

            }

            // 3. Pan/Rotate (PAN)

            else if (state.gesture === 'PAN') {

                // Map hand movement to rotation.

                // Hand moving right (positive deltaX) -> Should look right -> Rotate Earth Left (negative Y)

                // Hand moving down (positive deltaY) -> Should look down -> Rotate Earth Up (negative X)

                // Note: deltaX from MediaPipe: Left=0, Right=1. So moving right is +deltaX.

                // Adjust sensitivity and direction to feel natural

                earthGroup.rotation.y += state.panDelta.x * CONFIG.panSpeed;

                earthGroup.rotation.x += state.panDelta.y * CONFIG.panSpeed;

                // Clamp X rotation to avoid flipping

                earthGroup.rotation.x = Math.max(-Math.PI/3, Math.min(Math.PI/3, earthGroup.rotation.x));

            }

  

            // Smooth Zoom Interpolation

            camera.position.z += (state.targetZ - camera.position.z) * 0.1;

  

            // 4. Pinch Raycast

            if (state.gesture === 'PINCH') {

                performRaycast();

            }

  

            renderer.render(scene, camera);

        }

  

        function performRaycast() {

            raycaster.setFromCamera(new THREE.Vector2(0, 0), camera);

            // Raycast against the mesh inside the group

            const intersects = raycaster.intersectObject(earthMesh);

  

            if (intersects.length > 0) {

                const point = intersects[0].point;

                // Convert world point to local point relative to Earth Mesh

                // Since Earth is in a Group that might be rotated, and Earth Mesh itself might be rotated (if we used rotation there)

                // Currently rotation is applied to earthGroup.

                // worldToLocal on earthMesh handles the group transforms automatically.

                const localPoint = earthMesh.worldToLocal(point.clone());

                const lat = 90 - (Math.acos(localPoint.y) * 180 / Math.PI);

                const lon = ((Math.atan2(localPoint.x, localPoint.z) * 180 / Math.PI) + 360) % 360;

                let normalizedLon = lon;

                if (normalizedLon > 180) normalizedLon -= 360;

  

                const country = identifyCountry(lat, normalizedLon);

                if (country) {

                    statusText.innerText = country.name;

                    subStatus.innerText = `Lat: ${lat.toFixed(1)}°, Lon: ${normalizedLon.toFixed(1)}°`;

                    markerMesh.position.copy(localPoint.normalize().multiplyScalar(1.01));

                    markerMesh.visible = true;

                } else {

                    statusText.innerText = "海洋 / 未知区域";

                    subStatus.innerText = `Lat: ${lat.toFixed(1)}°, Lon: ${normalizedLon.toFixed(1)}°`;

                    markerMesh.visible = false;

                }

            }

        }

  

        function identifyCountry(lat, lon) {

            for (let c of COUNTRIES) {

                const [latMin, latMax, lonMin, lonMax, name] = c;

                if (lat >= latMin && lat <= latMax && lon >= lonMin && lon <= lonMax) {

                    return { name };

                }

            }

            return null;

        }

  

        // Start

        init();

    </script>

</body>

</html>
```