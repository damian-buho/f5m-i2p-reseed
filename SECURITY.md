<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

[Español](docs/es/SECURITY.md) · [Українська](docs/uk/SECURITY.md)

# Security Policy

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public issues, discussions, or change requests.**

Report them by emailing **<damian.buho@proton.me>**.

Please include as much of the following as you can — it helps us triage and resolve the report faster:

- The type of issue (e.g. buffer overflow, SQL injection, cross-site scripting)
- Affected version(s)
- The impact of the issue, including how an attacker might exploit it
- Step-by-step instructions to reproduce the issue
- The location of the affected source code (tag, branch, commit, or direct URL)
- Full paths of the source file(s) related to the issue
- Any configuration required to reproduce the issue
- Relevant log files, if possible
- Proof-of-concept or exploit code, if possible

We aim to acknowledge reports within 30 days and to coordinate
disclosure once a fix is available.

## Encrypting a Report

If you would like to send us an encrypted report, follow these steps.

Import our public key:

```sh
gpg --keyserver keys.openpgp.org --recv-keys B64C122EE16C3746
```

Verify the fingerprint matches before you trust it:

```sh
gpg --fingerprint B64C122EE16C3746
```

The output must show:

```text
6F19 7084 3C9E 8406 AD70  0467 B64C 122E E16C 3746
```

Encrypt your message to us:

```sh
gpg --encrypt --armor --recipient B64C122EE16C3746 message.txt
```

## Bug Bounty

F5M / I2P Reseed does not currently run a bug bounty programme. We still welcome
responsibly disclosed reports — see the contact channel above.

## Acknowledged Vulnerabilities

The following findings were reviewed and are intentionally suppressed (a fix
depends on an upstream release, or the advisory does not apply to this project):

| ID | Reason |
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
