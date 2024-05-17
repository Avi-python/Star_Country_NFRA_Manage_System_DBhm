# 宇宙國森林管理系統

### 如果要測試，可以參考下列步驟

先將我放在此 repo 裡面的四個檔案 clone or 下載下來

#### 建立 db
1. 打開 MySQL
2. 導入 star_country_EER.mwb 這個 EER model
3. 點開上面的 Database 選項 -> 點選 Forward Engineer 
4. 就可以將我的 EER model 轉換成實際的 db

#### insert Data
1. 按下 File 點選 Open Script
2. 將那三個 .sql file 全部開起
3. 可以看到檔名有 insert 都是插入資料，也就是我自己編的資料，執行這個腳本就可以將這些資料匯入到 table 裡面。

#### query
1. 檔名有 query 就是我在報告上面實作的那些 query source code，可以逐一執行或是自己撰寫以檢查正確性。
