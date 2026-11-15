# M3 - Ket qua thu nghiem dang ky dong thoi

## Cau hinh va du lieu

- PostgreSQL 18.6, database `csdl_nc`, du lieu seed cua do an.
- Lop tranh cho: `LHP401`, si so ban dau `6/6`; moi vong mo dung 1 cho.
- 10 sinh vien `N107`-`N116` tranh cung mot cho; `N109`-`N116` duoc them lich su hoc IT202 tam thoi de thoa tien quyet. Runner xoa cac dong tam va khoi phuc si so sau khi chay.
- Chay 10 vong cho moi phuong an, tong cong 100 yeu cau moi phuong an.

## So sanh dong thoi

| Phuong an | Dang ky thanh cong | Retry | Latency trung binh | P95 | Overbooking |
|---|---:|---:|---:|---:|---:|
| Khong khoa (loi co y) | 100/100 (100%) | 0 | 124.80 ms | 199.27 ms | 10/10 vong |
| `SELECT FOR UPDATE` | 10/100 (10%) | 0 | 124.17 ms | 190.33 ms | 0/10 vong |
| `SERIALIZABLE` | 10/100 (10%) | 90 | 197.93 ms | 264.08 ms | 0/10 vong |

Ca khong khoa cho ca 10 sinh vien dang ky vao 1 cho: bo dem cuoi la `7`, trong khi co `16` dang ky hoat dong va suc chua `7`. Day la lost update tren bo dem va overbooking tren cac dong dang ky.

Hai phuong an an toan chi cho 1 sinh vien thanh cong moi vong. `SERIALIZABLE` retry 9 lan moi vong trung binh; ca retry sau do thay lop da day va bi tu choi. Khong co loi database khong xu ly duoc.

## Thu dang ky trung

- Hai request dong thoi cho cung sinh vien `N107`: 1 thanh cong, 1 bi tu choi la `already_registered`.
- So dong `dang_ky` cua N107/LHP401 sau hai request: `1`.
- Si so / dang ky hoat dong / suc chua: `7/7/7`.

## EXPLAIN ANALYZE

Chay tu `m3_dang_ky.sql` tren truy van kiem tra cho, tien quyet va trung lich:

- Planning Time: `0.729 ms`
- Execution Time: `0.197 ms`
- Root plan: `Seq Scan` tren `lop_hoc_phan` (seed chi co 11 lop); cac bang lich/ket qua co cac scan va index scan nhu trong output psql.

Runner Python chay mot lan `EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)` doc lap va ghi `Planning Time = 2.186 ms`, `Execution Time = 0.164 ms`. Day la lan do rieng, khong gop trung binh voi ket qua tren.

## Kiem tra sau chay

- `m3_dang_ky.sql`: rollback khong de lai dang ky; giao dich thanh cong cap nhat dong bo bo dem va dang ky; cleanup tra `LHP401` ve `6/6`.
- Thu dang ky lai dong thoi cua cung sinh vien bi tu choi, khong tao dong thu hai.
- Runner: xoa fixture IT202 tam va cac dong dang ky thu; da kiem tra khong con dong fixture, `LHP401` van `6/6`.
- Cac file SQL chinh `quan_ly_hoc_vu.sql` va `du_lieu_mau.sql` khong bi sua.
