# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  eval "$(b19-resolve-dep reseed-tools)"

  b19-fetch "RESEED" "${M6E_UPSTREAM__URL}" "${M6E_UPSTREAM__FILE}" "${M6E_UPSTREAM__HASH}"

  b19-run "RESEED" "$(_p "Extract %s/%s" "${B19_TEMP_PATH}" "${M6E_UPSTREAM__FILE}")" --    \
    tar --extract                                                                           \
        --file "${B19_TEMP_PATH}/${M6E_UPSTREAM__FILE}"                                     \
        --strip-components 1                                                                \
        --use-compress-program pigz
