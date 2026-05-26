# shandada

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>知陌 - 高保真交互原型系统</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@300;400;500;700&family=Poppins:wght@400;500;600;700&display=swap');
        
        body {
            font-family: 'Noto Sans SC', 'Poppins', sans-serif;
            background-color: #F8FAFC;
        }

        /* Hide Scrollbar for Chrome, Safari and Opera */
        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }
        /* Hide Scrollbar for IE, Edge and Firefox */
        .no-scrollbar {
            -ms-overflow-style: none;  /* IE and Edge */
            scrollbar-width: none;  /* Firefox */
        }

        /* Dynamic transition for smooth prototype experience */
        .screen-fade {
            transition: opacity 0.25s ease-in-out, transform 0.25s ease-in-out;
        }
        
        /* Custom safe shadows */
        .shadow-premium {
            box-shadow: 0 10px 30px -5px rgba(144, 95, 255, 0.08), 0 4px 12px -2px rgba(144, 95, 255, 0.03);
        }
        .shadow-glow {
            box-shadow: 0 8px 24px rgba(144, 95, 255, 0.35);
        }
    </style>
</head>
<body class="min-height-screen flex flex-col lg:flex-row items-center justify-center p-4 lg:p-8 gap-8 bg-slate-50 text-slate-800 antialiased">

    <!-- Left Column: Specification Manual & Product Brief -->
    <div class="w-full lg:w-[420px] bg-white p-6 rounded-3xl border border-purple-100 shadow-premium flex flex-col gap-6">
        <div>
            <div class="inline-flex items-center gap-2 px-3 py-1 bg-purple-50 rounded-full text-[#905FFF] text-xs font-semibold mb-3">
                <i class="fa-solid fa-layer-group"></i> 全栈产品原型手册
            </div>
            <h1 class="text-2xl font-bold text-slate-900 tracking-tight">知陌 <span class="text-[#905FFF] font-medium text-lg font-mono">ShanDaDa</span></h1>
            <p class="text-sm text-slate-500 mt-1">组局搭子社区 App · 高保真功能演示</p>
        </div>

        <div class="space-y-4 text-xs text-slate-600">
            <div class="p-3.5 bg-slate-50 rounded-xl border border-slate-100">
                <h3 class="font-bold text-slate-800 text-sm mb-1.5 flex items-center gap-1.5">
                    <span class="w-1.5 h-3 bg-[#905FFF] rounded-full"></span>核心设计规范
                </h3>
                <ul class="space-y-1 list-disc list-inside text-slate-500 pl-1">
                    <li>主题色：<span class="font-mono text-[#905FFF] font-semibold">#905FFF</span> (高饱优雅紫)</li>
                    <li>底色：应用全白背景 (<span class="font-mono">#FFFFFF</span>)，轻通透空气感</li>
                    <li>交互：iPhone 15 Pro 比例外壳，支持全面屏触控手势</li>
                </ul>
            </div>

            <div class="p-3.5 bg-slate-50 rounded-xl border border-slate-100">
                <h3 class="font-bold text-slate-800 text-sm mb-1.5 flex items-center gap-1.5">
                    <span class="w-1.5 h-3 bg-[#905FFF] rounded-full"></span>底部栏新增「中央发布」交互说明
                </h3>
                <p class="text-slate-500 leading-relaxed">
                    响应最新需求，底部导航重构为五分区架构。正中央设立独立悬浮<strong>「加号发布键」</strong>。点击后触发优雅的<b>半屏空气感抽屉模态窗</b>，用户可在无边框设计中平滑输入活动标题、品类标签、时间地点等高级模块化卡片。
                </p>
            </div>
        </div>

        <!-- Interactive Control Tips -->
        <div class="bg-purple-50/50 rounded-2xl p-4 border border-purple-100">
            <h4 class="text-xs font-bold text-purple-950 flex items-center gap-1.5 mb-2">
                <i class="fa-solid fa-hand-pointer text-[#905FFF]"></i> 交互演示指南：
            </h4>
            <div class="grid grid-cols-2 gap-2 text-[11px] text-purple-900/80">
                <div class="flex items-center gap-1"><i class="fa-solid fa-circle-check text-emerald-500"></i> 点击底部标签切换页面</div>
                <div class="flex items-center gap-1"><i class="fa-solid fa-circle-check text-emerald-500"></i> 点击中央紫色 <i class="fa-solid fa-plus"></i> 唤起发布</div>
                <div class="flex items-center gap-1"><i class="fa-solid fa-circle-check text-emerald-500"></i> 支持顶部分类横向滑动</div>
                <div class="flex items-center gap-1"><i class="fa-solid fa-circle-check text-emerald-500"></i> 支持页面真实上下滚动</div>
            </div>
        </div>
    </div>

    <!-- Right Column: The Premium iPhone 15 Pro Device Frame -->
    <div class="relative w-[393px] h-[852px] bg-white rounded-[55px] p-3 shadow-[0_25px_60px_-15px_rgba(144,95,255,0.22)] border-[12px] border-slate-900 flex flex-col overflow-hidden select-none select-none">
        
        <!-- Apple Dynamic Island (灵动岛) -->
        <div class="absolute top-3 left-1/2 -translate-x-1/2 w-[110px] h-[30px] bg-black rounded-full z-50 flex items-center justify-between px-3.5 text-[10px] text-white font-medium">
            <span class="text-white/90 scale-90 font-mono">9:41</span>
            <div class="w-3 h-3 bg-slate-900 rounded-full border border-white/10 flex items-center justify-center">
                <div class="w-1 h-1 bg-blue-500 rounded-full"></div>
            </div>
            <div class="flex items-center gap-1 opacity-90 scale-90">
                <i class="fa-solid fa-signal"></i>
                <i class="fa-solid fa-battery-three-quarters"></i>
            </div>
        </div>

        <!-- APP SCREENS CONTAINER (WHITE BACKGROUND AS REQUESTED) -->
        <div class="w-full h-full bg-white relative flex flex-col pt-9 pb-16 overflow-hidden">
            
            <!-- ================= PAGE 1: 首页 (HOME) ================= -->
            <div id="page-home" class="screen-view w-full h-full flex flex-col overflow-y-auto no-scrollbar bg-white">
                <!-- Header -->
                <div class="px-4 pt-4 pb-2 flex justify-between items-center bg-white/90 sticky top-0 z-30 backdrop-blur-md">
                    <h2 class="text-xl font-bold tracking-tight text-slate-900">知陌</h2>
                    <div class="flex items-center gap-3">
                        <button class="w-8 h-8 rounded-full bg-slate-50 border border-slate-100 flex items-center justify-center text-slate-600"><i class="fa-regular fa-bell text-sm"></i></button>
                        <button class="w-8 h-8 rounded-full bg-slate-50 border border-slate-100 flex items-center justify-center text-slate-600"><i class="fa-solid fa-magnifying-glass text-sm"></i></button>
                    </div>
                </div>

                <!-- Horizontal Scroll Categories -->
                <div class="flex gap-2.5 overflow-x-auto px-4 py-2 no-scrollbar bg-white shrink-0">
                    <span class="px-3.5 py-1.5 bg-[#905FFF] text-white text-xs font-medium rounded-full shadow-sm whitespace-nowrap">全部分享</span>
                    <span class="px-3.5 py-1.5 bg-slate-50 text-slate-600 text-xs font-medium rounded-full border border-slate-100 whitespace-nowrap">🍿 观影</span>
                    <span class="px-3.5 py-1.5 bg-slate-50 text-slate-600 text-xs font-medium rounded-full border border-slate-100 whitespace-nowrap">🎨 看展</span>
                    <span class="px-3.5 py-1.5 bg-slate-50 text-slate-600 text-xs font-medium rounded-full border border-slate-100 whitespace-nowrap">🍷 品鉴</span>
                    <span class="px-3.5 py-1.5 bg-slate-50 text-slate-600 text-xs font-medium rounded-full border border-slate-100 whitespace-nowrap">🍲 饭局</span>
                    <span class="px-3.5 py-1.5 bg-slate-50 text-slate-600 text-xs font-medium rounded-full border border-slate-100 whitespace-nowrap">🎵 音乐</span>
                    <span class="px-3.5 py-1.5 bg-slate-50 text-slate-600 text-xs font-medium rounded-full border border-slate-100 whitespace-nowrap">🚴 骑行</span>
                    <span class="px-3.5 py-1.5 bg-slate-50 text-slate-600 text-xs font-medium rounded-full border border-slate-100 whitespace-nowrap">🏕️ 户外</span>
                </div>

                <!-- Waterfall Content Flow (Two-column layout simulating masonry) -->
                <div class="grid grid-cols-2 gap-3 px-4 py-3">
                    <!-- Column 1 -->
                    <div class="flex flex-col gap-3">
                        <div class="bg-white rounded-2xl border border-slate-100 overflow-hidden shadow-sm">
                            <img src="https://images.unsplash.com/photo-1536924940846-227afb31e2a5?w=300&q=80" class="w-full object-cover h-44" alt="Exhibition">
                            <div class="p-2.5 bg-white">
                                <span class="text-[10px] bg-purple-50 text-[#905FFF] px-1.5 py-0.5 rounded font-medium">🎨 看展</span>
                                <h4 class="text-xs font-bold text-slate-800 mt-1 line-clamp-2">当代艺术私享展，寻找周末一起熏陶的艺术搭子</h4>
                                <div class="flex items-center justify-between mt-2 pt-2 border-t border-slate-50">
                                    <div class="flex items-center gap-1">
                                        <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&q=80" class="w-4 h-4 rounded-full" alt="Avatar">
                                        <span class="text-[10px] text-slate-500">Molly</span>
                                    </div>
                                    <span class="text-[10px] text-slate-400"><i class="fa-regular fa-heart"></i> 142</span>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white rounded-2xl border border-slate-100 overflow-hidden shadow-sm">
                            <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300&q=80" class="w-full object-cover h-36" alt="Food">
                            <div class="p-2.5 bg-white">
                                <span class="text-[10px] bg-amber-50 text-amber-600 px-1.5 py-0.5 rounded font-medium">🍷 品鉴</span>
                                <h4 class="text-xs font-bold text-slate-800 mt-1 line-clamp-2">黑珍珠法餐新菜私密评测局，限2位极度挑剔的饕餮！</h4>
                                <div class="flex items-center justify-between mt-2 pt-2 border-t border-slate-50">
                                    <div class="flex items-center gap-1">
                                        <div class="w-4 h-4 rounded-full bg-indigo-500 text-white text-[8px] flex items-center justify-center font-bold">J</div>
                                        <span class="text-[10px] text-slate-500">Jerry</span>
                                    </div>
                                    <span class="text-[10px] text-slate-400"><i class="fa-regular fa-heart"></i> 89</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Column 2 -->
                    <div class="flex flex-col gap-3">
                        <div class="bg-white rounded-2xl border border-slate-100 overflow-hidden shadow-sm">
                            <img src="https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=300&q=80" class="w-full object-cover h-32" alt="Cycling">
                            <div class="p-2.5 bg-white">
                                <span class="text-[10px] bg-emerald-50 text-emerald-600 px-1.5 py-0.5 rounded font-medium">🚴 骑行</span>
                                <h4 class="text-xs font-bold text-slate-800 mt-1 line-clamp-2">夜骑长安街！吹吹晚风，破风同行速来</h4>
                                <div class="flex items-center justify-between mt-2 pt-2 border-t border-slate-50">
                                    <div class="flex items-center gap-1">
                                        <div class="w-4 h-4 rounded-full bg-slate-200 flex items-center justify-center text-[8px] text-slate-700 font-bold">简</div>
                                        <span class="text-[10px] text-slate-500">简简单单</span>
                                    </div>
                                    <span class="text-[10px] text-[#905FFF]"><i class="fa-solid fa-heart"></i> 320</span>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white rounded-2xl border border-slate-100 overflow-hidden shadow-sm">
                            <img src="https://images.unsplash.com/photo-1501555088652-021faa106b9b?w=300&q=80" class="w-full object-cover h-48" alt="Outdoor">
                            <div class="p-2.5 bg-white">
                                <span class="text-[10px] bg-sky-50 text-sky-600 px-1.5 py-0.5 rounded font-medium">🏕️ 户外</span>
                                <h4 class="text-xs font-bold text-slate-800 mt-1 line-clamp-2">天幕、落日与不插电民谣。周六星空露营走起</h4>
                                <div class="flex items-center justify-between mt-2 pt-2 border-t border-slate-50">
                                    <div class="flex items-center gap-1">
                                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&q=80" class="w-4 h-4 rounded-full" alt="Avatar">
                                        <span class="text-[10px] text-slate-500">阿木</span>
                                    </div>
                                    <span class="text-[10px] text-slate-400"><i class="fa-regular fa-heart"></i> 215</span>
                                end</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= PAGE 2: 找搭子 (FIND BUDDIES) ================= -->
            <div id="page-buddies" class="screen-view w-full h-full hidden flex flex-col overflow-y-auto no-scrollbar bg-white">
                <!-- Filter Header -->
                <div class="px-4 pt-4 pb-2 bg-white sticky top-0 z-30 border-b border-slate-50">
                    <div class="flex items-center justify-between mb-3">
                        <h2 class="text-xl font-bold tracking-tight text-slate-900">找搭子</h2>
                        <span class="text-xs text-[#905FFF] font-medium bg-purple-50 px-2.5 py-1 rounded-lg"><i class="fa-solid fa-location-arrow"></i> 上海 · 静安</span>
                    </div>
                    <!-- Filters Grid -->
                    <div class="grid grid-cols-3 gap-2 text-xs text-center">
                        <button class="py-2 bg-purple-50 text-[#905FFF] font-semibold rounded-xl flex items-center justify-center gap-1">按距离 <i class="fa-solid fa-chevron-down text-[10px]"></i></button>
                        <button class="py-2 bg-slate-50 text-slate-600 font-medium rounded-xl flex items-center justify-center gap-1">按时间 <i class="fa-solid fa-chevron-down text-[10px]"></i></button>
                        <button class="py-2 bg-slate-50 text-slate-600 font-medium rounded-xl flex items-center justify-center gap-1">按热度 <i class="fa-solid fa-chevron-down text-[10px]"></i></button>
                    </div>
                </div>

                <!-- Interactive Activity Cards -->
                <div class="p-4 space-y-4">
                    <!-- Card 1 -->
                    <div class="bg-white rounded-2xl border border-purple-100 p-4 shadow-premium relative overflow-hidden">
                        <div class="absolute top-0 right-0 bg-gradient-to-l from-[#905FFF] to-purple-500 text-white text-[9px] px-2.5 py-1 rounded-bl-xl font-medium tracking-wide">即将满员</div>
                        <div class="flex items-center gap-2 mb-2.5">
                            <span class="px-2 py-0.5 bg-purple-100 text-[#905FFF] text-[10px] font-bold rounded-md">🎾 球类搭子</span>
                            <span class="text-slate-400 text-[11px]"><i class="fa-solid fa-location-dot"></i> 1.2km</span>
                        </div>
                        <h3 class="text-sm font-bold text-slate-900 mb-1.5">有无有氧上网网球搭子？今晚7点静安体育中心</h3>
                        <p class="text-xs text-slate-500 line-clamp-2 mb-3">目前已有2人，都是友好型小白。希望再来1-2个水平相近的小伙伴一同快乐拉开，AA场地费。</p>
                        
                        <div class="flex items-center justify-between pt-2.5 border-t border-slate-100">
                            <div class="flex -space-x-1.5">
                                <img class="w-5 h-5 rounded-full border border-white" src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=50&q=80" alt="avatar">
                                <img class="w-5 h-5 rounded-full border border-white" src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=50&q=80" alt="avatar">
                                <div class="w-5 h-5 rounded-full border border-white bg-slate-100 flex items-center justify-center text-[8px] text-slate-500 font-bold">+1</div>
                            </div>
                            <button class="px-4 py-1.5 bg-gradient-to-r from-[#905FFF] to-purple-500 text-white text-xs font-semibold rounded-xl shadow-sm hover:opacity-95" onclick="alert('申请成功！已向主发起人发送同频信号')">立即申请</button>
                        </div>
                    </div>

                    <!-- Card 2 -->
                    <div class="bg-white rounded-2xl border border-slate-100 p-4 shadow-sm relative">
                        <div class="flex items-center gap-2 mb-2.5">
                            <span class="px-2 py-0.5 bg-amber-50 text-amber-600 text-[10px] font-bold rounded-md">☕️ 探店品鉴</span>
                            <span class="text-slate-400 text-[11px]"><i class="fa-solid fa-location-dot"></i> 2.8km</span>
                        </div>
                        <h3 class="text-sm font-bold text-slate-900 mb-1.5">新晋网红黑胶咖啡厅打卡，找个会拍照的小姐姐</h3>
                        <p class="text-xs text-slate-500 line-clamp-2 mb-3">买到了珍藏版黑胶，准备下午去叹咖啡聊天。本人带专业微单，出片率极高！</p>
                        
                        <div class="flex items-center justify-between pt-2.5 border-t border-slate-100">
                            <div class="flex -space-x-1.5">
                                <img class="w-5 h-5 rounded-full border border-white" src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=50&q=80" alt="avatar">
                            </div>
                            <button class="px-4 py-1.5 bg-gradient-to-r from-[#905FFF] to-purple-500 text-white text-xs font-semibold rounded-xl shadow-sm" onclick="alert('申请成功！已向主发起人发送同频信号')">立即申请</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= PAGE 3: 发现 (DISCOVER) ================= -->
            <div id="page-discover" class="screen-view w-full h-full hidden flex flex-col overflow-y-auto no-scrollbar bg-white">
                <!-- Title Header -->
                <div class="px-4 pt-4 pb-2 bg-white sticky top-0 z-30">
                    <h2 class="text-xl font-bold tracking-tight text-slate-900">发现</h2>
                    <p class="text-[11px] text-slate-400 mt-0.5">寻找高分同频搭子的反馈实录 😊</p>
                </div>

                <!-- Feed Cards (Instagram style with ratings and smiles) -->
                <div class="px-4 py-2 space-y-4">
                    <!-- Feed 1 -->
                    <div class="bg-white rounded-2xl border border-slate-100 overflow-hidden shadow-sm">
                        <!-- User Header -->
                        <div class="p-3 flex items-center justify-between">
                            <div class="flex items-center gap-2">
                                <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&q=80" class="w-6 h-6 rounded-full" alt="User">
                                <span class="text-xs font-bold text-slate-800">林糖糖 ✨</span>
                            </div>
                            <div class="flex items-center text-amber-400 text-[10px] gap-0.5 bg-amber-50 px-2 py-0.5 rounded-full">
                                <i class="fa-solid fa-star"></i> 5.0 <span class="text-slate-400 text-[9px]">(完美搭子)</span>
                            </div>
                        </div>
                        <!-- Main Image -->
                        <div class="relative">
                            <img src="https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=400&q=80" class="w-full h-44 object-cover" alt="Cinema Feed">
                            <div class="absolute bottom-2 right-2 bg-black/50 backdrop-blur-md text-white text-[10px] px-2 py-0.5 rounded-md font-mono">1/3</div>
                        </div>
                        <!-- Description & Smile Panel -->
                        <div class="p-3">
                            <h3 class="text-xs font-bold text-slate-900 mb-1 flex items-center gap-1">
                                昨晚和电影搭子看完首映啦！ 😊 超级合拍
                            </h3>
                            <p class="text-[11px] text-slate-500 leading-relaxed mb-2.5">
                                在知陌上找的第一个看电影搭子，对导演风格的理解神同步！全网零代沟，观影全程无手机亮光，极度舒适！
                            </p>
                            <!-- Interaction metrics -->
                            <div class="flex items-center justify-between text-[11px] text-slate-400 border-t border-slate-50 pt-2.5">
                                <span class="text-[#905FFF] bg-purple-50 px-2 py-0.5 rounded text-[10px] font-medium">🍿 电影局回馈</span>
                                <div class="flex items-center gap-3">
                                    <span><i class="fa-regular fa-heart"></i> 1,402</span>
                                    <span><i class="fa-regular fa-comment"></i> 58</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Feed 2 -->
                    <div class="bg-white rounded-2xl border border-slate-100 overflow-hidden shadow-sm">
                        <div class="p-3 flex items-center justify-between">
                            <div class="flex items-center gap-2">
                                <div class="w-6 h-6 rounded-full bg-gradient-to-tr from-[#905FFF] to-pink-500 text-white text-[10px] flex items-center justify-center font-bold">K</div>
                                <span class="text-xs font-bold text-slate-800">Kevin 大大</span>
                            </div>
                            <div class="flex items-center text-amber-400 text-[10px] gap-0.5 bg-amber-50 px-2 py-0.5 rounded-full">
                                <i class="fa-solid fa-star"></i> 4.9 <span class="text-slate-400 text-[9px]">(超赞)</span>
                            </div>
                        </div>
                        <div class="p-3 pt-0">
                            <h3 class="text-xs font-bold text-slate-900 mb-1 flex items-center gap-1">
                                沉浸式飞盘新体验，暴汗局完满结束 😊🦾
                            </h3>
                            <p class="text-[11px] text-slate-500 leading-relaxed mb-2.5">
                                吹爆我们这次闪搭出的飞盘局！匹配到的大家体能组织力都在线，完全没有尴尬期，给社区环境点赞！评分必须拉满！
                            </p>
                            <div class="flex items-center justify-between text-[11px] text-slate-400 border-t border-slate-50 pt-2.5">
                                <span class="text-emerald-600 bg-emerald-50 px-2 py-0.5 rounded text-[10px] font-medium">🥏 健身飞盘</span>
                                <div class="flex items-center gap-3">
                                    <span><i class="fa-regular fa-heart"></i> 753</span>
                                    <span><i class="fa-regular fa-comment"></i> 24</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= PAGE 4: 我的 (ME / PROFILE) ================= -->
            <div id="page-profile" class="screen-view w-full h-full hidden flex flex-col overflow-y-auto no-scrollbar bg-white">
                <!-- User Profile Header -->
                <div class="p-4 bg-white relative">
                    <!-- Top Actions Bar -->
                    <div class="flex justify-between items-center mb-4">
                        <span class="text-xs bg-slate-100 text-slate-600 px-2.5 py-1 rounded-full font-medium">UID: 9051024</span>
                        <!-- Settings Icon Button -->
                        <button class="w-7 h-7 rounded-full bg-slate-50 flex items-center justify-center text-slate-600 border border-slate-100 hover:text-[#905FFF]" onclick="alert('进入系统级设置中心')">
                            <i class="fa-solid fa-gear text-sm"></i>
                        </button>
                    </div>

                    <!-- Profile Info Area -->
                    <div class="flex items-start justify-between">
                        <div class="flex items-center gap-3">
                            <div class="relative">
                                <div class="w-16 h-16 rounded-full ring-2 ring-purple-100 overflow-hidden bg-slate-100">
                                    <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&q=80" class="w-full h-full object-cover" alt="User Head">
                                </div>
                                <div class="absolute -bottom-1 -right-1 bg-[#905FFF] text-white text-[8px] w-5 h-5 rounded-full flex items-center justify-center border-2 border-white"><i class="fa-solid fa-v"></i></div>
                            </div>
                            <div>
                                <h2 class="text-base font-bold text-slate-900 flex items-center gap-1.5">
                                    简简单单 
                                </h2>
                                <p class="text-[11px] text-slate-400 mt-0.5">生活本该如此，搭子常伴左右。</p>
                            </div>
                        </div>
                        <!-- Edit Button -->
                        <button class="px-2.5 py-1 border border-slate-200 text-slate-600 text-[10px] font-medium rounded-lg hover:border-[#905FFF] hover:text-[#905FFF]" onclick="alert('唤起修改资料模态窗')">编辑资料</button>
                    </div>

                    <!-- Counter Metrics Bar -->
                    <div class="grid grid-cols-4 gap-2 bg-slate-50/70 border border-slate-100 rounded-xl p-3 mt-4 text-center">
                        <div>
                            <div class="text-sm font-bold text-slate-900 font-mono">1.2k</div>
                            <div class="text-[10px] text-slate-400">粉丝</div>
                        </div>
                        <div>
                            <div class="text-sm font-bold text-slate-900 font-mono">3.4k</div>
                            <div class="text-[10px] text-slate-400">获赞</div>
                        </div>
                        <div>
                            <div class="text-sm font-bold text-slate-900 font-mono">248</div>
                            <div class="text-[10px] text-slate-400">收藏夹</div>
                        </div>
                        <div>
                            <div class="text-sm font-bold text-slate-900 font-mono">189</div>
                            <div class="text-[10px] text-slate-400">关注</div>
                        </div>
                    </div>
                </div>

                <!-- Toggle Segment Indicator -->
                <div class="flex border-b border-slate-100 text-xs px-4 bg-white sticky top-0 z-10">
                    <button class="flex-1 py-3 text-center border-b-2 border-[#905FFF] text-[#905FFF] font-bold">发布活动轴</button>
                    <button class="flex-1 py-3 text-center text-slate-400 font-medium">参与活动轴</button>
                </div>

                <!-- Timeline Feed Section -->
                <div class="p-4 space-y-4">
                    <div class="relative pl-5 border-l-2 border-purple-100 space-y-5 py-2">
                        <!-- Item 1 -->
                        <div class="relative">
                            <!-- Bullet -->
                            <div class="absolute -left-[25px] top-1 w-2 h-2 rounded-full bg-[#905FFF] ring-4 ring-purple-50"></div>
                            <span class="text-[10px] font-mono text-slate-400">2026-05-12</span>
                            <div class="mt-1 bg-slate-50 p-2.5 rounded-xl border border-slate-100">
                                <h4 class="text-xs font-bold text-slate-800">🚴 发起了「夜骑长安街！吹吹晚风破风同行」</h4>
                                <p class="text-[10px] text-slate-400 mt-1"><i class="fa-solid fa-circle-check text-emerald-500"></i> 已组局成功 · 4人同行</p>
                            </div>
                        </div>
                        <!-- Item 2 -->
                        <div class="relative">
                            <!-- Bullet -->
                            <div class="absolute -left-[25px] top-1 w-2 h-2 rounded-full bg-slate-300 ring-4 ring-slate-100"></div>
                            <span class="text-[10px] font-mono text-slate-400">2026-04-28</span>
                            <div class="mt-1 bg-slate-50 p-2.5 rounded-xl border border-slate-100">
                                <h4 class="text-xs font-bold text-slate-700">🍿 发起了「周日独家科幻电影IMAX午后局」</h4>
                                <p class="text-[10px] text-slate-400 mt-1">已结束行程</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= NEW COMPLEMENTED MODAL VIEW: 发起活动 (PUBLISH OVERLAY DRAWERS) ================= -->
            <div id="modal-publish" class="absolute bottom-0 left-0 w-full h-[85%] bg-white rounded-t-[32px] shadow-[0_-15px_40px_rgba(144,95,255,0.18)] border-t border-purple-50 z-50 transform translate-y-full transition-transform duration-300 ease-out flex flex-col overflow-hidden">
                <!-- Modal Bar Indicator -->
                <div class="w-12 h-1 bg-slate-200 rounded-full mx-auto my-3 shrink-0 cursor-pointer" onclick="togglePublishModal(false)"></div>
                
                <!-- Modal Title Block -->
                <div class="px-4 pb-2 flex justify-between items-center shrink-0">
                    <button class="text-slate-400 text-xs" onclick="togglePublishModal(false)">取消</button>
                    <h3 class="text-sm font-bold text-slate-900">发起全新搭子局</h3>
                    <button class="text-[#905FFF] text-xs font-bold" onclick="alert('已存入草稿箱')">存草稿</button>
                </div>

                <!-- Scrollable Fields Form -->
                <div class="flex-1 overflow-y-auto px-4 py-2 space-y-4 pb-20 no-scrollbar">
                    <!-- Media Upload Card Block -->
                    <div class="w-full h-32 rounded-2xl border-2 border-dashed border-purple-200 bg-purple-50/30 flex flex-col items-center justify-center text-center gap-1.5 cursor-pointer hover:bg-purple-50/60 transition-colors" onclick="alert('调用手机相册选图权限')">
                        <i class="fa-solid fa-circle-plus text-[#905FFF] text-xl"></i>
                        <span class="text-[11px] font-medium text-[#905FFF]">上传好看的活动头图/视频</span>
                        <span class="text-[9px] text-slate-400">高品质底图能吸引更多高颜同频伙伴哦</span>
                    </div>

                    <!-- Borderless Free Text Input Area -->
                    <div class="space-y-1">
                        <input type="text" placeholder="给你的局起个响亮的标题..." class="w-full text-base font-bold text-slate-900 placeholder-slate-300 border-none outline-none focus:ring-0">
                        <textarea placeholder="描述一下你完美的搭子活动愿景，比如大致流程、聚会小亮点、对搭子的特定需求等..." class="w-full h-16 text-xs text-slate-600 placeholder-slate-400 border-none outline-none focus:ring-0 resize-none leading-relaxed"></textarea>
                    </div>

                    <!-- Horizontal Categorized Capsules Selection -->
                    <div>
                        <label class="text-[11px] font-bold text-slate-400 block mb-1.5">选择契合的活动类目</label>
                        <div class="flex gap-2 overflow-x-auto no-scrollbar py-0.5">
                            <span class="px-3 py-1 bg-gradient-to-r from-[#905FFF] to-purple-600 text-white text-xs rounded-full font-medium whitespace-nowrap">🎾 球类网球</span>
                            <span class="px-3 py-1 bg-slate-50 text-slate-600 border border-slate-100 text-xs rounded-full whitespace-nowrap">☕️ 咖啡探店</span>
                            <span class="px-3 py-1 bg-slate-50 text-slate-600 border border-slate-100 text-xs rounded-full whitespace-nowrap">🎬 院线观影</span>
                            <span class="px-3 py-1 bg-slate-50 text-slate-600 border border-slate-100 text-xs rounded-full whitespace-nowrap">🏕️ 露营户外</span>
                            <span class="px-3 py-1 bg-slate-50 text-slate-600 border border-slate-100 text-xs rounded-full whitespace-nowrap">🎮 剧本桌游</span>
                        </div>
                    </div>

                    <!-- Modular Card Group Setup -->
                    <div class="bg-slate-50 rounded-2xl border border-slate-100 overflow-hidden divide-y divide-slate-100/60">
                        <!-- Row 1: Time -->
                        <div class="p-3 flex items-center justify-between text-xs" onclick="alert('唤起系统滚轮时间选择组件')">
                            <div class="flex items-center gap-2 text-slate-700 font-medium">
                                <div class="w-5 h-5 rounded bg-white flex items-center justify-center text-[#905FFF] shadow-sm"><i class="fa-regular fa-calendar text-[10px]"></i></div>
                                <span>期望活动时间</span>
                            </div>
                            <span class="text-slate-800 font-semibold flex items-center gap-1">今天 19:00 <i class="fa-solid fa-angle-right text-slate-300 text-[10px]"></i></span>
                        </div>
                        <!-- Row 2: Location -->
                        <div class="p-3 flex items-center justify-between text-xs" onclick="alert('调起高德/谷歌地图选点')">
                            <div class="flex items-center gap-2 text-slate-700 font-medium">
                                <div class="w-5 h-5 rounded bg-white flex items-center justify-center text-[#905FFF] shadow-sm"><i class="fa-solid fa-location-dot text-[10px]"></i></div>
                                <span>集合详细地点</span>
                            </div>
                            <span class="text-slate-400 flex items-center gap-1">请选择定位首位 <i class="fa-solid fa-angle-right text-slate-300 text-[10px]"></i></span>
                        </div>
                        <!-- Row 3: Members Count -->
                        <div class="p-3 flex items-center justify-between text-xs">
                            <div class="flex items-center gap-2 text-slate-700 font-medium">
                                <div class="w-5 h-5 rounded bg-white flex items-center justify-center text-[#905FFF] shadow-sm"><i class="fa-solid fa-user-group text-[10px]"></i></div>
                                <span>期望人数上限</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <button class="w-5 h-5 bg-white border border-slate-200 rounded text-slate-500 font-bold flex items-center justify-center">-</button>
                                <span class="font-bold text-slate-800">4 人</span>
                                <button class="w-5 h-5 bg-white border border-slate-200 rounded text-slate-500 font-bold flex items-center justify-center">+</button>
                            </div>
                        </div>
                        <!-- Row 4: Pricing Mode -->
                        <div class="p-3 flex items-center justify-between text-xs">
                            <div class="flex items-center gap-2 text-slate-700 font-medium">
                                <div class="w-5 h-5 rounded bg-white flex items-center justify-center text-[#905FFF] shadow-sm"><i class="fa-solid fa-wallet text-[10px]"></i></div>
                                <span>费用分摊机制</span>
                            </div>
                            <div class="flex gap-1.5">
                                <span class="px-2 py-0.5 bg-purple-100 text-[#905FFF] font-bold rounded text-[10px]">AA制</span>
                                <span class="px-2 py-0.5 bg-white text-slate-400 rounded text-[10px] border border-slate-200">主邀请客</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Form Bottom Action Button (Fixed inside drawer) -->
                <div class="absolute bottom-0 left-0 w-full p-3 bg-gradient-to-t from-white via-white to-white/80 border-t border-slate-50">
                    <button class="w-full py-3 bg-gradient-to-r from-[#905FFF] to-[#7C3AED] text-white font-bold text-xs rounded-xl shadow-glow" onclick="executePublishMockSubmit()">确认安全发布 · 搜寻同频搭子</button>
                </div>
            </div>

            <!-- ================= GLOBAL FIXED FIVE-ITEM BOTTOM NAV BAR ================= -->
            <div class="absolute bottom-0 left-0 w-full h-[62px] bg-white/95 border-t border-slate-100 px-2 flex items-center justify-between z-40 backdrop-blur-md">
                <!-- Nav 1: Home -->
                <button onclick="switchTab('home', this)" class="nav-btn flex-1 flex flex-col items-center justify-center gap-0.5 text-[#905FFF]">
                    <i class="fa-solid fa-compass text-base"></i>
                    <span class="text-[9px] font-bold">首页</span>
                </button>
                <!-- Nav 2: Buddies -->
                <button onclick="switchTab('buddies', this)" class="nav-btn flex-1 flex flex-col items-center justify-center gap-0.5 text-slate-400 hover:text-slate-600">
                    <i class="fa-solid fa-user-group text-base"></i>
                    <span class="text-[9px] font-medium">找搭子</span>
                </button>
                
                <!-- Nav 3: CENTRAL DYNAMIC PUBLISH ACTION KEY (NEWLY ADDED & COMPLEMENTED) -->
                <div class="flex-1 flex justify-center relative -top-3">
                    <button onclick="togglePublishModal(true)" class="w-12 h-12 bg-gradient-to-tr from-[#905FFF] to-[#7C3AED] rounded-full flex items-center justify-center text-white text-lg shadow-[0_6px_16px_rgba(144,95,255,0.45)] transform hover:scale-105 active:scale-95 transition-all">
                        <i class="fa-solid fa-plus transition-transform duration-200" id="center-plus-icon"></i>
                    </button>
                </div>

                <!-- Nav 4: Discover -->
                <button onclick="switchTab('discover', this)" class="nav-btn flex-1 flex flex-col items-center justify-center gap-0.5 text-slate-400 hover:text-slate-600">
                    <i class="fa-solid fa-heart-pulse text-base"></i>
                    <span class="text-[9px] font-medium">发现</span>
                </button>
                <!-- Nav 5: Me -->
                <button onclick="switchTab('profile', this)" class="nav-btn flex-1 flex flex-col items-center justify-center gap-0.5 text-slate-400 hover:text-slate-600">
                    <i class="fa-regular fa-user text-base"></i>
                    <span class="text-[9px] font-medium">我的</span>
                </button>
            </div>

            <!-- Virtual iOS Bottom Bar Strip Indicator -->
            <div class="absolute bottom-1 left-1/2 -translate-x-1/2 w-[120px] h-[4px] bg-slate-900 rounded-full z-50"></div>
        </div>
    </div>

    <!-- Embedded High-Fidelity Prototype Core Logic Script -->
    <script>
        // Tab switching machine logic
        function switchTab(targetTabId, element) {
            // Close publish overlay just in case it's open
            togglePublishModal(false);

            // Hide all views
            document.querySelectorAll('.screen-view').forEach(view => {
                view.classList.add('hidden');
            });

            // Show target view
            const activePage = document.getElementById(`page-${targetTabId}`);
            if (activePage) {
                activePage.classList.remove('hidden');
            }

            // Reset all navigation states classes
            document.querySelectorAll('.nav-btn').forEach(btn => {
                btn.classList.remove('text-[#905FFF]', 'font-bold');
                btn.classList.add('text-slate-400', 'font-medium');
                
                // Toggle strong icon family tags
                const icon = btn.querySelector('i');
                if(icon.classList.contains('fa-solid') && btn !== element) {
                    // Turn active solid into light regular if necessary (except compass/user-group which are structural)
                    if(icon.classList.contains('fa-user')) {
                        icon.classList.remove('fa-solid');
                        icon.classList.add('fa-regular');
                    }
                }
            </script>
            
            // Highlight selected tab
            if(element) {
                element.classList.remove('text-slate-400', 'font-medium');
                element.classList.add('text-[#905FFF]', 'font-bold');
                const activeIcon = element.querySelector('i');
                if(activeIcon.classList.contains('fa-regular')) {
                    activeIcon.classList.remove('fa-regular');
                    activeIcon.classList.add('fa-solid');
                }
            }
        }

        // Toggle Complemented Publish Bottom Modal Panel Drawer
        function togglePublishModal(show) {
            const modal = document.getElementById('modal-publish');
            const icon = document.getElementById('center-plus-icon');
            
            if (show) {
                modal.classList.remove('translate-y-full');
                icon.classList.add('rotate-45');
            } else {
                modal.classList.add('translate-y-full');
                icon.classList.remove('rotate-45');
            }
        }

        // Mock Submission Pipeline
        function executePublishMockSubmit() {
            alert('🎉 组局发布成功！知陌同频算法已接入，正在向周边3公里内的精准运动/探店圈层推流推送！');
            togglePublishModal(false);
            // Auto switch to Find Buddies screen to see list
            switchTab('buddies', document.querySelectorAll('.nav-btn')[1]);
        }
    </script>
</body>
</html>

# tanxin
# zhimo
# zhimotest
