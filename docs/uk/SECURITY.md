<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

<!-- textlint-disable terminology,common-misspellings -->
[English](../../SECURITY.md) · [Español](../es/SECURITY.md)

# Політика безпеки

## Як повідомити про вразливість

**Не повідомляйте про вразливості безпеки через публічні задачі, обговорення або запити на зміну.**

Зробіть це, написавши на **<damian.buho@proton.me>**.

Додайте стільки з наведеного, скільки зможете — це допоможе нам швидше розсортувати та вирішити повідомлення:

- Тип проблеми (наприклад переповнення буфера, ін'єкція SQL, cross-site scripting)
- Версію або версії, яких це стосується
- Вплив проблеми, зокрема як зловмисник може її використати
- Покрокові інструкції для відтворення проблеми
- Розташування відповідного вихідного коду (тег, гілка, коміт або пряме URL)
- Повні шляхи файлів вихідного коду, пов'язаних із проблемою
- Будь-яку конфігурацію, необхідну для відтворення проблеми
- Відповідні файли журналів, якщо можливо
- Доказ концепції або код експлойту, якщо можливо

Ми прагнемо підтвердити отримання повідомлення протягом 30 днів і
скоординувати розкриття, щойно буде готове виправлення.

## Шифрування повідомлення

Якщо ви хочете надіслати нам зашифроване повідомлення, виконайте ці кроки.

Імпортуйте наш відкритий ключ:

```sh
gpg --keyserver keys.openpgp.org --recv-keys B64C122EE16C3746
```

Перевірте, що відбиток збігається, перш ніж довіритися йому:

```sh
gpg --fingerprint B64C122EE16C3746
```

Вивід має показати:

```text
6F19 7084 3C9E 8406 AD70  0467 B64C 122E E16C 3746
```

Зашифруйте своє повідомлення для нас:

```sh
gpg --encrypt --armor --recipient B64C122EE16C3746 message.txt
```

## Винагорода за вразливості

F5M/I2P Reseed наразі не має програми винагород за вразливості. Проте ми цінуємо
відповідальні повідомлення — див. канал контакту вище.

## Визнані вразливості

Наведені знахідки переглянуто та навмисно придушено (виправлення залежить від
наступного випуску upstream-проєкту, або повідомлення не стосується цього проєкту):

| ID | Причина |
| --- | --- |
| CVE-2026-39827 | blocked by upstream |
| GHSA-45gg-vh54-h5m9 | blocked by upstream |
| GHSA-89gr-r52h-f8rx | blocked by upstream |
| GHSA-f5wc-c3c7-36mc | blocked by upstream |
| GHSA-q4h4-gmj2-qvw2 | blocked by upstream |
| GHSA-qpw4-5x99-6vjp | blocked by upstream |
| GHSA-rm3j-f69w-wqmq | blocked by upstream |
| GHSA-vgwf-h737-ff37 | blocked by upstream |
| GHSA-w879-237q-wc7r | blocked by upstream |
| GHSA-x527-x647-q7gg | blocked by upstream |
| CVE-2026-39828 | blocked by upstream |
| GO-2026-5014 | blocked by upstream |
| CVE-2026-39829 | blocked by upstream |
| GO-2026-5018 | blocked by upstream |
| CVE-2026-39830 | blocked by upstream |
| GO-2026-5017 | blocked by upstream |
| CVE-2026-39831 | blocked by upstream |
| GO-2026-5019 | blocked by upstream |
| CVE-2026-39832 | blocked by upstream |
| GO-2026-5006 | blocked by upstream |
| CVE-2026-39833 | blocked by upstream |
| GO-2026-5005 | blocked by upstream |
| CVE-2026-39834 | blocked by upstream |
| GO-2026-5020 | blocked by upstream |
| CVE-2026-39835 | blocked by upstream |
| GO-2026-5015 | blocked by upstream |
| CVE-2026-42508 | blocked by upstream |
| GO-2026-5021 | blocked by upstream |
| CVE-2026-46595 | blocked by upstream |
| GO-2026-5023 | blocked by upstream |
| CVE-2026-46597 | blocked by upstream |
| GO-2026-5013 | blocked by upstream |
| CVE-2026-56854 | blocked by upstream |
| GO-2026-6303 | blocked by upstream |
| CVE-2026-46600 | blocked by upstream |
| CVE-2026-25681 | blocked by upstream |
| CVE-2026-27136 | blocked by upstream |
| CVE-2026-33814 | blocked by upstream |
| GO-2026-4918 | blocked by upstream |
| CVE-2026-39821 | blocked by upstream |
| GO-2026-5026 | blocked by upstream |
| CVE-2026-39822 | blocked by upstream |
| CVE-2026-42502 | blocked by upstream |
| CVE-2026-56852 | blocked by upstream |
| GO-2026-5970 | blocked by upstream |
| CVE-2026-40611 | unfixable upstream dependency; fixable only via upstream release |

<!-- textlint-enable -->
