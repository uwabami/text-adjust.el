text-adjust.el (archive)
========================

What is this?
-------------

Hiroyuki Komatsu さんが公開されていた text-adjust.el をひっそりと更新してみました.

やった事は 
* mell 依存の削除: XEmacs support はサポートしない(使わない)
* 幾つかの obsolete warning の修正
です

Install
-------

単に 

        (setq load-path (cons (expand-file-name "~/elisp") load-path))
        (load "text-adjust")

です.

Usage
-----

1. `M-x text-adjust` を実行すると文章が整形される.
2. 使用可能な関数の概要.
   * `text-adjust-codecheck` : 半角カナ, 規格外文字を「〓」に置き換える.
   * `text-adjust-hankaku`   : 全角英数文字を半角にする.
   * `text-adjust-kutouten`  : 句読点を「, 」「. 」に置き換える.
   * `text-adjust-space`     : 全角文字と半角文字の間に空白を入れる.
   * `text-adjust`           : これらをすべて実行する.
   * `text-adjust-fill`      : 句読点優先で, fill-region をする.

適応範囲はリージョンがある場合はその範囲を, なければ mark-paragraph で得られた値.

   * `*-region` : 上記関数をリージョン内で実行する.
   * ` *-buffer` : 上記関数をバッファ内で実行する.

Tips
----

1. 次のように設定すると, `text-adjust-fill-region` 実行時に, 左マージンが考慮される.

        (setq adaptive-fill-regexp "[ \t]*")
        (setq adaptive-fill-mode t)

2.  `？！` や全角空白を半角へ変換しないようにするには `text-adjust-hankaku-except` に文字を追加すれば可能になります.

        (setq text-adjust-hankaku-except "　？！＠ー〜、，。．")

License
-------

元のコードが `GPL` としか書かれていなかったのですが,
とりあえず `GPL-3+` にしておきます. 
