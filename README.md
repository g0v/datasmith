# 開放資料新聞產生器

目前只有一堆 script 用來產生成果

## Usage

```
ruby build.rb INPUT.csv > output.html
open output.html
```

## Scripts

### derive_type.rb

從 column 資料內容推斷資料類型

* Input: Raw data CSV
* Output: Column Type array

usage:

```
ruby derive_type.rb INPUT.csv INTERMEDIATE.csv # 將 derived 的結果輸出到 INTERMEDIATE.csv
```

### label_count_renderer.rb

* Input: INTERMEDIATE.csv , 要計數的 column index
* Output: 圖表頁面

usage:

```
ruby label_count_renderer.rb INTERMEDIATE.csv INDEX
```
