<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Starbucks App – Bài Tập Dart</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@300;400;500;600&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
  :root {
    --bg: #0a1a0f;
    --surface: #0f2318;
    --card: #142b1e;
    --card2: #1a3326;
    --border: #1e3d2a;
    --sbux: #00704A;
    --sbux2: #00a862;
    --gold: #CBA258;
    --gold2: #f0c97a;
    --cream: #F2EDD7;
    --red: #e74c3c;
    --blue: #3498db;
    --text: #e8f0eb;
    --muted: #5a7a64;
    --code-bg: #060e09;
  }

* { margin: 0; padding: 0; box-sizing: border-box; }
  body {
  font-family: 'DM Sans', sans-serif;
  background: var(--bg);
  color: var(--text);
  min-height: 100vh;
  }

/* HEADER */
header {
position: relative;
overflow: hidden;
padding: 56px 32px 48px;
text-align: center;
background: radial-gradient(ellipse 80% 60% at 50% -10%, rgba(0,168,98,.25) 0%, transparent 70%),
linear-gradient(180deg, #061410 0%, #0a1a0f 100%);
border-bottom: 1px solid var(--border);
}
header::before {
content: '';
position: absolute; inset: 0;
background-image: repeating-linear-gradient(
0deg, transparent, transparent 39px, rgba(0,112,74,.06) 40px),
repeating-linear-gradient(
90deg, transparent, transparent 39px, rgba(0,112,74,.06) 40px);
pointer-events: none;
}
.sbux-logo {
font-size: 52px;
margin-bottom: 12px;
display: block;
filter: drop-shadow(0 0 20px rgba(0,168,98,.5));
}
header h1 {
font-family: 'Playfair Display', serif;
font-size: clamp(28px, 5vw, 52px);
font-weight: 900;
color: var(--cream);
letter-spacing: -1px;
line-height: 1.1;
}
header h1 em { color: var(--sbux2); font-style: normal; }
header p {
margin-top: 12px;
color: var(--muted);
font-size: 14px;
letter-spacing: 1px;
text-transform: uppercase;
}
.header-pills {
display: flex; gap: 10px; justify-content: center; flex-wrap: wrap;
margin-top: 20px;
}
.pill {
font-family: 'DM Mono', monospace;
font-size: 11px;
padding: 4px 14px;
border-radius: 20px;
border: 1px solid;
}
.pill-g { border-color: rgba(0,168,98,.4); color: var(--sbux2); background: rgba(0,168,98,.08); }
.pill-y { border-color: rgba(203,162,88,.4); color: var(--gold2); background: rgba(203,162,88,.08); }

/* LAYOUT */
.wrap { max-width: 980px; margin: 0 auto; padding: 48px 20px; }

/* SECTION */
.section {
margin-bottom: 44px;
border-radius: 20px;
overflow: hidden;
border: 1px solid var(--border);
animation: rise .5s ease both;
}
.section:nth-child(1){ animation-delay:.05s }
.section:nth-child(2){ animation-delay:.1s }
.section:nth-child(3){ animation-delay:.15s }
.section:nth-child(4){ animation-delay:.2s }
.section:nth-child(5){ animation-delay:.25s }
@keyframes rise {
from { opacity:0; transform:translateY(24px); }
to   { opacity:1; transform:translateY(0); }
}

.sec-head {
display: flex; align-items: center; gap: 16px;
padding: 22px 28px;
background: var(--card);
border-bottom: 1px solid var(--border);
}
.num {
width: 40px; height: 40px; border-radius: 12px;
display: flex; align-items: center; justify-content: center;
font-family: 'DM Mono', monospace; font-size: 14px; font-weight: 500;
flex-shrink: 0;
}
.n1 { background: rgba(0,168,98,.12); color: var(--sbux2); border: 1px solid rgba(0,168,98,.25); }
.n2 { background: rgba(203,162,88,.12); color: var(--gold2); border: 1px solid rgba(203,162,88,.25); }
.n3 { background: rgba(52,152,219,.12); color: #74b9e8; border: 1px solid rgba(52,152,219,.25); }
.n4 { background: rgba(231,76,60,.12); color: #f1948a; border: 1px solid rgba(231,76,60,.25); }
.n5 { background: rgba(155,89,182,.12); color: #c39bd3; border: 1px solid rgba(155,89,182,.25); }

.sec-title { font-size: 17px; font-weight: 600; color: var(--cream); }
.sec-title small { display: block; font-size: 12px; color: var(--muted); font-weight: 400; margin-top: 3px; }

.sec-body { padding: 28px; background: var(--surface); }

/* CODE */
pre {
background: var(--code-bg);
border: 1px solid var(--border);
border-radius: 12px;
padding: 20px 22px;
font-family: 'DM Mono', monospace;
font-size: 12.5px;
line-height: 1.8;
overflow-x: auto;
tab-size: 2;
}
.kw  { color: #7ec8a0; }
.cls { color: #f0c97a; }
.fn  { color: #74b9e8; }
.str { color: #a8d8a8; }
.cmt { color: #3d6b4f; font-style: italic; }
.num { color: var(--sbux2); }
.sym { color: var(--gold2); }

/* THEORY CARDS */
.theory-grid { display: grid; gap: 14px; }
.tc {
background: var(--card);
border: 1px solid var(--border);
border-radius: 14px;
padding: 20px 22px;
}
.tc h3 {
font-size: 11px; font-weight: 600; letter-spacing: 1.5px;
text-transform: uppercase; margin-bottom: 12px;
}
.tc p, .tc li { font-size: 13.5px; color: #8fb89a; line-height: 1.85; }
.tc ul { padding-left: 18px; }
.tc li { margin-bottom: 5px; }
.tc.pro li::marker { color: var(--sbux2); }
.tc.con li::marker { color: var(--red); }

.two { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
@media(max-width:600px){ .two { grid-template-columns: 1fr; } }

/* OUTPUT */
.output {
margin-top: 16px;
background: #030807;
border: 1px solid #0f2318;
border-radius: 12px;
padding: 18px 20px;
font-family: 'DM Mono', monospace;
font-size: 12px;
line-height: 2;
}
.out-head { color: var(--cream); font-weight: 500; margin-bottom: 4px; }
.out-ok   { color: var(--sbux2); }
.out-err  { color: var(--red); }
.out-lbl  { color: var(--gold2); }
.out-dim  { color: var(--muted); }
.out-star { color: var(--gold); }

/* CRUD BADGES */
.crud-row { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 16px; }
.badge {
font-family: 'DM Mono', monospace; font-size: 11px; font-weight: 500;
padding: 4px 14px; border-radius: 8px; border: 1px solid;
}
.bc { background:rgba(0,168,98,.1); color:var(--sbux2); border-color:rgba(0,168,98,.25); }
.br { background:rgba(52,152,219,.1); color:#74b9e8; border-color:rgba(52,152,219,.25); }
.bu { background:rgba(203,162,88,.1); color:var(--gold2); border-color:rgba(203,162,88,.25); }
.bd { background:rgba(231,76,60,.1); color:#f1948a; border-color:rgba(231,76,60,.25); }

/* DRINK CARDS (câu 3 visual) */
.drink-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px,1fr)); gap: 12px; margin-bottom: 20px; }
.drink-card {
background: var(--card2);
border: 1px solid var(--border);
border-radius: 14px;
padding: 16px;
display: flex; align-items: center; gap: 12px;
}
.drink-emoji { font-size: 28px; }
.drink-info { flex: 1; min-width: 0; }
.drink-name { font-size: 13px; font-weight: 600; color: var(--cream); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.drink-cat { font-size: 11px; color: var(--muted); margin-top: 2px; }
.drink-price { font-family: 'DM Mono', monospace; font-size: 14px; color: var(--gold2); font-weight: 500; white-space: nowrap; }

/* STEPS */
.steps { counter-reset: s; }
.step { display: flex; gap: 14px; margin-bottom: 14px; align-items: flex-start; }
.step::before {
counter-increment: s; content: counter(s);
width: 28px; height: 28px; min-width: 28px;
background: rgba(155,89,182,.12); border: 1px solid rgba(155,89,182,.25);
color: #c39bd3; border-radius: 50%;
display: flex; align-items: center; justify-content: center;
font-size: 12px; font-family: 'DM Mono', monospace;
}
.step p { font-size: 13.5px; color: #8fb89a; padding-top: 4px; line-height: 1.7; }
.step code {
background: rgba(255,255,255,.06); padding: 1px 6px; border-radius: 5px;
font-family: 'DM Mono', monospace; font-size: 12px; color: var(--gold2);
}

footer {
text-align: center; padding: 32px; color: var(--muted);
font-size: 13px; border-top: 1px solid var(--border);
}
footer span { color: var(--sbux2); }
</style>
</head>
<body>

<header>
  <span class="sbux-logo">☕</span>
  <h1>Starbucks App<br><em>Bài Tập Dart</em></h1>
  <p>Flutter · OOP · Static · Generics · CRUD</p>
  <div class="header-pills">
    <span class="pill pill-g">Câu 1 — Static</span>
    <span class="pill pill-y">Câu 2 — Generics</span>
    <span class="pill pill-g">Câu 3 — Drink.dart</span>
    <span class="pill pill-y">Câu 4 — ListDrink CRUD</span>
    <span class="pill pill-g">Câu 5 — GitHub</span>
  </div>
</header>

<div class="wrap">

  <!-- CÂU 1 -->
  <div class="section">
    <div class="sec-head">
      <div class="num n1">01</div>
      <div class="sec-title">
        Từ khóa <code style="color:var(--sbux2);font-family:'DM Mono',monospace">static</code> trong Dart
        <small>Áp dụng vào Starbucks App · 300+ từ</small>
      </div>
    </div>
    <div class="sec-body">
      <div class="theory-grid">

        <div class="tc">
          <h3 style="color:var(--sbux2)">🌿 Static là gì?</h3>
          <p>Từ khóa <b style="color:var(--sbux2)">static</b> gắn biến hoặc phương thức vào <b>class</b>, không phải từng <b>instance (object)</b>. Biến static được chia sẻ chung cho tất cả instance và chỉ <b>cấp phát bộ nhớ 1 lần duy nhất</b> trong toàn bộ vòng đời app.</p>
          <br>
          <p>Ứng dụng vào Starbucks: nếu không dùng static, mỗi màn hình (Menu, Cart, Order) phải tự nhận dữ liệu <code style="color:var(--gold2)">drinkNames</code> qua tham số. Với static, <code style="color:var(--gold2)">DrinkData.names</code> khả dụng mọi nơi — không cần truyền tay.</p>
        </div>

        <div class="tc">
          <h3 style="color:var(--sbux2)">🔧 Cách sử dụng</h3>
          <pre><span class="kw">class</span> <span class="cls">DrinkData</span> {
<span class="cmt">// Biến static — dùng chung toàn app</span>
<span class="kw">static</span> <span class="cls">List</span>&lt;<span class="cls">String</span>&gt; names = [
<span class="str">'Caramel Frappuccino'</span>,
<span class="str">'Cold Brew'</span>, ...
];

<span class="cmt">// Hằng static</span>
<span class="kw">static const</span> <span class="cls">String</span> store = <span class="str">'Starbucks VN'</span>;

<span class="cmt">// Phương thức static</span>
<span class="kw">static</span> <span class="cls">Drink</span>? <span class="fn">findById</span>(<span class="cls">String</span> id) { ... }
}

<span class="cmt">// Gọi — KHÔNG cần new DrinkData()</span>
<span class="fn">print</span>(<span class="cls">DrinkData</span>.names);
<span class="fn">print</span>(<span class="cls">DrinkData</span>.store);
<span class="cls">DrinkData</span>.<span class="fn">findById</span>(<span class="str">'D001'</span>);</pre>
</div>

        <div class="two">
          <div class="tc pro">
            <h3 style="color:var(--sbux2)">✅ Ưu điểm</h3>
            <ul>
              <li>Tiết kiệm bộ nhớ — chỉ load dữ liệu menu 1 lần dù có 10 màn hình</li>
              <li>Truy cập từ bất kỳ widget nào mà không cần truyền tham số</li>
              <li>Hằng số gắn class: <code style="color:var(--gold2)">Drink.maxQty</code> rõ hơn biến global</li>
              <li>Hàm tiện ích không cần state phù hợp khai báo static</li>
              <li>Dễ xây Singleton pattern quản lý trạng thái app</li>
            </ul>
          </div>
          <div class="tc con">
            <h3 style="color:#f1948a">❌ Nhược điểm</h3>
            <ul>
              <li>Khó unit test: trạng thái toàn cục, test case ảnh hưởng nhau</li>
              <li>Vi phạm OOP nếu lạm dụng — mất đóng gói, đa hình</li>
              <li>Không thể override trong lớp con → hạn chế mở rộng</li>
              <li>Tồn tại suốt app → dễ memory leak nếu giữ object lớn</li>
              <li>Tăng coupling giữa các class khó tái sử dụng</li>
            </ul>
          </div>
        </div>

      </div>
    </div>
  </div>

  <!-- CÂU 2 -->
  <div class="section">
    <div class="sec-head">
      <div class="num n2">02</div>
      <div class="sec-title">
        Generics Class <code style="color:var(--gold2);font-family:'DM Mono',monospace">Container&lt;T&gt;</code>
        <small>1 biến obj · In menu Starbucks</small>
      </div>
    </div>
    <div class="sec-body">
      <pre><span class="kw">class</span> <span class="cls">Container</span>&lt;<span class="cls">T</span>&gt; {
  <span class="cls">T</span> obj;
  <span class="cls">Container</span>(<span class="kw">this</span>.obj);
  <span class="kw">void</span> <span class="fn">printData</span>() { <span class="fn">print</span>(obj); }
}

<span class="kw">void</span> <span class="fn">main</span>() {
<span class="kw">var</span> drinkMenu = [
{<span class="str">'id'</span>: <span class="str">'D001'</span>, <span class="str">'name'</span>: <span class="str">'Caramel Frappuccino'</span>,  <span class="str">'price'</span>: <span class="str">'79000'</span>},
{<span class="str">'id'</span>: <span class="str">'D002'</span>, <span class="str">'name'</span>: <span class="str">'Green Tea Frappuccino'</span>, <span class="str">'price'</span>: <span class="str">'79000'</span>},
{<span class="str">'id'</span>: <span class="str">'D003'</span>, <span class="str">'name'</span>: <span class="str">'Caramel Macchiato'</span>,     <span class="str">'price'</span>: <span class="str">'85000'</span>},
{<span class="str">'id'</span>: <span class="str">'D004'</span>, <span class="str">'name'</span>: <span class="str">'Java Chip Frappuccino'</span>,  <span class="str">'price'</span>: <span class="str">'85000'</span>},
{<span class="str">'id'</span>: <span class="str">'D005'</span>, <span class="str">'name'</span>: <span class="str">'Cold Brew'</span>,              <span class="str">'price'</span>: <span class="str">'75000'</span>},
{<span class="str">'id'</span>: <span class="str">'D006'</span>, <span class="str">'name'</span>: <span class="str">'Iced Matcha Latte'</span>,      <span class="str">'price'</span>: <span class="str">'80000'</span>},
];

<span class="kw">var</span> container = <span class="cls">Container</span>&lt;<span class="cls">List</span>&lt;<span class="cls">Map</span>&lt;<span class="cls">String</span>,<span class="cls">String</span>&gt;&gt;&gt;(drinkMenu);

<span class="kw">for</span> (<span class="kw">var</span> d <span class="kw">in</span> container.obj) {
<span class="fn">print</span>(<span class="str">'[</span>${d[<span class="str">'id'</span>]}<span class="str">] </span>${d[<span class="str">'name'</span>]}<span class="str"> - </span>${d[<span class="str">'price'</span>]}<span class="str"> VNĐ'</span>);
}
}</pre>
<div class="output">
<div class="out-head">📤 Output:</div>
<div>[D001] Caramel Frappuccino  - <span class="out-lbl">79000</span> VNĐ</div>
<div>[D002] Green Tea Frappuccino - <span class="out-lbl">79000</span> VNĐ</div>
<div>[D003] Caramel Macchiato     - <span class="out-lbl">85000</span> VNĐ</div>
<div>[D004] Java Chip Frappuccino - <span class="out-lbl">85000</span> VNĐ</div>
<div>[D005] Cold Brew             - <span class="out-lbl">75000</span> VNĐ</div>
<div>[D006] Iced Matcha Latte     - <span class="out-lbl">80000</span> VNĐ</div>
</div>
</div>
  </div>

  <!-- CÂU 3 -->
  <div class="section">
    <div class="sec-head">
      <div class="num n3">03</div>
      <div class="sec-title">
        Drink.dart — Đối tượng chính
        <small>lib/models/Drink.dart · Biến + Phương thức</small>
      </div>
    </div>
    <div class="sec-body">

      <div class="drink-grid">
        <div class="drink-card">
          <div class="drink-emoji">🧋</div>
          <div class="drink-info">
            <div class="drink-name">Caramel Frappuccino</div>
            <div class="drink-cat">Frappuccino · Caffeine TB</div>
          </div>
          <div class="drink-price">79K ⭐</div>
        </div>
        <div class="drink-card">
          <div class="drink-emoji">🍵</div>
          <div class="drink-info">
            <div class="drink-name">Green Tea Frappuccino</div>
            <div class="drink-cat">Frappuccino · Caffeine Thấp</div>
          </div>
          <div class="drink-price">79K ⭐</div>
        </div>
        <div class="drink-card">
          <div class="drink-emoji">☕</div>
          <div class="drink-info">
            <div class="drink-name">Caramel Macchiato</div>
            <div class="drink-cat">Espresso · Caffeine Cao</div>
          </div>
          <div class="drink-price">85K</div>
        </div>
        <div class="drink-card">
          <div class="drink-emoji">🍫</div>
          <div class="drink-info">
            <div class="drink-name">Java Chip Frappuccino</div>
            <div class="drink-cat">Frappuccino · Caffeine TB</div>
          </div>
          <div class="drink-price">85K</div>
        </div>
        <div class="drink-card">
          <div class="drink-emoji">🫗</div>
          <div class="drink-info">
            <div class="drink-name">Cold Brew</div>
            <div class="drink-cat">Cold Coffee · Caffeine Cao</div>
          </div>
          <div class="drink-price">75K</div>
        </div>
        <div class="drink-card">
          <div class="drink-emoji">🌿</div>
          <div class="drink-info">
            <div class="drink-name">Iced Matcha Latte</div>
            <div class="drink-cat">Teavana · Caffeine Thấp</div>
          </div>
          <div class="drink-price">80K</div>
        </div>
      </div>

      <pre><span class="kw">class</span> <span class="cls">Drink</span> {
<span class="cmt">// ── BIẾN ──────────────────────────────────────────</span>
<span class="cls">String</span> id;           <span class="cmt">// 'D001' — mã định danh duy nhất</span>
<span class="cls">String</span> name;         <span class="cmt">// 'Caramel Frappuccino'</span>
<span class="kw">int</span>    price;         <span class="cmt">// 79000 — đơn giá Tall (VNĐ)</span>
<span class="cls">String</span> emoji;        <span class="cmt">// '🧋' — icon hiển thị UI</span>
<span class="cls">String</span> category;     <span class="cmt">// 'Frappuccino' | 'Espresso' | ...</span>
<span class="cls">String</span> caffeine;     <span class="cmt">// 'Cao' | 'Trung bình' | 'Thấp'</span>
<span class="cls">String</span> description;  <span class="cmt">// mô tả ngắn</span>
<span class="kw">bool</span>   isBestSeller; <span class="cmt">// hiển thị badge ★ Best</span>
<span class="kw">bool</span>   isAvailable;  <span class="cmt">// ẩn/hiện khỏi menu</span>

<span class="cmt">// ── STATIC ────────────────────────────────────────</span>
<span class="kw">static const int</span>    maxOrderQuantity = <span class="num">20</span>;
<span class="kw">static const</span> <span class="cls">String</span> storeName = <span class="str">'Starbucks Vietnam'</span>;

<span class="cmt">// ── CONSTRUCTOR ───────────────────────────────────</span>
<span class="cls">Drink</span>({ <span class="kw">required</span> <span class="kw">this</span>.id, <span class="kw">required</span> <span class="kw">this</span>.name,
<span class="kw">required</span> <span class="kw">this</span>.price, <span class="kw">required</span> <span class="kw">this</span>.emoji,
<span class="kw">required</span> <span class="kw">this</span>.category, <span class="kw">required</span> <span class="kw">this</span>.caffeine,
<span class="kw">required</span> <span class="kw">this</span>.description,
<span class="kw">this</span>.isBestSeller = <span class="kw">false</span>,
<span class="kw">this</span>.isAvailable = <span class="kw">true</span> });

<span class="cmt">// ── PHƯƠNG THỨC ───────────────────────────────────</span>
<span class="cls">String</span> <span class="kw">get</span> formattedPrice => <span class="str">'</span>${price ~/ <span class="num">1000</span>}<span class="str">K'</span>;       <span class="cmt">// 79000 → '79K'</span>
<span class="kw">bool</span>   <span class="kw">get</span> isLowCaffeine  => caffeine == <span class="str">'Thấp'</span>;       <span class="cmt">// phù hợp trẻ em</span>
<span class="kw">int</span>    <span class="fn">priceAfterDiscount</span>(<span class="kw">int</span> pct) => price - (price * pct ~/ <span class="num">100</span>);
<span class="kw">void</span>   <span class="fn">display</span>()  { <span class="cmt">/* in thông tin đầy đủ */</span> }
<span class="cls">Map</span>    <span class="fn">toMap</span>()    { <span class="cmt">/* serialize */</span> }
<span class="kw">factory</span> <span class="cls">Drink</span>.<span class="fn">fromMap</span>(<span class="cls">Map</span> m) { <span class="cmt">/* deserialize */</span> }

<span class="cmt">// ── STATIC METHODS ────────────────────────────────</span>
<span class="kw">static</span> <span class="cls">List</span>&lt;<span class="cls">Drink</span>&gt; <span class="fn">filterByCategory</span>(<span class="cls">List</span>&lt;<span class="cls">Drink</span>&gt; list, <span class="cls">String</span> cat);
<span class="kw">static</span> <span class="cls">List</span>&lt;<span class="cls">Drink</span>&gt; <span class="fn">getBestSellers</span>(<span class="cls">List</span>&lt;<span class="cls">Drink</span>&gt; list);
}</pre>
</div>
  </div>

  <!-- CÂU 4 -->
  <div class="section">
    <div class="sec-head">
      <div class="num n4">04</div>
      <div class="sec-title">
        ListDrink.dart — CRUD
        <small>lib/models/ListDrink.dart</small>
      </div>
    </div>
    <div class="sec-body">
      <div class="crud-row">
        <span class="badge bc">CREATE — thêm đồ uống</span>
        <span class="badge br">READ — đọc toàn bộ menu</span>
        <span class="badge bu">EDIT — sửa theo ID</span>
        <span class="badge bd">DELETE — xóa theo ID</span>
      </div>
      <pre><span class="kw">class</span> <span class="cls">ListDrink</span> {
  <span class="cmt">// Danh sách các Drink</span>
  <span class="cls">List</span>&lt;<span class="cls">Drink</span>&gt; drinks = [];

<span class="cmt">// ── CREATE ────────────────────────────────────────</span>
<span class="kw">void</span> <span class="fn">create</span>(<span class="cls">Drink</span> drink) {
<span class="kw">if</span> (drinks.<span class="fn">any</span>((d) => d.id == drink.id)) {
<span class="fn">print</span>(<span class="str">'❌ ID đã tồn tại!'</span>); <span class="kw">return</span>;
}
drinks.<span class="fn">add</span>(drink);
<span class="fn">print</span>(<span class="str">'✅ Đã thêm: </span>${drink.emoji} ${drink.name}<span class="str">'</span>);
}

<span class="cmt">// ── READ ──────────────────────────────────────────</span>
<span class="kw">void</span> <span class="fn">readAll</span>() {
<span class="kw">for</span> (<span class="kw">var</span> d <span class="kw">in</span> drinks) {
<span class="fn">print</span>(<span class="str">'</span>${d.emoji} [${d.id}] ${d.name} — ${d.formattedPrice}<span class="str">'</span>
<span class="str">'</span>${d.isBestSeller ? <span class="str">' ⭐'</span> : <span class="str">''</span>}<span class="str">'</span>);
}
}

<span class="cmt">// ── EDIT ──────────────────────────────────────────</span>
<span class="kw">void</span> <span class="fn">edit</span>(<span class="cls">String</span> id, {<span class="cls">String</span>? name, <span class="kw">int</span>? price,
<span class="kw">bool</span>? isBestSeller, <span class="kw">bool</span>? isAvailable, ...}) {
<span class="kw">int</span> i = drinks.<span class="fn">indexWhere</span>((d) => d.id == id);
<span class="kw">if</span> (i == -<span class="num">1</span>) { <span class="fn">print</span>(<span class="str">'❌ Không tìm thấy ID "$id"'</span>); <span class="kw">return</span>; }
<span class="kw">if</span> (name != <span class="kw">null</span>)         drinks[i].name = name;
<span class="kw">if</span> (price != <span class="kw">null</span>)        drinks[i].price = price;
<span class="kw">if</span> (isBestSeller != <span class="kw">null</span>) drinks[i].isBestSeller = isBestSeller;
<span class="kw">if</span> (isAvailable != <span class="kw">null</span>)  drinks[i].isAvailable = isAvailable;
<span class="fn">print</span>(<span class="str">'✅ Đã cập nhật "$id"'</span>);
}

<span class="cmt">// ── DELETE ────────────────────────────────────────</span>
<span class="kw">void</span> <span class="fn">delete</span>(<span class="cls">String</span> id) {
drinks.<span class="fn">removeWhere</span>((d) => d.id == id);
<span class="fn">print</span>(<span class="str">'✅ Đã xóa "$id"'</span>);
}

<span class="cmt">// ── EXTRA ─────────────────────────────────────────</span>
<span class="cls">Drink</span>?     <span class="fn">findById</span>(<span class="cls">String</span> id)         { ... }
<span class="cls">List</span>&lt;<span class="cls">Drink</span>&gt; <span class="fn">filterByCategory</span>(<span class="cls">String</span> cat) { ... }
<span class="cls">List</span>&lt;<span class="cls">Drink</span>&gt; <span class="fn">getBestSellers</span>()            { ... }
}</pre>
<div class="output">
<div class="out-head">📤 Output khi chạy demo:</div>
<div class="out-ok">✅ Đã thêm: 🧋 Caramel Frappuccino (79K)</div>
<div class="out-ok">✅ Đã thêm: 🍵 Green Tea Cream Frappuccino (79K)</div>
<div class="out-ok">✅ Đã thêm: ☕ Caramel Macchiato (85K)</div>
<div class="out-ok">✅ Đã thêm: 🍫 Java Chip Frappuccino (85K)</div>
<div class="out-ok">✅ Đã thêm: 🫗 Cold Brew (75K)</div>
<div class="out-ok">✅ Đã thêm: 🌿 Iced Matcha Latte (80K)</div>
<div class="out-dim">───</div>
<div class="out-ok">✅ Đã cập nhật D003 → price: 89K, isBestSeller: true</div>
<div class="out-ok">✅ Đã ẩn D005 khỏi menu (isAvailable: false)</div>
<div class="out-dim">───</div>
<div><span class="out-lbl">Best Sellers:</span> Caramel Frappuccino, Green Tea Frappuccino, Caramel Macchiato <span class="out-star">⭐</span></div>
<div><span class="out-lbl">Frappuccino:</span> 3 món &nbsp;|&nbsp; <span class="out-lbl">Giá thấp nhất:</span> 75K &nbsp;|&nbsp; <span class="out-lbl">Cao nhất:</span> 89K</div>
<div><span class="out-lbl">Static:</span> maxOrderQty = 20 &nbsp;|&nbsp; store = Starbucks Vietnam</div>
</div>
</div>
  </div>

  <!-- CÂU 5 -->
  <div class="section">
    <div class="sec-head">
      <div class="num n5">05</div>
      <div class="sec-title">
        Cập nhật README &amp; Push GitHub
        <small>Commit code · Cấu trúc file đề xuất</small>
      </div>
    </div>
    <div class="sec-body">
      <pre><span class="cmt"># Cấu trúc project sau khi hoàn thành</span>
lib/
├── models/
│   ├── <span class="cls">Drink</span>.dart         <span class="cmt"># Câu 3 — class Drink</span>
│   ├── <span class="cls">ListDrink</span>.dart     <span class="cmt"># Câu 4 — CRUD</span>
│   ├── <span class="cls">Cart</span>.dart
│   ├── <span class="cls">CartItem</span>.dart
│   ├── <span class="cls">Order</span>.dart
│   └── <span class="cls">User</span>.dart
├── screens/
│   └── starbucks_menu_screen.dart
└── main.dart</pre>
      <br>
      <div class="steps">
        <div class="step"><p>Tạo file <code>lib/models/Drink.dart</code> và <code>lib/models/ListDrink.dart</code>, copy code từ bài làm vào đúng vị trí.</p></div>
        <div class="step"><p>Mở <code>README.md</code>, thêm mục <b>Mô hình dữ liệu</b> — mô tả class Drink, các biến, phương thức và mục đích sử dụng.</p></div>
        <div class="step"><p>Stage toàn bộ thay đổi: <code>git add .</code></p></div>
        <div class="step"><p>Commit rõ ràng: <code>git commit -m "feat: add Drink model + ListDrink CRUD"</code></p></div>
        <div class="step"><p>Push lên repo nhóm: <code>git push origin main</code></p></div>
        <div class="step"><p>Kiểm tra GitHub — xác nhận file xuất hiện và README hiển thị đúng định dạng Markdown.</p></div>
      </div>
      <br>
      <pre><span class="cmt">## Mô hình dữ liệu — README.md</span>

### <span class="cls">Drink</span> (lib/models/Drink.dart)
| Biến         | Kiểu   | Mô tả                    |
|--------------|--------|--------------------------|
| id           | String | Mã đồ uống (unique)      |
| name         | String | Tên đồ uống              |
| price        | int    | Đơn giá Tall (VNĐ)       |
| emoji        | String | Icon hiển thị trên UI    |
| category     | String | Frappuccino/Espresso/... |
| caffeine     | String | Cao / Trung bình / Thấp  |
| isBestSeller | bool   | Hiển thị badge ⭐         |
| isAvailable  | bool   | Đang bán / Tạm ngưng     |</pre>
    </div>
  </div>

</div>

<footer>Starbucks App · Flutter · Dart · <span>Bài tập lớn nhóm</span></footer>
</body>
</html>